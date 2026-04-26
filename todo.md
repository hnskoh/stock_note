# TODO

## 즉시 해야 할 것

- [ ] Firebase App Distribution 앱 수신 확인
  - 폰 Gmail에서 초대 이메일 열기 → Get Started 클릭 → APK 다운로드 및 설치
  - 이후 push 시 자동 업데이트 알림 오는지 검증

## Android 설정 정리

- [ ] `AndroidManifest.xml`의 WEB_CLIENT_ID placeholder 제거
  - `YOUR_WEB_CLIENT_ID.apps.googleusercontent.com` → 해당 meta-data 블록 삭제 (현재 미사용)
- [ ] `firebase_options.dart` Android appId 업데이트
  - 현재: `1:587400383504:android:b99f4706b2b4f1519e8e95` (구 앱)
  - 실제: `1:587400383504:android:861a186db9e461109e8e95` (google-services.json 기준)
  - `flutterfire configure` 재실행으로 갱신 권장

## 릴리즈 빌드 준비

- [ ] Release keystore 생성 및 서명 설정
  - 현재 debug APK로 배포 중 → 정식 배포 시 release 서명 필요
  - keystore 생성 후 GitHub Secret에 추가, workflow에서 release APK 빌드
- [ ] GitHub Actions Node.js 24 마이그레이션
  - `actions/checkout`, `actions/setup-java` 최신 버전으로 업데이트 (2026년 6월 전)

## 앱 완성도

- [ ] 앱 아이콘 변경 (현재 Flutter 기본 아이콘)
- [ ] 스플래시 화면 커스터마이징 (현재 Flutter 기본 로고)
- [ ] Firestore 복합 인덱스 점검
  - accountId + tradeDate 범위 쿼리 시 인덱스 필요할 수 있음

## 알려진 버그

- [ ] Flutter 웹 한국어 IME 입력 중 글자 깨짐 (Flutter 엔진 버그, 완성 후 정상)
