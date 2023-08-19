-- Table: users
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  username VARCHAR,
  role VARCHAR,
  created_at TIMESTAMP
);

-- Table: hosts (Many-to-One with users, One-to-Many with rooms)
CREATE TABLE hosts (
  id SERIAL,
  user_id INTEGER REFERENCES users(id),  -- Many-to-One relationship with users
  num_reviews INT,
  verified_identity BOOLEAN,
  superhost BOOLEAN,
  languages VARCHAR[],
  response_rate DECIMAL,
  response_time VARCHAR,
  PRIMARY KEY (id, user_id)  -- Composite primary key
);

-- Table: guests (Many-to-One with users)
CREATE TABLE guests (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id)  -- Many-to-One relationship with users
);

-- Table: rooms (Many-to-One with hosts, One-to-Many with reservations and reviews)
CREATE TABLE rooms (
  id SERIAL PRIMARY KEY,
  host_id INTEGER REFERENCES hosts(id),  -- Many-to-One relationship with hosts
  room_name VARCHAR,
  room_description TEXT,
  max_residents INT,
  price_per_night DECIMAL,
  has_wifi BOOLEAN,
  has_free_parking BOOLEAN,
  has_waterfront BOOLEAN,
  has_tv_with_cable BOOLEAN,
  has_hair_dryer BOOLEAN,
  rating DECIMAL,
  common_spaces VARCHAR[],
  PRIMARY KEY (id, host_id)  -- Composite primary key
);

-- Table: reservations (Many-to-One with guests and rooms)
CREATE TABLE reservations (
  id SERIAL PRIMARY KEY,
  guest_id INTEGER REFERENCES guests(id),  -- Many-to-One relationship with guests
  room_id INTEGER REFERENCES rooms(id),  -- Many-to-One relationship with rooms
  check_in_date TIMESTAMP,
  check_out_date TIMESTAMP,
  total_price DECIMAL,
  reservation_status VARCHAR,
  payment_status VARCHAR
);

-- Table: reviews (Many-to-One with guests and rooms)
CREATE TABLE reviews (
  id SERIAL PRIMARY KEY,
  guest_id INTEGER REFERENCES guests(id),  -- Many-to-One relationship with guests
  room_id INTEGER REFERENCES rooms(id),  -- Many-to-One relationship with rooms
  cleanliness_rating INT,
  accuracy_rating INT,
  communication_rating INT,
  location_rating INT,
  checkin_rating INT,
  value_rating INT,
  total_rating DECIMAL,
  review_text TEXT,
  review_date TIMESTAMP
);
