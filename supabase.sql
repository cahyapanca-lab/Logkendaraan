-- Jalankan di Supabase > SQL Editor
create table public.trips (
  id uuid primary key default gen_random_uuid(),
  trip_date date not null,
  time_out time not null,
  rider text not null,
  plate text not null,
  dest text not null,
  purpose text not null,
  km_start integer not null check (km_start >= 0),
  time_in time,
  km_end integer check (km_end >= 0),
  fuel integer check (fuel >= 0),
  note text,
  status text not null default 'open' check (status in ('open','done')),
  created_by uuid default auth.uid() references auth.users(id) on delete set null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  check (km_end is null or km_end >= km_start)
);
create index trips_date_idx on public.trips (trip_date desc);

alter table public.trips enable row level security;
create policy "read"   on public.trips for select to authenticated using (true);
create policy "insert" on public.trips for insert to authenticated with check (true);
create policy "update" on public.trips for update to authenticated using (true) with check (true);
create policy "delete" on public.trips for delete to authenticated using (true);

alter publication supabase_realtime add table public.trips;

-- View rapi untuk Excel (Power Query / Google Sheets)
create view public.trips_export with (security_invoker = true) as
select trip_date as "Tanggal", rider as "Pemakai", plate as "Motor", purpose as "Keperluan", dest as "Tujuan",
       time_out as "Jam keluar", time_in as "Jam kembali", km_start as "KM awal", km_end as "KM akhir",
       km_end - km_start as "Jarak (km)", fuel as "BBM (Rp)", note as "Catatan",
       case status when 'done' then 'Selesai' else 'Sedang dipakai' end as "Status"
from public.trips order by trip_date, time_out;
