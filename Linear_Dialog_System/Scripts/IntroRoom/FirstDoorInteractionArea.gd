extends Area2D


signal request_transition(target_map_name, target_door_name)

export(String) var door_id = "door1"
export(String) var target_door_name = "DoorTwo"
export(String) var target_map_name
export(NodePath) var target_map_path  # Assign to "../SecondMap" in Inspector
export(NodePath) var target_door_exit_path  # Assign to "../SecondMap/DoorToMap1_ExitPos"
export(String, FILE, "*.tscn") var target_scene = ""
#export(Vector2) var target_position = Vector2()
var player_in_range = false
var transitioning = false


onready var door_lock = $DoorLock


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	if player_in_range and Input.is_action_just_pressed("interact") and not transitioning:
		transitioning = true
		door_lock.play()
		_handle_door_interaction()

func _handle_door_interaction():
	match door_id:
		"door1":
			
			DoorPrompt.show_message("Door is locked. Unlock it through the computer.")
			transitioning = false
		"door2":
			
			if Globals.second_door_unlocked:
				DoorPrompt.show_message("This door is unlocked. Good luck in the next part")
				yield(get_tree().create_timer(1.5), "timeout")
#				emit_signal("request_transition", "SceneOneRoom", "DoorTwo")
				emit_signal("request_transition", target_map_name, target_door_name)

			else:
				DoorPrompt.show_message("Door is locked. Unlock it through the computer.")
				transitioning = false
		_:
			DoorPrompt.show_message("This door doesn't respond.")
	print("Interacted with computer:", name)
	# Future logic: open door, load scene, etc.


func _on_FirstDoorInteractionArea_body_entered(body):
	if body.is_in_group("player"):
		print("Player entered ", door_id)
		print("Player entered interaction area")
		player_in_range = true
		DoorPrompt.show_prompt("Press Q to enter")


func _on_FirstDoorInteractionArea_body_exited(body):
	if body.is_in_group("player"):
		print("Player exited interaction area")
		player_in_range = false
		DoorPrompt.hide_prompt()
		DoorPrompt.hide_message()


