DROP DATABASE IF EXISTS PJ_SDY;
CREATE DATABASE PJ_SDY;
USE PJ_SDY;

# 게시물 테이블 생성
CREATE TABLE article(
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    title CHAR(100) NOT NULL,
    `body` TEXT NOT NULL
);

# 한글 에러
ALTER TABLE article CONVERT TO CHARSET UTF8;

# 게시물 테스트데이터 생성
INSERT INTO article 
SET regDate = NOW(),
updateDate = NOW(),
title = '제목 1',
`body` = '내용 1';

INSERT INTO article 
SET regDate = NOW(),
updateDate = NOW(),
title = '제목 2',
`body` = '내용 2';

INSERT INTO article 
SET regDate = NOW(),
updateDate = NOW(),
title = '제목 3',
`body` = '내용 3';


# 회원 테이블 생성
CREATE TABLE `member`(
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    loginId CHAR(50) NOT NULL,
    loginPw CHAR(100) NOT NULL,
    `authLevel` SMALLINT(2) UNSIGNED DEFAULT 1 COMMENT '권한 레벨 (1=일반 회원, 2=동호회 매니저, 3=동호회 회장, 7=관리자)',
    `name` CHAR(20) NOT NULL,
    nickname CHAR(20) NOT NULL,
    cellphoneNum CHAR(20) NOT NULL,
    email CHAR(50) NOT NULL,
    delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '탈퇴 여부 (0=탈퇴 전, 1=탈퇴 후)',
    delDate DATETIME COMMENT '탈퇴 날짜'
);

# 한글 에러
ALTER TABLE `member` CONVERT TO CHARSET UTF8;

# 회원 테스트데이터 생성 (관리자)
INSERT INTO `member` 
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'admin',
loginPw = 'admin',
`authLevel` = 7,
`name` = '관리자',
`nickname` = '관리자',
cellphoneNum = '01012341234',
email = 'admin@gmail.com';

# 회원 테스트데이터 생성 (일반 회원)
INSERT INTO `member` 
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test1',
loginPw = 'test1',
`name` = '회원1',
`nickname` = '회원1',
cellphoneNum = '01045674567',
email = 'test1@gmail.com';

INSERT INTO `member` 
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test2',
loginPw = 'test2',
`name` = '회원2',
`nickname` = '회원2',
cellphoneNum = '01067896789',
email = 'test2@gmail.com';

# article 테이블에 memberId 추가
ALTER TABLE article ADD COLUMN memberId INT(11) UNSIGNED NOT NULL;

# memberId가 없는 게시글에 memberId 부여
UPDATE article SET memberId = 2 WHERE id = 1;
UPDATE article SET memberId = 3 WHERE id = 2;
UPDATE article SET memberId = 2 WHERE id = 3;

#############################################################################################

# 게시글 검색
SELECT * FROM article;
SELECT * FROM `member`;

# 마지막으로 삽입된 id 검색
SELECT LAST_INSERT_ID();
