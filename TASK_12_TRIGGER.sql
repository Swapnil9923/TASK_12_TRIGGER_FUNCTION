select * from players

select * from records 

CREATE TABLE report_table (
    playerid int PRIMARY KEY,
    sum_of_fifty FLOAT,
    sum_of_fours FLOAT
);

CREATE OR REPLACE FUNCTION update_player_report()
RETURNS TRIGGER AS $$
DECLARE
    sumOfFifty FLOAT;
    sumOfFours FLOAT;
    count_report INT;
BEGIN
    
    SELECT SUM(fifty), SUM(fours)
    INTO sumOfFifty, sumOfFours
    FROM records 
    WHERE playerid = NEW.playerid;

    select count(*)
    INTO count_report
    FROM report_table
    WHERE playerid = NEW.playerid;

    IF count_report = 0 THEN
    
        INSERT INTO report_table (playerid, sum_of_fifty, sum_of_fours)
        VALUES (NEW.playerid, sumOfFifty, sumOfFours);
    ELSE
       
        UPDATE report_table
        SET sum_of_fifty = sumOfFifty,
            sum_of_fours = sumOfFours
        WHERE playerid = NEW.playerid;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_player_report_trigger
AFTER INSERT OR UPDATE ON records
FOR EACH ROW
EXECUTE FUNCTION update_player_report();

select sum(fifty),sum(fours) from records where playerid=20


insert into records (playerid,fifty,hundreds,fours,sixes,thirtyplus_score)
values (20,5,2,5,3,2)

insert into records (playerid,fifty,hundreds,fours,sixes,thirtyplus_score)
values (20,15,2,15,3,2)

select * from records