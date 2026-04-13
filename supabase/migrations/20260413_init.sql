-- Meal Plans table (shared between family)
CREATE TABLE IF NOT EXISTS meal_plans (
  id SERIAL PRIMARY KEY,
  week_key TEXT NOT NULL,
  day_key TEXT NOT NULL,
  meal TEXT NOT NULL CHECK (meal IN ('breakfast', 'lunch', 'dinner')),
  title TEXT,
  ate_out BOOLEAN DEFAULT FALSE,
  restaurant TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(week_key, day_key, meal)
);

-- Recipe Ratings & Notes (shared)
CREATE TABLE IF NOT EXISTS recipe_ratings (
  id SERIAL PRIMARY KEY,
  recipe_title TEXT NOT NULL UNIQUE,
  stars INTEGER CHECK (stars >= 1 AND stars <= 5),
  note TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Custom Inventory Items
CREATE TABLE IF NOT EXISTS custom_inventory (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  brand TEXT DEFAULT '',
  category TEXT NOT NULL,
  location TEXT NOT NULL,
  nutrition JSONB,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable RLS but allow anonymous access (family app)
ALTER TABLE meal_plans ENABLE ROW LEVEL SECURITY;
ALTER TABLE recipe_ratings ENABLE ROW LEVEL SECURITY;
ALTER TABLE custom_inventory ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow all meal_plans" ON meal_plans FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow all recipe_ratings" ON recipe_ratings FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow all custom_inventory" ON custom_inventory FOR ALL USING (true) WITH CHECK (true);
