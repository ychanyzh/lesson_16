CREATE TABLE "users" (
  "id" integer PRIMARY KEY,
  "username" varchar,
  "role" varchar,
  "created_at" timestamp
);

CREATE TABLE "hosts" (
  "id" integer,
  "num_reviews" int,
  "verified_identity" boolean,
  "superhost" boolean,
  "languages" varchar[],
  "response_rate" decimal,
  "response_time" varchar
);

CREATE TABLE "guests" (
  "id" integer,
  "can_pay_for_reservation" boolean,
  "can_review_host" boolean
);

CREATE TABLE "rooms" (
  "id" integer PRIMARY KEY,
  "host_id" integer,
  "room_name" varchar,
  "room_description" text,
  "max_residents" int,
  "price_per_night" decimal,
  "has_wifi" boolean,
  "has_free_parking" boolean,
  "has_waterfront" boolean,
  "has_tv_with_cable" boolean,
  "has_hair_dryer" boolean,
  "rating" decimal,
  "common_spaces" varchar[]
);

CREATE TABLE "reservations" (
  "id" integer PRIMARY KEY,
  "guest_id" integer,
  "room_id" integer,
  "check_in_date" timestamp,
  "check_out_date" timestamp,
  "total_price" decimal,
  "reservation_status" varchar,
  "payment_status" varchar
);

CREATE TABLE "reviews" (
  "id" integer PRIMARY KEY,
  "guest_id" integer,
  "room_id" integer,
  "cleanliness_rating" int,
  "accuracy_rating" int,
  "communication_rating" int,
  "location_rating" int,
  "checkin_rating" int,
  "value_rating" int,
  "total_rating" decimal,
  "review_text" text,
  "review_date" timestamp
);

COMMENT ON COLUMN "hosts"."languages" IS 'Array of languages spoken';

COMMENT ON COLUMN "hosts"."response_rate" IS 'Percentage';

COMMENT ON COLUMN "hosts"."response_time" IS 'Response time description';

COMMENT ON COLUMN "rooms"."common_spaces" IS 'Array of common space descriptions';

COMMENT ON COLUMN "reservations"."payment_status" IS 'Pending, Completed, Failed, etc.';

COMMENT ON COLUMN "reviews"."total_rating" IS 'Calculated total rating';

ALTER TABLE "hosts" ADD FOREIGN KEY ("id") REFERENCES "users" ("id");

ALTER TABLE "guests" ADD FOREIGN KEY ("id") REFERENCES "users" ("id");

ALTER TABLE "rooms" ADD FOREIGN KEY ("host_id") REFERENCES "hosts" ("id");

ALTER TABLE "reservations" ADD FOREIGN KEY ("guest_id") REFERENCES "guests" ("id");

ALTER TABLE "reservations" ADD FOREIGN KEY ("room_id") REFERENCES "rooms" ("id");

ALTER TABLE "reviews" ADD FOREIGN KEY ("guest_id") REFERENCES "guests" ("id");

ALTER TABLE "reviews" ADD FOREIGN KEY ("room_id") REFERENCES "rooms" ("id");

ALTER TABLE "rooms" ADD FOREIGN KEY ("id") REFERENCES "hosts" ("id");

ALTER TABLE "reservations" ADD FOREIGN KEY ("id") REFERENCES "guests" ("id");

ALTER TABLE "reservations" ADD FOREIGN KEY ("id") REFERENCES "rooms" ("id");

ALTER TABLE "reviews" ADD FOREIGN KEY ("id") REFERENCES "guests" ("id");

ALTER TABLE "reviews" ADD FOREIGN KEY ("id") REFERENCES "rooms" ("id");
