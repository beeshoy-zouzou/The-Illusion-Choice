extends Area2D

signal request_transition(target_map_name, target_door_name)
export(String) var target_map_name = ""
export(String) var target_door_name = ""

var player_in_range = false

onready var door_lock = $DoorLock
# Called when the node enters the scene tree for the first time.
func _ready():
	DoorPrompt.hide_prompt()


func _process(delta):
	if player_in_range and Input.is_action_just_pressed("interact"):
		door_lock.play()
		DoorPrompt.show_message("You are returning back to the previous room")
		yield(get_tree().create_timer(1.5), "timeout") 
		DoorPrompt.hide_message()
		DoorPrompt.hide_prompt()
		yield(get_tree().create_timer(1.5), "timeout")
		emit_signal("request_transition", target_map_name, target_door_name) 


func _on_ThirdDoorThirdRoom_body_entered(body):
	if body.is_in_group("player"):
		player_in_range = true
		DoorPrompt.show_prompt("Press Q to enter")


func _on_ThirdDoorThirdRoom_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false
		DoorPrompt.hide_prompt()
