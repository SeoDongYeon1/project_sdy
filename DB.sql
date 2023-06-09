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

INSERT INTO board 
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'SearchClub',
`name` = '이런 동호회 없나?';

INSERT INTO board 
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'SearchMember',
`name` = '여기 동호회 어때?';

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

ALTER TABLE reply CONVERT TO CHARSET UTF8;

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
    areacode VARCHAR(50) NOT NULL
);

ALTER TABLE club CONVERT TO CHARSET UTF8;

INSERT INTO club
SET regDate = NOW(),
updateDate = NOW(),
leaderId = 1,
`name`= '축구좋아',
purpose = '재밌게 축구 하실 분 모집해요',
categoryId = 1,
areacode = '3000000000';

INSERT INTO club
SET regDate = NOW(),
updateDate = NOW(),
leaderId = 2,
`name`= '등산가자!',
purpose = '매주 일요일에 등산하실 분 들어오세요!',
categoryId = 3,
areacode = '﻿1100000000';

INSERT INTO club
SET regDate = NOW(),
updateDate = NOW(),
leaderId = 3,
`name`= '도제(도자기 제작)',
purpose = '매일 같이 공방에 나와서 도자기 만드실 분 모집해요!',
categoryId = 2,
areacode = '4500000000';

# category 테이블 생성
CREATE TABLE category(
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    `name` CHAR(100) NOT NULL UNIQUE 
);

ALTER TABLE category CONVERT TO CHARSET UTF8;

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

# 지역 테이블 추가
CREATE TABLE region (
	`areacode` VARCHAR(50) NOT NULL COMMENT '행정구역코드' COLLATE 'utf8_general_ci',
	`step1` VARCHAR(50) NOT NULL COMMENT '시도' COLLATE 'utf8_general_ci',
	`step2` VARCHAR(50) NULL DEFAULT NULL COMMENT '시군구' COLLATE 'utf8_general_ci',
	`step3` VARCHAR(50) NULL DEFAULT NULL COMMENT '읍면동' COLLATE 'utf8_general_ci',
	`gridX` VARCHAR(50) NOT NULL COMMENT '격자X' COLLATE 'utf8_general_ci',
	`gridY` VARCHAR(50) NOT NULL COMMENT '격자Y' COLLATE 'utf8_general_ci',
	`longitudeHour` VARCHAR(50) NOT NULL COMMENT '경도(시)' COLLATE 'utf8_general_ci',
	`longitudeMin` VARCHAR(50) NOT NULL COMMENT '경도(분)' COLLATE 'utf8_general_ci',
	`longitudeSec` VARCHAR(50) NOT NULL COMMENT '경도(초)' COLLATE 'utf8_general_ci',
	`latitudeHour` VARCHAR(50) NOT NULL COMMENT '위도(시)' COLLATE 'utf8_general_ci',
	`latitudeMin` VARCHAR(50) NOT NULL COMMENT '위도(분)' COLLATE 'utf8_general_ci',
	`latitudeSec` VARCHAR(50) NOT NULL COMMENT '위도(초)' COLLATE 'utf8_general_ci',
	`longitudeMs` VARCHAR(50) NOT NULL COMMENT '경도(초/100)' COLLATE 'utf8_general_ci',
	`latitudeMs` VARCHAR(50) NOT NULL COMMENT '위도(초/100)' COLLATE 'utf8_general_ci'
)
COMMENT='Excel 파일의 값들을 DB화 한 테이블'
COLLATE='utf8_general_ci'
ENGINE=INNODB;



# 동호회에 가입한 회원을 관리하기 위해서 member_club 테이블 생성 
CREATE TABLE member_club (
  id INT(11) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  memberId INT(10) UNSIGNED NOT NULL,
  clubId INT(10) UNSIGNED NOT NULL,
  purpose TEXT NOT NULL,
  regDate DATETIME NOT NULL,
  `authLevel` SMALLINT(2) UNSIGNED DEFAULT 1 COMMENT '권한 레벨 (1=일반 회원, 6=매니저 ,7=동호회 회장)'

);

