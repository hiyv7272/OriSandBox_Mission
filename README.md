# OriSandBox_Mission
- OriSandBox Mission `COSGRAM` Project
- `COSGRAM` is a service that provides customized insights to users through Web crawling data.

## Technologies
- Endpoint APIs are written in Python(v3.8.3)
- Django web Flask(v1.1.2)
- Bcrypt encoding password, Access Token With JWT
- Build Relationship Data Modeling and Schema With MySQL(v5.7)

## Features
**User App**
- SignUp (사용자 회원 가입)
- SignIn (사용자 로그인)

**Module App**
- UserProfile (사용자 프로필 확인)
- ModuleList (사용자 모듈 리스트 확인, 가입, 해제)
- ProductList (상품 리스트, 상품 피드백 리스트 확인)


## Data Modeling
<a target="_blank" rel="noopener noreferrer" href="https://github.com/hiyv7272/OriSandBox_Mission/blob/master/COSGRAM_ERD.png"><img src="https://github.com/hiyv7272/OriSandBox_Mission/blob/master/COSGRAM_ERD.png" alt="COSGRAM_ERD" style="max-width:100%;"></a>
[COSGRAM_ERD With draw.io](https://drive.google.com/file/d/1XLNgl9bPlhfTMxWZ2uMKF6ZhPYH-lOSC/view?usp=sharing)


## API Document
[API Document with POSTMAN](https://documenter.getpostman.com/view/9816681/TVK77M4h)


## How To Use
1. [bash] git init
2. [bash] git pull https://github.com/hiyv7272/OriSandBox_Mission.git
3. [MySQL] create database COSGRAM
  - Refer to schema/COSGRAM_schema_total_v.1.0.0.sql
4. [MySQL] Run Script sql file
  - Refer to schema/COSGRAM_schema_total_v.1.0.0.sql
5. [bash] python manage.py runserver


## Contact Me
Please share your thoughts on this project.<br>
E-mail : hiyv7272@gmail.com
