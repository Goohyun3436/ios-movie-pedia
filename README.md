[![iOS 16.0+](https://img.shields.io/badge/iOS-16.0+-EAEAEA.svg?style=flat)](https://swift.org/download/) [![Swift 5.10](https://img.shields.io/badge/swift-5.10-F05138.svg?style=flat)](https://swift.org/download/) [![Xcode 16.2](https://img.shields.io/badge/Xcode-16.2-147EFB.svg?style=flat&color=blue)](https://swift.org/download/)

# 🎬 iOS-Movie-Pedia

요즘 인기 있는 영화를 실시간으로 둘러볼 수 있습니다.

궁금한 영화의 줄거리, 등장인물, 포스터 사진들을 검색해 볼 수 있습니다.

또한 사용자가 어떤 영화를 검색했는지, 좋아하는지 여부를 기록해둘 수 있습니다.


&nbsp;


## ✓ 개발 인원 및 기간

* **기간**: 2025.01.24 ~ 2025.02.01 [9일]

* **인원**: [Goo](https://github.com/Goohyun3436) [1명]

&nbsp;

## ✓ 앱 주요 기능

> 🌑 다크모드를 지원합니다.

<img src="https://github.com/user-attachments/assets/7f4c41d5-7f44-475d-b700-17712574391d" width="30%">

#

> 🎬 오늘의 인기 영화를 실시간으로 둘러볼 수 있습니다.

<img src="https://github.com/user-attachments/assets/2bf4b295-0fc8-45c1-a74e-cdae1ff1fb19" width="30%">

#

> 🔎 궁금한 영화를 검색해 볼 수 있습니다.
> 
> 검색 결과가 없는 경우 표시하지 않습니다.

<img src="https://github.com/user-attachments/assets/d09943a9-c366-4e17-b60c-0ba697d873e8" width="30%">

#

> 🔎 영화의 줄거리, 등장인물, 포스터 사진들을 검색해 볼 수 있습니다.
>
> 정보가 등록되지 않은 영화의 경우 정보를 표시하지 않습니다.

<img src="https://github.com/user-attachments/assets/98dfbfd0-5ea3-4222-aa9a-bde581140d37" width="30%">
<img src="https://github.com/user-attachments/assets/b3d8068a-4b0f-409e-a68f-60c5fae7bd09" width="30%">

#

> 📝 사용자가 어떤 영화를 검색했는지 기록해둘 수 있습니다.

<img src="https://github.com/user-attachments/assets/20275896-b007-4242-9fef-9bc4c94b29cf" width="30%">

&nbsp;

#

> ♥️ 사용자가 어떤 영화를 좋아하는지 기록해둘 수 있습니다.

<img src="https://github.com/user-attachments/assets/72ebc9e1-a437-46ea-9162-8f5d854169d1" width="30%">

&nbsp;

> 👦🏻 사용자의 프로필 이미지와 이름을 등록/수정할 수 있으며, 서비스 가입 일시를 기록해둡니다.

<img src="https://github.com/user-attachments/assets/aa0391f2-8072-4fda-9b7c-f67ce795758b" width="30%">
<img src="https://github.com/user-attachments/assets/e494c823-3791-4901-92f9-4d5122e7f821" width="30%">

&nbsp;

> 🏃🏻 사용자가 탈퇴하여 데이터를 모두 초기화할 수 있습니다.

<img src="https://github.com/user-attachments/assets/7e3332a0-44fd-4703-8f24-2d2e40cb5ff8" width="30%">

&nbsp;

## ✓ 앱 기술 스택

> Alamofire (v5.10.2)

* TMDB API 네트워크 통신을 구현하는데에 활용하였습니다.

> Kingfisher (v8.1.3)

* 영화 포스터, 백드롭 이미지, 등장인물 프로필 사진 등을 로드하는데에 활용하였습니다.

> SnapKit (v5.7.1)

* 앱의 레이아웃을 구성하는데에 활용하였습니다.

&nbsp;

## ✓ 기술적 도전

> 페이지네이션

* UITableViewDataSourcePrefetching 프로토콜의 prefetchRowsAt을 활용하여, 검색 화면의 페이지네이션을 구현하였습니다.

> 에러 핸들링

* TMDB API의 48가지 [`네트워크 에러`](https://developer.themoviedb.org/docs/errors)에 대하여 사용자가 오류 상황을 인지할 수 있도록 대응하였습니다.

> Optimization

* final, private 키워드를 활용하여 Dynamic Dispatch를 Static Dispatch로 정의함으로써 런타임 시점을 최적화하였습니다.

&nbsp;

## ✓ 트러블슈팅

&nbsp;

## ✓ Credits/Thanks

🙏🏻 Thanks to [`TMDB API`](https://developer.themoviedb.org/docs/getting-started)

* 이 앱은 The Movie Data Base API 를 활용하여 최신 영화 정보와, 영화 상세 정보를 가져옵니다.