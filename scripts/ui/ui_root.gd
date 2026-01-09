extends Control

@onready var gold_value_label: Label = get_node_or_null("Layout/TopBar/GoldBox/GoldValueLabel")
@onready var catnip_value_label: Label = get_node_or_null("Layout/TopBar/CatnipBox/CatnipValueLabel")
@onready var ticket_value_label: Label = get_node_or_null("Layout/TopBar/TicketBox/TicketValueLabel")
@onready var tap_button: TextureButton = get_node_or_null("Layout/Center/TapButton")

var tap_feedback_tween: Tween
var local_gold: int = 0

var game_state: GameState

func _ready() -> void:
	game_state = get_node_or_null("/root/GameState")
	if not _validate_ui_refs():
		_set_placeholder_values()
		return
	if game_state:
		game_state.currency_changed.connect(_refresh_currency)
		_refresh_currency()
	else:
		_set_placeholder_values()
		push_error("GameState autoload not found. Using local counter for debug. Add it in Project Settings > AutoLoad.")

	tap_button.pressed.connect(_on_tap_button_pressed)

func _on_tap_button_pressed() -> void:
	print("TapButton pressed")
	if not game_state:
		local_gold += 1
		_refresh_currency()
		_play_tap_feedback()
		return
	game_state.add_gold(game_state.gold_per_click)
	_refresh_currency()
	_play_tap_feedback()

func _play_tap_feedback() -> void:
	if not tap_button:
		return
	if tap_feedback_tween and tap_feedback_tween.is_running():
		tap_feedback_tween.kill()
	tap_button.pivot_offset = tap_button.size * 0.5
	tap_button.scale = Vector2.ONE
	tap_feedback_tween = create_tween()
	tap_feedback_tween.tween_property(tap_button, "scale", Vector2(1.08, 1.08), 0.08).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tap_feedback_tween.tween_property(tap_button, "scale", Vector2.ONE, 0.12).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

func _refresh_currency() -> void:
	if game_state:
		gold_value_label.text = str(game_state.gold)
		catnip_value_label.text = str(game_state.catnip)
		ticket_value_label.text = str(game_state.tickets)
		return
	gold_value_label.text = str(local_gold)
	catnip_value_label.text = "0"
	ticket_value_label.text = "0"

func _set_placeholder_values() -> void:
	gold_value_label.text = "0"
	catnip_value_label.text = "0"
	ticket_value_label.text = "0"

func _validate_ui_refs() -> bool:
	if gold_value_label and catnip_value_label and ticket_value_label and tap_button:
		return true
	push_error("UIRoot missing expected nodes. Check ui_root.tscn node paths.")
	if tap_button:
		tap_button.disabled = true
	return false
