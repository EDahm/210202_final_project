--신청테이블에 신청상태 컬럼 추가
ALTER TABLE auc_aply_tb ADD(AA_A_STATE VARCHAR2(30) DEFAULT '신청완료');

--배송정보 입력시 진행중인 경매상태가 경매종료로 변경되는 트리거 작성
CREATE OR REPLACE TRIGGER trg_change_state
BEFORE
INSERT ON SHPNG_TB
BEGIN
    UPDATE AUC_TB SET A_STATE = '경매종료'
    WHERE A_STATE = '진행중';
END;
/

--경매 진행을 '준비중'으로 등록 시, 신청상태가 같이 '준비중'으로 바뀌는 트리거 작성
CREATE OR REPLACE TRIGGER trg_change_state_apply1
AFTER
INSERT ON AUC_TB
BEGIN
    UPDATE AUC_APLY_TB SET AA_A_STATE = '준비중'
    WHERE AA_BNO = (SELECT AA_BNO FROM AUC_TB WHERE A_STATE = '준비중');
END;
/

--210302

--업체테이블 c_email = m_email로 변경

alter table auc_cmpny_tb rename column c_email to m_email;

alter table auc_cmpny_tb modify m_email varchar2(100);


--업체테이블 m_email 외래키 생성

ALTER TABLE auc_cmpny_tb
    ADD CONSTRAINT fk_mber_tb_to_auc_cmpny_tb_1 FOREIGN KEY ( m_email )
        REFERENCES mber_tb ( m_email );
