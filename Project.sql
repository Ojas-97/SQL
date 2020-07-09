/* Query: With aggregate values (Total expenditure by each club to acquire their footballers) */

select c.ClubID, c.Name, sum(p.`MarketValue(millions)`)
from club c
join players p on c.ClubID = p.ClubID
group by c.ClubID;


/* Query: With aggregate & Nesting (Expenditure by each club on acquiring footballers as a percentage of the total average spending by every team in the league) */
select TotalSpendingPerClub.ClubID, TotalSpendingPerClub.Name, (TotalSpending/(select avg(TotalSpending) from TotalSpendingPerClub)) * 100 `ClubSpendingComparedToLeagueAverage(%)`
from (select c.ClubID, c.Name, sum(p.`MarketValue(millions)`) TotalSpending
from club c
join players p on c.ClubID = p.ClubID
group by c.ClubID) TotalSpendingPerClub;

/* Query: Normal Join Query (Information about owner, what club he/she owns and the value of the club they own) */

select o.OwnerID, o.FirstName, o.LastName, c.Name ClubName, c.`ClubValue (billions)`
from club c
join owners o on c.ClubID = o.ClubID
order by OwnerID;

#total goals for each player, ranking; GoldenBoot
select Player, max(Golazo) GoldenBoot
from (
select p.PlayerID, p.LastName Player, c.Name, sum(goals) Golazo
from playermatch pm
join players p 
	on pm.PlayerID=p.PlayerID
join club c
	on p.ClubID = c.ClubID
where pm.Goals > 0
group by p.PlayerID
order by Golazo desc
) yeet
;

#total attendance for season- to compare to last szn, see how popularity/interest changing
select sum(f.Attendance) SeasonViewership
from fixtures f
;

    
# num of english players per team - compliant or not with min 5 rule
select Nom, count(eng) EnglishLads, if(count(eng)<3,'No','Yes') LocalPlayerCompliant
from (
select p.FirstName, p.LastName, c.Name Nom, p.Nationality Eng
from players p
join club c
on p.ClubID = c.ClubID
where p.Nationality = "English"
order by c.Name
) eng
group by Nom
;

#avg attendance per stadium per szn
select Stadium, avg(fans) AvgAttendance, Club
from (
select f.StadiumName Stadium, f.Attendance Fans, f.HomeTeam Club
from fixtures f
join clubmatch cm
	on f.FixtureID = cm.FixtureID

) lol
group by stadium
;


