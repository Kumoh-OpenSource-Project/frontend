# 천체관측 서비스 StarHub Frontend

![IMG_2526 iphonex (1)](https://github.com/Kumoh-OpenSource-Project/backend/assets/98962864/552ea124-18da-49e7-87c8-7977d680f121)


<br>

## ☝프로젝트 소개

- 천체 관측에 필요한 기초적인 정보들을 제공합니다.
- 커뮤니티 기능을 제공하여 필요한 배경지식을 채울 수 있습니다.
- 검색을 통해 천체관측에 대한 의사소통을 꾀합니다.
- 마음에 드는 게시글에 좋아요, 스크랩을 누르거나 댓글을 작성할 수 있습니다.
- 본 레포지토리는 프론트엔드를 소개합니다.
  
<br>

## 👨🏻‍💻Frontend 팀원 구성

<div align="center">

| **강윤지** | **김민지** |
| :------: |  :------: |
| [<img src="https://avatars.githubusercontent.com/u/135759058?s=64&v=4" height=150 width=150> <br/> @yunyunenara](https://github.com/yunyunenara)| [<img src="https://avatars.githubusercontent.com/u/78207698?s=64&v=4" height=150 width=150> <br/> @mackerel0818](https://github.com/mackerel0818)
</div>

<br>

## 🔨개발 환경

  + Flutter (3.13.9)
  + IDE : Android Studio
  + Jira, Notion, Slack
<br>

## ⚙️채택한 개발 기술과 브랜치 전략

### Flutter
  - dart 언어 기반의 모바일 앱 제작 프레임워크로 이를 통해 안드로이드 앱과 iOS 앱을 동시에 구현함으로써 효율성을 극대화하였습니다.
    
### 브랜치 전략

- Git-flow 전략을 기반으로 main, develop 브랜치와 feature 보조 브랜치로 간소화 하여 사용했습니다.
- main, develop, Feat 브랜치로 나누어 개발을 하였습니다.
    - **Main** 브랜치는 최종 배포 단계에서만 사용하는 브랜치입니다. dev 브랜치에서 병합 시 github action으로 ci/cd 가 이루어집니다.
    - **Dev** 브랜치는 개발 단계의 Feature 브랜치들의 집합 브랜치입니다.
    - **Feat** 브랜치는 기능 단위로 독립적인 개발 환경을 위하여 사용하였습니다. Feature 브랜치명은 Jira Service의 각 ticket에 부여되는 고유 id로 작성하였습니다.

<br>

## 📄 기능 구현 사항


### 초기화면
  - Splash 화면이 잠시 나타난 뒤 다음 페이지로 넘어간다.
    * 로그인이 되어 있는 경우 : Star Hub의 Home 화면
    * 로그인이 되어 있지 않은 경우 : 카카오톡 로그인 페이지

<p align="center">
<img src="https://github.com/Kumoh-OpenSource-Project/frontend/assets/135759058/2b64fdbf-d4f5-4cc6-a19b-e293ce927d02">
</p>

### 로그인
  - 카카오 로그인을 제공한다.
    * 카카오톡이 설치되어 있는 경우 : 카카오톡으로 로그인
    * 카카오톡이 설치되어 있지 않은 경우 : 카카오 계정으로 로그인

<p align="center">
<img src="https://github.com/Kumoh-OpenSource-Project/frontend/assets/135759058/ec936996-2352-4935-90a6-9817028755c3">
</p>

### 홈 화면
  - 사용자가 접속한 날짜의 날씨, 실시간 날씨, 월령, 천체와 관련된 가장 가까운 이벤트의 디데이를 제공한다.
  - 접속한 날짜로부터 5일간의 날씨 데이터를 제공한다.
  - 오른쪽 상단의 달력 아이콘을 통해 월령과 해당 날짜를 보여주는 월력을 제공한다.

<p align="center">
<img src="https://github.com/Kumoh-OpenSource-Project/frontend/assets/135759058/124e27e0-a798-417a-b724-2b0534af48f2">
</p>

### 커뮤니티 화면
#### 게시물 조회
  - 사진 자랑, 관측 도구, 관측 장소 게시판을 제공한다.
    * 무한 스크롤 방식
    * 사진 자랑 게시판 : 이미지 피드 형식
    * 관측 도구 게시판 : 리스트 형식
    * 관측 장소 게시판 : 리스트 형식, 단 사용자의 등급에 따라 접근 제한이 있다. 첫 등급인 '수성'에서 두 번째 등급인 '금성'으로 등업하지 않은 사용자는 접근이 불가능하며, 이를 시도할 경우 "금성 레벨 이상이어야 관측장소를 열람할 수 있습니다."라는 내용의 스낵바가 상단에 1초간 나타난다.
    * 각 게시판 최상단에 주간 인기 게시물 제공

#### 게시물 작성
  - 커뮤니티 화면의 플로팅 액션 버튼을 통해 글쓰기 화면을 제공한다.
  - 사용자는 카테고리를 선택하고, 제목과 내용을 작성할 수 있으며, 사진을 첨부할 수 있다.
    * 사진 자랑 카테고리에서는 사진이 필수 요소로 하나 이상 첨부해야만 한다.
    * 모든 카테고리에서 제목과 내용은 반드시 포함되어야 글쓰기 버튼이 활성화된다.

<p align="center">
<img src="https://github.com/Kumoh-OpenSource-Project/frontend/assets/135759058/d1fa92c5-a30d-4521-a531-6fcaf97f320a">
</p>

#### 게시물 검색
  - 검색 아이콘을 통해 검색 화면을 제공한다.
  - 사용자는 두 글자 이상의 키워드를 띄어쓰기 없이 입력해 검색어에 해당하는 게시글들을 확인할 수 있다.

<p align="center">
<img src="https://github.com/Kumoh-OpenSource-Project/frontend/assets/135759058/d54e3ab7-cb5d-46df-bd21-4bdc85ccb666">
</p>

#### 게시물 상세 조회
  - 각 게시물마다 상세 페이지를 제공한다.
  - 사용자는 해당되는 카테고리명, 제목, 내용, 작성자, 작성자의 등급, 작성 날짜, 댓글 전체를 확인할 수 있다.
  - 사용자가 직접 작성한 게시글이라면 수정이나 삭제가 가능하다.
  - 사용자는 버튼을 통해 좋아요나 스크랩을 남길 수 있다.
  - 사용자는 댓글을 작성할 수 있으며, 직접 남긴 댓글은 삭제가 가능하다.
  - 사용자가 직접 남긴 게시글이나 댓글이 아니라면 신고가 가능하다.

<p align="center">
<img src="https://github.com/Kumoh-OpenSource-Project/frontend/assets/135759058/063f9925-6334-4b5b-8699-dfebbe34d228">
<img src="https://github.com/Kumoh-OpenSource-Project/frontend/assets/135759058/ffe03aa3-56f1-40c5-b304-a8e2f399f62c">
</p>

### 마이페이지 화면
  - 사용자 개인의 프로필과 레벨을 제공한다.
  - 사용자는 닉네임 혹은 프로필 사진을 변경할 수 있다.
  - 사용자는 커뮤니티에서 활동했던 기록을 확인할 수 있다.
    * 내가 쓴 글, 좋아요한 글, 스크랩한 글이 포함된다.
  - 로그아웃이 가능하며, 버튼을 누르면 초기화면으로 되돌아간다.

<p align="center">
<img src="https://github.com/Kumoh-OpenSource-Project/frontend/assets/135759058/f189159b-772e-46ba-b6a3-7270dd5cb64f">
</p>

<br>

## 🤝역할 분담

### 🐱강윤지
- **기능**
    - 로그인 화면 구현
    - 무한 스크롤 구현
    - 게시물 목록 및 검색 화면 구현
    - 작성 글, 좋아요, 스크랩 화면 구현
    - 로딩 화면 구현
    - 레벨 업 화면 구현

<br>
    
### 🐢김민지
- **기능**
    - Splash 화면 및 홈 화면 구현
    - S3로 이미지 통신
    - 주간 인기 게시글 구현
    - 마이페이지 구현
    - 게시글 작성 화면 구현
    - 게시글 수정 화면 구현
    
<br>

## 📆개발 기간 및 작업 관리

### 개발 기간

- 총 9차 스프린트 진행 완료

<br>

![image](https://github.com/Kumoh-OpenSource-Project/backend/assets/98962864/1f2c7984-e92a-4845-a340-3feeb71e6a55)


## 📹︎시연 영상

[![Video Label](http://img.youtube.com/vi/gHagJYh-x2Q/0.jpg)](https://youtu.be/gHagJYh-x2Q)
