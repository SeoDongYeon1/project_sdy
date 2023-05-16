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
    `authLevel` SMALLINT(2) UNSIGNED DEFAULT 1 COMMENT '권한 레벨 (1=일반 회원, 7=관리자)',
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

# 기존 게시물의 good,bad ReactionPoint 필드의 값을 채운다
UPDATE article AS A
INNER JOIN (
    SELECT RP.relTypeCode, RP.relId,
    SUM(IF(RP.point > 0, RP.point,0)) AS goodReactionPoint,
    SUM(IF(RP.point < 0, RP.point * -1,0)) AS badReactionPoint
    FROM reactionPoint AS RP
    GROUP BY RP.relTypeCode, RP.relId
) AS RP_SUM
ON A.id = RP_SUM.relId
SET A.goodReactionPoint = RP_SUM.goodReactionPoint,
A.badReactionPoint = RP_SUM.badReactionPoint;


# reply 테이블 생성
CREATE TABLE reply(
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    memberId INT(10) UNSIGNED NOT NULL,
    relTypeCode CHAR(50) NOT NULL COMMENT '관련 데이터 타입 코드',
    relId INT(10) NOT NULL COMMENT '관련 데이터 번호',
    `body` TEXT NOT NULL
);

# reply 테이블의 relTypeCode, relId에 인덱스 걸기
ALTER TABLE `PJ_SDY`.`reply` ADD KEY `relTypeCodeId` (`relTypeCode` , `relId`);

# 2번 회원이 1번 글에 댓글
INSERT INTO reply
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relTypeCode = 'article',
relId = 1,
`body` = '댓글 1';

# 2번 회원이 1번 글에 댓글
INSERT INTO reply
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relTypeCode = 'article',
relId = 1,
`body` = "댓글 2";

# 3번 회원이 1번 글에 댓글
INSERT INTO reply
SET regDate = NOW(),
updateDate = NOW(),
memberId = 3,
relTypeCode = 'article',
relId = 1,
`body` = "댓글 3";

# 3번 회원이 2번 글에 댓글
INSERT INTO reply
SET regDate = NOW(),
updateDate = NOW(),
memberId = 3,
relTypeCode = 'article',
relId = 2,
`body` = "댓글 4";


# club 테이블 생성
CREATE TABLE club(
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    leaderId INT(10) UNSIGNED NOT NULL,
    `name` CHAR(100) NOT NULL COMMENT '동호회 이름',
    purpose TEXT NOT NULL COMMENT '동호회 목표',
    categoryId INT(10) UNSIGNED NOT NULL COMMENT '(1=운동/스포츠, 2=아웃도어/여행, 3=공예/만들기, ...)',
    delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '삭제 여부 (0=삭제 전, 1= 삭제 후)',
    delDate DATETIME COMMENT '삭제 날짜',
    region VARCHAR(255) NOT NULL
);

INSERT INTO club
SET regDate = NOW(),
updateDate = NOW(),
leaderId = 1,
`name`= '축구좋아',
purpose = '재밌게 축구 하실 분 모집해요',
categoryId = 1,
region = '대전광역시';

INSERT INTO club
SET regDate = NOW(),
updateDate = NOW(),
leaderId = 2,
`name`= '등산가자!',
purpose = '매주 일요일에 등산하실 분 들어오세요!',
categoryId = 2,
region = '서울특별시';

INSERT INTO club
SET regDate = NOW(),
updateDate = NOW(),
leaderId = 2,
`name`= '도제(도자기 제작)',
purpose = '매일 같이 공방에 나와서 도자기 만드실 분 모집해요!',
categoryId = 3,
region = '전라북도';

# 테스트 member에 clubId 추가
ALTER TABLE `member` ADD COLUMN clubId INT(10) UNSIGNED NOT NULL DEFAULT 0;

UPDATE `member`
SET clubId = 1
WHERE id = 1;

UPDATE `member`
SET clubId = 2
WHERE id = 2;

UPDATE `member`
SET clubId = 3
WHERE id = 3;

# category 테이블 생성
CREATE TABLE category(
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    `name` CHAR(100) NOT NULL UNIQUE 
);

INSERT INTO category 
SET regDate = NOW(),
updateDate = NOW(),
`name` = '운동/스포츠';

INSERT INTO category 
SET regDate = NOW(),
updateDate = NOW(),
`name` = '아웃도어/여행';

INSERT INTO category 
SET regDate = NOW(),
updateDate = NOW(),
`name` = '문화/공연/축제';

INSERT INTO category 
SET regDate = NOW(),
updateDate = NOW(),
`name` = '음악/악기';

INSERT INTO category 
SET regDate = NOW(),
updateDate = NOW(),
`name` = '공예/만들기';

INSERT INTO category 
SET regDate = NOW(),
updateDate = NOW(),
`name` = '댄스/무용';

INSERT INTO category 
SET regDate = NOW(),
updateDate = NOW(),
`name` = '봉사활동';

INSERT INTO category 
SET regDate = NOW(),
updateDate = NOW(),
`name` = '차/오토바이';

INSERT INTO category 
SET regDate = NOW(),
updateDate = NOW(),
`name` = '사진/영상';

INSERT INTO category 
SET regDate = NOW(),
updateDate = NOW(),
`name` = '게임/오락';

INSERT INTO category 
SET regDate = NOW(),
updateDate = NOW(),
`name` = '요리/제조';

INSERT INTO category 
SET regDate = NOW(),
updateDate = NOW(),
`name` = '반려동물';

INSERT INTO category 
SET regDate = NOW(),
updateDate = NOW(),
`name` = '자유주제';

# member 테이블에 나이 추가
ALTER TABLE `member` ADD COLUMN age INT(10) UNSIGNED NOT NULL AFTER email;

# member 테이블에 나이가 0인것 나이 넣어주기
UPDATE `member`
SET age = 21
WHERE id = 1;

UPDATE `member`
SET age = 31
WHERE id = 2;

UPDATE `member`
SET age = 25
WHERE id = 3;


#############################################################################################
# 동호회 갯수 조회
SELECT COUNT(c.id)
FROM club c
WHERE c.categoryId = '1';

# 회원 평균 나이 조회
SELECT AVG(m.age)
FROM `member` m
INNER JOIN club c
ON m.clubId = c.id
GROUP BY c.id;


# 검색 쿼리
SELECT * FROM article;
SELECT * FROM `member`;
SELECT * FROM board;
SELECT * FROM reactionPoint;
SELECT * FROM club;
SELECT * FROM category;

# 마지막으로 삽입된 id 검색
SELECT LAST_INSERT_ID();

# 게시물 갯수 늘리기
INSERT INTO article 
( 
    regDate, updateDate, memberId, boardId, title, `body`
)
SELECT NOW(), NOW(), FLOOR(RAND() * 2) + 2, FLOOR(RAND() * 2) + 1, CONCAT('제목_',RAND()), CONCAT('내용_',RAND())
FROM article;

UPDATE article
SET hitCount = hitCount + 1
WHERE id = 3;

UPDATE `member` SET nickname = 'qweqweqweqweqwe' WHERE id = 2;
