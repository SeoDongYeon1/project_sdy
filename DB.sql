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

# 게시판 테이블 생성
CREATE TABLE board(
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    `code` CHAR(100) NOT NULL UNIQUE COMMENT 'Notice(공지사항), Free(자유게시판), QnA(질의응답), ...',
    `name` CHAR(100) NOT NULL UNIQUE COMMENT '게시판 이름',
    delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '삭제 여부 (0=삭제 전, 1= 삭제 후)',
    delDate DATETIME COMMENT '삭제 날짜'
);
ALTER TABLE board CONVERT TO CHARSET UTF8;

# 게시판 추가
INSERT INTO board 
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'Notice',
`name` = '공지사항';

INSERT INTO board 
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'Free',
`name` = '자유게시판';

INSERT INTO board 
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'QnA',
`name` = '질의응답';

# article 테이블에 boardId 컬럼 추가
ALTER TABLE article ADD COLUMN boardId INT(10) UNSIGNED NOT NULL AFTER memberId;

UPDATE article
SET boardId = 1
WHERE id IN(1,2);

UPDATE article
SET boardId = 2
WHERE id = 3;

# article 테이블에 hitCount 컬럼 추가
ALTER TABLE article ADD COLUMN hitCount INT(10) UNSIGNED NOT NULL DEFAULT 0;

# reactionPoint 테이블 생성
CREATE TABLE reactionPoint(
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    memberId INT(10) UNSIGNED NOT NULL,
    relTypeCode CHAR(50) NOT NULL COMMENT '관련 데이터 타입 코드',
    relId INT(10) NOT NULL COMMENT '관련 데이터 번호',
    `point` INT(10) NOT NULL
);
ALTER TABLE reactionPoint CONVERT TO CHARSET UTF8;

# reactionPoint 테스트 데이터
# 1번 회원이 1번 글에 싫어요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
relTypeCode = 'article',
relId = 1,
`point` = -1;

# 1번 회원이 2번 글에 좋아요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
relTypeCode = 'article',
relId = 2,
`point` = 1;

# 2번 회원이 1번 글에 싫어요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relTypeCode = 'article',
relId = 1,
`point` = -1;

# 2번 회원이 2번 글에 싫어요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relTypeCode = 'article',
relId = 2,
`point` = -1;

# 3번 회원이 1번 글에 좋아요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 3,
relTypeCode = 'article',
relId = 1,
`point` = 1;

# 게시물 테이블에 추천 관련 컬럼 추가
ALTER TABLE article ADD COLUMN goodReactionPoint INT(10) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE article ADD COLUMN badReactionPoint INT(10) UNSIGNED NOT NULL DEFAULT 0;

#############################################################################################

# 검색 쿼리
SELECT * FROM article;
SELECT * FROM `member`;
SELECT * FROM board;
SELECT * FROM reactionPoint;

# 마지막으로 삽입된 id 검색
SELECT LAST_INSERT_ID();

# 게시물 갯수 늘리기
INSERT INTO article 
( 
    regDate, updateDate, memberId, boardId, title, `body`
)
SELECT NOW(), NOW(), FLOOR(RAND() * 2) + 2, FLOOR(RAND() * 2) + 1, CONCAT('제목_',RAND()), CONCAT('내용_',RAND())
FROM article;

update article
set hitCount = hitCount + 1
WHERE id = 3;
