###############################################################################
# [COSGRAM total schema 스크립트]
###############################################################################

-- 0. CREATE DATABASE COSGRAM
-- DROP DATABASE IF EXISTS COSGRAM;
-- CREATE DATABASE COSGRAM character SET utf8mb4 collate utf8mb4_general_ci;

-- 0. FOREIGN_KEY_CHECKS = 0
SET FOREIGN_KEY_CHECKS = 0;

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

-- INSERT INTO PRODUCER(제작자 테이블)
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


-- CREATE TABLE PRODUCT
DROP TABLE IF EXISTS COSGRAM.PRODUCT;
CREATE TABLE COSGRAM.PRODUCT
(
    `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
    `PRODUCER_id` int DEFAULT NULL COMMENT '제작자 id',
    `MODULE_id` int DEFAULT NULL COMMENT '모듈 id',
    `name` varchar(100) DEFAULT NULL COMMENT '상품 이름',
    `regist_datetime` datetime(6) DEFAULT NULL COMMENT '상품 등록 시간',
    `update_datetime` datetime(6) DEFAULT NULL COMMENT '상품 수정 시간',
    `is_use` tinyint(1) DEFAULT 1 NOT NULL COMMENT '상품 사용 여부',
    PRIMARY KEY (`id`),
    KEY `PRODUCT_FK_PRODUCER_id` (`PRODUCER_id`),
    KEY `PRODUCT_FK_MODULE_id` (`MODULE_id`),
    CONSTRAINT  `PRODUCT_FK_PRODUCER_id` FOREIGN KEY (`PRODUCER_id`) REFERENCES `PRODUCER` (`id`),
    CONSTRAINT  `PRODUCT_FK_MODULE_id` FOREIGN KEY (`MODULE_id`) REFERENCES `MODULE` (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT '상품 테이블';

-- INSERT INTO PRODUCT
INSERT INTO COSGRAM.PRODUCT (id, PRODUCER_id, MODULE_id, name, regist_datetime, update_datetime, is_use) VALUES
(
    1,
    1,
    1,
    '나이키 에어 테일윈드 79 487754-100',
    '2020-05-29',
    NOW(),
    1
),
(
    2,
    1,
    1,
    '뉴발란스 327 블랙 화이트 MS327CPG',
    '2020-08-30',
    NOW(),
    1
),
(
    3,
    1,
    1,
    '닥터마틴 2976 첼시부츠 11853001',
    '2019-08-21',
    NOW(),
    1
),
(
    4,
    2,
    2,
    '[REVIEW+] 너무 이쁜 992! 그레이 아니어도 좋아요! 뉴발란스 992 옐로우(992골드크림) 리뷰 NB 992 GOLD CREAM M992BB REVIEW',
    '2020-09-10',
    NOW(),
    1
),
(
    5,
    3,
    3,
    'Nike Men Revolution 5 Running Shoe',
    '2020-03-10',
    NOW(),
    1
)
;


-- CREATE TABLE NAVER_FEEDBACK
DROP TABLE IF EXISTS COSGRAM.NAVER_FEEDBACK;
CREATE TABLE COSGRAM.NAVER_FEEDBACK
(
    `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
    `PRODUCT_id` int DEFAULT NULL COMMENT '상품 id',
    `writer` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '네이버피드백 작성자',
    `title` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '네이버피드백 제목',
    `comment` varchar(500) COLLATE utf8mb4_general_ci NOT NULL COMMENT '네이버피드백 댓글',
    `rate` int NOT NULL COMMENT '네이버피드백 평점',
    `regist_datetime` datetime(6) NOT NULL COMMENT '네이버피드백 등록 시간',
    `update_datetime` datetime(6) NOT NULL COMMENT '네이버피드백 수정 시간',
    `is_use` tinyint(1) DEFAULT 1 NOT NULL COMMENT '네이버피드백 사용 유무',
    PRIMARY KEY (`id`),
    KEY `NAVER_FEEDBACK_FK_PRODUCT_id` (`PRODUCT_id`),
    CONSTRAINT  `NAVER_FEEDBACK_FK_PRODUCER_id` FOREIGN KEY (`PRODUCT_id`) REFERENCES `PRODUCT` (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT '네이버피드백 테이블';


-- INSERT INTO NAVER_FEEDBACK
INSERT INTO COSGRAM.NAVER_FEEDBACK (id, PRODUCT_id, writer, title, comment, rate, regist_datetime, update_datetime, is_use) VALUES
(
    1,
    (SELECT id FROM COSGRAM.PRODUCT WHERE name = '나이키 에어 테일윈드 79 487754-100' LIMIT 1),
    'ball****',
    '사람들 마다 한사이즈 업이네 다운이네 하시는데... 저는 250이 딱 맞습니다^^ (딱 맞게 신는 스타일..신발 긴거 싫어해요ㅋㅋ 그래도 발끝 살짝 남아요.)  신발이 길고 볼이 ',
    '~~ 어짜피 신발이 조금 긴 스타일이니 정사이즈로 구매 하셔도 될듯 해요. 볼은 꽉끼는 소재가 아녀서 좀 신다보면 발에 편하게 적응 되실겁니다. 그리고 중국에서 들어오는 쓰레기 제품과는 차원이 다른 고품질 정품입니다~!!! 가끔 보면 5만원 6만원 주고 구입하면서 무슨 정품을 바란답니까.. 쿠× 뭐 이런데 가면 싸긴한데 정품이 아닌 다른 제품이 간다든지.. 반품 비용이 신발값 보다 더 많이 든다던지...배송도 얼마나 걸릴지 모르는 중국발 데일윈드(짝퉁).. 암튼.. ',
    5,
    '2020-05-29',
    NOW(),
    1
),
(
    2,
    (SELECT id FROM COSGRAM.PRODUCT WHERE name = '나이키 에어 테일윈드 79 487754-100' LIMIT 1),
    'over****',
    '나이키 신발 박스가 왜 찢어져 있습니까? 그리고 신발 두 군대에서 빨간 볼펜 점?인가 자국이 좀 보이는데 이게 뭐죠? 신발 자세히 보면 보이는데 그냥 귀찮아서 신을께요 ㅠㅠ 그리고',
    '나이키 신발 박스가 왜 찢어져 있습니까? 그리고 신발 두 군대에서 빨간 볼펜 점?인가 자국이 좀 보이는데 이게 뭐죠? 신발 자세히 보면 보이는데 그냥 귀찮아서 신을께요 ㅠㅠ 그리고 뒷굼치에 약간 얼룩인가? 마모인가? 착샷안된거 맞나요? 좀 불안하네.. 나코탭이고 전반적으로 큰 문제 안보여서 그냥 신습니다... 전반적으로 좀 아쉽네요 완전 새상품이었으면 좋겠는데,,,',
    2,
    '2020-02-02',
    NOW(),
    1
),
(
    3,
    (SELECT id FROM COSGRAM.PRODUCT WHERE name = '나이키 에어 테일윈드 79 487754-100' LIMIT 1),
    'jusu****',
    '정말 갖고 싶었던 신발인데 이번에 구매하게 되었네요 사진으로만 봐도 이뻐서 정말 기대 많이했는데 실제로 보고 신어보니 진짜 예쁘네요 실물깡패 ㅎㅎ 착화감도 정말 좋고 편하네요 신발',
    '정말 갖고 싶었던 신발인데 이번에 구매하게 되었네요 사진으로만 봐도 이뻐서 정말 기대 많이했는데 실제로 보고 신어보니 진짜 예쁘네요 ',
    5,
    '2020-08-19',
    NOW(),
    1
),
(
    4,
    (SELECT id FROM COSGRAM.PRODUCT WHERE name = '나이키 에어 테일윈드 79 487754-100' LIMIT 1),
    'gich****',
    '남친 선물해주려고 산거였습니다~ 주문 후에 알게된 점이 남친 발 사이즈가 제가 주문한 사이즈 보다 10 크더라구요ㅠ 그래서 맞을까 안맞을까 걱정했는데 딱 맞아서 안심했습니다~ 정품',
    '남친 선물해주려고 산거였습니다~ 주문 후에 알게된 점이 남친 발 사이즈가 제가 주문한 사이즈 보다 10 크더라구요ㅠ 그래서 맞을까 안맞을까 걱정했는데 딱 맞아서 안심했습니다~ 정품 맞는거 같구요~ ',
    5,
    '2020-03-07',
    NOW(),
    1
),
(
    5,
    (SELECT id FROM COSGRAM.PRODUCT WHERE name = '나이키 에어 테일윈드 79 487754-100' LIMIT 1),
    'spee****',
    '판매자님 답변에는 제조공정중 미세한 차이가 발생 할 수 있는 부분이라고 하는데 구매자로서는 착장 후에 전혀 다른 신발 착용 했다고 보여 집니다. 조용히 처리하기 위해 1:1 문의로',
    '판매자님 답변에는 제조공정중 미세한 차이가 발생 할 수 있는 부분이라고 하는데 구매자로서는 착장 후에 전혀 다른 신발 착용 했다고 보여 집니다. 조용히 처리하기 위해 1:1 문의로 교환 및 환불 요청 했으나 한번 착장 했다는 이유로 불가하다고만 함. 구매 하시는 분들 사진 참고 하셔야 손해 안보실거에요. 미세한 차이가 구매자의 입장과 판매자의 입장차가 엄청 크게 느껴집니다. 아이폰 9분할로 촬영 한 사진 입니다. 구매에 도움이 되시길 바랍니다.',
    1,
    '2020-06-06',
    NOW(),
    1
),
(
	6,
    (SELECT id FROM COSGRAM.PRODUCT WHERE name = '뉴발란스 327 블랙 화이트 MS327CPG' LIMIT 1),
    'oloo****',
    '청바지 그리고 반바지와 잘어울릴듯... 배송 매우 빠름',
    '청바지 그리고 반바지와 잘어울릴듯... 배송 매우 빠름',
    5,
    '2020-08-05',
    NOW(),
    1
),
(
    7,
    (SELECT id FROM COSGRAM.PRODUCT WHERE name = '뉴발란스 327 블랙 화이트 MS327CPG' LIMIT 1),
    'grut****',
    '발볼 넓으신분 아니면 정사이즈 하세요. 흰끈 사셔서 바꾸는거 추천합니다. 신발 진짜 이뻐요',
    '발볼 넓으신분 아니면 정사이즈 하세요. 흰끈 사셔서 바꾸는거 추천합니다. 신발 진짜 이뻐요',
    5,
    '2020-09-02',
    NOW(),
    1
),
(
    8,
    (SELECT id FROM COSGRAM.PRODUCT WHERE name = '뉴발란스 327 블랙 화이트 MS327CPG' LIMIT 1),
    'bir1****',
    '생각보다 질이 좋고 발이 편해서 좋네요^^ 신발 자체는 커보입니다',
    '생각보다 질이 좋고 발이 편해서 좋네요^^ 신발 자체는 커보입니다',
    5,
    '2020-08-21',
    NOW(),
    1
),
(
    9,
    (SELECT id FROM COSGRAM.PRODUCT WHERE name = '닥터마틴 2976 첼시부츠 11853001' LIMIT 1),
    'goan****',
    '저가 평소240에 발볼이.좀있는편이고 컨버스는 230신는데 이건 발볼때문에240 정사이즈로 구매했어요 신발이 워낙커서 한사이즈나 반사이즈 내려서 구매하라는후기가많았는데 저는 발볼이',
    '저가 평소240에 발볼이.좀있는편이고 컨버스는 230신는데 이건 발볼때문에240 정사이즈로 구매했어요 신발이 워낙커서 한사이즈나 반사이즈 내려서 구매하라는후기가많았는데 저는 발볼이 걸려서,,30도 맞을것같긴한데 좀 불편할',
    5,
    '2020-07-31',
    NOW(),
    1
),
(
    10,
    (SELECT id FROM COSGRAM.PRODUCT WHERE name = '닥터마틴 2976 첼시부츠 11853001' LIMIT 1),
    'eepp****',
    '배송은 6일 정도 걸렸어요^^매장에서 신어보니 원래 235 신는데 이건 220 사이즈가 맞더라구요~발 사이즈는 맞는데발목 부분이 짱짱하니 작아요그래도 신고나면 딱 잡아줘서 편하긴 ',
    '배송은 6일 정도 걸렸어요^^매장에서 신어보니 원래 235 신는데 이건 220 사이즈가 맞더라구요~발 사이즈는 맞는데발목 부분이 짱짱하니 작아요그래도 신고나면 딱 잡아줘서 편하긴 합니다.',
    5,
    '2019-12-02',
    NOW(),
    1
)
;


-- CREATE TABLE NAVER_FEEDBACK_IMAGE
DROP TABLE IF EXISTS COSGRAM.NAVER_FEEDBACK_IMAGE;
CREATE TABLE COSGRAM.NAVER_FEEDBACK_IMAGE
(
    `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
    `NAVER_FEEDBACK_id` int DEFAULT NULL COMMENT '네이버_피드백 id',
    `image_url` varchar(1000)  DEFAULT NULL COMMENT '네이버피드백_이미지 이미지_url',
    `create_datetime` datetime(6) NOT NULL COMMENT '네이버피드백_이미지 생성 시간',
    `update_datetime` datetime(6) NOT NULL COMMENT '네이버피드백_이미지 수정 시간',
    `is_use` tinyint(1) DEFAULT 1 NOT NULL COMMENT '네이버피드백_이미지 사용 유무',
    PRIMARY KEY (`id`),
    KEY `FEEDBACK_IMAGE_FK_NAVER_FEEDBACK_id` (`NAVER_FEEDBACK_id`),
    CONSTRAINT  `FEEDBACK_IMAGE_FK_NAVER_FEEDBACK_id` FOREIGN KEY (`NAVER_FEEDBACK_id`) REFERENCES `NAVER_FEEDBACK` (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT '네이버피드백_이미지 테이블';

-- INSERT INTO NAVER_FEEDBACK_IMAGE
INSERT INTO COSGRAM.NAVER_FEEDBACK_IMAGE (id, NAVER_FEEDBACK_id, image_url, create_datetime, update_datetime, is_use) VALUES
(
    1,
    1,
    'https://phinf.pstatic.net/checkout.phinf/20200529_190/1590725607943w7cTj_JPEG/20200529_130243.jpg?type=f287',
    NOW(),
    NOW(),
    1
),
(
    2,
    1,
    'https://phinf.pstatic.net/checkout.phinf/20200602_143/1591077881583gQI6g_JPEG/20200530_002227.jpg?type=f287',
    NOW(),
    NOW(),
    1
),
(
    3,
    2,
    'https://phinf.pstatic.net/checkout/20200202_23/1580626610450pvyGt_JPEG/KakaoTalk_20200202_155437468.jpg?type=f287',
    NOW(),
    NOW(),
    1
),
(
    4,
    2,
    'https://phinf.pstatic.net/checkout/20200202_195/1580626634186DmzqW_JPEG/KakaoTalk_20200202_155447408.jpg?type=f287',
    NOW(),
    NOW(),
    1
),
(
    5,
    2,
    'https://phinf.pstatic.net/checkout/20200202_261/1580626634068QxDe6_JPEG/KakaoTalk_20200202_155442950.jpg?type=f287',
    NOW(),
    NOW(),
    1
),
(
    6,
    2,
    'https://phinf.pstatic.net/checkout/20200202_219/1580626634459aHGLO_JPEG/KakaoTalk_20200202_155445478.jpg?type=f287',
    NOW(),
    NOW(),
    1
),
(
    7,
    2,
    'https://phinf.pstatic.net/checkout/20200202_254/15806266343147nn1y_JPEG/KakaoTalk_20200202_155440611.jpg?type=f287',
    NOW(),
    NOW(),
    1
),
(
    8,
    3,
    'https://phinf.pstatic.net/checkout/20200819_48/1597842762826PACj8_JPEG/review-attachment-fddde227-ebb9-4179-98b4-8aeb1ae5131f.jpeg?type=f287',
    NOW(),
    NOW(),
    1
),
(
    9,
    3,
    'https://phinf.pstatic.net/checkout/20200819_285/1597842763706JDRdR_JPEG/review-attachment-88c06702-d611-4b45-941a-7049dcb13ea1.jpeg?type=f287',
    NOW(),
    NOW(),
    1
),
(
    10,
    3,
    'https://phinf.pstatic.net/checkout/20200819_148/1597842760493tAAKe_JPEG/review-attachment-9a78675b-e0eb-4217-8c04-cd01cab8052d.jpeg?type=f287',
    NOW(),
    NOW(),
    1
),
(
    11,
    4,
    'https://phinf.pstatic.net/checkout/20200307_139/1583506953027hFqJj_JPEG/457547D2-7028-4060-94D9-B16048F79B01.jpeg?type=f287',
    NOW(),
    NOW(),
    1
),
(
    12,
    4,
    'https://phinf.pstatic.net/checkout/20200307_110/1583506954019vtgFo_JPEG/F5B20B10-3EC4-4983-B053-B2AF14FE6D4D.jpeg?type=f287',
    NOW(),
    NOW(),
    1
),
(
    13,
    4,
    'https://phinf.pstatic.net/checkout/20200307_79/15835069541437PW28_JPEG/77F443DB-2B52-4A68-98FB-9879EE518051.jpeg?type=f287',
    NOW(),
    NOW(),
    1
),
(
    14,
    4,
    'https://phinf.pstatic.net/checkout/20200307_124/1583506954789vyPm0_JPEG/F92C0EA0-C90B-429E-A178-B57DE7D29458.jpeg?type=f287',
    NOW(),
    NOW(),
    1
),
(
    15,
    5,
    'https://phinf.pstatic.net/checkout/20200606_137/1591370721247QG8Tr_JPEG/5555.jpg?type=f287',
    NOW(),
    NOW(),
    1
),
(
    16,
    5,
    'https://phinf.pstatic.net/checkout/20200606_23/1591370721236p7Fnd_JPEG/66666666.jpg?type=f287',
    NOW(),
    NOW(),
    1
),
(
    17,
    6,
    'https://phinf.pstatic.net/checkout/20200805_295/1596601884796jUCq7_JPEG/review-attachment-e3cb1c69-1fb7-4b76-bb68-07ee375c074c.jpeg?type=f287',
    NOW(),
    NOW(),
    1
),
(
    18,
    6,
    'https://phinf.pstatic.net/checkout/20200805_16/15966018964942BsFP_JPEG/review-attachment-45a1eb05-2f2e-4777-a8b6-5d3bdcc96441.jpeg?type=f287',
    NOW(),
    NOW(),
    1
),
(
    19,
    7,
    'https://phinf.pstatic.net/checkout/20200902_182/1599023436871nb7Kf_JPEG/review-attachment-69b68f8c-2a69-4a04-a6c4-56b6487e906b.jpeg?type=f287',
    NOW(),
    NOW(),
    1
),
(
    20,
    9,
    'https://phinf.pstatic.net/checkout/20200731_135/1596167412361kEVN6_JPEG/review-attachment-858595f1-7bcc-40e1-96e9-99dd64a3cf0a.jpeg?type=f287',
    NOW(),
    NOW(),
    1
),
(
    21,
    10,
    'https://phinf.pstatic.net/checkout/20191202_225/1575293916973FAh7M_JPEG/569F40E4-E61E-4993-A9A3-4DEF39A40BBF.jpeg?type=f287',
    NOW(),
    NOW(),
    1
),
(
    22,
    10,
    'https://phinf.pstatic.net/checkout/20191202_14/1575293918419O7IMD_JPEG/F2A37CDE-A4AC-49FA-91CC-5F42C365F196.jpeg?type=f287',
    NOW(),
    NOW(),
    1
),
(
    23,
    10,
    'https://phinf.pstatic.net/checkout/20191202_14/1575293918419O7IMD_JPEG/F2A37CDE-A4AC-49FA-91CC-5F42C365F196.jpeg?type=f287',
    NOW(),
    NOW(),
    1
)
;


-- CREATE TABLE YOUTUBE_FEEDBACK(유투브피드백)
DROP TABLE IF EXISTS COSGRAM.YOUTUBE_FEEDBACK;
CREATE TABLE COSGRAM.YOUTUBE_FEEDBACK
(
    `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
    `PRODUCT_id` int DEFAULT NULL COMMENT '상품 id',
    `writer` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '유투브피드백 작성자',
    `comment` varchar(500) COLLATE utf8mb4_general_ci NOT NULL COMMENT '유투브피드백 댓글',
    `regist_datetime` datetime(6) NOT NULL COMMENT '유투브피드백 등록 시간',
    `update_datetime` datetime(6) NOT NULL COMMENT '유투브피드백 수정 시간',
    `is_use` tinyint(1) DEFAULT 1 NOT NULL COMMENT '유투브피드백 사용 유무',
    PRIMARY KEY (`id`),
    KEY `YOUTUBE_FEEDBACK_FK_PRODUCT_id` (`PRODUCT_id`),
    CONSTRAINT  `YOUTUBE_FEEDBACK_FK_PRODUCER_id` FOREIGN KEY (`PRODUCT_id`) REFERENCES `PRODUCT` (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT '유투브피드백 테이블';

-- INSERT INTO YOUTUBE_FEEDBACK
INSERT INTO COSGRAM.YOUTUBE_FEEDBACK (id, PRODUCT_id, writer, comment, regist_datetime, update_datetime, is_use) VALUES
(
    1,
    4,
    '김상기',
    '색이 사진으로 볼때보다 연해서 괜찮네요.한국 정발 관한 정보는 없나봐요.?무난한 컬러도 좋지만 포인트있는것도 좋네요.',
    '2020-09-08',
    NOW(),
    1
),
(
    2,
    4,
    '장순호',
    '이거 살까 고민했는데 영상보고 구매욕구가 상당히 생기네요ㅎㅎ!',
    '2020-09-08',
    NOW(),
    1
),
(
    3,
    4,
    'Will Fe',
    '와 ㅋㅋㅋㅋ진짜 이쁘다',
    '2020-09-08',
    NOW(),
    1
),
(
    4,
    4,
    'ALIEN_알린',
    '와.......이ㅃ죄송하지만 일루미나티 언급하신 부분에 대해서 조금더 알려주실 수 있나요?너무 궁금해서요 ㅠㅠ스티븐잡스와 연관이 있는건지.....',
    '2020-09-07',
    NOW(),
    1
),
(
    5,
    4,
    '정재식',
    '주목받는 신발만 리뷰하지 않고 다양한 제품리뷰 정말 최고입니다!! 겨자색도 좋은거 같습니다 !!! 저도 한번 시도 해봐야겠습니다 !!',
    '2020-09-07',
    NOW(),
    1
)
;


-- CREATE TABLE AMAZON_FEEDBACK(아마존피드백)
DROP TABLE IF EXISTS COSGRAM.AMAZON_FEEDBACK;
CREATE TABLE COSGRAM.AMAZON_FEEDBACK
(
    `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
    `PRODUCT_id` int DEFAULT NULL COMMENT '상품 id',
    `writer` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '아마존피드백 작성자',
    `title` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '아마존피드백 제목',
    `comment` varchar(500) COLLATE utf8mb4_general_ci NOT NULL COMMENT '아마존피드백 댓글',
    `rate` int NOT NULL COMMENT '아마존피드백 평점',
    `regist_datetime` datetime(6) NOT NULL COMMENT '아마존피드백 등록 시간',
    `update_datetime` datetime(6) NOT NULL COMMENT '아마존피드백 수정 시간',
    `is_use` tinyint(1) DEFAULT 1 NOT NULL COMMENT '아마존피드백 사용 유무',
    PRIMARY KEY (`id`),
    KEY `AMAZON_FEEDBACK_FK_PRODUCT_id` (`PRODUCT_id`),
    CONSTRAINT  `AMAZON_FEEDBACK_FK_PRODUCER_id` FOREIGN KEY (`PRODUCT_id`) REFERENCES `PRODUCT` (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT '아마존피드백 테이블';


-- INSERT INTO AMAZON_FEEDBACK
INSERT INTO COSGRAM.AMAZON_FEEDBACK (id, PRODUCT_id, writer, title, comment, rate, regist_datetime, update_datetime, is_use) VALUES
(
    1,
    5,
    'Jim',
    'Sturdy, light, and wow do they look great!',
    'I’m not a marathon runner and in fact I’m far from it, run about 2 miles 4-5 days a week and was looking to replace my current new balances but wanted to try something new because all I buy are NB’s. These shoes, to me, were stunning. Minute I put them on, felt comfortable, light, but the sole is deceivingly thick. But not so much that it feels like your trucking around in some basketball shoes. These also on an aesthetic level...god do they pop. I knew they were fresh as hell the moment I put them on but I got 5 compliments the first day I wore these around just to break them in. Probably going to get another pair just for walking around. I’m not some expert runner so there may be flaws to my untrained eye but I am beyond impressed with these. I go around to different brands with different athletic gear and I always wind up in one way or another going back to Nike. They’ve always had superb products and they are still at the top of their game with these shoes',
    5,
    '2020-01-08',
    NOW(),
    1
),
(
    2,
    5,
    'Tucker Alleborn',
    ' Loud popping sound while walking...',
    'First off, these shoes are insanely comfortable, and fit perfectly. However, the "bubble" traction pattern on the bottom of the shoe makes a loud snap / pop when you walk, at literally the volume of popping bubble packaging. Numerous people have commented on this, its completely unmistakable. This goes for nearly all surfaces. Really odd design choice, or maybe it was just my size (12.5).',
    2,
    '2020-01-16',
    NOW(),
    1
),
(
    1,
    5,
    'Victor G.',
    'Always',
    'One shoe had a loud smack every time my son walked. Like it was suctioning down to the floor. We even put tape at the bottOm to pin point area And it continued doing it. Waiting on replacement I do not know if I will be billed twice as my son took shoes to dads house and have them a good wear down in 3 days and he never told me about problem till he was home',
    3,
    '2020-01-02',
    NOW(),
    1
)
;

-- 0. FOREIGN_KEY_CHECKS = 1
SET FOREIGN_KEY_CHECKS = 1;