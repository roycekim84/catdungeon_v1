# Godot Setup (v0.1)

## 1) AutoLoad 등록 (GameState)
1. Godot 에디터에서 `Project > Project Settings...` 열기
2. `AutoLoad` 탭 선택
3. Path에 `res://scripts/autoload/game_state.gd` 추가
4. Name은 `GameState`로 설정
5. `Add` 클릭

## 2) 메인 씬 지정
1. `Project > Project Settings...` 열기
2. `Application > Run`에서 `Main Scene`을 `res://scenes/main.tscn`으로 지정

## 3) 화면 해상도/회전 설정 (Portrait)
1. `Project > Project Settings...` 열기
2. `Display > Window`에서 설정
   - Size: Width `1080`, Height `1920`
   - Mode: `Windowed` (개발 단계)
3. `Display > Window > Stretch`에서 설정
   - Mode: `canvas_items`
   - Aspect: `keep`

Rationale: `canvas_items`는 UI 기반 게임에 적합하고, `keep`은 비율을 유지해 UI 찌그러짐을 방지합니다.
