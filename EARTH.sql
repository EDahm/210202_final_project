-----------------------------------------------------------2월 9일 화요일 테이블생성

-- 회원 --
CREATE TABLE mber_tb (
    m_num       VARCHAR2(20),
    m_regdate   DATE DEFAULT sysdate,
    m_email     VARCHAR2(100) NOT NULL,
    m_password  VARCHAR2(1000) NOT NULL,
    m_name      VARCHAR2(30) NOT NULL,
    m_ncnm      VARCHAR2(30) NOT NULL,
    m_contact   VARCHAR2(15) NOT NULL,
    m_birth     DATE DEFAULT sysdate,
    m_type      VARCHAR2(10) DEFAULT '일반',
    m_point     NUMBER(10, 0) DEFAULT 0
);

-- 기본키 설정 --
ALTER TABLE mber_tb ADD CONSTRAINT pk_mber_tb PRIMARY KEY ( m_num );

CREATE SEQUENCE seq_qna;

CREATE SEQUENCE seq_qna_category;

SELECT
    *
FROM
    qna_category_tb;

CREATE SEQUENCE seq_qna_reply;

-- 회원번호 시퀀스 --
CREATE SEQUENCE seq_mber INCREMENT BY 1 START WITH 100000;

-- 수거예약번호 시퀀스 --
create sequence seq_tkawy
INCREMENT by 1
start with 1000;


-- #################qna 게시판 테이블################# --
CREATE TABLE qna_tb (
    q_bno       NUMBER(10, 0),
    m_num       VARCHAR2(20),
    qc_bno      NUMBER(10, 0),
    q_sj        VARCHAR2(200) NOT NULL,
    q_ncnm      VARCHAR2(30) NOT NULL,
    q_content   VARCHAR2(2000) NOT NULL,
    q_regdate   DATE DEFAULT sysdate,
    q_replycnt  NUMBER DEFAULT 0
);
-- #################qna 댓글 테이블################# --
CREATE TABLE qna_reply_tb (
    qr_rno      NUMBER(10, 0),
    q_bno       NUMBER(10, 0),
    m_num       VARCHAR2(20),
    qr_reply    VARCHAR2(1000) NOT NULL,
    qr_replyer  VARCHAR2(50) NOT NULL,
    qr_regdate  DATE DEFAULT sysdate
);
-- #################qna 카테고리 테이블################# --
CREATE TABLE qna_category_tb (
    qc_bno   NUMBER(10, 0),
    qc_name  VARCHAR2(50) NOT NULL
);
-- qna 게시판 기본키 설정 --
ALTER TABLE qna_tb ADD CONSTRAINT pk_qna_tb PRIMARY KEY ( q_bno );                                           
                                           
-- qna 댓글 기본키 설정 --
ALTER TABLE qna_reply_tb ADD CONSTRAINT pk_qna_reply_tb PRIMARY
KEY ( qr_rno );

-- qna 카테고리 기본키 설정 --
ALTER TABLE qna_category_tb ADD CONSTRAINT pk_qna_category_tb PRIMARY KEY ( qc_bno );

-- 외래키 설정---------
ALTER TABLE qna_tb
    ADD CONSTRAINT fk_mber_tb_to_qna_tb_1 FOREIGN KEY ( m_num )
        REFERENCES mber_tb ( m_num );

ALTER TABLE qna_tb
    ADD CONSTRAINT fk_qna_category_tb_to_qna_tb_2 FOREIGN KEY ( qc_bno )
        REFERENCES qna_category_tb ( qc_bno );

--***************외래키 보류 오류남 ㅠㅠ------------------
-- 외래키 설정 --
ALTER TABLE qna_reply_tb
    ADD CONSTRAINT fk_qna_tb_to_qna_reply_tb_1 FOREIGN KEY ( q_bno )
        REFERENCES qna_tb ( q_bno );

ALTER TABLE qna_reply_tb
    ADD CONSTRAINT fk_qna_tb_to_qna_reply_tb_2 FOREIGN KEY ( m_num )
        REFERENCES mber_tb ( m_num );
        
