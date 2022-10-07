CREATE SCHEMA library;

CREATE TABLE IF NOT EXISTS library.categories_
(
        name_ VARCHAR(30) PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS library.readers_
(
        id_ NUMERIC(6,0) PRIMARY KEY,
        surname_ VARCHAR(40) NOT NULL,
        name_ VARCHAR(40) NOT NULL,
        address_ VARCHAR(100),
        birth_date_ DATE NOT NULL DEFAULT CURRENT_DATE
);

CREATE TABLE IF NOT EXISTS library.publishers_
(
        code_ NUMERIC(7,0) PRIMARY KEY,
        name_ VARCHAR(40) NOT NULL,
        address_ VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS library.books_
(
        publisher_code_ NUMERIC(7,0) NOT NULL REFERENCES library.publishers_(code_),
        book_number_ NUMERIC(7,0) NOT NULL,
        PRIMARY KEY (publisher_code_, book_number_),
        category_ VARCHAR(30) NOT NULL REFERENCES library.categories_(name_),
        name_ VARCHAR(100) NOT NULL,
        year_published_ NUMERIC(4,0) NOT NULL CHECK (year_published_ <= EXTRACT(YEAR FROM CURRENT_DATE)),
        author_ VARCHAR(100) NOT NULL,
        num_of_pages_ NUMERIC(5, 0) NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS library.book_copies_
(
        publisher_code_ NUMERIC(7,0) NOT NULL,
        book_number_ NUMERIC(7,0) NOT NULL,
        copy_number_ NUMERIC(7,0) NOT NULL,
        FOREIGN KEY (publisher_code_, book_number_) REFERENCES library.books_ (publisher_code_, book_number_),
        PRIMARY KEY (publisher_code_, book_number_, copy_number_),
        shelf_position_ NUMERIC(2,0) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS library.book_rents_
(
        reader_id_ NUMERIC(6,0) NOT NULL REFERENCES library.readers_(id_),
        publisher_code_ NUMERIC(7,0) NOT NULL,
        book_number_ NUMERIC(7,0) NOT NULL,
        copy_number_ NUMERIC(7,0) NOT NULL,
        FOREIGN KEY (publisher_code_, book_number_, copy_number_) REFERENCES library.book_copies_ (publisher_code_, book_number_, copy_number_)
);


INSERT INTO library.categories_ VALUES
('юмористическое фэнтези'), ('фантастика'), ('боевое фэнтези'),
('любовная фантастика'), ('готический роман'), ('космоопера'),
('мистика'), ('бояръ-аниме'), ('попаданцы'),
('технофэнтези'), ('постапокалипсис'), ('боевая фантастика'),
('ненаучная фантастика'), ('крутой детектив'), ('маньяки'), ('технотриллер');

INSERT INTO library.readers_ VALUES
(1, 'Армаш', 'Мира', NULL, '2003-02-03'),
(2, 'Холмс', 'Шерлок', '221b, Baker Street, London, NW1 6XE, UK', '1854-01-06'),
(3, 'Фандорин', 'Эраст', 'Ул. Малая Никитская, д. 12', '1856-01-20'),
(4, 'Фрай', 'Макс', NULL, '1965-02-22'),
(5, 'Мейзел', 'Мириам', NULL, '1933-07-12'),
(6, 'Купер', 'Шелдон', '2311 North Los Robles Avenue, Pasadena, California', '1980-02-26');

INSERT INTO library.publishers_ VALUES
(1, 'Росмэн', 'г. Москва, ул. Шереметьевская, д. 47'),
(2, 'Питер', 'г. Санкт-Петербург, Б. Сампсониевский пр., 29а'),
(3, 'Эксмо', 'г. Москва, ул. Зорге, д.1, стр.1'),
(4, 'Аст', 'г. Москва, Пресненская наб., д.6, стр.2, БЦ «Империя»');

INSERT INTO library.books_ VALUES
(1, 1, 'юмористическое фэнтези', 'Пивовой', 2003, 'Громыко Ольга Николаевна', 7),
(1, 2, 'юмористическое фэнтези', 'Особо одаренная особа', 2008, 'Вересень Мария', 120),
(2, 1, 'маньяки', 'SQL: быстрое погружение', 2022, 'Шилдс Уолтер', 224),
(1, 3, 'фантастика', 'Гарри Поттер и методы рационального мышления', 2015, 'Элиезер Юдковский', 2000),
(3, 1, 'фантастика', 'Вы, конечно, шутите, мистер Фейнман', 1985, 'Ричард Фейнман', 350),
(4, 1, 'постапокалипсис', 'Метро 2033', 2007, 'Дмитрий Глуховский', 384),
(4, 2, 'крутой детектив', 'Арсен Люпен', 1874, 'Морис Леблан', 200);

INSERT INTO library.book_copies_ VALUES
(1, 1, 1, 1), (1, 1, 2, 2), (1, 1, 3, 4), (1, 2, 1, 3), (2, 1, 1, 5), (2, 1, 2, 6), (1, 3, 1, 7), (1, 3, 2, 8), (3, 1, 1, 9), (4, 1, 1, 10), (4, 1, 2, 11), (4, 2, 1, 12);

INSERT INTO library.book_rents_ VALUES
(1, 3, 1, 1), (2, 4, 2, 1), (3, 1, 1, 1), (4, 2, 1, 1), (5, 1, 1, 2), (6, 1, 3, 1);