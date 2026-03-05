USE [mist353-server-schwertfeger];
GO

INSERT INTO ConferenceDivision (Conference, Division)
VALUES 
('AFC', 'North'),
('AFC', 'South'),
('AFC', 'East'),
('AFC', 'West'),
('NFC', 'North'),
('NFC', 'South'),
('NFC', 'East'),
('NFC', 'West');
GO

INSERT INTO Team (TeamName, TeamCityState, TeamColors, ConferenceDivisionID)
VALUES
('Baltimore Ravens', 'Baltimore', 'Purple, Black, Gold', 1),
('Pittsburgh Steelers', 'Pittsburgh', 'Black, Gold', 1),
('Cleveland Browns', 'Cleveland', 'Brown, Orange', 1),
('Cincinnati Bengals', 'Cincinnati', 'Orange, Black', 1),

('Houston Texans', 'Houston', 'Navy, Red', 2),
('Indianapolis Colts', 'Indianapolis', 'Blue, White', 2),
('Jacksonville Jaguars', 'Jacksonville', 'Teal, Black, Gold', 2),
('Tennessee Titans', 'Nashville', 'Navy, Light Blue', 2),

('Buffalo Bills', 'Buffalo', 'Blue, Red', 3),
('Miami Dolphins', 'Miami', 'Aqua, Orange', 3),
('New England Patriots', 'Foxborough', 'Navy, Red, Silver', 3),
('New York Jets', 'New York', 'Green, White', 3),

('Kansas City Chiefs', 'Kansas City', 'Red, Gold', 4),
('Las Vegas Raiders', 'Las Vegas', 'Black, Silver', 4),
('Los Angeles Chargers', 'Los Angeles', 'Powder Blue, Gold', 4),
('Denver Broncos', 'Denver', 'Orange, Navy', 4),

('Chicago Bears', 'Chicago', 'Navy, Orange', 5),
('Detroit Lions', 'Detroit', 'Blue, Silver', 5),
('Green Bay Packers', 'Green Bay', 'Green, Gold', 5),
('Minnesota Vikings', 'Minneapolis', 'Purple, Gold', 5),

('Atlanta Falcons', 'Atlanta', 'Red, Black', 6),
('Carolina Panthers', 'Charlotte', 'Black, Blue', 6),
('New Orleans Saints', 'New Orleans', 'Black, Gold', 6),
('Tampa Bay Buccaneers', 'Tampa Bay', 'Red, Pewter', 6),

('Dallas Cowboys', 'Dallas', 'Blue, Silver', 7),
('New York Giants', 'New York', 'Blue, Red', 7),
('Philadelphia Eagles', 'Philadelphia', 'Green, Silver', 7),
('Washington Commanders', 'Washington', 'Burgundy, Gold', 7),

('San Francisco 49ers', 'San Francisco', 'Red, Gold', 8),
('Seattle Seahawks', 'Seattle', 'Navy, Green', 8),
('Los Angeles Rams', 'Los Angeles', 'Blue, Gold', 8),
('Arizona Cardinals', 'Phoenix', 'Red, Black', 8);
GO
