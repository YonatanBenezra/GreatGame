extends Node
class_name HotBarComponent

signal updatedHotbar
var hotBar = ["res://entities/miners/miner_tier1/miner_tier1.tscn", "res://entities/conveyors/conveyor_tier1/conyeyor_tier1.tscn", "res://entities/hub/hub_1/hub.tscn", "res://entities/turret/turret.tscn"]

func getBuilding():
	if hotBar[Global.HUD_HOTBAR_CURRENTID]:
		return hotBar[Global.HUD_HOTBAR_CURRENTID]
	else:
		return 0

func getHotbar(): return hotBar

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("hotbar_1"):
		Global.HUD_HOTBAR_CURRENTID = 0
		updatedHotbar.emit()
	elif event.is_action_pressed("hotbar_2"):
		Global.HUD_HOTBAR_CURRENTID = 1
		updatedHotbar.emit()
	elif event.is_action_pressed("hotbar_3"):
		Global.HUD_HOTBAR_CURRENTID = 2
		updatedHotbar.emit()
	elif event.is_action_pressed("hotbar_4"):
		Global.HUD_HOTBAR_CURRENTID = 3
		updatedHotbar.emit()
	elif event.is_action_pressed("hotbar_5"):
		Global.HUD_HOTBAR_CURRENTID = 4
		updatedHotbar.emit()
	elif event.is_action_pressed("hotbar_6"):
		Global.HUD_HOTBAR_CURRENTID = 5
		updatedHotbar.emit()
	elif event.is_action_pressed("hotbar_7"):
		Global.HUD_HOTBAR_CURRENTID = 6
		updatedHotbar.emit()
	elif event.is_action_pressed("hotbar_8"):
		Global.HUD_HOTBAR_CURRENTID = 7
		updatedHotbar.emit()
	elif event.is_action_pressed("hotbar_9"):
		Global.HUD_HOTBAR_CURRENTID = 8
		updatedHotbar.emit()
