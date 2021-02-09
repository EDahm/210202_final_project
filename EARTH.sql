-----------------------------------------------------------2월 9일 화요일

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
