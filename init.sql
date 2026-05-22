-- init.sql: Database initialization for dragon-tap

CREATE TABLE IF NOT EXISTS todos (
  id SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT,
  status TEXT NOT NULL DEFAULT 'pending',
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE IF NOT EXISTS todo_deps (
  todo_id INTEGER NOT NULL,
  depends_on INTEGER NOT NULL,
  PRIMARY KEY (todo_id, depends_on),
  FOREIGN KEY (todo_id) REFERENCES todos(id) ON DELETE CASCADE,
  FOREIGN KEY (depends_on) REFERENCES todos(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS inbox_entries (
  id SERIAL PRIMARY KEY,
  content TEXT,
  created_at TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE todos OWNER TO dragon;
ALTER TABLE todo_deps OWNER TO dragon;
ALTER TABLE inbox_entries OWNER TO dragon;

