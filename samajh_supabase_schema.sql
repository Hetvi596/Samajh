-- =====================================================================
-- SAMAJH: SUPABASE CLOUD SCHEMA v1  (backup and sync target, future phase)
-- =====================================================================
-- How to run: Supabase dashboard > SQL Editor > New query > paste this
-- whole file > Run. Run it once on a NEW project (region: Mumbai).
--
-- Design rules
--  * The phone is the source of truth. Supabase only receives copies.
--  * Only Real-class data syncs. Demo data never does.
--  * Zero OCR, zero photos/images, zero audio, no passcode or keys are
--    ever stored here. Audio never leaves local temporary encrypted storage.
--  * Each teacher sees only their own rows (Row Level Security).
--  * One teacher can own many classes. There is no head-teacher role.
--  * Primary keys are UUIDs created on the phone, so offline devices
--    never collide.
-- =====================================================================


-- ---------------------------------------------------------------------
-- 1. TEACHER PROFILE (one row per signed-in teacher)
-- ---------------------------------------------------------------------
create table if not exists public.teachers (
  id                uuid primary key references auth.users(id) on delete cascade,
  display_name      text,
  app_language      text not null default 'en' check (app_language in ('en','hi','mr')),
  created_at        timestamptz not null default now(),
  updated_at        timestamptz not null default now(),
  server_updated_at timestamptz not null default now()
);

-- Create the teacher row automatically when someone signs up.
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.teachers (id) values (new.id) on conflict (id) do nothing;
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();


-- ---------------------------------------------------------------------
-- 2. DEVICES (lets a teacher restore on a new phone and see last sync)
-- ---------------------------------------------------------------------
create table if not exists public.sync_devices (
  id                uuid primary key default gen_random_uuid(),
  owner_id          uuid not null default auth.uid() references auth.users(id) on delete cascade,
  label             text,
  platform          text not null default 'android',
  app_version       text,
  last_push_at      timestamptz,
  last_pull_at      timestamptz,
  created_at        timestamptz not null default now(),
  updated_at        timestamptz not null default now(),
  server_updated_at timestamptz not null default now(),
  deleted_at        timestamptz
);


-- ---------------------------------------------------------------------
-- 3. CLASSES (a teacher can have many)
-- ---------------------------------------------------------------------
create table if not exists public.classes (
  id                 uuid primary key default gen_random_uuid(),
  owner_id           uuid not null default auth.uid() references auth.users(id) on delete cascade,
  name               text not null,                       -- e.g. "4A"
  grade              smallint not null check (grade between 1 and 5),
  section            text,
  curriculum         text not null check (curriculum in ('ncert_cbse','up','rajasthan','school_own')),
  check_language     text not null check (check_language in ('hi','en','mr')),
  instruction_medium text not null check (instruction_medium in ('hi','en','mr')),
  textbook_id        text,                                -- id from registry.json
  current_chapter_id text,
  academic_year      text not null,                       -- e.g. "2026-27"
  created_at         timestamptz not null default now(),
  updated_at         timestamptz not null default now(),
  server_updated_at  timestamptz not null default now(),
  deleted_at         timestamptz,
  unique (id, owner_id)
);


-- ---------------------------------------------------------------------
-- 4. CHILDREN (first name and last initial only)
-- ---------------------------------------------------------------------
create table if not exists public.children (
  id                uuid primary key default gen_random_uuid(),
  owner_id          uuid not null default auth.uid() references auth.users(id) on delete cascade,
  class_id          uuid not null,
  first_name        text not null,
  last_initial      text not null check (char_length(last_initial) between 1 and 2),
  home_language     text not null check (home_language in ('hi','en','mr','other')),
  created_at        timestamptz not null default now(),
  updated_at        timestamptz not null default now(),
  server_updated_at timestamptz not null default now(),
  deleted_at        timestamptz,
  unique (id, owner_id),
  foreign key (class_id, owner_id) references public.classes (id, owner_id) on delete cascade
);


