## 사용자들의 정보
create database if not exists chemi;

CREATE TABLE chemi.user_info (

	## 기본 정보
	user_id varchar(45) NOT NULL,
    mail varchar(45) NOT NULL,
    gender tinyint(4) NOT NULL,
    age_range varchar(4),
    _local int NOT NULL,
    age int NOT NULL,
    chemi_type_qa varchar(9) NOT NULL,
    chemi_type int NOT NULL,
    cluster_type int,
    nickname varchar(20) NOT NULL,
    
    ## 나이 제한 설정
    want_age_min int,
    want_age_max int,
    
    ## profile_image 1,2 path와 그에 대한 심사 flag 
    profile_image1 boolean NOT NULL,
    profile_image2 boolean NOT NULL,
    pass_flag bool DEFAULT FALSE, 
    
    ## 추가 image path
    profile_image3 boolean DEFAULT FALSE,
    profile_image4 boolean DEFAULT FALSE,
    profile_image5 boolean DEFAULT FALSE,
    profile_image6 boolean DEFAULT FALSE,
    
    ## 추가 image 심사 flag
    image3_flag boolean DEFAULT FALSE,
    image4_flag boolean DEFAULT FALSE,
    image5_flag boolean DEFAULT FALSE,
    image6_flag boolean DEFAULT FALSE,
    
    assign_datetime timestamp,
    latest_login_datetime timestamp,
    assign_type int,
    spark int ## 화폐
);

## 데일리 질문, 유저 녹음 정보
create database if not exists user_record;

CREATE TABLE user_record.daily_questions (
	question_id int primary key auto_increment,
    question_title varchar(45),
    upload_date timestamp
);

CREATE TABLE user_record.user_record (
	question_id int,
    user_id varchar(45),
    upload_time timestamp,
    sentiment tinyint,
    topic text,
    labeling_data1 int,
    labeling_data2 int,
    labeling_data3 int,
    like_count int DEFAULT 0
);

create database if not exists chemi_recommend;

create database if not exists user_who_i_like;

create database if not exists user_who_likes_me;

create database if not exists matched_users;

## 상품에 대한 정보, 구매 내역
create database if not exists spark;

## 사용자들의 스파크 사용 내역
CREATE TABLE spark.spark_log (
	user_id varchar(45) NOT NULL,
    spark_variance int NOT NULL,
    variance_type int NOT NULL,
    variance_time timestamp
);

## 상품에 대한 정보
CREATE TABLE spark.goods (
	goods_id int NOT NULL,
    cost int NOT NULL,
    num_sparks int NOT NULL
);

## 공지사항
create database if not exists notice;

CREATE TABLE notice.notice (
	notice_id int primary key auto_increment,
    notice_subject text,
    notice_content text,
    upload_time timestamp
);

## 문의하기 및 신고하기
create database if not exists ask;

CREATE TABLE ask.ask (
	ask_id int primary key auto_increment,
    writer_id varchar(45),
	ask_type int,
    ask_content text,
    upload_time timestamp,
    reply_state tinyint,
    reply text
);

CREATE TABLE ask.report (
	report_id int primary key auto_increment,
    writer_id varchar(45),
    report_type int,
    report_content text DEFAULT NULL,
    upload_time timestamp,
    reply_state tinyint,
    reply text
);
