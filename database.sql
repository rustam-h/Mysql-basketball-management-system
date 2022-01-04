-- Create and use database
DROP DATABASE IF EXISTS Basketball_Management_System;
CREATE DATABASE Basketball_Management_System;
USE Basketball_Management_System;

-- Table General_Stats

DROP TABLE IF EXISTS General_Stats ;

CREATE TABLE General_Stats (
  general_stats_id INT NOT NULL AUTO_INCREMENT,
  games_played INT NULL,
  points FLOAT NULL,
  rebounds FLOAT NULL,
  assists FLOAT NULL,
  field_goal_percentage FLOAT NULL,
  3pt_percentage FLOAT NULL,
  free_throw_percentage FLOAT NULL,
  PRIMARY KEY (general_stats_id))
;

-- Table Advanced_Stats

DROP TABLE IF EXISTS Advanced_Stats ;

CREATE TABLE Advanced_Stats (
  advanced_stats_id INT NOT NULL AUTO_INCREMENT,
  player_efficiency_rating FLOAT NULL,
  true_shooting_percentage FLOAT NULL,
  win_shares FLOAT NULL,
  box_plus_minus FLOAT NULL,
  PRIMARY KEY (advanced_stats_id))
;

-- Table Team_Summary

DROP TABLE IF EXISTS Team_Summary ;

CREATE TABLE Team_Summary (
  summary_id INT NOT NULL AUTO_INCREMENT,
  played_seasons INT NULL,
  playoff_appearances INT NULL,
  win_lose_percentage FLOAT NULL,
  championships INT NULL,
  hall_of_fame_player_count INT NULL,
  PRIMARY KEY (summary_id))
;

-- Table Coach

DROP TABLE IF EXISTS Coach ;

CREATE TABLE Coach (
  coach_id INT NOT NULL AUTO_INCREMENT,
  full_name VARCHAR(45) NULL,
  age INT NULL,
  coaching_season_count INT NULL,
  coach_of_the_year_count INT NULL,
  PRIMARY KEY (coach_id))
;

-- Table Conference

DROP TABLE IF EXISTS Conference ;

CREATE TABLE Conference (
  conference_id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(45) NULL,
  PRIMARY KEY (conference_id))
;

-- Table Division

DROP TABLE IF EXISTS Division ;