-- ---------------------------------------------------------------------
-- 5. CONSENT (assessment consent, and separate consent for cloud backup)
-- ---------------------------------------------------------------------
create table if not exists public.consents (
  id                uuid primary key default gen_random_uuid(),
  owner_id          uuid not null default auth.uid() references auth.users(id) on delete cascade,
  child_id          uuid not null,
  purpose           text not null default 'assessment' check (purpose in ('assessment','cloud_backup')),
  status            text not null check (status in ('not_recorded','given','declined','withdrawn')),
  recorded_at       timestamptz not null default now(),
  note              text,
  created_at        timestamptz not null default now(),
  updated_at        timestamptz not null default now(),
  server_updated_at timestamptz not null default now(),
  deleted_at        timestamptz,
  foreign key (child_id, owner_id) references public.children (id, owner_id) on delete cascade
);


-- ---------------------------------------------------------------------
-- 6. CHECKS (one reading check of one child)
-- ---------------------------------------------------------------------
create table if not exists public.checks (
  id                     uuid primary key default gen_random_uuid(),
  owner_id               uuid not null default auth.uid() references auth.users(id) on delete cascade,
  child_id               uuid not null,
  passage_id             text not null,                    -- id from bank.json
  state                  text not null default 'in_progress'
                           check (state in ('in_progress','waiting_review','completed','abandoned')),
  step                   text,                             -- where to resume
  student_self_rating    text default 'not_recorded'
                           check (student_self_rating in ('thumbs_up','thumbs_down','not_recorded')),
  started_at             timestamptz not null default now(),
  finished_at            timestamptz,
  noise_level            numeric,
  low_confidence         boolean not null default false,
  reading_seconds        numeric,
  rubric_version         text,                             -- e.g. "0.1"
  benchmark_id           text,                             -- id from benchmarks.json
  benchmark_source_label text,
  created_at             timestamptz not null default now(),
  updated_at             timestamptz not null default now(),
  server_updated_at      timestamptz not null default now(),
  deleted_at             timestamptz,
  unique (id, owner_id),
  foreign key (child_id, owner_id) references public.children (id, owner_id) on delete cascade
);


