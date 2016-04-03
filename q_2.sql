--PA02 Part 1.2 Question 2
CREATE FUNCTION q2_function()
	RETURNS TRIGGER AS $$
	BEGIN
		--For all parts where its retail price has changed, the supply cost should change
		--by the same amount, which is the new amount subtracted by the old amount
		UPDATE partsupp
		SET ps_supplycost = ps_supplycost + (NEW.p_retailprice-OLD.p_retailprice)
		WHERE ps_partkey = OLD.p_partkey;
		RETURN NEW;
	END; $$
LANGUAGE plpgsql;

CREATE TRIGGER q2
	AFTER UPDATE ON part
	FOR EACH ROW 
	EXECUTE PROCEDURE q2_function();