--***************외래키 보류 오류남 ㅠㅠ--------------- 

-- #############수거예약 테이블############################--

CREATE TABLE tkawy_tb (
    t_bno          VARCHAR2(20) NOT NULL,
    m_num          VARCHAR2(20) NOT NULL,
    t_regdate      DATE DEFAULT sysdate,
    t_contact      VARCHAR2(15) NOT NULL,
    t_plastic      NUMBER(5, 0) default 0,
    t_plastic_cap  NUMBER(5, 0) default 0,
    t_vstng_cmpny  VARCHAR2(100) NOT NULL,
    t_date_vist    DATE DEFAULT sysdate,
    t_progress     VARCHAR2(20) DEFAULT '신청완료'
);

-- 수거 예약 기본키 설정 --
ALTER TABLE tkawy_tb ADD CONSTRAINT pk_tkawy_tb PRIMARY KEY ( t_bno,
                                                              m_num );

-- 외래키 설정 --
ALTER TABLE tkawy_tb
    ADD CONSTRAINT fk_mber_tb_to_tkawy_tb_1 FOREIGN KEY ( m_num )
        REFERENCES mber_tb ( m_num );
        

--------------------------------------------------------------------
DROP TABLE mber_tb;

DROP TABLE qna_tb;

DROP TABLE qna_category_tb;

DROP TABLE qna_reply_tb;

SELECT
    *
FROM
    qna_category_tb;

SELECT
    *
FROM
    qna_tb;

SELECT
    *
FROM
    qna_reply_tb;

SELECT
    *
FROM
    mber_tb;

INSERT INTO qna_tb (
    q_bno,
    q_sj,
    q_ncnm,
    q_content
) VALUES (
    seq_qna.NEXTVAL,
    '테스트 제목',
    'user00',
    '테스트 내용'
);

INSERT INTO qna_tb (
    q_bno,
    q_sj,
    q_ncnm,
    q_content
) VALUES (
    seq_qna.NEXTVAL,
    '테스트 제목',
    'user00',
    '테스트 내용'
);

SELECT
    *
FROM
    qna_tb;

INSERT INTO qna_reply_tb (
    qr_rno,
    qr_reply,
    qr_replyer
) VALUES (
    seq_qna_reply.NEXTVAL,
    '테스트 댓글 입니다.',
    '충성'
);

INSERT INTO qna_category_tb (
    qc_bno,
    qc_name
) VALUES (
    seq_qna_category.NEXTVAL,
    '수거'
);

-- 회원 더미데이터 --
insert into mber_tb (m_num, m_email, m_password, m_name, m_ncnm, m_contact, m_birth)
values ('M' || seq_mber.nextval, 'test@test.com', 'test', '테스트', '테스트닉네임', '010-0000-0000', '2021-02-09');

select * from mber_tb;

-- 수거예약 더미데이터--
insert into tkawy_tb (t_bno, m_num, t_contact, t_plastic, t_plastic_cap, t_vstng_cmpny, t_date_vist)
values ('T' || to_CHAR(sysdate,'YYYY-MM-DD') || '-' ||seq_tkawy.nextval, 'M100000', '010-0000-0000', 5, 5, '테스트상점', '2021-02-09');


