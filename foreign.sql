--PA02, Section 4.2, Key and Foreign Key Constraints

--Foreign Keys
ALTER TABLE customer
ADD CONSTRAINT fk1 FOREIGN KEY (c_nationkey) references nation;

ALTER TABLE lineitem
ADD CONSTRAINT fk2 FOREIGN KEY (l_partkey,l_suppkey) references partsupp;
ALTER TABLE lineitem
ADD CONSTRAINT fk3 FOREIGN KEY (l_orderkey) references orders;

ALTER TABLE nation
ADD CONSTRAINT fk4 FOREIGN KEY (n_regionkey) references region;

ALTER TABLE orders
ADD CONSTRAINT fk5 FOREIGN KEY (o_custkey) references customer;

ALTER TABLE partsupp
ADD CONSTRAINT fk6 FOREIGN KEY (ps_suppkey) references supplier;
ALTER TABLE partsupp
ADD CONSTRAINT fk7 FOREIGN KEY (ps_partkey) references part;

ALTER TABLE supplier
ADD CONSTRAINT fk8 FOREIGN KEY (s_nationkey) references nation;