-- ---------------------------------------------------------------------
-- 7. WORD MARKS (the teacher's mark on each word of the passage)
-- ---------------------------------------------------------------------
create table if not exists public.word_marks (
  id                    uuid primary key default gen_random_uuid(),
  owner_id              uuid not null default auth.uid() references auth.users(id) on delete cascade,
  check_id              uuid not null,
  word_index            integer not null,
  expected_text         text not null,
  mark                  text not null default 'correct'
                          check (mark in ('correct','read_differently','skipped','self_corrected','repeated','not_sure','not_reached')),
  heard_text            text,                              -- what the child said, typed by the teacher
  error_kind            text check (error_kind in ('consonant','matra_short','matra_long','conjunct','halant','bindu','chandrabindu','nukta','other')),
  corrected_by_teacher  boolean not null default false,
  created_at            timestamptz not null default now(),
  updated_at            timestamptz not null default now(),
  server_updated_at     timestamptz not null default now(),
  deleted_at            timestamptz,
  unique (check_id, word_index),
  foreign key (check_id, owner_id) references public.checks (id, owner_id) on delete cascade
);


-- ---------------------------------------------------------------------
-- 8. RETELL POINTS (story points the teacher ticked)
-- ---------------------------------------------------------------------
create table if not exists public.retell_points (
  id                uuid primary key default gen_random_uuid(),
  owner_id          uuid not null default auth.uid() references auth.users(id) on delete cascade,
  check_id          uuid not null,
  point_index       integer not null,
  ticked            boolean not null default false,
  created_at        timestamptz not null default now(),
  updated_at        timestamptz not null default now(),
  server_updated_at timestamptz not null default now(),
  deleted_at        timestamptz,
  unique (check_id, point_index),
  foreign key (check_id, owner_id) references public.checks (id, owner_id) on delete cascade
);


-- ---------------------------------------------------------------------
-- 9. QUESTION ANSWERS (tiered comprehension questions marked by teacher)
--    * Level 1 (Literal): 'fact' (e.g. 1 point)
--    * Level 2 (Inferential): 'cause_effect', 'word_meaning', 'why_how' (e.g. 2 points)
--    * Level 3 (Evaluative): 'main_idea' (e.g. 3 points)
--    * Discontinuation Rule: If Level 1 is missed, subsequent tiers can
--      be marked 'not_asked' to avoid pupil frustration.
-- ---------------------------------------------------------------------
create table if not exists public.question_answers (
  id                  uuid primary key default gen_random_uuid(),
  owner_id            uuid not null default auth.uid() references auth.users(id) on delete cascade,
  check_id            uuid not null,
  question_id         text not null,                         -- id from bank.json
  question_level      integer not null default 1 check (question_level between 1 and 5),
  question_type       text not null check (question_type in ('fact','cause_effect','word_meaning','why_how','main_idea')),
  result              text not null check (result in ('correct','partly','incorrect','no_answer','not_asked')),
  max_points          numeric(3,1) not null default 1.0,
  points_awarded      numeric(3,1) not null default 0.0,
  time_taken_seconds  numeric(6,1),                          -- time taken per question (more time -> less marks)
  answer_language     text check (answer_language in ('hi','en','mr','other')),
  created_at          timestamptz not null default now(),
  updated_at          timestamptz not null default now(),
  server_updated_at   timestamptz not null default now(),
  deleted_at          timestamptz,
  unique (check_id, question_id),
  foreign key (check_id, owner_id) references public.checks (id, owner_id) on delete cascade
);


-- ---------------------------------------------------------------------
-- 10. DICTATION & FORMATIVE ITEMS (Student typing & picture MCQs; zero OCR, zero photos)
-- ---------------------------------------------------------------------
create table if not exists public.dictation_items (
  id                     uuid primary key default gen_random_uuid(),
  owner_id               uuid not null default auth.uid() references auth.users(id) on delete cascade,
  check_id               uuid not null,
  position               integer not null,
  item_text              text not null,
  item_kind              text not null default 'word' check (item_kind in ('word','sentence','mcq_alignment','typed_spelling')),
  typed_input            text,                              -- child typing for spell check
  selected_option_index  integer,                           -- option index if MCQ line alignment test
  time_taken_seconds     numeric(6,1),
  from_misread           boolean not null default false,
  result                 text not null default 'not_marked' check (result in ('correct','incorrect','not_marked')),
  error_kind             text,
  created_at             timestamptz not null default now(),
  updated_at             timestamptz not null default now(),
  server_updated_at      timestamptz not null default now(),
  deleted_at             timestamptz,
  unique (check_id, position),
  foreign key (check_id, owner_id) references public.checks (id, owner_id) on delete cascade
);


-- ---------------------------------------------------------------------
-- 11. LISTENING CHECKS (only for children who struggle with both)
-- ---------------------------------------------------------------------
create table if not exists public.listening_checks (
  id                uuid primary key default gen_random_uuid(),
  owner_id          uuid not null default auth.uid() references auth.users(id) on delete cascade,
  child_id          uuid not null,
  check_id          uuid,
  passage_id        text not null,
  points_ticked     integer not null default 0,
  points_total      integer not null default 0,
  created_at        timestamptz not null default now(),
  updated_at        timestamptz not null default now(),
  server_updated_at timestamptz not null default now(),
  deleted_at        timestamptz,
  foreign key (child_id, owner_id) references public.children (id, owner_id) on delete cascade,
  foreign key (check_id, owner_id) references public.checks (id, owner_id) on delete cascade
);


-- ---------------------------------------------------------------------
-- 12. RESULTS (the analysed outcome of one check; speed may be empty)
-- ---------------------------------------------------------------------
create table if not exists public.results (
  id                       uuid primary key default gen_random_uuid(),
  owner_id                 uuid not null default auth.uid() references auth.users(id) on delete cascade,
  check_id                 uuid not null unique,
  child_id                 uuid not null,
  words_attempted          integer,
  words_correct            integer,
  skipped_count            integer not null default 0,
  read_differently_count   integer not null default 0,
  self_corrected_count     integer not null default 0,
  accuracy_pct             numeric(5,2),
  speed_measured           boolean not null default false,
  correct_wpm              numeric(6,1),                  -- null when speed_measured is false
  story_points_ticked      integer,
  story_points_total       integer,
  question_summary         jsonb not null default '{}'::jsonb,  -- counts per question type
  weighted_score           numeric(5,2),                  -- weighted total earned
  max_weighted_score       numeric(5,2),                  -- maximum weighted points
  dictation_marked         integer not null default 0,
  dictation_correct        integer not null default 0,
  dictation_total          integer not null default 0,
  stuck_on                 text[] not null default '{}',
  evidence_status          text not null default 'enough' check (evidence_status in ('enough','not_enough')),
  group_code               text check (group_code in ('on_track','understands_needs_reading_help','reads_needs_understanding_help','needs_help_both')),
  next_step_key            text,
  student_self_rating      text default 'not_recorded' check (student_self_rating in ('thumbs_up','thumbs_down','not_recorded')),
  created_at               timestamptz not null default now(),
  updated_at               timestamptz not null default now(),
  server_updated_at        timestamptz not null default now(),
  deleted_at               timestamptz,
  foreign key (check_id, owner_id) references public.checks (id, owner_id) on delete cascade,
  foreign key (child_id, owner_id) references public.children (id, owner_id) on delete cascade,
  check (speed_measured or correct_wpm is null)
);


-- ---------------------------------------------------------------------
-- 13. GROUP HISTORY (append-only: every suggestion and every move)
-- ---------------------------------------------------------------------
create table if not exists public.group_assignments (
  id                uuid primary key default gen_random_uuid(),
  owner_id          uuid not null default auth.uid() references auth.users(id) on delete cascade,
  child_id          uuid not null,
  group_code        text not null check (group_code in ('on_track','understands_needs_reading_help','reads_needs_understanding_help','needs_help_both')),
  source            text not null check (source in ('suggested','teacher_moved')),
  note              text,
  assigned_at       timestamptz not null default now(),
  created_at        timestamptz not null default now(),
  updated_at        timestamptz not null default now(),
  server_updated_at timestamptz not null default now(),
  deleted_at        timestamptz,
  foreign key (child_id, owner_id) references public.children (id, owner_id) on delete cascade
);


-- ---------------------------------------------------------------------
-- 14. PRACTICE NEEDS and PRINTED SHEETS
-- ---------------------------------------------------------------------
create table if not exists public.practice_needs (
  id                uuid primary key default gen_random_uuid(),
  owner_id          uuid not null default auth.uid() references auth.users(id) on delete cascade,
  child_id          uuid not null,
  check_id          uuid,
  need_code         text not null check (need_code in ('matra','conjunct','bindu','word_reading','fluency','facts','why_how','word_meaning','spelling','listening')),
  detail            text,
  created_at        timestamptz not null default now(),
  updated_at        timestamptz not null default now(),
  server_updated_at timestamptz not null default now(),
  deleted_at        timestamptz,
  foreign key (child_id, owner_id) references public.children (id, owner_id) on delete cascade,
  foreign key (check_id, owner_id) references public.checks (id, owner_id) on delete cascade
);

create table if not exists public.practice_items_printed (
  id                uuid primary key default gen_random_uuid(),
  owner_id          uuid not null default auth.uid() references auth.users(id) on delete cascade,
  child_id          uuid not null,
  printed_at        timestamptz not null default now(),
  content_hash      text not null,
  validator_passed  boolean not null,
  created_at        timestamptz not null default now(),
  updated_at        timestamptz not null default now(),
  server_updated_at timestamptz not null default now(),
  deleted_at        timestamptz,
  foreign key (child_id, owner_id) references public.children (id, owner_id) on delete cascade
);


-- ---------------------------------------------------------------------
-- 15. WEEKLY CLASS PLAN TICKS
-- ---------------------------------------------------------------------
create table if not exists public.weekly_plan_ticks (
  id                uuid primary key default gen_random_uuid(),
  owner_id          uuid not null default auth.uid() references auth.users(id) on delete cascade,
  class_id          uuid not null,
  week_start        date not null,
  group_code        text not null check (group_code in ('on_track','understands_needs_reading_help','reads_needs_understanding_help','needs_help_both')),
  activity_id       text not null,                         -- id from activities.json
  done              boolean not null default false,
  created_at        timestamptz not null default now(),
  updated_at        timestamptz not null default now(),
  server_updated_at timestamptz not null default now(),
  deleted_at        timestamptz,
  unique (class_id, week_start, group_code, activity_id),
  foreign key (class_id, owner_id) references public.classes (id, owner_id) on delete cascade
);


-- ---------------------------------------------------------------------
-- 16. PARENT REPORTS (only the approval record; the page is rebuilt on the phone)
-- ---------------------------------------------------------------------
create table if not exists public.parent_reports (
  id                   uuid primary key default gen_random_uuid(),
  owner_id             uuid not null default auth.uid() references auth.users(id) on delete cascade,
  child_id             uuid not null,
  language             text not null check (language in ('hi','en','mr')),
  generated_at         timestamptz not null default now(),
  approved_by_teacher  boolean not null default false,
  approved_at          timestamptz,
  created_at           timestamptz not null default now(),
  updated_at           timestamptz not null default now(),
  server_updated_at    timestamptz not null default now(),
  deleted_at           timestamptz,
  check (not approved_by_teacher or approved_at is not null),
  foreign key (child_id, owner_id) references public.children (id, owner_id) on delete cascade
);


-- ---------------------------------------------------------------------
-- 17. ACCEPTED PRONUNCIATIONS (the teacher's own list, per teacher)
-- ---------------------------------------------------------------------
create table if not exists public.accepted_pronunciations (
  id                uuid primary key default gen_random_uuid(),
  owner_id          uuid not null default auth.uid() references auth.users(id) on delete cascade,
  language_or_region text not null,
  expected_word     text not null,
  accepted_variant  text not null,
  created_at        timestamptz not null default now(),
  updated_at        timestamptz not null default now(),
  server_updated_at timestamptz not null default now(),
  deleted_at        timestamptz,
  unique (owner_id, language_or_region, expected_word, accepted_variant)
);


-- ---------------------------------------------------------------------
-- 18. MILESTONE STARS (teacher-awarded; no class chart, no ranking)
-- ---------------------------------------------------------------------
create table if not exists public.milestone_stars (
  id                uuid primary key default gen_random_uuid(),
  owner_id          uuid not null default auth.uid() references auth.users(id) on delete cascade,
  child_id          uuid not null,
  kind              text not null,                         -- e.g. 'moved_up_group', 'reached_benchmark'
  awarded_at        timestamptz not null default now(),
  created_at        timestamptz not null default now(),
  updated_at        timestamptz not null default now(),
  server_updated_at timestamptz not null default now(),
  deleted_at        timestamptz,
  foreign key (child_id, owner_id) references public.children (id, owner_id) on delete cascade
);


-- ---------------------------------------------------------------------
-- 19. TOMBSTONES (so other devices learn that a class or child was deleted;
--     holds no personal data, only ids)
-- ---------------------------------------------------------------------
create table if not exists public.sync_tombstones (
  id                uuid primary key default gen_random_uuid(),
  owner_id          uuid not null default auth.uid() references auth.users(id) on delete cascade,
  table_name        text not null check (table_name in ('classes','children')),
  row_id            uuid not null,
  created_at        timestamptz not null default now(),
  updated_at        timestamptz not null default now(),
  server_updated_at timestamptz not null default now(),
  deleted_at        timestamptz
);

create or replace function public.tg_record_tombstone()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.sync_tombstones (owner_id, table_name, row_id)
  values (old.owner_id, tg_table_name, old.id);
  return old;
end;
$$;

drop trigger if exists classes_tombstone on public.classes;
create trigger classes_tombstone  after delete on public.classes  for each row execute function public.tg_record_tombstone();

drop trigger if exists children_tombstone on public.children;
create trigger children_tombstone after delete on public.children for each row execute function public.tg_record_tombstone();


-- ---------------------------------------------------------------------
-- 20. SYNC HELPER TRIGGER (applies to every table that has owner_id)
--     * INSERT: stamps server_updated_at
--     * UPDATE: owner can never change; a stale edit from an old offline
--       phone is ignored (last write wins by updated_at); otherwise it
--       stamps server_updated_at so other phones can pull it.
-- ---------------------------------------------------------------------
create or replace function public.tg_sync_fields()
returns trigger
language plpgsql
as $$
begin
  if tg_op = 'INSERT' then
    new.server_updated_at := now();
    return new;
  end if;

  if new.owner_id <> old.owner_id then
    raise exception 'owner_id cannot be changed';
  end if;

  if new.updated_at < old.updated_at then
    return null;   -- stale write: keep the newer row already on the server
  end if;

  new.server_updated_at := now();
  return new;
end;
$$;


-- ---------------------------------------------------------------------
-- 21. SECURITY: Row Level Security, triggers and indexes for all tables
-- ---------------------------------------------------------------------
do $$
declare
  t text;
begin
  foreach t in array array[
    'sync_devices','classes','children','consents','checks','word_marks',
    'retell_points','question_answers','dictation_items','listening_checks',
    'results','group_assignments','practice_needs','practice_items_printed',
    'weekly_plan_ticks','parent_reports','accepted_pronunciations',
    'milestone_stars','sync_tombstones'
  ]
  loop
    execute format('alter table public.%I enable row level security', t);
    execute format('revoke all on public.%I from anon', t);
    execute format('drop policy if exists "owner full access" on public.%I', t);
    execute format(
      'create policy "owner full access" on public.%I for all to authenticated
         using (owner_id = (select auth.uid()))
         with check (owner_id = (select auth.uid()))', t);
    execute format('drop trigger if exists sync_fields on public.%I', t);
    execute format(
      'create trigger sync_fields before insert or update on public.%I
         for each row execute function public.tg_sync_fields()', t);
    execute format(
      'create index if not exists %I on public.%I (owner_id, server_updated_at)', t || '_pull_idx', t);
  end loop;
end $$;

-- Teacher profile: each teacher can read and change only their own row.
alter table public.teachers enable row level security;
revoke all on public.teachers from anon;
drop policy if exists "own profile" on public.teachers;
create policy "own profile" on public.teachers for all to authenticated
  using (id = (select auth.uid()))
  with check (id = (select auth.uid()));


-- ---------------------------------------------------------------------
-- 22. EXTRA INDEXES for the links between tables
-- ---------------------------------------------------------------------
create index if not exists children_class_idx          on public.children (class_id);
create index if not exists consents_child_idx          on public.consents (child_id);
create index if not exists checks_child_idx            on public.checks (child_id, started_at desc);
create index if not exists word_marks_check_idx        on public.word_marks (check_id);
create index if not exists retell_points_check_idx     on public.retell_points (check_id);
create index if not exists question_answers_check_idx  on public.question_answers (check_id);
create index if not exists dictation_items_check_idx   on public.dictation_items (check_id);
create index if not exists listening_checks_child_idx  on public.listening_checks (child_id);
create index if not exists results_child_idx           on public.results (child_id);
create index if not exists group_assignments_child_idx on public.group_assignments (child_id, assigned_at desc);
create index if not exists practice_needs_child_idx    on public.practice_needs (child_id);
create index if not exists printed_child_idx           on public.practice_items_printed (child_id);
create index if not exists weekly_plan_class_idx       on public.weekly_plan_ticks (class_id, week_start);
create index if not exists parent_reports_child_idx    on public.parent_reports (child_id);
create index if not exists stars_child_idx             on public.milestone_stars (child_id);


-- ---------------------------------------------------------------------
-- 23. "DELETE MY CLOUD DATA" (privacy: removes everything this teacher
--     has in the cloud; the phone's own data is not touched)
-- ---------------------------------------------------------------------
create or replace function public.delete_my_cloud_data()
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  uid uuid := auth.uid();
begin
  if uid is null then
    raise exception 'not signed in';
  end if;
  delete from public.classes where owner_id = uid;            -- cascades to children and everything below
  delete from public.accepted_pronunciations where owner_id = uid;
  delete from public.sync_devices where owner_id = uid;
  delete from public.sync_tombstones where owner_id = uid;
end;
$$;

revoke all on function public.delete_my_cloud_data() from public, anon;
grant execute on function public.delete_my_cloud_data() to authenticated;

-- Grant standard public schema permissions to anon and authenticated
grant usage on schema public to anon, authenticated, service_role;
grant all on all tables in schema public to anon, authenticated, service_role;
grant all on all sequences in schema public to anon, authenticated, service_role;
grant all on all routines in schema public to anon, authenticated, service_role;

alter default privileges in schema public grant all on tables to anon, authenticated, service_role;
alter default privileges in schema public grant all on sequences to anon, authenticated, service_role;
alter default privileges in schema public grant all on routines to anon, authenticated, service_role;


-- =====================================================================
-- CHECKS: run these after the schema to confirm everything is in place
-- =====================================================================
-- 1) Every table should show rowsecurity = true:
--    select tablename, rowsecurity from pg_tables where schemaname = 'public' order by 1;
--
-- 2) Every table should have the "owner full access" policy:
--    select tablename, policyname, roles from pg_policies where schemaname = 'public' order by 1;
--
-- 3) Triggers present:
--    select event_object_table, trigger_name from information_schema.triggers
--    where trigger_schema = 'public' order by 1;
--
-- 4) Isolation test (needs two test users A and B): sign in as A, insert a
--    class; sign in as B, select from public.classes. B must see 0 rows and
--    must get an error if B tries to insert a child pointing at A's class.
-- =====================================================================