insert into tkawy_tb (

DROP TABLE qna_tb;

DROP TABLE qna_category_tb;

DROP TABLE qna_reply_tb;

DROP TABLE mber_tb;

select * from qna_tb;

select * from qna_category_tb;

select * from qna_reply_tb;

select * from mber_tb;

select * from tkawy_tb;

commit;

--------------------------------------------------------------------------
 -- q_sj(제목) 컬럼명 변경
ALTER TABLE qna_tb RENAME COLUMN q_sj TO q_title;

-- 바꾼 컬럼 확인 하쇼
SELECT
    *
FROM
    qna_tb;

--------------------------------------------------------------------------
-- 02/10 더미 테이블 생성
-- 회원 더미데이터 --
INSERT INTO mber_tb (
    m_num,
    m_email,
    m_password,
    m_name,
    m_ncnm,
    m_contact,
    m_birth
) VALUES (
    'M' || seq_mber.NEXTVAL,
    'test@test.com',
    'test',
    '테스트',
    '테스트닉네임',
    '010-0000-0000',
    '2021-02-09'
);

-- 수거예약 더미데이터--
INSERT INTO tkawy_tb (
    t_bno,
    m_num,
    t_contact,
    t_plastic,
    t_plastic_cap,
    t_vstng_cmpny,
    t_date_vist
) VALUES (
    'T'
    || to_char(sysdate, 'YYYY-MM-DD')
    || '-'
    || seq_tkawy.NEXTVAL,
    'M100000',
    5,
    '010-0000-0000',
    5,
    5,
    '테스트상점',
    '2021-02-09'
);

COMMIT;

-- 게시판 테이블에 댓글 수 컬럼 추가
ALTER TABLE qna_tb ADD (
    q_replycnt NUMBER DEFAULT 0
);

-- 기존 댓글 수 반영
UPDATE qna_tb
SET
    q_replycnt = (
        SELECT
            COUNT(qr_rno)
        FROM
            qna_reply_tb
        WHERE
            qna_reply_tb.q_bno = qna_tb.q_bno
    );

SELECT
    *
FROM
    qna_tb;

-- 예약수거 테이블에 실제 수거일 컬럼 추가
ALTER TABLE tkawy_tb ADD (
    t_done_date VARCHAR(20) DEFAULT '0000-00-00'
);

ALTER TABLE tkawy_tb MODIFY
    t_done_date DATE DEFAULT '1111-11-11';

DELETE tkawy_tb;

SELECT
    *
FROM
    tkawy_tb;

DELETE tkawy_tb;

-- 게시판 첨부 파일 테이블
CREATE TABLE qna_attach_tb (
    qa_uuid         VARCHAR2(200) NOT NULL,
    qa_upload_path  VARCHAR2(200) NOT NULL,
    qa_file_name    VARCHAR2(200) NOT NULL,
    qa_file_type    CHAR(1) DEFAULT 'I',
    q_bno           NUMBER(10, 0)
);

-- 게시판 첨부 파일 테이블 기본키 설정
ALTER TABLE qna_attach_tb ADD CONSTRAINT pk_qna_attach PRIMARY KEY ( qa_uuid );

-- 게시판 첨부 파일 테이블 외래키 설정
ALTER TABLE qna_attach_tb
    ADD CONSTRAINT fk_qna_attach FOREIGN KEY ( q_bno )
        REFERENCES qna_tb ( q_bno );
        
        
        
--#####################################################
-- ---------------경매 테이블 생성-------------------------------

CREATE TABLE auc_tb (
    a_bno        VARCHAR2(20) NOT NULL,
    aa_bno       VARCHAR2(20) NOT NULL,
    a_versifier  NUMBER(10, 0) NOT NULL,
    a_crnt_prc   NUMBER(10, 0) NOT NULL,
    a_wnng_prc   NUMBER(10, 0) DEFAULT 0,
    a_state      VARCHAR2(30) DEFAULT '진행중',
    a_prgrs_prd  DATE DEFAULT sysdate
);

------------------------기본키설정              
ALTER TABLE auc_tb ADD CONSTRAINT pk_auc_tb PRIMARY KEY ( a_bno );

------------------------외래키설정
ALTER TABLE auc_tb
    ADD CONSTRAINT fk_auc_aply_tb_to_auc_tb_1 FOREIGN KEY ( aa_bno )
        REFERENCES auc_aply_tb ( aa_bno );

-- *************ㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠ외래키 보류ㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠ******************* --
ALTER TABLE auc_tb
    ADD CONSTRAINT fk_auc_aply_tb_to_auc_tb_2 FOREIGN KEY ( c_num )
        REFERENCES auc_aply_tb ( c_num );

-- *************ㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠ외래키 보류ㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠ******************* --

--#####################################################
-------------------경매 신청테이블 생성---------------------------------------
CREATE TABLE auc_aply_tb (
    aa_bno         VARCHAR2(20) NOT NULL,
    c_num          VARCHAR2(20) NOT NULL,
    aa_hope_prd    DATE DEFAULT sysdate,
    aa_item_nm     VARCHAR2(100) NOT NULL,
    aa_markt_prc   NUMBER(10, 0) NOT NULL,
    aa_weight      VARCHAR2(20) NOT NULL,
    aa_cntry_orgn  VARCHAR2(50) NOT NULL
);

---------------------- 기본키 설정
ALTER TABLE auc_aply_tb ADD CONSTRAINT pk_auc_aply_tb PRIMARY KEY ( aa_bno );



----------------------외래키 설정
ALTER TABLE auc_aply_tb
    ADD CONSTRAINT fk_auc_cmpny_aply_tb_1 FOREIGN KEY ( c_num )
        REFERENCES auc_cmpny_tb ( c_num );

--#####################################################
--------------------------경매 신청 첨부파일 테이블----------------------------

CREATE TABLE auc_attach_tb (
    aa_uuid         VARCHAR2(200) NOT NULL,
    aa_bno          VARCHAR2(20) NOT NULL,
    aa_upload_path  VARCHAR2(200) NOT NULL,
    aa_file_name    VARCHAR2(200) NOT NULL,
    aa_file_type    CHAR(1) DEFAULT 'I'
);

---------------------------기본키 설정
ALTER TABLE auc_attach_tb ADD CONSTRAINT pk_auc_attach_tb PRIMARY KEY ( aa_uuid );

--#####################################################
------------------------경매 업체 테이블 생성-----------------------------------
CREATE TABLE auc_cmpny_tb (
    c_num      VARCHAR2(20) NOT NULL,
    c_name     VARCHAR2(100) NOT NULL,
    c_email    VARCHAR2(100) NOT NULL,
    c_address  VARCHAR2(500) NOT NULL,
    c_contact  VARCHAR2(15) NOT NULL,
    c_sector   VARCHAR2(50) NOT NULL
);

-------------- 기본키 설정
ALTER TABLE auc_cmpny_tb ADD CONSTRAINT pk_auc_cmpny_tb PRIMARY KEY ( c_num );

----------------------------외래키 설정

ALTER TABLE auc_attach_tb
    ADD CONSTRAINT fk_auc_aplyc_attach_tb_1 FOREIGN KEY ( aa_bno )
        REFERENCES auc_aply_tb ( aa_bno );

--#####################################################
-----------------------------입찰테이블 생성----------------------------------------
CREATE TABLE bid_tb (
    m_num        VARCHAR2(20) NOT NULL,
    a_bno        VARCHAR2(20) NOT NULL,
    b_bid_price  NUMBER(10, 0) NOT NULL,
    b_bid_time   VARCHAR2(20) DEFAULT to_char(systimestamp, 'HH')
                                    || '시'
                                    || to_char(systimestamp, 'MI')
                                    || '분'
                                    || to_char(systimestamp, 'SS')
                                    || '초'
                                    || to_char(systimestamp, 'FF2'),
    b_bid_state  VARCHAR2(50) DEFAULT '입찰중'
);

----------------외래키 설정
ALTER TABLE bid_tb
    ADD CONSTRAINT fk_mber_tb_to_bid_tb_1 FOREIGN KEY ( m_num )
        REFERENCES mber_tb ( m_num );

ALTER TABLE bid_tb
    ADD CONSTRAINT fk_auc_tb_to_bid_tb_1 FOREIGN KEY ( a_bno )
        REFERENCES auc_tb ( a_bno );

--#####################################################
------------------------------배송테이블 생성---------------------------------------------

CREATE TABLE shpng_tb (
    m_num          VARCHAR2(20) NOT NULL,
    a_bno          VARCHAR2(20) NOT NULL,
    c_num          VARCHAR2(20) NOT NULL,
    s_shpng_addr   VARCHAR2(500) NOT NULL,
    s_shpng_cntct  VARCHAR2(15) NOT NULL,
    s_shpng_stts   VARCHAR2(50) DEFAULT '배송준비중'
);



---------------------외래키설정
ALTER TABLE shpng_tb
    ADD CONSTRAINT fk_mber_tb_to_shpng_tb_1 FOREIGN KEY ( m_num )
        REFERENCES mber_tb ( m_num );

ALTER TABLE shpng_tb
    ADD CONSTRAINT fk_auc_tb_to_shpng_tb_1 FOREIGN KEY ( a_bno )
        REFERENCES auc_tb ( a_bno );

ALTER TABLE shpng_tb
    ADD CONSTRAINT fk_auc_cmpny_tb_to_shpng_tb_1 FOREIGN KEY ( c_num )
        REFERENCES auc_cmpny_tb ( c_num );



--#####################경매업체 더미데이터 ####################--
INSERT INTO auc_cmpny_tb (
    c_num,
    c_name,
    c_email,
    c_address,
    c_contact,
    c_sector
) VALUES (
    'C000000',
    '테스트업체',
    '000000@test.com',
    '테스트주소',
    '010-0000-0000',
    '테스트업종'
);


--############################################
------------------------------경매신청번호 시퀀스
CREATE SEQUENCE seq_auc_aply INCREMENT BY 1 START WITH 100;

-- ############################################
-- ----------------------경매신청 테이블 더미데이터
INSERT INTO auc_aply_tb (
    aa_bno,
    c_num,
    aa_hope_prd,
    aa_item_nm,
    aa_markt_prc,
    aa_weight,
    aa_cntry_orgn
) VALUES (
    'AA'
    || to_char(sysdate, 'YYYY-MM-DD')
    || '-'
    || seq_auc_aply.NEXTVAL,
    'C000000',
    '2021-02-10',
    '레드향',
    10000,
    '2kg',
    '제주'
);

SELECT
    *
FROM
    auc_aply_tb;

SELECT
    to_char(systimestamp, 'HH')
    || '시'
    || to_char(systimestamp, 'MI')
    || '분'
    || to_char(systimestamp, 'SS')
    || '초'
    || to_char(systimestamp, 'FF2')
FROM
    dual;

-- #########################################
-- ----------------------경매 테이블 더미데이터
INSERT INTO auc_tb (
    a_bno,
    aa_bno,
    a_versifier,
    a_crnt_prc
) VALUES (
    'A' || to_char(sysdate, 'YYYY-MM-DD'),
    'AA2021-02-10-100',
    500,
    600
);

SELECT
    *
FROM
    auc_tb;

INSERT INTO bid_tb (
    m_num,
    a_bno,
    b_bid_price)
    values ('M100144', 'A2021-02-10', 600);
    
commit;

-- 댓글 인덱스 --
create index idx_reply on qna_reply_tb(q_bno desc, qr_rno asc);

-- qna_tb에 조회수 컬럼 추가 --
ALTER TABLE qna_tb ADD(q_hits NUMBER DEFAULT 0);
COMMIT;
    
    
 
    
--------------------------------------------------------------------------------
----------------------------------------------------2월 15일 월요일
ALTER TABLE mber_tb DROP COLUMN m_birth;

SELECT
    *
FROM
    mber_tb;

SELECT
    *
FROM
    tkawy_tb;

ALTER TABLE qna_tb ADD (
    q_hits NUMBER DEFAULT 0
);

COMMIT;

SELECT
    *
FROM
    qna_reply_tb;

TRUNCATE TABLE qna_reply_tb;

COMMIT;

SELECT
    *
FROM
    qna_tb;

SELECT
    *
FROM
    tkawy_tb;

DROP TABLE qna_category_tb;

ALTER TABLE qna_category_tb DROP PRIMARY KEY;

ALTER TABLE qna_tb DROP CONSTRAINT fk_qna_category_tb_to_qna_tb_2;

INSERT INTO qna_tb (
    q_bno,
    m_num,
    q_title,
    q_ncnm,
    q_content
) VALUES (
    seq_qna,
    nextval,
    'M' || seq_mber.NEXTVAL,
    '테스트 제목',
    '테스트 닉네임',
    '테스트 내용'
);

COMMIT;


alter table tkawy_tb drop column t_done_date;

commit;

select * from tkawy_tb;

select * from mber_tb;
    

    

--------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------2월 22일 수거업체 테이블
    
-- 컬럼명 변경(for 외래키 설정) --
alter table store_tb rename column s_name to t_vstng_cmpny;

-- 컬럼 타입 변경(for 외래키 설정)--
alter table store_tb modify t_vstng_cmpny  VARCHAR2(100);

-- 수거업체 진행상태 추가 --
alter table store_tb add s_progress varchar(20) default '수거진행';


-- 기본키 설정 --
ALTER TABLE store_tb ADD CONSTRAINT pk_store_tb PRIMARY KEY ( t_vstng_cmpny );


-- 제약조건 걸릴 테이블 데이터 삭제 --
delete tkawy_tb;


-- 외래키 설정 --
ALTER TABLE tkawy_tb
    ADD CONSTRAINT fk_store_tb_to_tkawy_tb FOREIGN KEY ( t_vstng_cmpny )
        REFERENCES store_tb ( t_vstng_cmpny );
        
        
-- 수거업체 데이터 다시 심기 --
insert into store_tb (t_vstng_cmpny, s_address, s_contact, s_biz_h)
values ('없는가게 쓸', '서울특별시 은평구 녹번동 산1-55', '070-4771-0039', '월-금 11:00-20:00 / 토 17:00-20:00');

insert into store_tb (t_vstng_cmpny, s_address, s_biz_h)
values ('라마홈', '서울특별시 종로구 창성동 149번지 1층 101호', '수-토 12:30-18:30');

insert into store_tb (t_vstng_cmpny, s_address, s_biz_h)
values ('동선 나눔점방', '서울특별시 성북구 동선동3가 130-7', '화-일 12:00-18:00');

insert into store_tb (t_vstng_cmpny, s_address, s_contact, s_biz_h)
values ('레디투웰니스', '서울특별시 중구 회현동 퇴계로2길 9-8', '070-4771-0039', '월-금 11:00-20:00 / 토 17:00-20:00');

insert into store_tb (t_vstng_cmpny, s_address, s_biz_h)
values ('라운드트라이앵글(디자인스튜디오)', '서울특별시 용산구 후암동 두텁바위로1길 93-6', '월-금 10:00-18:00');

insert into store_tb (t_vstng_cmpny, s_address, s_biz_h)
values ('보틀팩토리', '서울특별시 서대문구 연희동 708번지 1층', '화-일 11:00-22:00');

insert into store_tb (t_vstng_cmpny, s_address, s_contact, s_biz_h)
values ('dear.earth', '서울특별시 서대문구 수색로 43 104호 가좌청년상가 104호', '070-4485-3388', '화-토 11:30-20:00');

insert into store_tb (t_vstng_cmpny, s_address, s_contact, s_biz_h)
values ('알맹상점(리필스테이션)', '서울특별시 마포구 합정동 월드컵로 49 한우마을 2층', '010-2229-1027', '월-금 11:00-20:00 / 토 17:00-20:00');

insert into store_tb (t_vstng_cmpny, s_address, s_contact, s_biz_h)
values ('비그린(스페이스 살림)', '서울특별시 동작구 대방동 노량진로 10 ', '02-810-5088', '목금토 13:00-19:00');

insert into store_tb (t_vstng_cmpny, s_address, s_biz_h)
values ('waste upso', '서울특별시 서초구 방배4동 방배로 189 ', '금,토 13:00-18:00');

insert into store_tb (t_vstng_cmpny, s_address, s_contact, s_biz_h)
values ('제로웨이스트샵 지구', '서울특별시 동작구 상도동 성대로1길 16', '070-7640-4940', '화-토 13:00-20:00');

insert into store_tb (t_vstng_cmpny, s_address, s_contact, s_biz_h)
values ('덕분애 제로웨이스트샵', '서울특별시 서초구 서초4동 서초대로 389', '02-6959-4479', '월-금 11:00-19:00 / 토 11:00-16:00');

insert into store_tb (t_vstng_cmpny, s_address, s_biz_h)
values ('허그어웨일', '서울특별시 강서구 화곡동 화곡로55길 23', '월-금 11:00-19:00 / 토 12:00-17:00');

insert into store_tb (t_vstng_cmpny, s_address, s_biz_h)
values ('더초록(시민단체)', '서울특별시 구로구 오류동 고척로16길 72', '월-금 10:00-18:00');

insert into store_tb (t_vstng_cmpny, s_address, s_contact, s_biz_h)
values ('더피커', '서울특별시 성동구 성수동1가 왕십리로 115 헤이그라운드 9층', '070-4118-0710', '화-금 12:00-19:00 / 토 12:00-18:00');

insert into store_tb (t_vstng_cmpny, s_address, s_biz_h)
values ('디어에코', '서울특별시 광진구 구의3동 아차산로65길 22', '화-금 11:00-20:00 / 토 13:00-20:00');

insert into store_tb (t_vstng_cmpny, s_address, s_contact, s_biz_h)
values ('대안생활 공기', '서울특별시 강동구 암사동 상암로3길 24 104호', '010-9948-0716', '월-금 09:30-18:00');

insert into store_tb (t_vstng_cmpny, s_address, s_contact, s_biz_h)
values ('송포어스(song for earth)', '서울특별시 강동구 성내동 288-4', '070-8095-3534', '월-금 15:00-20:00 / 토 11:00-19:00');

insert into store_tb (t_vstng_cmpny, s_address, s_contact, s_biz_h)
values ('지구수호대 리필상점', '인천광역시 연희동 연희동 796-12번지 5층 504 505호', '010-9227-5911', '월-금 10:00-16:00');

insert into store_tb (t_vstng_cmpny, s_address, s_biz_h)
values ('소중한모든것', '인천 남동구 인하로 617 플러스타워 108호', '월-금 11:00-20:00 / 토 13:00-18:00');

insert into store_tb (t_vstng_cmpny, s_address, s_contact, s_biz_h)
values ('꿈꾸는부엉이(녹색대안공간)', '경기도 안양시 동안구 비산동 377-1 1층', '070-8113-5311', '월-금 10:00-18:00');

insert into store_tb (t_vstng_cmpny, s_address, s_biz_h)
values ('솝리필스테이션', '경기 성남시 수정구 위례광장로 21 105호', '화-토 11:00-20:00 / 일 11:00-18:00');

insert into store_tb (t_vstng_cmpny, s_address, s_contact, s_biz_h)
values ('동그라미 리필러리', '경기도 성남시 분당구 운중동 판교로33번길 9 1층', '0507-1346-3447', '월-금 12:30-18:00 / 토 11:00-17:00');

insert into store_tb (t_vstng_cmpny, s_address, s_contact, s_biz_h)
values ('가치상점', '경기도 수원시 권선구 세류3동 세권로 140 B01', '010-9144-8781', '일-금 13:00-20:00');

insert into store_tb (t_vstng_cmpny, s_address, s_biz_h)
values ('지구에티켓', '경기도 오산시 세마역로 19번길 52  52 인도방향 101', '화-금 10:00-19:00 / 토 10:00-17:00 / 일 10:00-14:00');

insert into store_tb (t_vstng_cmpny, s_address, s_biz_h)
values ('동네마당', '충청북도 청주시 흥덕구 비하동 비하로57번길 38-8 ', '월-토 11:00-19:00');

insert into store_tb (t_vstng_cmpny, s_address, s_contact, s_biz_h)
values ('은영상점', '대전광역시 유성구 온천2동 대학로159번길 2 ', '0507-1321-9475', '화-토 13:00-20:00');


select * from store_tb;

commit;
