```
CREATE TABLE `touban` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL,
    `history` varchar(255) NOT NULL,
    `updated_at` datetime NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into touban (id, name, history, updated_at) values (1, 'Honda', 'axxxx', now());
insert into touban (id, name, history, updated_at) values (2, 'Kagawa', 'bxxxx', now());
insert into touban (id, name, history, updated_at) values (3, 'Okazaki', 'xxxxx', now());
insert into touban (id, name, history, updated_at) values (4, 'Hasebe', 'xxxxx', now());
insert into touban (id, name, history, updated_at) values (5, 'Nagatomo', 'xxxxx', now());
insert into touban (id, name, history, updated_at) values (6, 'Endo', 'xxxxx', now());
```
