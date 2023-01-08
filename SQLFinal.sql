CREATE TABLE games (
  gID char(20) primary key,
  year char(4),
  round char(10),
  date date,
  venue char(50),
  startTime time,
  attendance bigint,
  homeTeam char(50),
  homeTeamScore smallint,
  awayTeam char(50),
  awayTeamScore smallint,
  rainfall char(5));

copy games from '/Users/sarahwindeknecht/Documents/games.csv' DELIMITER',' csv header;

CREATE TABLE players (
  ID char(20) primary key,
  displayName char(50),
  height smallint,
  weight smallint,
  dob date,
  position char(50),
  origin char(50));

copy players from '/Users/sarahwindeknecht/Documents/players.csv' DELIMITER',' csv header;

CREATE TABLE stats (
  gameID char(20),
  team char(50),
  year char(4),
  round char(5),
  playerID char(50),
	displayName char(50),
	gameNumber smallint,
	disposals smallint,
	kicks smallint,
	marks smallint,
	handballs smallint,
	goals smallint,
	behinds smallint,
	hitouts smallint,
	tackles smallint,
	rebounds smallint,
	inside50s smallint,
	clearances smallint,
	clangers smallint,
	frees smallint,
	freesAgainst smallint,
	brownlowVotes smallint,
	contestedPossessions smallint,
	uncontestedPossessions smallint,
	contestedMarks smallint,
	marksInside50 smallint,
	onePercenters smallint,
	bounces smallint,
	goalAssists smallint,
	percentPlayed smallint,
	subs char(10),
	CONSTRAINT stats_ibfk_1 FOREIGN KEY (gameID) REFERENCES games (gID),
	CONSTRAINT stats_ibfk_2 FOREIGN KEY (playerID) REFERENCES players (ID));

copy stats from '/Users/sarahwindeknecht/Documents/stats.csv' DELIMITER',' csv header;

/*Unique player with their positions and teams*/
select distinct players.displayname as player, players.position as position, stats.team from players inner join stats on players.id=stats.playerid order by players.displayname;

/*Player name and how many goals they’ve scored*/
select stats.displayname as player, sum(goals) as totalGoals from stats group by stats.displayname;

/*Average game attendance per year*/
select games.year, avg(attendance) as aveAttendance from games group by year order by year;