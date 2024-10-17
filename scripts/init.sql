-- enum for user roles
CREATE TYPE user_role AS ENUM ('admin', 'employee');

-- enum for training modes
CREATE TYPE training_mode AS ENUM ('online', 'offline', 'onsite');

-- table: users
CREATE TABLE users (
    id VARCHAR PRIMARY KEY,
    email VARCHAR UNIQUE NOT NULL,
    first_name VARCHAR NOT NULL,
    middle_name VARCHAR,
    last_name VARCHAR,
    role user_role NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

-- table: secrets
CREATE TABLE secrets (
    user_id VARCHAR PRIMARY KEY,
    password VARCHAR NOT NULL
);

-- table: subjects
CREATE TABLE subjects (
    id VARCHAR PRIMARY KEY,
    name VARCHAR NOT NULL,
    min_marks INT NOT NULL,
    max_marks INT NOT NULL,
    total_time INT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

-- table: trainings
CREATE TABLE trainings (
    id VARCHAR PRIMARY KEY,
    name VARCHAR NOT NULL,
    mode training_mode NOT NULL,
    subject_id VARCHAR NOT NULL,
    started_at TIMESTAMPTZ NOT NULL,
    ended_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
    CONSTRAINT fk_subject FOREIGN KEY (subject_id) REFERENCES subjects(id) ON DELETE CASCADE
);

-- table: assessments
CREATE TABLE assessments (
    user_id VARCHAR NOT NULL,
    training_id VARCHAR NOT NULL,
    marks INT NOT NULL,
    internet_allowed BOOLEAN NOT NULL,
    PRIMARY KEY (user_id, training_id),
    CONSTRAINT fk_user_assessment FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_training_assessment FOREIGN KEY (training_id) REFERENCES trainings(id) ON DELETE CASCADE
);
