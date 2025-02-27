-- 데이터베이스 생성
CREATE DATABASE sample;

-- 데이터베이스 생성(CharSet, Collation 지정)
CREATE DATABASE sample2
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

-- 데이터베이스 변경
ALTER DATABASE sample
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

-- 데이터베이스 삭제
-- 운영DB에서 실행하면 퇴사각
DROP DATABASE sample2;
DROP DATABASE sample;

-- 테이블 생성
-- 3-34 NewBook 테이블을 생성하세요, 정수형은 Integer, 문자형은 가변형인 Varchar를 사용하십시오
-- 기본키를 설정합니다

-- 기본키가 두개 이상일 경우 아래와 같이 작성
CREATE TABLE NewBook(
	bookId 		INTEGER,
    bookname 	VARCHAR(255),
    publisher 	VARCHAR(50),
    price 		INTEGER,
    PRIMARY KEY (bookid, publisher)
);

-- 기본키가 하나면 컬럼 하나에 작성 가능, 기본키가 두개이상일 경우 컬럼에 PRIMARY KEY를 두 군데 작성 불가
CREATE TABLE NewBook(
	bookId 		INTEGER	 PRIMARY KEY,
    bookname 	VARCHAR(255),
    publisher 	VARCHAR(50),
    price 		INTEGER
);

DROP TABLE NewBook;
DROP TABLE NewOrders;

-- 테이블 생성시, 제약조건을 추가 가능
-- bookname은 NULL을 가질 수 없고, publisher는 같은 값이 있으면 안됨
-- price는 값이 입력되지 않은 경우 기본값이 10000원을 저장
-- 최소가격은 1000원 이상
CREATE TABLE NewBook(
	bookId		INTEGER,
    bookname	VARCHAR(255)  NOT NULL,
    publisher	VARCHAR(50)  UNIQUE,
    price 		INTEGER  DEFAULT 10000 CHECK (price >= 1000),
    PRIMARY KEY (bookId)
);

-- 3-35 아래 속성의 NewCustomer 테이블을 생성하시오
-- custid - INTEGER, 기본키
-- name - VARCHAR(100) NOT NULL
-- address - VARCHAR(255) NOT NULL
-- phone - VARCHAR(30) NOT NULL
CREATE TABLE NewCustomer(
	custid 	INTEGER,
    name 	VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    phone	VARCHAR(30) NOT NULL,
    primary key (custid)
);

-- 3-36 다음과 같은 속성의 NewOrders 테이블을 생성하시오
-- orderid - integer, primary key
-- bookid - integer, not null, foreignkey(NewBook bookid)
-- custid - integer, not null, FK(NewCustomer custid)
-- saleprice - integer
-- orderdate - date
CREATE TABLE NewOrders(
	orderid 	integer,
	bookid 		integer not null,
	custid 		integer not null,
	saleprice 	integer,
	orderdate 	date,
    primary key (orderid),
    foreign key (bookid) references NewBook(bookid) on delete cascade,
    foreign key (custid) references NewCustomer(custid) on delete cascade
);

-- ALTER
-- 3-37 NewBook 테이블에 Varchar(13)의 isbn 속성을 추가하시오
ALTER TABLE NewBook ADD isbn VARCHAR(13);

-- 3-38 NewBook 테이블 isbn 속성의 데이터타입을 integer로 변경하시오
ALTER TABLE NewBook MODIFY isbn INTEGER;

-- 3-38 NewBook 테이블 publisher의 제약사항을 NOT NULL로 변경하시오
ALTER TABLE NewBook MODIFY publisher VARCHAR(100) NOT NULL;

-- DROP
-- 3-42 NewBook 테이블을 삭제하시오
-- 관게에서 부모테이블은 자식테이블을 지우기전에 삭제할 수 없음
DROP TABLE NewBook;
DROP TABLE NewOrders;
