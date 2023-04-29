# 내사남사
## 1팀 1차 프로젝트

- ### 내사남사 핵심 기능
1. 간편하게 결제할 수 있는 카카오페이<br/>
https://github.com/taek-s/NaeSaNamSa/blob/main/NS/src/main/java/ns/kakaopay/controller/KakaoPayController.java
2. 판매자와 구매자 사이에 원활한 소통을 위한 메시지<br/>
https://github.com/taek-s/NaeSaNamSa/blob/main/NS/src/main/java/ns/message/controller/MessageController.java
3. 회원가입 시 이메일 중복확인과 동시에 이메일 인증을 받음<br/>
https://github.com/taek-s/NaeSaNamSa/blob/main/NS/src/main/java/ns/common/common/MailHandler.java<br/>
https://github.com/taek-s/NaeSaNamSa/blob/main/NS/src/main/java/ns/member/service/MailServiceImpl.java
4. 상품 등록, 수정 시 다중 이미지 업로드와 업로드 전 썸네일 확인, 쉽고 편한 이미지 수정<br/>
https://github.com/taek-s/NaeSaNamSa/blob/main/NS/src/main/java/ns/shop/controller/ShopController.java<br/>
https://github.com/taek-s/NaeSaNamSa/blob/main/NS/src/main/java/ns/shop/service/ShopServiceImpl.java
5. 판매자 상세보기 내에서 이루어지는 추천과 후기 작성<br/>
https://github.com/taek-s/NaeSaNamSa/blob/main/NS/src/main/java/ns/seller/controller/SellerController.java

- #### 개발 목표
내사남사는 중고거래 사이트입니다.
판매자의 경우 쉽고 간편하게 상품을 등록하여 판매할 수 있고,
구매자의 경우 빠르고 편리하게 상품을 주문할 수 있도록 기획했습니다.

기본적으로 상품에 대한 CRUD와 상품 주문이 주기능을 이루고 있고 중고거래 사이트의 특징에
맞게 추가적인 기능을 갖추고 있습니다.

추가적인 기능은 두 가지로 분류할 수 있는데 사용자의 편의성을 고려한 기능과 중고거래 사이트가
가지고 있는 문제점을 보완하는 기능으로 분류할 수 있습니다.

 - #### 사용자의 편의성을 고려한 기능
 1. 연동 로그인 - 사용자는 사이트 내에서 회원가입을 한 후 서비스를 이용할 수도 있지만 네이버나 카카오 계정을 통해서도 이용 가능하다.<br/>
 https://github.com/taek-s/NaeSaNamSa/blob/main/NS/src/main/java/ns/member/controller/KakaoController.java<br/>
 https://github.com/taek-s/NaeSaNamSa/blob/main/NS/src/main/java/ns/member/controller/NaverController.java<br/>
 2. 찜하기, 최근 본 상품 - 사용자는 상품을 당장 구매하지 않더라도 관심 있는 상품을 찜하여 목록으로 확인할 수 있고, 최근에 본 상품 목록을 확인할 수 있다<br/>
 https://github.com/taek-s/NaeSaNamSa/blob/main/NS/src/main/java/ns/shop/controller/ShopController.java<br/>
 3. 상품 이미지 - 판매자가 상품을 등록하거나 수정할 때 등록할 이미지를 미리 썸네일로 확인할 수 있고 추가와 수정도 용이하다.<br/>
 https://github.com/taek-s/NaeSaNamSa/blob/main/NS/src/main/webapp/WEB-INF/views/shop/goodsWriteForm.jsp<br/>
 https://github.com/taek-s/NaeSaNamSa/blob/main/NS/src/main/java/ns/shop/controller/ShopController.java<br/>
 https://github.com/taek-s/NaeSaNamSa/blob/main/NS/src/main/java/ns/shop/service/ShopServiceImpl.java
 4. 카카오페이 - 결제 수단을 카카오페이로 선택하여 구매자가 빠르고 간편하게 결제할 수 있도록 한다.<br/>
 https://github.com/taek-s/NaeSaNamSa/blob/main/NS/src/main/java/ns/kakaopay/controller/KakaoPayController.java<br/>

 - #### 문제점을 보완하는 기능
 중고거래 사이트가 가지는 문제점 : 쉽고 간편하게 누구나 이용할 수 있는 중고거래 사이트의 단점은 구매자가 판매자를 신용할 수 있는 근거가
 부족하다는 것이다. 관리자가 직접 상품을 판매하는 것이 아닌 사용자가 사용자에게 판매하는 구조이기 때문에 구매자가 상품을 구매할 때 판매자에
 대한 신뢰도를 높일 수 있는 수단이 필요하다
 1. 화원가입 시 이메일 인증 - 사용자가 회원가입을 할 때 실제 사용할 수 있는 이메일을 인증받아 가입자 본인 여부를 확인하여 신뢰도를 높인다.<br/>
 https://github.com/taek-s/NaeSaNamSa/blob/main/NS/src/main/java/ns/common/common/MailHandler.java<br/>
 https://github.com/taek-s/NaeSaNamSa/blob/main/NS/src/main/java/ns/member/service/MailServiceImpl.java<br/>
 2. 메시지 - 판매자와 구매자가 채팅 기능을 통해 메시지를 주고 받아 즉각적인 소통을 할 수 있다.<br/>
 https://github.com/taek-s/NaeSaNamSa/blob/main/NS/src/main/java/ns/message/controller/MessageController.java<br/>
 3. 신고 - 판매자가 등록한 상품에 문제가 있거나 판매자가 의심스러운 경우 신고를 통해 관리자가 조치를 취할 수 있도록 할 수 있다.<br/>
 https://github.com/taek-s/NaeSaNamSa/blob/main/NS/src/main/java/ns/report/controller/ReportController.java<br/>
 4. 판매자에 대한 추천과 후기 - 구매자가 만족한 경우 판매자를 추천할 수 있고 후기를 남길 수 있다. 다른 구매자는 해당 판매자에 대한 추천수와
 후기를 통해 판매자에 대한 신뢰도를 높일 수 있다.<br/>
 https://github.com/taek-s/NaeSaNamSa/blob/main/NS/src/main/java/ns/seller/controller/SellerController.java<br/>
