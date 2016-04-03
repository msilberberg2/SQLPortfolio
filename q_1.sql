--PA02 Part 1.2 Question 1

--Dropping each foreign key is necessary in order to create a new
--one that cascades changes
ALTER TABLE customer
	DROP constraint fk1;
ALTER TABLE supplier
	DROP constraint fk8;

--New foreign keys are added for the tables that reference nation
--These foreign keys function as before but cascade changes to the referenced tuples on update
ALTER TABLE customer
	ADD constraint fknew1 FOREIGN KEY (c_nationkey) references nation ON UPDATE CASCADE;

ALTER TABLE supplier
	ADD constraint fknew8 FOREIGN KEY (s_nationkey) references nation ON UPDATE CASCADE;
	