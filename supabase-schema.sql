-- 小芒狗记账 · Supabase 建表 SQL
-- 在 Supabase SQL Editor 中执行

-- 1. 交易表
create table if not exists transactions (
  id text primary key,                  -- 本地生成的 id（时间戳）
  user_id uuid not null default auth.uid() references auth.users(id),
  type text not null,                   -- expense / income
  category text,
  amount numeric not null,
  description text,                     -- 账单描述
  date date not null,
  pay_method text default 'wechat',
  client_ts bigint,                     -- 本地时间戳
  updated_at timestamptz default now(),
  deleted boolean default false         -- 软删除
);

-- 2. 用户设置表
create table if not exists user_settings (
  user_id uuid primary key default auth.uid() references auth.users(id),
  daily_budget numeric,
  data jsonb default '{}'::jsonb,
  updated_at timestamptz default now()
);

-- 3. RLS 策略（必须开启）
alter table transactions enable row level security;
create policy "own_select" on transactions for select using (auth.uid() = user_id);
create policy "own_insert" on transactions for insert with check (auth.uid() = user_id);
create policy "own_update" on transactions for update using (auth.uid() = user_id);
create policy "own_delete" on transactions for delete using (auth.uid() = user_id);

alter table user_settings enable row level security;
create policy "own_select" on user_settings for select using (auth.uid() = user_id);
create policy "own_insert" on user_settings for insert with check (auth.uid() = user_id);
create policy "own_update" on user_settings for update using (auth.uid() = user_id);
create policy "own_delete" on user_settings for delete using (auth.uid() = user_id);

-- 4. 索引
create index if not exists idx_transactions_user_date on transactions(user_id, date desc);
create index if not exists idx_transactions_updated on transactions(user_id, updated_at desc);
