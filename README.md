## 🍃 Zandi Time - 실시간 학습 몰입 앱 서비스
###### #PM #iOS #UMC

### 👥 Co-Work

1. 서버와 협업하기 
    - REST API를 이용하여 GET / POST 메소드를 이용한 서버에 연동(with Alamofire, URLSession, Postman)
2. 디자이너와 협업하기
    - Figma Tool을 이용하여 Asset을 주고 받으며 UI구성
3. Git으로 협업하기
    - GitHub Organization을 만들어 Branch, Fork, PR을 통해 Xcode Project를 팀원과 공유
4. 소통하기
    - 전체 공지 : Kakao Talk
    - 문서 공유 : Notion
    - 온라인 미팅 : Zoom
   
---

### 📆 Plan
- 22.05.25 ~ 22.06.14 디자이너 모집기간 
- 22.06.15 ~ 22.06.22 디자이너 & 기획자 미팅 및 아이디어 Develop
- 22.06.23 ~ 22.06.28 팀원 매칭
- 22.07.01 ~ 22.07.02 해커톤
- 22.07.03 ~ 22.08.15 팀별 몰입 개발기간
- 22.08.25 UMC 2기 데모데이 (공덕역 프론트원)

---

### 🗣 MOM

<img width="1023" alt="스크린샷 2022-08-16 21 37 30" src="https://user-images.githubusercontent.com/74387813/184881299-13bb0c72-bb63-446f-9d33-eede1ce8c275.png">

---

### 📱 Final Result

https://www.youtube.com/watch?v=EAQBYl3l6Tc&t=8s

---

### 📸 Screen Shot

<p align="left">
<img src="https://user-images.githubusercontent.com/74387813/184878597-890cada7-4d7e-414e-8428-c9f0f90c71ea.png"  width="273" height="591"/>
<img src="https://user-images.githubusercontent.com/74387813/184879029-28578aaf-4856-4a6f-8133-80bc4d40dd9d.png"  width="273" height="591"/>
<img src="https://user-images.githubusercontent.com/74387813/184879132-ee2e1911-1bff-40a4-aa90-7645dd546638.png"  width="273" height="591"/>
</p>    
<p align="left">
<img src="https://user-images.githubusercontent.com/74387813/184879196-2471e86b-e9ee-46d5-83c4-061326d0cf8f.png"  width="273" height="591"/>
<img src="https://user-images.githubusercontent.com/74387813/184879443-052371e2-ff97-4ac3-90e7-c1b4cf66bfe5.png"  width="273" height="591"/>
<img src="https://user-images.githubusercontent.com/74387813/184879528-344fafbf-250d-4f49-aea3-72d213da88b6.png"  width="273" height="591"/>
</p>    
<p align="left">
<img src="https://user-images.githubusercontent.com/74387813/184875782-bde9e273-a93b-4b9f-b4fe-4b1b42effa90.png"  width="273" height="591"/>
</p>

---

### 🤖 Main Function

---

### 🧠 Gotten & Used Stack (중복제외)

#### Login View Controller

1. Google Social Login (OAuth)
2. App Switcher Mode (Scene Delegate)
3. Logo Icon

#### Timer Tab

1. Tabbar Controller 
2. DateFormatter
3. Timer 
4. TableView (XIB)
5. UseDefaults

#### Follwer Tab

1. AlertController
2. MVC Pattern
3. Data Pass (A->B)
4. FSCalander (Calander Library)
5. escaping closure

#### Market Tab

1. Collection View
2. Horrizental Scroll View

#### Profile Tab

1. Delegate Pattern
2. Compact Map

---

### 🙇‍♂️ Team Membet
##### iOS 
- 송 / 이주송 (PM)
- 온브 / 진윤겸
##### Server
- 창창 / 이창훈 (Server Leader)
- 메룰라 / 김상현
- 방랑자 / 김대건
- 서아 / 권슬희
##### Web 
- 잼민 / 신재민(Web Leader)
- 가온 / 유민서
##### App Design
- 포히 / 사희수
##### Web Design
- 나니 / 김나현

---

### Used NetWork Method (POST : URLSession , GET : Alamofire)

##### Login View Controller

- 3.1 유저 로그인 /oauth/google (POST)

##### Timer Tab

- 2.1 오늘 공부기록 저장 /saveRecords/today (POST)

##### Follwer Tab

- 4.1 친구추가 /addFriend/\(follweeName) (GET)
- 4.3 친구 수 추가 /addNumberOfFollowers (POST)
- 4.4 친구 수 조회 /getNumberOfFollowers (GET)

##### Market Tab

##### Profile Tab

- 1.1 유저 정보 조회 /showMember (GET)
- 2.2 월별 공부내역 조회 /records/monthly?month=08 (GET)

---

### 🧑‍💻 Ref. link

- Idea Info. https://cake-tarn-9a3.notion.site/d053e9512d7c415898fd41261b315f8f
- UMC https://makeus-challenge.notion.site/Univ-MakeUs-Challenge-2nd-Board-fba760aa7ed94edc93ebb42722307945

