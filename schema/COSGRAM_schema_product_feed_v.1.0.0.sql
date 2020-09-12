###############################################################################
# [COSGRAM product_feed 초기 schema 스크립트]
###############################################################################

-- 0. COSGRAM_schema_user 실행

-- CREATE TABLE PRODUCT(상품 테이블)
DROP TABLE IF EXISTS COSGRAM.PRODUCT;
CREATE TABLE COSGRAM.PRODUCT
(
    `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
    `PRODUCER_id` int DEFAULT NULL COMMENT '제작자 id',
    `MODULE_id` int DEFAULT NULL COMMENT '모듈 id',
    `name` varchar(50) DEFAULT NULL COMMENT '상품 이름',
    `regist_datetime` datetime(6) DEFAULT NULL COMMENT '상품 등록 시간',
    `update_datetime` datetime(6) DEFAULT NULL COMMENT '상품 수정 시간',
    `is_use` tinyint(1) DEFAULT 1 NOT NULL COMMENT '상품 사용 여부',
    PRIMARY KEY (`id`),
    KEY `PRODUCT_FK_PRODUCER_id` (`PRODUCER_id`),
    KEY `PRODUCT_FK_MODULE_id` (`MODULE_id`),
    CONSTRAINT  `PRODUCT_FK_PRODUCER_id` FOREIGN KEY (`PRODUCER_id`) REFERENCES `PRODUCER` (`id`),
    CONSTRAINT  `PRODUCT_FK_MODULE_id` FOREIGN KEY (`MODULE_id`) REFERENCES `MODULE` (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT '상품 테이블';


-- INSERT INTO PRODUCT(상품 테이블)
INSERT INTO COSGRAM.PRODUCT (id, PRODUCER_id, MODULE_id, name, regist_datetime, update_datetime, is_use) VALUES
(
    1,
    (SELECT id FROM COSGRAM.PRODUCER WHERE name = '제작자_A'),
    (SELECT id FROM COSGRAM.MODULE WHERE name = 'NAVER_SHOPPING'),
    'root product',
    '2037-12-31',
    NOW(),
    1
),
(
    2,
    (SELECT id FROM COSGRAM.PRODUCER WHERE name = '제작자_A'),
    (SELECT id FROM COSGRAM.MODULE WHERE name = 'NAVER_SHOPPING'),
    '나이키 에어 테일윈드 79 487754-100',
    '2020-05-29',
    NOW(),
    1
),
(
    3,
    (SELECT id FROM COSGRAM.PRODUCER WHERE name = '제작자_B'),
    (SELECT id FROM COSGRAM.MODULE WHERE name = 'NAVER_SHOPPING'),
    '뉴발란스 327 블랙 화이트 MS327CPG',
    '2020-08-30',
    NOW(),
    1
),
(
    4,
    (SELECT id FROM COSGRAM.PRODUCER WHERE name = '제작자_C'),
    (SELECT id FROM COSGRAM.MODULE WHERE name = 'NAVER_SHOPPING'),
    '[닥터마틴] 1461 3홀 모노 블랙 14345001 14345001',
    '2017-08-21',
    NOW(),
    1
)
;


-- CREATE TABLE NAVER_FEEDBACK(네이버피드백 테이블)
DROP TABLE IF EXISTS COSGRAM.NAVER_FEEDBACK;
CREATE TABLE COSGRAM.NAVER_FEEDBACK
(
    `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
    `PRODUCT_id` int DEFAULT NULL COMMENT '상품 id',
    `PARENT_NAVER_FEEDBACK_id` int DEFAULT 1 DEFAULT NULL COMMENT '상위 모듈_피드백 id',
    `writer` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '네이버피드백 작성자',
    `title` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '네이버피드백 제목',
    `comment` varchar(500) COLLATE utf8mb4_general_ci NOT NULL COMMENT '네이버피드백 댓글',
    `rate` int NOT NULL COMMENT '네이버피드백 평점',
    `regist_datetime` datetime(6) NOT NULL COMMENT '네이버피드백 등록 시간',
    `update_datetime` datetime(6) NOT NULL COMMENT '네이버피드백 수정 시간',
    `is_use` tinyint(1) DEFAULT 1 NOT NULL COMMENT '네이버피드백 사용 유무',
    PRIMARY KEY (`id`),
    KEY `NAVER_FEEDBACK_FK_PRODUCT_id` (`PRODUCT_id`),
    KEY `NAVER_FEEDBACK_FK_PARENT_NAVER_FEEDBACK_id` (`PARENT_NAVER_FEEDBACK_id`),
    CONSTRAINT  `NAVER_FEEDBACK_FK_PRODUCER_id` FOREIGN KEY (`PRODUCT_id`) REFERENCES `PRODUCT` (`id`),
    CONSTRAINT  `NAVER_FEEDBACK_FK_PARENT_NAVER_FEEDBACK_id` FOREIGN KEY (`PARENT_NAVER_FEEDBACK_id`) REFERENCES `NAVER_FEEDBACK` (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT '네이버피드백 테이블';



-- INSERT INTO NAVER_FEEDBACK(루트 값)
INSERT INTO COSGRAM.NAVER_FEEDBACK (id, PRODUCT_id, writer, title, comment, rate, regist_datetime, update_datetime, is_use) VALUES
(
	1,
    1,
    'NAVER_FEEDBACK Root',
    'NAVER_FEEDBACK Root',
    'NAVER_FEEDBACK Root id',
    5,
    '2037-12-31',
    '2037-12-31',
    0
)
;


-- INSERT INTO MODULE_FEEDBACK
INSERT INTO COSGRAM.NAVER_FEEDBACK (id, PRODUCT_id, PARENT_NAVER_FEEDBACK_id, writer, title, comment, rate, regist_datetime, update_datetime, is_use) VALUES
(
    2,
    (SELECT id FROM COSGRAM.PRODUCT WHERE name = '나이키 에어 테일윈드 79 487754-100' LIMIT 1),
    1,
    'ball****',
    '사람들 마다 한사이즈 업이네 다운이네 하시는데... 저는 250이 딱 맞습니다^^ (딱 맞게 신는 스타일..신발 긴거 싫어해요ㅋㅋ 그래도 발끝 살짝 남아요.)  신발이 길고 볼이 ',
    '~~ 어짜피 신발이 조금 긴 스타일이니 정사이즈로 구매 하셔도 될듯 해요. 볼은 꽉끼는 소재가 아녀서 좀 신다보면 발에 편하게 적응 되실겁니다. 그리고 중국에서 들어오는 쓰레기 제품과는 차원이 다른 고품질 정품입니다~!!! 가끔 보면 5만원 6만원 주고 구입하면서 무슨 정품을 바란답니까.. 쿠× 뭐 이런데 가면 싸긴한데 정품이 아닌 다른 제품이 간다든지.. 반품 비용이 신발값 보다 더 많이 든다던지...배송도 얼마나 걸릴지 모르는 중국발 데일윈드(짝퉁).. 암튼.. ',
    5,
    '2020-05-29',
    NOW(),
    1
),
(
    3,
    (SELECT id FROM COSGRAM.PRODUCER WHERE name = '나이키 에어 테일윈드 79 487754-100' LIMIT 1),
    1,
    'over****',
    '나이키 신발 박스가 왜 찢어져 있습니까? 그리고 신발 두 군대에서 빨간 볼펜 점?인가 자국이 좀 보이는데 이게 뭐죠? 신발 자세히 보면 보이는데 그냥 귀찮아서 신을께요 ㅠㅠ 그리고',
    '나이키 신발 박스가 왜 찢어져 있습니까? 그리고 신발 두 군대에서 빨간 볼펜 점?인가 자국이 좀 보이는데 이게 뭐죠? 신발 자세히 보면 보이는데 그냥 귀찮아서 신을께요 ㅠㅠ 그리고 뒷굼치에 약간 얼룩인가? 마모인가? 착샷안된거 맞나요? 좀 불안하네.. 나코탭이고 전반적으로 큰 문제 안보여서 그냥 신습니다... 전반적으로 좀 아쉽네요 완전 새상품이었으면 좋겠는데,,,',
    2,
    '2020-02-02',
    NOW(),
    1
),
(
    4,
    (SELECT id FROM COSGRAM.PRODUCER WHERE name = '나이키 에어 테일윈드 79 487754-100' LIMIT 1),
    1,
    'jusu****',
    '정말 갖고 싶었던 신발인데 이번에 구매하게 되었네요 사진으로만 봐도 이뻐서 정말 기대 많이했는데 실제로 보고 신어보니 진짜 예쁘네요 실물깡패 ㅎㅎ 착화감도 정말 좋고 편하네요 신발',
    '정말 갖고 싶었던 신발인데 이번에 구매하게 되었네요 사진으로만 봐도 이뻐서 정말 기대 많이했는데 실제로 보고 신어보니 진짜 예쁘네요 ',
    5,
    '2020-08-19',
    NOW(),
    1
),
(
    5,
    (SELECT id FROM COSGRAM.PRODUCER WHERE name = '나이키 에어 테일윈드 79 487754-100' LIMIT 1),
    1,
    'gich****',
    '남친 선물해주려고 산거였습니다~ 주문 후에 알게된 점이 남친 발 사이즈가 제가 주문한 사이즈 보다 10 크더라구요ㅠ 그래서 맞을까 안맞을까 걱정했는데 딱 맞아서 안심했습니다~ 정품',
    '남친 선물해주려고 산거였습니다~ 주문 후에 알게된 점이 남친 발 사이즈가 제가 주문한 사이즈 보다 10 크더라구요ㅠ 그래서 맞을까 안맞을까 걱정했는데 딱 맞아서 안심했습니다~ 정품 맞는거 같구요~ ',
    5,
    '2020-03-07',
    NOW(),
    1
),
(
    6,
    (SELECT id FROM COSGRAM.PRODUCER WHERE name = '나이키 에어 테일윈드 79 487754-100' LIMIT 1),
    1,
    'spee****',
    '판매자님 답변에는 제조공정중 미세한 차이가 발생 할 수 있는 부분이라고 하는데 구매자로서는 착장 후에 전혀 다른 신발 착용 했다고 보여 집니다. 조용히 처리하기 위해 1:1 문의로',
    '판매자님 답변에는 제조공정중 미세한 차이가 발생 할 수 있는 부분이라고 하는데 구매자로서는 착장 후에 전혀 다른 신발 착용 했다고 보여 집니다. 조용히 처리하기 위해 1:1 문의로 교환 및 환불 요청 했으나 한번 착장 했다는 이유로 불가하다고만 함. 구매 하시는 분들 사진 참고 하셔야 손해 안보실거에요. 미세한 차이가 구매자의 입장과 판매자의 입장차가 엄청 크게 느껴집니다. 아이폰 9분할로 촬영 한 사진 입니다. 구매에 도움이 되시길 바랍니다.',
    1,
    '2020-06-06',
    NOW(),
    1
);


-- CREATE TABLE NAVER_FEEDBACK_IMAGE(네이버피드백_이미지)
DROP TABLE IF EXISTS COSGRAM.NAVER_FEEDBACK_IMAGE;
CREATE TABLE COSGRAM.NAVER_FEEDBACK_IMAGE
(
    `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
    `NAVER_FEEDBACK_id` int DEFAULT NULL COMMENT '네이버_피드백 id',
    `image_url` varchar(1000) DEFAULT NULL COMMENT '네이버피드백_이미지 이미지_url',
    `create_datetime` datetime(6) NOT NULL COMMENT '네이버피드백_이미지 생성 시간',
    `update_datetime` datetime(6) NOT NULL COMMENT '네이버피드백_이미지 수정 시간',
    `is_use` tinyint(1) DEFAULT 1 NOT NULL COMMENT '네이버피드백_이미지 사용 유무',
    PRIMARY KEY (`id`),
    KEY `FEEDBACK_IMAGE_FK_NAVER_FEEDBACK_id` (`NAVER_FEEDBACK_id`),
    CONSTRAINT  `FEEDBACK_IMAGE_FK_NAVER_FEEDBACK_id` FOREIGN KEY (`NAVER_FEEDBACK_id`) REFERENCES `NAVER_FEEDBACK` (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT '네이버피드백_이미지 테이블';


-- INSERT INTO NAVER_FEEDBACK_IMAGE(네이버피드백_이미지)
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
)
;
