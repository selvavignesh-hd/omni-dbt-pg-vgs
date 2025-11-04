CREATE SCHEMA IF NOT EXISTS library_raw;

CREATE TABLE library_raw.books (
    book_id INTEGER,
    title VARCHAR(200),
    author VARCHAR(100),
    isbn VARCHAR(20),
    genre VARCHAR(50),
    published_year INTEGER,
    acquisition_date DATE,
    current_status VARCHAR(20) CHECK (current_status IN ('available', 'borrowed', 'maintenance')),
    shelf_location VARCHAR(10)
);

CREATE TABLE library_raw.members (
    member_id INTEGER,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    membership_tier VARCHAR(20),
    join_date DATE,
    is_active BOOLEAN
);

CREATE TABLE library_raw.loans (
    loan_id INTEGER,
    book_id INTEGER,
    member_id INTEGER,
    loan_date DATE,
    due_date DATE,
    return_date DATE,
    renewal_count INTEGER DEFAULT 0
);

INSERT INTO library_raw.books VALUES 
(1, 'The Great Gatsby', 'F. Scott Fitzgerald', '978-0743273565', 'Classic', 1925, '2020-01-15', 'available', 'FIC-A1'),
(2, 'To Kill a Mockingbird', 'Harper Lee', '978-0061120084', 'Fiction', 1960, '2020-02-20', 'borrowed', 'FIC-B2'),
(3, '1984', 'George Orwell', '978-0451524935', 'Dystopian', 1949, '2020-03-10', 'available', 'FIC-C3'),
(4, 'Pride and Prejudice', 'Jane Austen', '978-0141439518', 'Romance', 1813, '2020-01-25', 'borrowed', 'FIC-A2');

INSERT INTO library_raw.members VALUES
(101, 'Alice', 'Johnson', 'alice@email.com', 'premium', '2022-01-15', true),
(102, 'Bob', 'Smith', 'bob@email.com', 'standard', '2022-03-20', true),
(103, 'Carol', 'Davis', 'carol@email.com', 'standard', '2021-11-05', false),
(104, 'David', 'Wilson', 'david@email.com', 'premium', '2023-02-28', true);

INSERT INTO library_raw.loans VALUES
(1001, 2, 101, '2024-01-10', '2024-01-24', NULL, 1),
(1002, 4, 102, '2024-01-12', '2024-01-26', '2024-01-25', 0),
(1003, 1, 101, '2023-12-15', '2023-12-29', '2023-12-28', 0),
(1004, 2, 104, '2023-11-20', '2023-12-04', '2023-12-03', 0);