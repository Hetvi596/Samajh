-- =====================================================================
-- SAMAJH: DIRECT AUTO-SYNC UPDATE FOR SUPABASE
-- Run this in Supabase Dashboard -> SQL Editor -> Run
-- This allows the Samajh mobile app to automatically push class data
-- directly to Supabase whenever connected to the internet, without
-- requiring manual teacher logins or manual backup/restore files.
-- =====================================================================

-- 0. GRANT POSTGRES TABLE PRIVILEGES TO anon & authenticated ROLES
-- (Fixes "permission denied for table classes" / code 42501)
grant usage on schema public to anon, authenticated, service_role;
grant all on all tables in schema public to anon, authenticated, service_role;
grant all on all sequences in schema public to anon, authenticated, service_role;
grant all on all routines in schema public to anon, authenticated, service_role;

alter default privileges in schema public grant all on tables to anon, authenticated, service_role;
alter default privileges in schema public grant all on sequences to anon, authenticated, service_role;
alter default privileges in schema public grant all on routines to anon, authenticated, service_role;

-- 1. DROP RESTRICTIVE FOREIGN KEYS TO auth.users
alter table if exists public.classes drop constraint if exists classes_owner_id_fkey;
alter table if exists public.children drop constraint if exists children_owner_id_fkey;
alter table if exists public.consents drop constraint if exists consents_owner_id_fkey;
alter table if exists public.checks drop constraint if exists checks_owner_id_fkey;
alter table if exists public.word_marks drop constraint if exists word_marks_owner_id_fkey;
alter table if exists public.retell_points drop constraint if exists retell_points_owner_id_fkey;
alter table if exists public.question_answers drop constraint if exists question_answers_owner_id_fkey;
alter table if exists public.dictation_items drop constraint if exists dictation_items_owner_id_fkey;
alter table if exists public.listening_checks drop constraint if exists listening_checks_owner_id_fkey;
alter table if exists public.results drop constraint if exists results_owner_id_fkey;
alter table if exists public.group_assignments drop constraint if exists group_assignments_owner_id_fkey;
alter table if exists public.practice_needs drop constraint if exists practice_needs_owner_id_fkey;
alter table if exists public.weekly_plan_ticks drop constraint if exists weekly_plan_ticks_owner_id_fkey;
alter table if exists public.parent_reports drop constraint if exists parent_reports_owner_id_fkey;
alter table if exists public.accepted_pronunciations drop constraint if exists accepted_pronunciations_owner_id_fkey;
alter table if exists public.sync_tombstones drop constraint if exists sync_tombstones_owner_id_fkey;
alter table if exists public.sync_devices drop constraint if exists sync_devices_owner_id_fkey;
alter table if exists public.teachers drop constraint if exists teachers_id_fkey;

-- 2. SET SAFE DEFAULT OWNER ID
alter table if exists public.classes alter column owner_id set default '00000000-0000-0000-0000-000000000001'::uuid;
alter table if exists public.children alter column owner_id set default '00000000-0000-0000-0000-000000000001'::uuid;
alter table if exists public.consents alter column owner_id set default '00000000-0000-0000-0000-000000000001'::uuid;
alter table if exists public.checks alter column owner_id set default '00000000-0000-0000-0000-000000000001'::uuid;
alter table if exists public.word_marks alter column owner_id set default '00000000-0000-0000-0000-000000000001'::uuid;
alter table if exists public.retell_points alter column owner_id set default '00000000-0000-0000-0000-000000000001'::uuid;
alter table if exists public.question_answers alter column owner_id set default '00000000-0000-0000-0000-000000000001'::uuid;
alter table if exists public.dictation_items alter column owner_id set default '00000000-0000-0000-0000-000000000001'::uuid;
alter table if exists public.listening_checks alter column owner_id set default '00000000-0000-0000-0000-000000000001'::uuid;
alter table if exists public.results alter column owner_id set default '00000000-0000-0000-0000-000000000001'::uuid;
alter table if exists public.group_assignments alter column owner_id set default '00000000-0000-0000-0000-000000000001'::uuid;
alter table if exists public.practice_needs alter column owner_id set default '00000000-0000-0000-0000-000000000001'::uuid;
alter table if exists public.weekly_plan_ticks alter column owner_id set default '00000000-0000-0000-0000-000000000001'::uuid;
alter table if exists public.parent_reports alter column owner_id set default '00000000-0000-0000-0000-000000000001'::uuid;
alter table if exists public.accepted_pronunciations alter column owner_id set default '00000000-0000-0000-0000-000000000001'::uuid;
alter table if exists public.sync_tombstones alter column owner_id set default '00000000-0000-0000-0000-000000000001'::uuid;
alter table if exists public.sync_devices alter column owner_id set default '00000000-0000-0000-0000-000000000001'::uuid;

