--신청테이블에 신청상태 컬럼 추가
ALTER TABLE auc_aply_tb ADD(AA_A_STATE VARCHAR2(30) DEFAULT '신청완료');