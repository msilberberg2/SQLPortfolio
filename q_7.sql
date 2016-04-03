--PA02 Part 1.2 Question 7

--Generate a view that lists the tuples of a nationkey and the name of the region that contains that nation
CREATE VIEW nation_regions AS
	(SELECT n_nationkey, r_name
		FROM nation, region
		WHERE r_regionkey = n_regionkey);

--Generate a temporary table that pairs an old region, a new region, and the decimal by which
--the cost of parts must be multiplied by on transition from the first region to the second
CREATE TEMP TABLE region_cost_changes
	(old_r_name character(25),
	new_r_name character(25),
	change_decimal numeric);

--Inserts the values of the from/new table in guidelines into the temp table.
--The values are represented as percentages of the old costs (ex. -20% becomes 0.8)
INSERT INTO region_cost_changes VALUES 
	('AMERICA','ASIA',0.8),
	('ASIA','AMERICA',1.2),
	('AMERICA','EUROPE',1.05),
	('EUROPE','AMERICA',0.95),
	('EUROPE','ASIA',0.9),
	('ASIA','EUROPE',1.1);


CREATE FUNCTION q7_function()
	RETURNS TRIGGER AS $$
	DECLARE
		--Declares variables for the old_region, the new_region, and the change_decimal for this supplier's row
		old_region character(25);
		new_region character(25);
		proportion_change numeric;
	BEGIN
		--Finds the old region where the inserted supplier was from
		old_region := (SELECT r_name
			FROM nation_regions
			WHERE OLD.s_nationkey = n_nationkey);

		--Finds the new region that the inserted supplier has moved to
		new_region := (SELECT r_name
			FROM nation_regions
			WHERE NEW.s_nationkey = n_nationkey);

		--Determines the change in supply cost for a move from the old to the new region
		proportion_change := (SELECT r.change_decimal
			FROM region_cost_changes AS r
			WHERE old_region = r.old_r_name AND new_region = r.new_r_name);

		IF proportion_change IS NULL THEN
			--The price does not change for OLD and NEW nation pairs that aren't from regions in region_rates
			proportion_change := 1;
		END IF;

		--Updates the partsupp table to reflect the new supplycost
		UPDATE partsupp
		SET ps_supplycost = ps_supplycost * proportion_change
		WHERE ps_suppkey = NEW.s_suppkey;

		RETURN NEW;
	END; $$
LANGUAGE plpgsql;


CREATE TRIGGER q7
AFTER UPDATE ON supplier
FOR EACH ROW
EXECUTE PROCEDURE q7_function();
