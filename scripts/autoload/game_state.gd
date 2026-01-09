extends Node
class_name GameState

signal currency_changed

var gold: int = 0
var catnip: int = 0
var tickets: int = 0
var gold_per_click: int = 1

func add_gold(amount: int) -> void:
	if amount <= 0:
		return
	gold += amount
	currency_changed.emit()

func spend_gold(cost: int) -> bool:
	if cost <= 0:
		return true
	if gold < cost:
		return false
	gold -= cost
	currency_changed.emit()
	return true

func add_catnip(amount: int) -> void:
	if amount <= 0:
		return
	catnip += amount
	currency_changed.emit()

func spend_catnip(cost: int) -> bool:
	if cost <= 0:
		return true
	if catnip < cost:
		return false
	catnip -= cost
	currency_changed.emit()
	return true

func add_tickets(amount: int) -> void:
	if amount <= 0:
		return
	tickets += amount
	currency_changed.emit()

func spend_tickets(cost: int) -> bool:
	if cost <= 0:
		return true
	if tickets < cost:
		return false
	tickets -= cost
	currency_changed.emit()
	return true