ALTER TABLE member_club CONVERT TO CHARSET UTF8;

INSERT INTO member_club (memberId, clubId, purpose, regDate, authLevel)
VALUES (1, 3, ".", NOW(), 7);

INSERT INTO member_club (memberId, clubId, purpose, regDate, authLevel)
VALUES (2, 2, ".", NOW(), 7);

INSERT INTO member_club (memberId, clubId, purpose, regDate, authLevel)
VALUES (3, 1, ".", NOW(), 7);

# chat 테이블 추가
CREATE TABLE chat (
    id BIGINT(11) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `type` VARCHAR(255) NOT NULL,
    roomId INT(10) UNSIGNED NOT NULL,
    sender VARCHAR(255) NOT NULL,
    memberId INT(11) UNSIGNED NOT NULL,
    message TEXT NOT NULL,
    `time` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    roomType VARCHAR(255) NOT NULL,
    isRead TINYINT(1) NOT NULL DEFAULT 0
);

ALTER TABLE chat CONVERT TO CHARSET UTF8;


# ClubChatRoom 테이블 생성
CREATE TABLE ClubChatRoom (
  id INT(11) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  regDate DATETIME NOT NULL,
  updateDate DATETIME NOT NULL,
  roomName VARCHAR(255) NOT NULL,
  memberId INT(11) UNSIGNED NOT NULL,
  clubId INT(11) UNSIGNED NOT NULL

);
ALTER TABLE ClubChatRoom CONVERT TO CHARSET UTF8;

INSERT INTO ClubChatRoom
SET regDate = NOW(),
updateDate = NOW(),
roomName = '축구좋아',
memberId = 1,
clubId = 1;

INSERT INTO ClubChatRoom
SET regDate = NOW(),
updateDate = NOW(),
roomName = '등산가자!',
memberId = 2,
clubId = 2;

INSERT INTO ClubChatRoom
SET regDate = NOW(),
updateDate = NOW(),
roomName = '도제(도자기 제작)',
memberId = 3,
clubId = 3;

# chat_user 테이블 생성
CREATE TABLE chat_user (
  id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  regDate DATETIME NOT NULL,
  roomId INT(10) UNSIGNED NOT NULL,
  memberId INT(11) UNSIGNED NOT NULL,
  roomType VARCHAR(50) NOT NULL
);

ALTER TABLE chat_user CONVERT TO CHARSET UTF8;

# PersonalChatRoom 테이블 생성
CREATE TABLE PersonalChatRoom (
  id INT(11) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  regDate DATETIME NOT NULL,
  updateDate DATETIME NOT NULL,
  memberId1 INT(11) UNSIGNED NOT NULL,
  memberId2 INT(11) UNSIGNED NOT NULL

);

ALTER TABLE PersonalChatRoom CONVERT TO CHARSET UTF8;

# read_chat 테이블 생성
CREATE TABLE read_chat (
  id INT(11) PRIMARY KEY AUTO_INCREMENT,
  memberId INT(11),
  roomId INT(11),
  roomType VARCHAR(255),
  lastReadId INT(11) NOT NULL DEFAULT 0
  
);

