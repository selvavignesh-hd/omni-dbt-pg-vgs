create table if not exists orders (
    id number(38,0) not null,
    user_id number(38,0) not null,
    "DATE" date not null,
    status varchar(50) not null,
    address varchar(255),
    updated_at timestamp not null default current_timestamp,
    constraint orders_pk primary key (id)
);

insert into orders (id, user_id, "DATE", status, address)
values
(1, 1, '2025-01-01', 'Shipped', '123 Main St'),
(2, 2, '2025-01-02', 'Delivered', '456 Oak Ave'),
(3, 3, '2025-01-03', 'Shipped', '789 Pine Rd'),
(4, 4, '2025-01-04', 'Delivered', '101 Elm St'),
(5, 5, '2025-01-05', 'Shipped', '222 Birch St'),
(6, 6, '2025-01-06', 'Delivered', '101 Elm St'),
(7, 7, '2025-01-07', 'Ordered', '333 Oak St'),
(8, 8, '2025-01-08', 'Delivered', '444 Pine St'),
(9, 9, '2025-01-09', 'Ordered', '555 Elm St'),
(10, 10, '2025-01-10', 'Delivered', '666 Pine St'),
(11, 11, '2025-01-11', 'Ordered', '777 Oak St'),
(12, 12, '2025-01-12', 'Delivered', '888 Pine St'),
(13, 13, '2025-01-13', 'Shipped', '999 Elm St'),
(14, 14, '2025-01-14', 'Delivered', '1010 Oak St'),
(15, 15, '2025-01-15', 'Shipped', '1111 Pine St'),
(16, 16, '2025-01-16', 'Delivered', '1212 Elm St'),
(17, 17, '2025-01-17', 'Shipped', '1313 Oak St'),
(18, 18, '2025-01-18', 'Pending', '1414 Pine St'),
(19, 19, '2025-01-19', 'Shipped', '1515 Elm St'),
(20, 20, '2025-01-20', 'Pending', '1616 Pine St');
