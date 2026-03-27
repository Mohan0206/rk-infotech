-- ============================================
-- RK INFOTECH — COMPLETE DATABASE SETUP
-- Supabase SQL Editor में यह पूरा paste करें
-- ============================================

-- 1. CUSTOMERS
CREATE TABLE IF NOT EXISTS customers (
  id BIGSERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  phone TEXT,
  whatsapp TEXT,
  email TEXT,
  city TEXT,
  address TEXT,
  type TEXT DEFAULT 'Home',
  sites JSONB DEFAULT '[]',
  notes TEXT,
  created_at DATE
);

-- 2. LEADS
CREATE TABLE IF NOT EXISTS leads (
  id BIGSERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  phone TEXT,
  source TEXT,
  stage TEXT DEFAULT 'New',
  followup DATE,
  lost_reason TEXT,
  notes TEXT,
  date DATE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 3. EMPLOYEES
CREATE TABLE IF NOT EXISTS employees (
  id BIGSERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  phone TEXT,
  role TEXT,
  salary NUMERIC DEFAULT 0,
  salary_type TEXT DEFAULT 'Fixed',
  daily_wage NUMERIC DEFAULT 0,
  bank_name TEXT,
  account_no TEXT,
  ifsc TEXT,
  status TEXT DEFAULT 'Active',
  joined_date DATE,
  address TEXT,
  notes TEXT
);

-- 4. JOBS
CREATE TABLE IF NOT EXISTS jobs (
  id BIGSERIAL PRIMARY KEY,
  customer_id BIGINT,
  customer_name TEXT,
  customer_phone TEXT,
  type TEXT DEFAULT 'Installation',
  status TEXT DEFAULT 'Pending',
  priority TEXT DEFAULT 'Medium',
  tech_id BIGINT,
  tech_name TEXT,
  amount NUMERIC DEFAULT 0,
  date DATE,
  notes TEXT,
  items JSONB DEFAULT '[]',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 5. QUOTATIONS
CREATE TABLE IF NOT EXISTS quotations (
  id BIGSERIAL PRIMARY KEY,
  customer_id BIGINT,
  customer_name TEXT,
  customer_phone TEXT,
  items JSONB DEFAULT '[]',
  subtotal NUMERIC DEFAULT 0,
  gst_pct NUMERIC DEFAULT 0,
  gst_amt NUMERIC DEFAULT 0,
  discount NUMERIC DEFAULT 0,
  grand_total NUMERIC DEFAULT 0,
  status TEXT DEFAULT 'Draft',
  expiry_date DATE,
  notes TEXT,
  date DATE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 6. INVOICES
CREATE TABLE IF NOT EXISTS invoices (
  id BIGSERIAL PRIMARY KEY,
  customer_id BIGINT,
  customer_name TEXT,
  customer_phone TEXT,
  cust_addr TEXT,
  job_id BIGINT,
  items JSONB DEFAULT '[]',
  subtotal NUMERIC DEFAULT 0,
  gst_pct NUMERIC DEFAULT 0,
  gst_amt NUMERIC DEFAULT 0,
  discount NUMERIC DEFAULT 0,
  grand_total NUMERIC DEFAULT 0,
  paid_total NUMERIC DEFAULT 0,
  pending_amt NUMERIC DEFAULT 0,
  payments JSONB DEFAULT '[]',
  status TEXT DEFAULT 'Pending',
  date DATE,
  due_date DATE,
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 7. INVENTORY
CREATE TABLE IF NOT EXISTS inventory (
  id BIGSERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  category TEXT,
  brand TEXT,
  model TEXT,
  unit TEXT DEFAULT 'Pcs',
  stock NUMERIC DEFAULT 0,
  reserved NUMERIC DEFAULT 0,
  min_qty NUMERIC DEFAULT 5,
  buy_rate NUMERIC DEFAULT 0,
  sell_rate NUMERIC DEFAULT 0,
  notes TEXT,
  added_on DATE
);

-- 8. STOCK MOVEMENTS
CREATE TABLE IF NOT EXISTS stock_movements (
  id BIGSERIAL PRIMARY KEY,
  item_id BIGINT,
  type TEXT,
  qty NUMERIC,
  reference TEXT,
  note TEXT,
  date DATE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 9. AMC
CREATE TABLE IF NOT EXISTS amcs (
  id BIGSERIAL PRIMARY KEY,
  customer_id BIGINT,
  customer_name TEXT,
  customer_phone TEXT,
  site TEXT,
  site_index TEXT,
  start_date DATE,
  expiry_date DATE,
  amount NUMERIC DEFAULT 0,
  paid NUMERIC DEFAULT 0,
  tech_id BIGINT,
  status TEXT DEFAULT 'Active',
  cameras INTEGER DEFAULT 0,
  cam_type TEXT,
  dvr TEXT,
  dvr_brand TEXT,
  notes TEXT,
  visits JSONB DEFAULT '[]',
  renewals JSONB DEFAULT '[]',
  added_on DATE
);

-- 10. ATTENDANCE
CREATE TABLE IF NOT EXISTS attendance (
  id BIGSERIAL PRIMARY KEY,
  employee_id BIGINT,
  date DATE,
  status TEXT DEFAULT 'present'
);

-- 11. TASKS (old system)
CREATE TABLE IF NOT EXISTS tasks (
  id BIGSERIAL PRIMARY KEY,
  employee_id BIGINT,
  employee_name TEXT,
  title TEXT,
  description TEXT,
  status TEXT DEFAULT 'Pending',
  priority TEXT DEFAULT 'Medium',
  due_date DATE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 12. SALARY ADJUSTMENTS
CREATE TABLE IF NOT EXISTS salary_adjustments (
  id BIGSERIAL PRIMARY KEY,
  employee_id BIGINT,
  type TEXT,
  amount NUMERIC DEFAULT 0,
  description TEXT,
  date DATE
);

-- 13. EMPLOYEE ACCESS
CREATE TABLE IF NOT EXISTS employee_access (
  id BIGSERIAL PRIMARY KEY,
  employee_id BIGINT,
  employee_name TEXT,
  phone TEXT UNIQUE NOT NULL,
  pin TEXT NOT NULL,
  modules TEXT[] DEFAULT '{}',
  status TEXT DEFAULT 'Active',
  notes TEXT,
  created_at DATE,
  updated_at DATE
);

-- 14. EMPLOYEE TASKS
CREATE TABLE IF NOT EXISTS employee_tasks (
  id BIGSERIAL PRIMARY KEY,
  employee_id BIGINT,
  employee_name TEXT,
  title TEXT NOT NULL,
  description TEXT,
  module TEXT,
  status TEXT DEFAULT 'Pending',
  priority TEXT DEFAULT 'Medium',
  due_date DATE,
  created_at DATE
);

-- 15. EMPLOYEE ACTIVITY LOG
CREATE TABLE IF NOT EXISTS employee_activity (
  id BIGSERIAL PRIMARY KEY,
  employee_id BIGINT,
  employee_name TEXT,
  type TEXT,
  module TEXT,
  description TEXT,
  location TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 16. ATTENDANCE LOG (new with GPS)
CREATE TABLE IF NOT EXISTS attendance_log (
  id BIGSERIAL PRIMARY KEY,
  employee_id BIGINT,
  employee_name TEXT,
  date DATE NOT NULL,
  time_in TIMESTAMPTZ,
  time_out TIMESTAMPTZ,
  status TEXT DEFAULT 'present',
  lat NUMERIC,
  lng NUMERIC,
  location_addr TEXT,
  selfie_url TEXT,
  selfie_base64 TEXT
);

-- 17. DAILY REPORTS
CREATE TABLE IF NOT EXISTS daily_reports (
  id BIGSERIAL PRIMARY KEY,
  employee_id BIGINT,
  employee_name TEXT,
  date DATE,
  work_done TEXT[],
  details TEXT,
  problem TEXT,
  mood TEXT DEFAULT 'ok',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 18. MEETINGS
CREATE TABLE IF NOT EXISTS meetings (
  id BIGSERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  type TEXT DEFAULT 'weekly',
  date DATE,
  time TEXT,
  location TEXT,
  duration TEXT,
  description TEXT,
  minutes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 19. ANNOUNCEMENTS
CREATE TABLE IF NOT EXISTS announcements (
  id BIGSERIAL PRIMARY KEY,
  title TEXT,
  body TEXT,
  type TEXT DEFAULT 'general',
  expiry_date DATE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 20. RECOGNITION
CREATE TABLE IF NOT EXISTS recognition (
  id BIGSERIAL PRIMARY KEY,
  employee_id BIGINT,
  employee_name TEXT,
  badge TEXT DEFAULT '⭐',
  title TEXT,
  message TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 21. HELP REQUESTS
CREATE TABLE IF NOT EXISTS help_requests (
  id BIGSERIAL PRIMARY KEY,
  employee_id BIGINT,
  employee_name TEXT,
  category TEXT,
  message TEXT,
  urgency TEXT DEFAULT 'normal',
  anonymous BOOLEAN DEFAULT false,
  status TEXT DEFAULT 'Pending',
  admin_reply TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 22. BANK ACCOUNTS
CREATE TABLE IF NOT EXISTS bank_accounts (
  id BIGSERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  holder TEXT,
  account_no TEXT,
  ifsc TEXT,
  account_type TEXT DEFAULT 'Current',
  current_balance NUMERIC DEFAULT 0,
  opening_balance NUMERIC DEFAULT 0,
  upi TEXT,
  low_balance_alert NUMERIC,
  color TEXT,
  added_on DATE
);

-- 23. PAYMENTS
CREATE TABLE IF NOT EXISTS payments (
  id BIGSERIAL PRIMARY KEY,
  type TEXT NOT NULL,
  description TEXT,
  amount NUMERIC NOT NULL,
  date DATE,
  mode TEXT,
  party_name TEXT,
  customer_id BIGINT,
  employee_id BIGINT,
  employee_name TEXT,
  category TEXT,
  reference TEXT,
  bank_id BIGINT,
  to_bank_id BIGINT,
  txn_id TEXT,
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 24. EMPLOYEE PHOTOS ← यह table नहीं थी!
CREATE TABLE IF NOT EXISTS employee_photos (
  id BIGSERIAL PRIMARY KEY,
  employee_id BIGINT NOT NULL,
  employee_name TEXT,
  photo_type TEXT NOT NULL,
  photo_url TEXT,
  photo_base64 TEXT,
  file_name TEXT,
  description TEXT,
  job_id BIGINT,
  lat NUMERIC,
  lng NUMERIC,
  location_addr TEXT,
  task_title TEXT,
  task_module TEXT,
  date DATE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================
-- RLS POLICIES (सब allow)
-- ============================================
DO $$ 
DECLARE t TEXT;
BEGIN
  FOR t IN SELECT unnest(ARRAY[
    'customers','leads','employees','jobs','quotations','invoices',
    'inventory','stock_movements','amcs','attendance','tasks',
    'salary_adjustments','employee_access','employee_tasks',
    'employee_activity','attendance_log','daily_reports','meetings',
    'announcements','recognition','help_requests','bank_accounts',
    'payments','employee_photos'
  ]) LOOP
    EXECUTE format('ALTER TABLE %I ENABLE ROW LEVEL SECURITY', t);
    EXECUTE format('
      DO $inner$
      BEGIN
        IF NOT EXISTS (
          SELECT 1 FROM pg_policies 
          WHERE tablename = %L AND policyname = %L
        ) THEN
          EXECUTE $pol$CREATE POLICY "allow_all_%s" ON %I FOR ALL USING (true) WITH CHECK (true)$pol$;
        END IF;
      END $inner$;
    ', t, 'allow_all_'||t, t, t);
  END LOOP;
END $$;

-- Storage bucket
INSERT INTO storage.buckets (id, name, public)
VALUES ('employee-photos', 'employee-photos', true)
ON CONFLICT (id) DO NOTHING;

-- ============================================
-- VERIFY — Tables check करें
-- ============================================
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' 
ORDER BY table_name;