# 파일 테이블 추가
CREATE TABLE genFile (
  id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT, # 번호
  regDate DATETIME DEFAULT NULL, # 작성날짜
  updateDate DATETIME DEFAULT NULL, # 갱신날짜
  delDate DATETIME DEFAULT NULL, # 삭제날짜
  delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0, # 삭제상태(0:미삭제,1:삭제)
  relTypeCode CHAR(50) NOT NULL, # 관련 데이터 타입(article, member)
  relId INT(10) UNSIGNED NOT NULL, # 관련 데이터 번호
  originFileName VARCHAR(100) NOT NULL, # 업로드 당시의 파일이름
  fileExt CHAR(10) NOT NULL, # 확장자
  typeCode CHAR(20) NOT NULL, # 종류코드 (common)
  type2Code CHAR(20) NOT NULL, # 종류2코드 (attatchment)
  fileSize INT(10) UNSIGNED NOT NULL, # 파일의 사이즈
  fileExtTypeCode CHAR(10) NOT NULL, # 파일규격코드(img, video)
  fileExtType2Code CHAR(10) NOT NULL, # 파일규격2코드(jpg, mp4)
  fileNo SMALLINT(2) UNSIGNED NOT NULL, # 파일번호 (1)
  fileDir CHAR(20) NOT NULL, # 파일이 저장되는 폴더명
  PRIMARY KEY (id),
  KEY relId (relTypeCode,relId,typeCode,type2Code,fileNo)
);


# 달력 테이블 생성
CREATE TABLE `schedule` (
schedule_idx INT(11) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
schedule_num INT(11),
schedule_subject VARCHAR(45),
schedule_desc VARCHAR(45),
schedule_startdate DATE,
schedule_enddate DATE,
memberId INT(10) NOT NULL,
color VARCHAR(45),
clubid INT(11) UNSIGNED NOT NULL DEFAULT 0
);

#동호회 아이디 추가
ALTER TABLE article ADD clubId INT(10) UNSIGNED NOT NULL DEFAULT 0;


SELECT a.*, m.name AS 'extra__writer',
		IFNULL(SUM(R.`point`), 0) AS 'extra__sumReactionPoint',
		IFNULL(SUM(IF(R.`point` <0, R.`point`, 0)),0) AS 'goodReactionPoint',
		IFNULL(SUM(IF(R.`point` > 0, R.`point`, 0)),0) AS 'badReactionPoint'
		FROM article a
		INNER JOIN `member` m
		ON a.memberId = m.id
		LEFT JOIN board b
		ON a.boardId = b.id
		LEFT JOIN reactionPoint AS R
		ON a.id = R.relId AND R.relTypeCode = 'article'
		WHERE a.id = 1
		GROUP BY a.id;
#############################################################################################
# 검색 쿼리
SELECT * FROM article;
SELECT * FROM `member`;
SELECT * FROM board;
SELECT * FROM reactionPoint;
SELECT * FROM club;
SELECT * FROM category;
SELECT * FROM region;
SELECT * FROM member_club;
SELECT * FROM chat;
SELECT * FROM ClubchatRoom;
SELECT * FROM PersonalchatRoom;
SELECT * FROM chat_user;
SELECT * FROM read_chat;
SELECT * FROM genFile;
SELECT * FROM `schedule`;

# 동호회 채팅방 안읽은 채팅 개수 구하기
SELECT COUNT(c.id) 
FROM chat c
WHERE c.roomId = 2
AND c.roomType = 'Club'
AND c.id > 2
AND c.`type` = 'talk';

# 개인 채팅방 안읽은 채팅 개수 구하기
SELECT COUNT(c.id) 
FROM chat c
INNER JOIN PersonalchatRoom pcr
ON c.roomId = pcr.id
WHERE c.roomId = 1
AND c.roomType = 'Personal'
AND c.id > 10
AND (pcr.memberId1 = 2 OR pcr.memberId2 = 2)
AND c.`type` = 'talk';

# 마지막으로 읽은 id 가져오기
SELECT IFNULL(MAX(lastReadId), 0) AS lastReadId
FROM read_chat
WHERE memberId = 3
AND roomId = 2
AND roomType = 'club';

# 내가 속한 동호회 가져오기
SELECT mc.*, c.name AS 'clubName'
FROM club c
INNER JOIN member_club mc
ON c.id = mc.clubId
WHERE mc.memberId = 2;

