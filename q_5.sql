--PA02 Part 1.2 Question 5

CREATE FUNCTION q5_function()
	RETURNS TRIGGER AS $$
	BEGIN
		--Sets the inserted lineitem's order's orderstatus to P if the status of the new lineitem is different from the status of the order.
		--If orderstatus had the same status, then either both the lineitem and the order are status 'F', in which case all items for the order must be F, so no change is required,
		--or both are status 'O', so all items for the order must be 'O', so no change is required. If the statuses are different, then the order's new status must be P, since
		--no new lineitem would cause the other lineitems for the order to all become the same 
		IF NEW.l_linestatus <> (SELECT o_orderstatus 
				FROM orders
				WHERE NEW.l_orderkey = o_orderkey) THEN
			UPDATE orders
			SET o_orderstatus = 'P'
			WHERE NEW.l_orderkey = o_orderkey;
		END IF;

		RETURN NEW;
	END; $$
LANGUAGE plpgsql;

CREATE TRIGGER q5
AFTER INSERT ON lineitem
FOR EACH ROW EXECUTE PROCEDURE q5_function();
