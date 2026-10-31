import urllib.request
import re
import os

os.makedirs('assets/fonts/inter', exist_ok=True)
os.makedirs('assets/fonts/noto_sans_devanagari', exist_ok=True)

# We can download TTF fonts from google fonts or variable font
# In flutter, variable fonts work seamlessly or we can map them

def fetch_css(family_query):
    url = f"https://fonts.googleapis.com/css2?family={family_query}&display=swap"
    # Old android user agent forces TTF format from google fonts
    headers = {'User-Agent': 'Mozilla/5.0 (Linux; U; Android 2.2; en-us; Nexus One Build/FRF91) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1'}
    req = urllib.request.Request(url, headers=headers)
    with urllib.request.urlopen(req) as resp:
        return resp.read().decode('utf-8')

def download_font(url, out_path):
    print(f"Downloading to {out_path}...")
    req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
    with urllib.request.urlopen(req) as resp, open(out_path, 'wb') as f:
        f.write(resp.read())
    print(f"Saved {out_path} ({os.path.getsize(out_path)} bytes)")

# Download Noto Sans Devanagari
css_noto = fetch_css("Noto+Sans+Devanagari:wght@400;500;600;700")
matches_noto = re.findall(r'font-weight:\s*(\d+);.*?src:\s*url\((https://[^\)]+)\)', css_noto, re.DOTALL)
print("Noto matches:", len(matches_noto))
weight_names_noto = {
    '400': 'NotoSansDevanagari-Regular.ttf',
    '500': 'NotoSansDevanagari-Medium.ttf',
    '600': 'NotoSansDevanagari-SemiBold.ttf',
    '700': 'NotoSansDevanagari-Bold.ttf',
}
for weight, url in matches_noto:
    if weight in weight_names_noto:
        download_font(url, f"assets/fonts/noto_sans_devanagari/{weight_names_noto[weight]}")

# Download Inter
css_inter = fetch_css("Inter:wght@400;500;600;700;800")
matches_inter = re.findall(r'font-weight:\s*(\d+);.*?src:\s*url\((https://[^\)]+)\)', css_inter, re.DOTALL)
print("Inter matches:", len(matches_inter))
weight_names_inter = {
    '400': 'Inter-Regular.ttf',
    '500': 'Inter-Medium.ttf',
    '600': 'Inter-SemiBold.ttf',
    '700': 'Inter-Bold.ttf',
    '800': 'Inter-ExtraBold.ttf',
}
for weight, url in matches_inter:
    if weight in weight_names_inter:
        download_font(url, f"assets/fonts/inter/{weight_names_inter[weight]}")

print("Font download script finished.")