CREATE TABLE Division (
  division_id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(45) NULL,
  conference_id INT NOT NULL,
  PRIMARY KEY (division_id, conference_id),
  CONSTRAINT fk_conference_id
    FOREIGN KEY (conference_id)
    REFERENCES Conference (conference_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

-- Table Team

DROP TABLE IF EXISTS Team ;

CREATE TABLE Team (
  team_id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NULL,
  state VARCHAR(45) NULL,
  arena VARCHAR(255) NULL,
  current_win_lose_percentage FLOAT NULL,
  summary_id INT NOT NULL,
  coach_id INT NOT NULL,
  division_id INT NOT NULL,
  PRIMARY KEY (team_id),
  CONSTRAINT fk_summary_id
    FOREIGN KEY (summary_id)
    REFERENCES Team_Summary (summary_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_coach_id
    FOREIGN KEY (coach_id)
    REFERENCES Coach (coach_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_division_id
    FOREIGN KEY (division_id)
    REFERENCES Division (division_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

-- Table Player

DROP TABLE IF EXISTS Player ;

CREATE TABLE Player (
  player_id INT NOT NULL AUTO_INCREMENT,
  full_name VARCHAR(45) NULL,
  position VARCHAR(45) NULL,
  shooting_hand VARCHAR(45) NULL,
  height INT NULL,
  age INT NULL,
  college TINYINT NULL,
  general_stats_id INT NOT NULL,
  advanced_stats_id INT NOT NULL,
  team_id INT NOT NULL,
  PRIMARY KEY (player_id),
  CONSTRAINT fk_general_stats_id
    FOREIGN KEY (general_stats_id)
    REFERENCES General_Stats (general_stats_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_advanced_stats_id
    FOREIGN KEY (advanced_stats_id)
    REFERENCES Advanced_Stats (advanced_stats_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_team_id
    FOREIGN KEY (team_id)
    REFERENCES Team (team_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;



-- Table Award

DROP TABLE IF EXISTS Award ;

CREATE TABLE Award (
  award_name VARCHAR(40) NOT NULL,
  description VARCHAR(255) NULL,
  PRIMARY KEY (award_name))
;



-- Table Player_Award_Relationship

DROP TABLE IF EXISTS Player_Award_Relationship ;

CREATE TABLE Player_Award_Relationship (
  relationship_id INT NOT NULL AUTO_INCREMENT,
  award_name VARCHAR(45) NOT NULL,
  player_id INT NOT NULL,
  count INT NULL,
  PRIMARY KEY (relationship_id),
  CONSTRAINT fk_award_name
    FOREIGN KEY (award_name)
    REFERENCES Award (award_name)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_player_id
    FOREIGN KEY (player_id)
    REFERENCES Player (player_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


INSERT INTO Conference(name)
VALUES
("West"),
("East");

INSERT INTO Division(name, conference_id)
VALUES
("Northwest", 1),
("Pacific", 1),
("Southwest", 1),
("Atlantic", 2),
("Central", 2),
("Southeast", 2);

INSERT INTO Coach(full_name, age, coaching_season_count, coach_of_the_year_count)
VALUES
('Doc Rivers', 60, 23, 1),
('Brad Stevens', 45, 8, 0),
('Mike Budenholzer', 52, 9, 2),
('Nate Bjorkgren', 46, 1, 0),
('Nate McMillan', 57, 18, 0),
('Erik Spoelstra', 51, 14, 0),
('Quin Snyder', 55, 8, 0),
('Michael Malone', 50, 9, 0),
('Monty Williams', 50, 8, 0),
('Frank Vogel', 48, 11, 0),
('Rick Carlisle', 62, 20, 1),
('Taylor Jenkins', 37, 3, 0);

INSERT INTO Team_Summary(played_seasons, playoff_appearances, win_lose_percentage, championships, hall_of_fame_player_count)
VALUES
(73, 51, 0.518, 3, 19),
(76, 58, 0.589, 17, 37),
(54, 33, 0.522, 2, 15),
(55, 36, 0.515, 3, 8),
(73, 47, 0.493, 1, 20),
(34, 22, 0.523, 3, 5),
(48, 30, 0.545, 0, 8),
(55, 36, 0.506, 0, 10),
(54, 30, 0.533, 0, 11),
(74, 62, 0.595, 17, 27),
(42, 23, 0.503, 1, 5),
(27, 11, 0.421, 0, 1);

INSERT INTO Team(name, state, arena, current_win_lose_percentage, summary_id, coach_id, division_id)
VALUES
('Philadelphia 76ers', 'Pennsylvania', 'Wells Fargo Center', 0.681, 1, 1, 4),
('Boston Celtics', 'Massachusetts', 'TD Garden', 0.500, 2, 2, 4),
('Milwaukee Bucks', 'Wisconsin', 'Fiserv Forum', 0.639, 3, 3, 5),
('Indiana Pacers', 'Indiana', 'Bankers Life Fieldhouse', 0.472, 4, 4, 5),
('Atlanta Hawks', 'Georgia', 'State Farm Arena', 0.569, 5, 5, 6),
('Miami Heat', 'Florida', 'FTX Arena', 0.556, 6, 6, 6),
('Utah Jazz', 'Utah', 'Vivint Smart Home Arena', 0.722, 7, 7, 1),
('Denver Nuggets', 'Colorado', 'Ball Arena', 0.653, 8, 8, 1),
('Phoenix Suns', 'Arizona', 'Phoenix Suns Arena', 0.708, 9, 9, 2),
('Los Angeles Lakers', 'California', 'STAPLES center', 0.583, 10, 10, 2),
('Dallas Mavericks', 'Texas', 'American Airlines Center', 0.583, 11, 11, 3),
('Memphis Grizzlies', 'Tennessee', 'FedEx Forum', 0.528, 12, 12, 3);


INSERT INTO General_Stats(games_played, points, rebounds, assists, field_goal_percentage, 3pt_percentage, free_throw_percentage)
VALUES
(57, 12.5, 2.4, 2.7, 0.467, 0.450, 0.896),
(51, 28.5, 10.9, 4.4, 0.513, 0.377, 0.859),
(58, 24.7, 6.0, 3.4, 0.484, 0.397, 0.764),
(64, 26.4, 7.4, 4.3, 0.459, 0.386, 0.868),
(61, 28.1, 11.0, 5.9, 0.569, 0.303, 0.685),
(68, 20.4, 6.0, 5.4, 0.476, 0.414, 0.898),
(56, 21.2, 5.3, 5.9, 0.453, 0.388, 0.864),
(62, 20.3, 12.0, 6.7, 0.535, 0.321, 0.732),
(27, 3.9, 2.0, 3.5, 0.400, 0.378, 0.500),
(63, 25.3, 3.9, 9.4, 0.438, 0.343, 0.886),
(64, 18.7, 9.0, 5.4, 0.570, 0.250, 0.799),
(63, 4.4, 3.5, 2.3, 0.383, 0.330, 0.658),
(71, 14.3, 13.5, 1.3, 0.675, 0.000, 0.623),
(53, 26.4, 3.8, 5.0, 0.438, 0.386, 0.845),
(59, 18.5, 4.0, 4.8, 0.456, 0.346, 0.881),
(72, 26.4, 10.8, 8.3, 0.590, 0.376, 0.868),
(67, 25.6, 4.2, 4.3, 0.484, 0.340, 0.867),
(70, 16.4, 4.5, 8.9, 0.499, 0.395, 0.934),
(45, 25.0, 7.7, 7.8, 0.513, 0.365, 0.698),
(36, 21.8, 7.9, 3.1, 0.491, 0.260, 0.738),
(66, 27.7, 8.0, 8.6, 0.479, 0.350, 0.730),
(43, 20.1, 8.9, 1.6, 0.476, 0.376, 0.855),
(50, 10.6, 3.2, 2.2, 0.418, 0.391, 0.868),
(63, 19.1, 4.0, 7.4, 0.449, 0.303, 0.728);


INSERT INTO Advanced_Stats(player_efficiency_rating, true_shooting_percentage, win_shares, box_plus_minus)
VALUES
(12.9, 0.607, 4.0, -0.9),
(30.3, 0.636, 8.8, 7.2),
(19.9, 0.586, 4.8, 2.5),
(21.3, 0.576, 6.5, 3.7),
(29.2, 0.633, 10.2, 8.8),
(18.2, 0.588, 6.4, 1.3),
(17.9, 0.561, 4.2, 1.5),
(20.6, 0.601, 6.9, 3.9),
(9.9, 0.478, 0.2, -2.7),
(23.0, 0.589, 7.2, 3.6),
(22.7, 0.626, 8.8, 4.7),
(9.2, 0.519, 1.7, -0.7),
(23.5, 0.683, 11.3, 4.5),
(21.3, 0.569, 6.2, 3.5),
(17.7, 0.559, 4.3, 1.2),
(31.3, 0.647, 15.6, 11.7),
(19.2, 0.587, 4.9, -0.1),
(21.4, 0.599, 9.2, 4.7),
(24.2, 0.602, 5.6, 7.5),
(22.1, 0.556, 3.7, 4.5),
(25.3, 0.587, 7.7, 6.7),
(21.3, 0.582, 4.3, 2.0),
(12.8, 0.586, 2.7, -0.5),
(16.7, 0.537, 3.2, -0.8);



INSERT INTO Player(full_name, position, shooting_hand, height, age, college, general_stats_id, advanced_stats_id, team_id)
VALUES
('Seth Curry', 'SG', 'right', 188, 31, true, 1, 1, 1),
('Joel Embiid', 'C', 'right', 213, 27, true, 2, 2, 1),
('Jaylen Brown', 'SG', 'right', 198, 25, true, 3, 3, 2),
('Jayson Tatum', 'SF', 'right', 203, 23, true, 4, 4, 2),
('Giannis Antetokounmpo', 'PF', 'right', 211, 27, false, 5, 5, 3),
('Khris Middleton', 'SF', 'right', 201, 30, true, 6, 6, 3),
('Malcolm Brogdon', 'PG', 'right', 196, 29, true, 7, 7, 4),
('Domantas Sabonis', 'PF', 'left', 211, 25, true, 8, 8, 4),
('Rajon Rondo', 'PG', 'right', 185, 35, true, 9, 9, 5),
('Trae Young', 'PG', 'right', 185, 23, true, 10, 10, 5),
('Bam Adebayo', 'C', 'right', 206, 24, true, 11, 11, 6),
('Andre Iguodala', 'SF', 'right', 198, 37, true, 12, 12, 6),
('Rudy Gobert', 'C', 'right', 216, 29, false, 13, 13, 7),
('Donovan Mitchell', 'PG', 'right', 185, 25, true, 14, 14, 7),
('Jamal Murray', 'PG', 'right', 190, 24, true, 15, 15, 8),
('Nikola Jokic', 'C', 'right', 211, 26, false, 16, 16, 8),
('Devin Booker', 'SG', 'right', 196, 25, true, 17, 17, 9),
('Chris Paul', 'PG', 'right', 183, 36, true, 18, 18, 9),
('LeBron James', 'SF', 'right', 206, 36, false, 19, 19, 10),
('Anthony Davis', 'PF', 'right', 208, 28, true, 20, 20, 10),
('Luka Doncic', 'PG', 'right', 201, 22, false, 21, 21, 11),
('Kristaps Porzingis', 'PF', 'right', 221, 26, false, 22, 22, 11),
('Grayson Allen', 'SG', 'right', 193, 26, true, 23, 23, 12),
('Ja Morant', 'PG', 'right', 190, 22, true, 24, 24, 12);

INSERT INTO Award(award_name, description)
VALUES
('MVP', 'Most Valuable Player'),
('ROTY', 'Rookie Of The Year'),
('DPOY', 'Defensive Player Of The Year'),
('FMVP', 'Most Valuable Player of the Finals');

INSERT INTO Player_Award_Relationship(award_name, player_id, count)
VALUES
('MVP', 5, 2),
('DPOY', 5, 1),
('FMVP', 5, 1),
('ROTY', 7, 1),
('FMVP', 12, 1),
('DPOY', 13, 3),
('MVP', 16, 1),
('ROTY', 18, 1),
('ROTY', 19, 1),
('MVP', 19, 4),
('FMVP', 19, 4),
('ROTY', 21, 1),
('ROTY', 24, 1);

-- 1st procedure
-- Checks if the player went to college.

DROP PROCEDURE IF EXISTS PlayerCollegeCheck;

DELIMITER //

CREATE PROCEDURE PlayerCollegeCheck(
  IN collegeBool TINYINT
)
BEGIN
  SELECT * FROM Player
  WHERE college = collegeBool;
END //

DELIMITER ;

CALL PlayerCollegeCheck(false);

-- 2nd procedure
-- Shows the player count with the height of more than entered INT number.

DROP PROCEDURE IF EXISTS MoreThanHeight;

DELIMITER //

CREATE PROCEDURE MoreThanHeight(
  IN userInputHeight FLOAT,
  OUT total INT
)
BEGIN
  SELECT COUNT(player_id)
  INTO total
  FROM Player
  WHERE height > userInputHeight;
END //

DELIMITER ;

CALL MoreThanPoints(200, @total);

SELECT @total;

-- 1st function
DROP FUNCTION IF EXISTS TeamWinning;

DELIMITER //

CREATE FUNCTION TeamWinning(
  win_lose_percentage INT
) 
RETURNS VARCHAR(45) DETERMINISTIC
BEGIN
  DECLARE TeamWinning VARCHAR(45);
  IF win_lose_percentage >= 0.500 THEN
    SET TeamWinning = "winning";
  ELSEIF win_lose_percentage < 0.500 THEN
    SET TeamWinning = "losing";
  END IF;
RETURN (TeamWinning);
END //

DELIMITER ;

SELECT t.name as "Team Name", TeamWinning(ts.win_lose_percentage) as "Winning/Losing"
FROM Team AS t
JOIN Team_Summary AS ts ON ts.summary_id = t.summary_id;

-- 2nd function
-- Displays total points of a player by multiplying points per game by games played.
DROP FUNCTION IF EXISTS TotalPoints;

DELIMITER //

CREATE FUNCTION TotalPoints(
  games_played INT,
  points FLOAT
)
RETURNS FLOAT DETERMINISTIC
BEGIN
  DECLARE TotalPoints FLOAT;
  SET TotalPoints = ROUND(games_played * points, 0);
RETURN (TotalPoints);
END //

DELIMITER ;

SELECT p.full_name as "Player Name", TotalPoints(gs.games_played, gs.points) as "Total Points"
FROM Player as p
JOIN General_Stats AS gs ON gs.general_stats_id = p.general_stats_id;


-- 1st trigger
DROP TABLE IF EXISTS Advanced_Stats_Audit;

CREATE TABLE Advanced_Stats_Audit (
  advanced_stats_id INT NOT NULL AUTO_INCREMENT,
  player_efficiency_rating FLOAT NULL,
  true_shooting_percentage FLOAT NULL,
  win_shares FLOAT NULL,
  box_plus_minus FLOAT NULL,
  PRIMARY KEY (advanced_stats_id),
  action VARCHAR(45) DEFAULT NULL,
  changedat DATETIME DEFAULT NULL
);

DROP TRIGGER IF EXISTS before_advanced_stats_update;

CREATE TRIGGER before_advanced_stats_update
  BEFORE UPDATE ON Advanced_Stats
  FOR EACH ROW
INSERT INTO Advanced_Stats_Audit
SET ACTION = 'update',
  advanced_stats_id = OLD.advanced_stats_id,
  player_efficiency_rating = OLD.player_efficiency_rating,
  true_shooting_percentage = OLD.true_shooting_percentage,
  win_shares = OLD.win_shares,
  box_plus_minus = OLD.box_plus_minus,
  changedat = NOW();

UPDATE Advanced_Stats
SET player_efficiency_rating = 15
WHERE advanced_stats_id = 1;


-- 2nd trigger
DROP TABLE IF EXISTS General_Stats_Audit ;

CREATE TABLE General_Stats_Audit (
  general_stats_id INT NOT NULL AUTO_INCREMENT,
  games_played INT NULL,
  points FLOAT NULL,
  rebounds FLOAT NULL,
  old_assists FLOAT NULL,
  new_assists FLOAT NULL,
  field_goal_percentage FLOAT NULL,
  3pt_percentage FLOAT NULL,
  free_throw_percentage FLOAT NULL,
  PRIMARY KEY (general_stats_id),
  action VARCHAR(45) DEFAULT NULL,
  changedat DATETIME DEFAULT NULL
);

DROP TRIGGER IF EXISTS after_general_stats_update;

CREATE TRIGGER after_general_stats_update
  AFTER UPDATE ON General_Stats
  FOR EACH ROW
INSERT INTO General_Stats_Audit
SET ACTION = 'update',
  general_stats_id = OLD.general_stats_id,
  games_played = OLD.games_played,
  points = OLD.points,
  rebounds = OLD.rebounds,
  old_assists = OLD.assists,
  new_assists = NEW.assists,
  field_goal_percentage = OLD.field_goal_percentage,
  3pt_percentage = OLD.3pt_percentage,
  free_throw_percentage = OLD.free_throw_percentage,
  changedat = NOW();

UPDATE General_Stats
SET assists = 5.4
WHERE general_stats_id = 2;