-- 3. ENABLE DIRECT ACCESS FOR BOTH ANON AND AUTHENTICATED ROLES
drop policy if exists "allow_all_classes" on public.classes;
create policy "allow_all_classes" on public.classes for all to anon, authenticated using (true) with check (true);

drop policy if exists "allow_all_children" on public.children;
create policy "allow_all_children" on public.children for all to anon, authenticated using (true) with check (true);

drop policy if exists "allow_all_consents" on public.consents;
create policy "allow_all_consents" on public.consents for all to anon, authenticated using (true) with check (true);

drop policy if exists "allow_all_checks" on public.checks;
create policy "allow_all_checks" on public.checks for all to anon, authenticated using (true) with check (true);

drop policy if exists "allow_all_word_marks" on public.word_marks;
create policy "allow_all_word_marks" on public.word_marks for all to anon, authenticated using (true) with check (true);

drop policy if exists "allow_all_retell_points" on public.retell_points;
create policy "allow_all_retell_points" on public.retell_points for all to anon, authenticated using (true) with check (true);

drop policy if exists "allow_all_question_answers" on public.question_answers;
create policy "allow_all_question_answers" on public.question_answers for all to anon, authenticated using (true) with check (true);

drop policy if exists "allow_all_dictation_items" on public.dictation_items;
create policy "allow_all_dictation_items" on public.dictation_items for all to anon, authenticated using (true) with check (true);

drop policy if exists "allow_all_listening_checks" on public.listening_checks;
create policy "allow_all_listening_checks" on public.listening_checks for all to anon, authenticated using (true) with check (true);

drop policy if exists "allow_all_results" on public.results;
create policy "allow_all_results" on public.results for all to anon, authenticated using (true) with check (true);

drop policy if exists "allow_all_group_assignments" on public.group_assignments;
create policy "allow_all_group_assignments" on public.group_assignments for all to anon, authenticated using (true) with check (true);

drop policy if exists "allow_all_practice_needs" on public.practice_needs;
create policy "allow_all_practice_needs" on public.practice_needs for all to anon, authenticated using (true) with check (true);

drop policy if exists "allow_all_weekly_plan_ticks" on public.weekly_plan_ticks;
create policy "allow_all_weekly_plan_ticks" on public.weekly_plan_ticks for all to anon, authenticated using (true) with check (true);

drop policy if exists "allow_all_parent_reports" on public.parent_reports;
create policy "allow_all_parent_reports" on public.parent_reports for all to anon, authenticated using (true) with check (true);

drop policy if exists "allow_all_accepted_pronunciations" on public.accepted_pronunciations;
create policy "allow_all_accepted_pronunciations" on public.accepted_pronunciations for all to anon, authenticated using (true) with check (true);

drop policy if exists "allow_all_sync_tombstones" on public.sync_tombstones;
create policy "allow_all_sync_tombstones" on public.sync_tombstones for all to anon, authenticated using (true) with check (true);

drop policy if exists "allow_all_sync_devices" on public.sync_devices;
create policy "allow_all_sync_devices" on public.sync_devices for all to anon, authenticated using (true) with check (true);

drop policy if exists "allow_all_teachers" on public.teachers;
create policy "allow_all_teachers" on public.teachers for all to anon, authenticated using (true) with check (true);

-- 4. INSERT FALLBACK TEACHER ROW IF NOT PRESENT
insert into public.teachers (id, display_name, app_language)
values ('00000000-0000-0000-0000-000000000001'::uuid, 'Classroom Teacher', 'en')
on conflict (id) do nothing;
