# docs/gdd.md
# 고양이 던전 타이쿤 (Cat Dungeon Tycoon) — GDD v0.3

## 1. 개요
- 게임명: 고양이 던전 타이쿤 (가제: 탑의 집사들)
- 장르: 하이브리드 타이쿤 (방치형 경영 + 수집형 RPG 요소)
- 플랫폼: 모바일 (Android 우선 / Google Play)
- 개발: macOS(Apple Silicon) + Godot 4.5.x stable + GDScript
- 화면: Portrait, 기준 1080 x 1920
- 타깃: 귀여운 캐릭터 선호 캐주얼 + 성장/수집 재미를 좋아하는 방치 유저

---

## 2. 한 줄 피치
“집사(유저)가 마을을 성장시키며 고양이 용사들을 모아, 무한 캣닢 탑을 오르며 희귀 고양이를 수집하는 방치형 타이쿤 + 라이트 전투”

---

## 3. 시놉시스
용사 고양이들이 전설의 ‘무한 캣닢 탑’을 공략하기 위해 모인다.
유저는 집사이자 운영자가 되어 마을 시설/고양이 성장을 관리하고,
성장한 고양이 군단으로 탑의 보스를 격파해 더 희귀한 고양이를 얻는다.

---

## 4. 핵심 루프 (Core Loop)
1) Earn: 탭 + 고양이 자동 활동(GoldPerSecond, GPS)로 골드 획득  
2) Upgrade: 클릭 효율/자동 수익/시설 업그레이드 + 고양이 영입  
3) Expand: 더 많은 고양이/시설로 수익 극대화 + 오프라인 수익  
4) Progress: 탑 층수 진행 → 보상/희귀 고양이 획득 → 다시 성장

---

## 5. 씬 구성 & 내비게이션
### Scene A: Village (메인/타이쿤)
- 상단 통화 바: Gold / Catnip(프리미엄) / Ticket(가챠 티켓)
- 하단 탭바: Upgrades / Dungeon / Map / Shop
- Upgrades 팝업: 업그레이드 리스트(코인/프리미엄 결제 UI 포함)
- Offline Gold 배너/토스트: 마지막 접속~현재까지 수익 정산

### Scene B: Tower (전투/탑)
- 라이트 자동 전투 + 간단한 화면 연출
- 층 진행/보스/보상 수령 후 Village 복귀

---

## 6. 경제 시스템 (Economy)
- 재화:
  - Gold: 기본 재화
  - Catnip: 프리미엄 재화(추후 IAP/광고/이벤트)
  - Ticket: 가챠 티켓(보상/이벤트/광고 등)
- 수익:
  - Tap: Gold += GoldPerClick
  - GPS: Gold += GoldPerSecond (GPS) * deltaTime (또는 1초 Tick)
- 인플레이션:
  - NextCost = BaseCost * 1.5^Level (예시)
- 목표: “다음 업그레이드/다음 고양이/다음 층”을 계속 보여주는 설계

---

## 7. 고양이 영입/가챠 (Recruitment)
- 일반 영입:
  - Gold로 상점 구매(확정 영입)
  - (선택) Gold 일반 뽑기(낮은 비용, 낮은 희귀 확률)
- 고급 영입:
  - Catnip/티켓으로 프리미엄 뽑기
  - 희귀/전설 확률 상승 + 연출 강화
- MVP에서는 “UI/흐름/데이터 구조” 우선, 확률표/연출은 최소로 시작 가능

---

## 8. 마을 배치 알고리즘 (겹침 방지)
- SpawnArea(Rect) 내 랜덤 포인트 샘플링 N회
- 기존 고양이들과 최소 거리 R 이상이면 채택
- 실패 시 “가장 멀리 떨어진 후보” 선택
- (선택) 짧은 랜덤 워크 + separation로 느슨한 군집/충돌 회피

---

## 9. 전투 시스템 (라이트, 연출 포함)
- 기본: 고양이 전투력 합산 vs 몬스터 HP(층/보스)
- 전투는 자동으로 진행
- 연출:
  - 타격 시 작은 흔들림(Shake) 또는 스케일 펀치
  - 플로팅 데미지 숫자
  - 승리/보상 팝업
- 보상:
  - Gold 기본 + (선택) Ticket/재료

---

## 10. UI/아트 스타일 가이드 (참고 이미지 기반)
- Clean 2D Cartoon / Vector 느낌
- 둥근 모서리, 두꺼운 외곽선, 부드러운 그림자
- 나무 프레임 팝업(Upgrades), 우상단 X 버튼
- 상단 통화 바 + “+” 버튼
- 하단 탭바 4개(큰 아이콘 + 라벨)
- Offline Gold 토스트/배너

---

## 11. 수치 밸런스 초안
- GoldPerClick 시작값: 1
- GoldPerSecond (GPS) 시작값: 0.5
- 업그레이드 비용 성장: BaseCost * 1.45^Level (초기 구간 완만)
- 오프라인 수익 캡: 4시간 (MVP 기준)

## 12. 데이터 모델 & 저장 스키마 (MVP)
- version: 세이브 버전 문자열 (예: "0.3")
- gold: 보유 골드
- gold_per_click: 현재 클릭 수익
- gold_per_second: 현재 GPS
- last_login_unix: 마지막 접속 시간(Unix)
- upgrades: 업그레이드 ID -> level 맵
- cats_owned: 고양이 ID -> count 맵
- settings: sound_on, vibration_on 등 최소 설정

## 13. FTUE(첫 세션) 30초 튜토리얼 플로우
- Step 1: 화면 탭 → 골드 +1 확인
- Step 2: 업그레이드 열기 → 첫 업그레이드 구매
- Step 3: GPS 증가 확인 → 자동 수익 안내
- Step 4: 고양이 1마리 영입 → 마을 등장 연출
- Step 5: “다음 목표” 카드 노출(다음 업그레이드 비용 표시)

## 14. 저장/로드
- 1차: 로컬 JSON (Godot FileAccess)
- 구조: SaveService 추상화(ISaveService)로 추후 Cloud Save 교체 가능
- Offline Gold: last_login_unix 기반 누적 계산

---

## 15. BM (수익화)
- 광고 제거 패키지(IAP)
- 보상형 광고: 2배 수익 부스트 / 티켓 지급
- 프리미엄 재화(Catnip): 프리미엄 뽑기/편의 기능(추후)

---

## 16. MVP 범위(Vertical Slice)
MVP-1: Village 타이쿤 코어(탭/GPS/업그레이드/UI/저장/오프라인)
MVP-2: 고양이 구매/배치(겹침 방지) + GPS 기여
MVP-3: Tower 자동 전투(연출) + 보상 + 복귀

## 17. 버전 로드맵 v0.1~v1.0
- v0.1: MVP-1 기본 루프 완성(탭/GPS/업그레이드/UI/저장/오프라인)
- v0.2: MVP-2 고양이 영입/배치 + 기본 성장 곡선
- v0.3: MVP-3 전투 흐름 연결 + 저장 스키마 확정
- v0.4: 오프라인 수익 정산 고도화 + 밸런스 1차
- v0.5~0.9: 맵/샵/고양이 확장 + 연출 강화
- v1.0: Android APK/AAB 빌드 및 설치 테스트

## 18. v1.0 OUT OF SCOPE
- 광고/인앱결제 실연동(스토어 라이브)
- 복잡한 가챠 애니메이션/시네마틱 연출
- 실시간 멀티/길드/경쟁 콘텐츠
