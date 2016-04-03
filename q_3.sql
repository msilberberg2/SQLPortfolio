--PA02 Part 1.2 Question 3
CREATE FUNCTION q3_function()
	RETURNS TRIGGER AS $$
	BEGIN
		--The insert is rejected if it is an open order that belongs to the same customer
		--that has a total of 14 or more other open orders. 		
		CASE
			--Checks for cases where the number of open orders with same customer key is 14 or more
			WHEN NEW.o_orderstatus = 'O' AND 14 <= (SELECT COUNT(*)
				FROM orders
				WHERE orders.o_custkey = NEW.o_custkey
					AND orders.o_orderstatus = 'O') THEN
				--Rejection is accomplished by returning null on the function, so nothing is inserted.
				--The terminal will display "INSERT 0 0" in this case
				RETURN NULL;
			--The trigger does nothing if there are less than 14 open orders or the inserted order is not open
			ELSE
				RETURN NEW;
		END CASE;
	END; $$
LANGUAGE plpgsql;

CREATE TRIGGER q3
	BEFORE INSERT ON orders
	FOR EACH ROW
	EXECUTE PROCEDURE q3_function();
