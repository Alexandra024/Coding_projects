CREATE DATABASE DIAGRAMA_ER;
USE DIAGRAMA_ER;

-- Table: Users
CREATE TABLE Users (
    name VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL,
    nickname VARCHAR(50) UNIQUE NOT NULL,
    login INT NOT NULL,
    password VARCHAR(250) NOT NULL
);

-- Table: Avatar
CREATE TABLE Avatar (
    appearance TEXT NOT NULL,
    level INT NOT NULL,
    user_nickname VARCHAR(50) NOT NULL,
    game_type VARCHAR(50) NOT NULL CHECK (game_type IN ('FOOTBALL', 'GOLF', 'TENNIS', 'BASKETBALL'))
);

-- Table: GameType
CREATE TABLE GameType (
    game_type_id BIGINT NOT NULL,
    name VARCHAR(50) NOT NULL,
    description TEXT,
    game_rules TEXT
);

-- Table: Matches
CREATE TABLE Matches (
    match_id BIGINT NOT NULL,
    name VARCHAR(50) NOT NULL,
    password VARCHAR(255),
    creation_date_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) NOT NULL CHECK (status IN ('FINISHED', 'ONGOING', 'NOT_STARTED')),
    creator_avatar VARCHAR(200),
    game_type VARCHAR(50) NOT NULL CHECK (game_type IN ('FOOTBALL', 'GOLF', 'TENNIS', 'BASKETBALL')),
    registered_users VARCHAR(255)
);

-- Table: Encounters
CREATE TABLE Encounters (
    encounter_id BIGINT NOT NULL,
    match_id BIGINT NOT NULL,
    avatars VARCHAR(20) NOT NULL CHECK (avatars IN ('DEFAULT', 'NINJA', 'SAMURAI', 'WARRIOR')),
    score BIGINT
);

-- Relationships:
-- Avatar.user_nickname REFERENCES Users.nickname
-- Avatar.game_type REFERENCES GameType.name
-- Matches.game_type REFERENCES GameType.name
-- Encounters.match_id REFERENCES Matches.match_id


-- Ensure that Avatar table has the correct primary and foreign keys
ALTER TABLE Avatar
    ADD PRIMARY KEY (user_nickname),
    ADD CONSTRAINT fk_avatar_user FOREIGN KEY (user_nickname) REFERENCES Users(nickname),
    ADD CONSTRAINT fk_avatar_game FOREIGN KEY (game_type) REFERENCES GameType(name);

-- Ensure GameType has a primary key and unique constraint on name
ALTER TABLE GameType
    ADD PRIMARY KEY (game_type_id),
    ADD CONSTRAINT unique_game_name UNIQUE (name); -- Ensures 'name' is unique

-- Ensure Matches has a primary key and a valid foreign key to GameType
ALTER TABLE Matches
    ADD PRIMARY KEY (match_id),
    ADD CONSTRAINT fk_match_game FOREIGN KEY (game_type) REFERENCES GameType(name);

-- Ensure Encounters has a primary key and references Matches correctly
ALTER TABLE Encounters
    ADD PRIMARY KEY (encounter_id),
    ADD CONSTRAINT fk_encounter_match FOREIGN KEY (match_id) REFERENCES Matches(match_id);
