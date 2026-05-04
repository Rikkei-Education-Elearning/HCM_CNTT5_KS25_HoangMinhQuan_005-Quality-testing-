CREATE DATABASE ESportManagement;

USE ESportManagement;

CREATE TABLE IF NOT EXISTS Teams (
	id int primary key auto_increment,
    name varchar(20) not null,
	nation varchar(20) not null,
    owner varchar(20),
    establish_year int not null check (establish_year > 0)
);

CREATE TABLE IF NOT EXISTS Players (
	id int primary key auto_increment,
    name varchar(20) not null,
    nickname varchar(20) not null,
    position varchar(10) not null,
    salary decimal(15,2) check (salary > 0),
    team_id int unique,
    foreign key (team_id) references Teams(id)
);

CREATE TABLE IF NOT EXISTS Matches (
	id char(6) primary key,
    start_time time,
	result varchar(10) not null
);

CREATE TABLE IF NOT EXISTS Match_statistic (
	player_id int,
    match_id char(6) unique,
    kills int,
    death int, 
    assists int,
    foreign key (player_id) references Players(id),
    foreign key (match_id) references Matches(id)
);

ALTER TABLE Matches 
ADD win_price int;

ALTER TABLE Teams 
CHANGE nation region varchar(20);

INSERT INTO Teams (name, region, owner, establish_year)
VALUES
    ('T1', 'Korea', 'Joe Marsh', 2019),
    ('G2 Esports', 'Europe', 'null', 2015),
    ('GAM Esports', 'Vietnam', 'TK Nguyen', 2014),
	('Fratic', 'Europe', 'Sam Mathews', 2011),
    ('Cloud9', 'North America', 'Jack Etienne', 2013);

INSERT INTO Players (name, nickname, position, salary, team_id)
VALUES
    ('Lee Sang-hyeok', 'Faker', 'Mid', 50000000.00, 1),
    ('Rasmus Winther', 'Caps', 'Mid', 32000000.00, 2),
    ('Do Duy Khanh', 'Levi', 'Jungle', 18000000.00,3),
	('Tinh Vo', 'BeanJ', 'Jungle', 15000000.00, 4),
    ('Ilya Osipov', 'm0NESY', 'ADC', 41000000.00, 5);

INSERT INTO Matches (id, start_time, result, price)
VALUES
    ( 'MS_003','14:00:00', '2-1', 1500000),
    ('MS_005','16:30:00', '2-0', 1800000),
    ('MS_007','19:00:00', '1-2', 1200000),
	('MS_009','20:15:00', '2-1', 2000000),
    ('MS_011','21:00:00', '0-2', 1700000);

INSERT INTO Match_statistic (player_id, match_id, kills, death, assists)
VALUES
    (1, 'MS_003', 8, 2, 10),
    (2, 'MS_005', 6, 1, 9),
    (3, 'MS_007', 5, 3, 11),
	(4, 'MS_009', 7, 2, 8),
    (5, 'MS_011', 9, 4, 6);
    
UPDATE Players
SET salary = salary * 1.2
WHERE position = 'Jungle';

DELETE FROM Teams
WHERE owner is null;

SELECT * FROM Players
WHERE salary >= 50000000 and salary <= 150000000;

SELECT * FROM Matches
WHERE id = 'MS_007';

SELECT nickname AND position FROM Teams
WHERE region = 'Vietnam';

DROP TABLE Matches, Match_statistic;