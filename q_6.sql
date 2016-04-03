--PA02 Part 1.2 Question 6

--Drop constraints in order to replace them with constraints that delete the referencing tuples on delete of the referenced tuples
ALTER TABLE nation
	DROP constraint fk4;
ALTER TABLE partsupp
	DROP constraint fk6;
ALTER TABLE supplier
	DROP constraint fk8;

--Drop constraints in order to replace them with constraints that set the referencing tuples' referencing attributes to null on delete of the referenced tuples
ALTER TABLE customer
	DROP constraint fk1;
ALTER TABLE lineitem
	DROP constraint fk2;

--Adds new constraints to replace the dropped ones, with new actions on delete.

--fk1 and fk2 now set null on delete, so the tuples in lineitem that reference the deleted nation and in customer that reference the deleted partsupp tuple will not prevent
--the deletion of their referenced tuples, but will also not delete themselves.
ALTER TABLE customer
	ADD CONSTRAINT fk1 FOREIGN KEY (c_nationkey) references nation ON DELETE SET NULL;

ALTER TABLE lineitem
	ADD CONSTRAINT fk2 FOREIGN KEY (l_partkey,l_suppkey) references partsupp ON DELETE SET NULL;

--fk4, fk6, and fk8 now cascade on delete, so their referencing tuples are deleted when the referenced tuples are deleted.
ALTER TABLE nation
	ADD CONSTRAINT fk4 FOREIGN KEY (n_regionkey) references region ON DELETE CASCADE;

ALTER TABLE partsupp
	ADD CONSTRAINT fk6 FOREIGN KEY (ps_suppkey) references supplier ON DELETE CASCADE;

ALTER TABLE supplier
	ADD CONSTRAINT fk8 FOREIGN KEY (s_nationkey) references nation ON DELETE CASCADE;
