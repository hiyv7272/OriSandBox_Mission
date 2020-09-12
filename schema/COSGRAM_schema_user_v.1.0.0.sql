###############################################################################
# [COSGRAM user 초기 schema 스크립트]
###############################################################################

-- 0. CREATE DATABASE COSGRAM
-- DROP DATABASE IF EXISTS COSGRAM;
-- CREATE DATABASE COSGRAM character SET utf8mb4 collate utf8mb4_general_ci;


-- CREATE TABLE USER(사용자 테이블)
DROP TABLE IF EXISTS COSGRAM.USER;
CREATE TABLE COSGRAM.USER
(
    `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
    `name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '사용자 이름',
    `email` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '사용자 이메일',
    `password` varchar(300) COLLATE utf8mb4_general_ci NOT NULL COMMENT '사용자 패스워드',
    `create_datetime` datetime(6) NOT NULL COMMENT '사용자 생성 시간',
    `update_datetime` datetime(6) NOT NULL COMMENT '사용자 수정 시간',
    `is_use` tinyint(1) DEFAULT 1 NOT NULL COMMENT '사용자 사용 유무',
    PRIMARY KEY (`id`),
    UNIQUE KEY (`email`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT '사용자 테이블';


-- CREATE TABLE PRODUCER(제작자 테이블)
DROP TABLE IF EXISTS COSGRAM.PRODUCER;
CREATE TABLE COSGRAM.PRODUCER
(
    `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
    `name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '제작자 이름',
    `create_datetime` datetime(6) NOT NULL COMMENT '제작자 생성 시간',
    `update_datetime` datetime(6) NOT NULL COMMENT '제작자 수정 시간',
    `is_use` tinyint(1) DEFAULT 1 NOT NULL COMMENT '제작자 사용 유무',
    PRIMARY KEY (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT '제작자 테이블';



-- INSERT INTO PRODUCER
INSERT INTO COSGRAM.PRODUCER (id, name, create_datetime, update_datetime, is_use) VALUES
(
    1,
    '제작자_A',
    NOW(),
    NOW(),
    1
),
(
    2,
    '제작자_B',
    NOW(),
    NOW(),
    1
),
(
    3,
    '제작자_C',
    NOW(),
    NOW(),
    1
);


-- CREATE TABLE MODULE(모듈 테이블)
DROP TABLE IF EXISTS COSGRAM.MODULE;
CREATE TABLE COSGRAM.MODULE
(
    `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
    `name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '모 이름',
    `create_datetime` datetime(6) NOT NULL COMMENT '모듈 생성 시간',
    `update_datetime` datetime(6) NOT NULL COMMENT '모듈 수정 시간',
    `is_use` tinyint(1) DEFAULT 1 NOT NULL COMMENT '모듈 사용 유무',
    PRIMARY KEY (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT '모듈 테이블';


-- INSERT INTO MODULE(모듈 테이블)
INSERT INTO COSGRAM.MODULE (id, name, create_datetime, update_datetime, is_use) VALUES
(
    1,
    'NAVER_SHOPPING',
    NOW(),
    NOW(),
    1
),
(
    2,
    'YOUTUBE',
    NOW(),
    NOW(),
    1
),
(
    3,
    'AMAZON',
    NOW(),
    NOW(),
    1
);


-- CREATE TABLE USER_PRODUCER_MODULE(사용자_제작자_모듈 중간테이블)
DROP TABLE IF EXISTS COSGRAM.USER_PRODUCER_MODULE;
CREATE TABLE COSGRAM.USER_PRODUCER_MODULE
(
    `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
    `USER_id` int DEFAULT NULL COMMENT '사용자 id',
    `PRODUCER_id` int DEFAULT NULL COMMENT '제작자 id',
    `MODULE_id` int DEFAULT NULL COMMENT '모듈 id',
    `create_datetime` datetime(6) NOT NULL COMMENT '중간테이블 생성 시간',
    `update_datetime` datetime(6) NOT NULL COMMENT '중간테이블 수정 시간',
    `is_use` tinyint(1) DEFAULT 1 NOT NULL COMMENT '중간테이블 사용 유무',
    PRIMARY KEY (`id`),
    KEY `USER_PRODUCER_MODULE_FK_USER_id` (`USER_id`),
    KEY `USER_PRODUCER_MODULE_FK_PRODUCER_id` (`PRODUCER_id`),
    KEY `USER_PRODUCER_MODULE_FK_MODULE_id` (`MODULE_id`),
    CONSTRAINT  `USER_PRODUCER_MODULE_FK_USER_id` FOREIGN KEY (`USER_id`) REFERENCES `USER` (`id`),
    CONSTRAINT  `USER_PRODUCER_MODULE_FK_PRODUCER_id` FOREIGN KEY (`PRODUCER_id`) REFERENCES `PRODUCER` (`id`),
    CONSTRAINT  `USER_PRODUCER_MODULE_FK_MODULE_id` FOREIGN KEY (`MODULE_id`) REFERENCES `MODULE` (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT '사용자_제작자_모듈 중간테이블';


-- INSERT INTO USER_PRODUCER_MODULE(사용자_제작자_모듈 중간테이블)
INSERT INTO COSGRAM.USER_PRODUCER_MODULE (id, USER_id, PRODUCER_id, MODULE_id, create_datetime, update_datetime, is_use) VALUES
(
    1,
    1,
    (SELECT id FROM COSGRAM.PRODUCER WHERE name = '제작자_A'),
    (SELECT id FROM COSGRAM.MODULE WHERE name = 'NAVER_SHOPPING'),
    NOW(),
    NOW(),
    1
),
(
    2,
    2,
    (SELECT id FROM COSGRAM.PRODUCER WHERE name = '제작자_B'),
    (SELECT id FROM COSGRAM.MODULE WHERE name = 'NAVER_SHOPPING'),
    NOW(),
    NOW(),
    1
),
(
    3,
    2,
    (SELECT id FROM COSGRAM.PRODUCER WHERE name = '제작자_B'),
    (SELECT id FROM COSGRAM.MODULE WHERE name = 'YOUTUBE'),
    NOW(),
    NOW(),
    1
),
(
    4,
    1,
    (SELECT id FROM COSGRAM.PRODUCER WHERE name = '제작자_C'),
    (SELECT id FROM COSGRAM.MODULE WHERE name = 'NAVER_SHOPPING'),
    NOW(),
    NOW(),
    1
),
(
    5,
    1,
    (SELECT id FROM COSGRAM.PRODUCER WHERE name = '제작자_C'),
    (SELECT id FROM COSGRAM.MODULE WHERE name = 'YOUTUBE'),
    NOW(),
    NOW(),
    1
),
(
    6,
    1,
    (SELECT id FROM COSGRAM.PRODUCER WHERE name = '제작자_C'),
    (SELECT id FROM COSGRAM.MODULE WHERE name = 'AMAZON'),
    NOW(),
    NOW(),
    1
)
;