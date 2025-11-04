create table if not exists customers (
    id number(38,0) not null,
    name varchar(255) not null,
    email varchar(255) not null,
    phone varchar(255) not null,
    address varchar(255) not null,
    city varchar(255) not null,
    state varchar(255) not null,
    zip varchar(255) not null,
    constraint customers_pk primary key (id)
);

insert into customers (id, name, email, phone, address, city, state, zip)
values
(1, 'John Doe', 'john.doe@example.com', '1234567890', '123 Main St', 'Anytown', 'CA', '12345'),
(2, 'Jane Smith', 'jane.smith@example.com', '0987654321', '456 Oak Ave', 'Othertown', 'NY', '67890'),
(3, 'Jim Beam', 'jim.beam@example.com', '1112223333', '789 Pine Rd', 'Smallville', 'KS', '11111'),
(4, 'Jill Johnson', 'jill.johnson@example.com', '2223334444', '101 Elm St', 'Bigcity', 'TX', '22222'),
(5, 'Jack Black', 'jack.black@example.com', '3334445555', '222 Birch St', 'Smalltown', 'MO', '33333'),
(6, 'Jill Johnson', 'jill.johnson@example.com', '2223334444', '101 Elm St', 'Bigcity', 'TX', '22222');
