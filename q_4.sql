--PA02 Part 1.2 Question 4
--Dropping each foreign key is necessary in order to create a new
--one that cascades changes
ALTER TABLE lineitem
	DROP constraint fk3;
ALTER TABLE orders
	DROP constraint fk5;

--New foreign keys are added to replace fk3 and fk5.
--These new constraints function like the previous ones, but on deletion of their respective referenced keys
--that deletion cascades. Thus, deleting an order gets rid of the customers referencing the order and the suppliers referencing that customer
ALTER TABLE lineitem
	ADD constraint fknew3 FOREIGN KEY (l_orderkey) references orders ON DELETE CASCADE;
ALTER TABLE orders
	ADD constraint fknew5 FOREIGN KEY (o_custkey) references customer ON DELETE CASCADE;