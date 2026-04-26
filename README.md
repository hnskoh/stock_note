# Stock Note

개인 주식 매매 일지 앱 (Flutter)

## 배포

- GitHub Pages: https://hnskoh.github.io/stock_note/

## 로컬 실행

```bash
flutter run -d chrome --web-port 8080
```

## 초기 설정 (새 컴퓨터에서 clone 시)

### Android 빌드를 위한 Firebase 설정

`android/app/google-services.json` 파일은 보안상 Git에 포함되어 있지 않습니다.
아래 절차로 직접 다운로드해서 추가하세요.

1. [Firebase 콘솔](https://console.firebase.google.com/) 접속
2. `stack-note-app` 프로젝트 선택
3. 프로젝트 설정 → Android 앱 선택
4. `google-services.json` 다운로드
5. `android/app/google-services.json` 경로에 저장

> 웹 빌드(`flutter run -d chrome`)는 이 파일 없이도 실행 가능합니다.
