# Cat Dungeon Tycoon (Working Title)

Godot(GDScript)로 만드는 모바일 아이들(Idle) 클리커/타이쿤 게임.  
개발은 **Codex CLI 중심**으로 진행하며, 최종 목표는 **Android v1.0 출시(최소 APK 설치 테스트)** 입니다.

---

## 핵심 컨셉

- Village 화면에서 **탭(클릭)** 으로 재화 획득
- 업그레이드/고양이/던전 진행으로 성장
- 오프라인 수익(Idle) 정산
- 장기 목표: 타워(던전) 자동 전투 + 재화 루프 완성

기획 상세는 아래 문서를 참고하세요:
- `docs/gdd.md`

---

## 개발 목표 (로드맵)

- **v0.1**: 프로젝트 생성 + Village 메인 + 탭으로 골드 증가 + UI 골격
- **v0.2**: 업그레이드(10개 내외) + 비용 인플레 + 팝업 UI
- **v0.3**: 저장/로드 스키마 + 자동 저장
- **v0.4**: 오프라인 수익 정산
- **v0.5~v0.9**: 고양이/배치/던전/맵/샵 확장 + 폴리싱
- **v1.0**: Android Export(APK/AAB) + 설치 테스트 + 릴리즈 준비

---

## 기술 스택

- Engine: Godot 4.x (권장: 4.5.x stable)
- Language: GDScript
- Target: Android (portrait)
- Dev: macOS + VSCode (단, 변경은 Codex CLI 중심)

---

## 빠른 시작 (로컬 실행)

1) Godot 설치 (4.x)
2) 이 프로젝트 폴더를 Godot Project Manager에서 열기
3) Main Scene 실행 (Play)

> v0.1 단계에서는 에셋이 placeholder일 수 있습니다. (현재 기본 UI 에셋 연결 완료)

---

## Android 빌드(예정)

v1.0 단계에서 Android Export를 진행합니다.  
APK(설치 테스트) → AAB(Play 배포 형태) 순으로 준비할 예정입니다.

- JDK 17
- Android Studio + SDK/NDK 설정
- Godot Editor Settings / Export Presets 설정

자세한 내용은 추후:
- `docs/SETUP_GODOT.md`
- `docs/RELEASE_ANDROID.md`
에 정리합니다.

---

## 프로젝트 구조(권장)

- `scenes/` : 씬(.tscn)
- `scenes/ui/` : UI 씬
- `scripts/` : 스크립트
- `scripts/autoload/` : 싱글톤(게임 상태 등)
- `scripts/ui/` : UI 로직
- `assets/` : 이미지/사운드 리소스
- `docs/` : 문서(GDD, 셋업, 릴리즈 등)

---

## Current Status

- v0.1 플레이 가능: 탭으로 골드 증가, 기본 UI 에셋 연결 완료.
