-- Enum for Role
CREATE TYPE user_role AS ENUM ('admin', 'employee');

-- Enum for TrainingMode
CREATE TYPE training_mode AS ENUM ('online', 'offline', 'onsite');

-- Table: users
CREATE TABLE users (
    id          VARCHAR PRIMARY KEY,
    email       VARCHAR UNIQUE NOT NULL,
    first_name  VARCHAR NOT NULL,
    middle_name VARCHAR,
    last_name   VARCHAR,
    role        user_role NOT NULL,
    training_id VARCHAR,
    created_at  TIMESTAMPTZ DEFAULT NOW() NOT NULL,
    updated_at  TIMESTAMPTZ DEFAULT NOW() NOT NULL,
    CONSTRAINT fk_training FOREIGN KEY (training_id) REFERENCES training(id) ON DELETE SET NULL
);

-- Table: secrets
CREATE TABLE secrets (
    user_id  VARCHAR PRIMARY KEY,
    password VARCHAR NOT NULL,
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Table: subjects
CREATE TABLE subjects (
    id         VARCHAR PRIMARY KEY,
    name       VARCHAR NOT NULL,
    min_marks  INT NOT NULL,
    max_marks  INT NOT NULL,
    total_time INT NOT NULL,
    training_id VARCHAR,
    created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

-- Table: training
CREATE TABLE training (
    id         VARCHAR PRIMARY KEY,
    name       VARCHAR NOT NULL,
    mode       training_mode NOT NULL,
    subject_id VARCHAR NOT NULL,
    started_at TIMESTAMPTZ NOT NULL,
    ended_at   TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
    CONSTRAINT fk_subject FOREIGN KEY (subject_id) REFERENCES subjects(id) ON DELETE CASCADE
);

-- Table: assessments
CREATE TABLE assessments (
    user_id          VARCHAR NOT NULL,
    training_id      VARCHAR NOT NULL,
    marks            INT NOT NULL,
    internet_allowed BOOLEAN NOT NULL,
    PRIMARY KEY (user_id, training_id),
    CONSTRAINT fk_user_assessment FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_training_assessment FOREIGN KEY (training_id) REFERENCES training(id) ON DELETE CASCADE
);

-- Add relations between subjects and training
ALTER TABLE subjects ADD CONSTRAINT fk_training_subject FOREIGN KEY (training_id) REFERENCES training(id) ON DELETE SET NULL;
