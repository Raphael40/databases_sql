CREATE TABLE cohorts (
  id SERIAL PRIMARY KEY,
  names text,
  start_date date
);

CREATE TABLE students (
  id SERIAL PRIMARY KEY,
  names text,
-- The foreign key name is always {other_table_singular}_id
  cohort_id int,
  constraint fk_cohort foreign key(cohort_id)
    references cohorts(id)
    on delete cascade
);