# 채팅방 멤버수 구하기
SELECT cr.*, COUNT(cu.memberId) AS 'userCount'
FROM chatRoom cr
LEFT JOIN chat_user cu
ON cr.id = cu.roomId
GROUP BY cr.id

# 채팅방 유저 이름 가져오기
SELECT m.name AS 'userName'
FROM chat_user cu
INNER JOIN `member` m
ON m.id = cu.memberId
WHERE roomId = 1
AND memberId = 2;

# 마지막으로 삽입된 id 검색
SELECT LAST_INSERT_ID();

# 게시물 갯수 늘리기
INSERT INTO article 
( 
    regDate, updateDate, memberId, boardId, title, `body`
)
SELECT NOW(), NOW(), FLOOR(RAND() * 2) + 2, FLOOR(RAND() * 2) + 1, CONCAT('제목_',RAND()), CONCAT('내용_',RAND())
FROM article;

# 지역 이름 검색 조건
SELECT c.*, ca.name AS category_name, r.step1 AS 'region_name'
FROM club c
INNER JOIN category ca
ON c.categoryId = ca.id
INNER JOIN region r
ON c.areacode = r.areacode;

# 동호회 갯수 조회
SELECT COUNT(c.id)
FROM club c
WHERE c.categoryId = '1';

# 회원 평균 나이 조회
SELECT c.id, AVG(m.age) AS 'avgAge'
FROM member_club mc
INNER JOIN club c
ON mc.clubId = c.id
INNER JOIN `member` m
ON mc.memberId = m.id
GROUP BY c.id;

# 동호회별 회원수
SELECT c.id AS 'id',
COUNT(mc.memberId) AS 'membersCount'
FROM club c
INNER JOIN member_club mc
ON c.id = mc.clubId
GROUP BY c.id;

# region 검색
SELECT *
FROM region
WHERE step1='전라북도';

# 같은 채팅방 생성 안하도록 하는 쿼리
SELECT * FROM PersonalchatRoom
WHERE (memberId1 =2 OR memberId1 = 1) AND (memberId2=1 OR memberId2 = 2)
LIMIT 1;

# 맴버아이디로 개인 채팅방 리스트 가져오는 쿼리
SELECT pc.*, m1.name AS member1_name, m2.name AS member2_name
FROM PersonalchatRoom pc
JOIN MEMBER m1 ON pc.memberId1 = m1.id
JOIN MEMBER m2 ON pc.memberId2 = m2.id
WHERE (pc.memberId1 = 2 OR pc.memberId2 = 2);

# 맴버아이디로 동호회 채팅방 리스트 가져오는 쿼리
SELECT cr.*
FROM ClubChatRoom cr
INNER JOIN chat c 
ON cr.id = c.roomId
WHERE c.memberId = 2 AND c.roomType = 'Club'
GROUP BY cr.id;

# 개인채팅방에 회원 이름
SELECT pc.*, m1.name AS member1_name, m2.name AS member2_name
FROM PersonalchatRoom pc
JOIN MEMBER m1 ON pc.memberId1 = m1.id
JOIN MEMBER m2 ON pc.memberId2 = m2.id
WHERE pc.id = 1;

SELECT c.*, ca.name AS category_name, r.step1 AS 'region_name'
FROM club c
INNER JOIN category ca
ON c.categoryId = ca.id
INNER JOIN region r
ON c.areacode = r.areacode
WHERE 1
AND r.step1 = "전라북도"
AND r.step2 = "정읍시"
AND r.step3 = "내장상동"
ORDER BY c.id DESC


SELECT *
FROM member_club
WHERE memberId = 2;

SELECT mc.*, m.name AS 'name'
FROM `member` m
INNER JOIN member_club mc
ON m.id = mc.memberId
WHERE mc.clubId = 2;

INSERT INTO article
SET regDate = NOW(),
updateDate= NOW(),
title = 'sd',
`body`= 'sd',
memberId = 1,
boardId = 2,	
clubId = 0;