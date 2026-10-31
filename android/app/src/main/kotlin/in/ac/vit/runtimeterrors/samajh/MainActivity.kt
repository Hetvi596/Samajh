package `in`.ac.vit.runtimeterrors.samajh

import android.os.Handler
import android.os.Looper
import io.flutter.FlutterInjector
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import org.vosk.Model
import org.vosk.Recognizer
import java.io.File
import java.io.RandomAccessFile
import java.nio.ByteBuffer
import java.nio.ByteOrder
import java.util.concurrent.Executors
import java.util.zip.ZipInputStream

class MainActivity : FlutterActivity() {
    private val worker = Executors.newSingleThreadExecutor()
    private val main = Handler(Looper.getMainLooper())
    private var model: Model? = null
    private var modelName: String? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "samajh/speech").setMethodCallHandler { call, result ->
            when (call.method) {
                "transcribe" -> {
                    val asset = call.argument<String>("modelAsset")!!
                    val wav = call.argument<String>("wavPath")!!
                    val grammar = call.argument<String>("grammar")!!
                    // Speech recognition is slow; keep it off the UI thread.
                    worker.execute {
                        try {
                            val out = transcribe(asset, wav, grammar)
                            main.post { result.success(out) }
                        } catch (e: Throwable) {
                            main.post { result.error("speech_failed", e.javaClass.simpleName, null) }
                        }
                    }
                }
                else -> result.notImplemented()
            }
        }
    }

    /** Runs Vosk over the recording, listening only for the grammar words. */
    private fun transcribe(asset: String, wavPath: String, grammar: String): List<String> {
        val recognizer = Recognizer(loadModel(asset), 16000f, grammar)
        recognizer.setWords(true)
        val results = ArrayList<String>()
        RandomAccessFile(wavPath, "r").use { file ->
            val (start, length) = findPcm(file)
            file.seek(start)
            val buffer = ByteArray(8000) // a quarter of a second of 16 kHz 16-bit audio
            var left = length
            while (left > 0) {
                val n = file.read(buffer, 0, minOf(buffer.size.toLong(), left).toInt())
                if (n <= 0) break
                left -= n
                if (recognizer.acceptWaveForm(buffer, n)) results.add(recognizer.result)
            }
        }
        results.add(recognizer.finalResult)
        recognizer.close()
        return results
    }

    /** Unzips the bundled model once (a marker file shows the unzip finished). */
    private fun loadModel(asset: String): Model {
        val name = File(asset).nameWithoutExtension
        model?.let { if (modelName == name) return it }
        val root = File(filesDir, "speech_models")
        val dir = File(root, name)
        val marker = File(root, "$name.ready")
        if (!marker.exists()) {
            dir.deleteRecursively()
            root.mkdirs()
            val key = FlutterInjector.instance().flutterLoader().getLookupKeyForAsset(asset)
            ZipInputStream(assets.open(key)).use { zip ->
                var entry = zip.nextEntry
                while (entry != null) {
                    val out = File(root, entry.name)
                    // Never write outside the models folder.
                    require(out.canonicalPath.startsWith(root.canonicalPath + File.separator))
                    if (entry.isDirectory) {
                        out.mkdirs()
                    } else {
                        out.parentFile?.mkdirs()
                        out.outputStream().use { zip.copyTo(it) }
                    }
                    entry = zip.nextEntry
                }
            }
            marker.writeText("ok")
        }
        return Model(dir.absolutePath).also { model = it; modelName = name }
    }

    /** Start and length of the sample data in a PCM WAV file. */
    private fun findPcm(file: RandomAccessFile): Pair<Long, Long> {
        val header = ByteArray(12)
        file.readFully(header)
        require(String(header, 0, 4) == "RIFF")
        var pos = 12L
        val chunk = ByteArray(8)
        while (pos + 8 <= file.length()) {
            file.seek(pos)
            file.readFully(chunk)
            val id = String(chunk, 0, 4)
            val size = ByteBuffer.wrap(chunk, 4, 4).order(ByteOrder.LITTLE_ENDIAN).int.toLong() and 0xffffffffL
            if (id == "data") return Pair(pos + 8, minOf(size, file.length() - pos - 8))
            pos += 8 + size + (size and 1)
        }
        throw IllegalArgumentException("no data chunk")
    }
}
