# Google Cloud 설정 가이드

Stock Note 앱의 Google Drive 동기화를 위한 설정 방법입니다.

---

## 1단계: Google Cloud 프로젝트 생성

1. [Google Cloud Console](https://console.cloud.google.com) 접속
2. 상단 프로젝트 드롭다운 클릭 → **새 프로젝트**
3. 프로젝트 이름: `stock-note-app`
4. **만들기** 클릭

---

## 2단계: Google Drive API 활성화

1. 좌측 메뉴: **API 및 서비스** → **라이브러리**
2. `Google Drive API` 검색
3. **사용 설정** 클릭

---

## 3단계: OAuth 동의 화면 구성

1. **API 및 서비스** → **OAuth 동의 화면**
2. 사용자 유형: **외부** (개인 Google 계정 사용 시)
3. 앱 정보 입력:
   - 앱 이름: `주식 노트`
   - 사용자 지원 이메일: 본인 이메일
4. **범위 추가**: `https://www.googleapis.com/auth/drive.appdata`
5. **테스트 사용자** 탭에 본인 Google 계정 추가
6. 저장

---

## 4단계: OAuth 2.0 자격증명 생성

### Android용

1. **API 및 서비스** → **사용자 인증 정보** → **사용자 인증 정보 만들기** → **OAuth 2.0 클라이언트 ID**
2. 애플리케이션 유형: **Android**
3. 패키지 이름: `com.stocknote.stock_note`
4. SHA-1 인증서 지문 (디버그 키):
   ```
   keytool -list -v -keystore %USERPROFILE%\.android\debug.keystore -alias androiddebugkey -storepass android -keypass android
   ```
   출력에서 `SHA1:` 줄의 값을 복사
5. **만들기** (Android는 별도 JSON 파일 불필요)

### Web용

1. **사용자 인증 정보 만들기** → **OAuth 2.0 클라이언트 ID**
2. 애플리케이션 유형: **웹 애플리케이션**
3. 이름: `Stock Note Web`
4. 승인된 JavaScript 원본:
   - `http://localhost`
   - `http://localhost:7357`
5. **만들기** → **클라이언트 ID** 복사

---

## 5단계: 앱에 Client ID 적용

두 개의 파일에서 `YOUR_WEB_CLIENT_ID`를 복사한 Web Client ID로 교체:

### `android/app/src/main/AndroidManifest.xml`

```xml
<meta-data
    android:name="com.google.android.gms.auth.api.signin.WEB_CLIENT_ID"
    android:value="YOUR_ACTUAL_WEB_CLIENT_ID.apps.googleusercontent.com" />
```

### `lib/features/auth/data/auth_repository.dart`

```dart
clientId: kIsWeb
    ? 'YOUR_ACTUAL_WEB_CLIENT_ID.apps.googleusercontent.com'
    : null,
```

### `web/index.html`

```html
<meta name="google-signin-client_id"
      content="YOUR_ACTUAL_WEB_CLIENT_ID.apps.googleusercontent.com">
```

---

## 6단계: sqflite_common_ffi_web WASM 파일 설정 (Web 빌드 시)

```bash
dart run sqflite_common_ffi_web:setup
```

그 다음 `web/index.html`에서 아래 주석을 해제:

```html
<script src="sqlite3.js"></script>
```

---

## 실행 명령어

```bash
# 의존성 설치
flutter pub get

# 코드 생성 (freezed 모델)
dart run build_runner build --delete-conflicting-outputs

# Android 실행
flutter run -d android

# Web 실행
flutter run -d chrome --web-port 7357

# 테스트
flutter test

# Release APK 빌드
flutter build apk --release

# Release Web 빌드
flutter build web --release
```

---

## Flutter PATH 영구 설정 (Windows)

현재 세션에서만 Flutter가 동작합니다.
영구 설정을 위해 시스템 환경변수에 추가:

1. **시작** → `환경 변수 편집` 검색
2. **사용자 변수** → `Path` 선택 → **편집**
3. **새로 만들기**: `C:\Users\ohhy\flutter\bin`
4. 확인 후 터미널 재시작
