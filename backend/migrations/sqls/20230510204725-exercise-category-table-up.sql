CREATE TABLE exercise_category (
  excercise_category_id SERIAL PRIMARY KEY,
  excercise_category_name VARCHAR(100) NOT NULL,
  excercise_category_thumbnail_path VARCHAR(255) NOT NULL
);