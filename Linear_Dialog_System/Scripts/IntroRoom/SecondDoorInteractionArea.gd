extends Area2D


signal request_transition(target_map_name, target_door_name)


var player_in_range = false
export(String) var door_id = "door2"
export(String, FILE, "*.tscn") var target_scene = ""

export(String) var target_map_name = "SceneOneRoom" 
export(String) var target_door_name = "DoorTwo" 


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
	print("Interacted with computer:", name)
	match door_id:
		"door1":
			DoorPrompt.show_message("Door is locked. Unlock it through the computer.")
		"door2":
			if Globals.second_door_unlocked:
				print("DEBUG: Door unlocked! Attempting transition...")
				DoorPrompt.show_message("This door is unlocked. Good luck in the next part")
				
				yield(get_tree().create_timer(1.5), "timeout")
				print("Emitting transition to: ", target_map_name, " | ", target_door_name)
#				emit_signal("request_transition", "SceneOneRoom", "DoorTwo")
				emit_signal("request_transition", target_map_name, target_door_name)
				transitioning = false
				
			else:
				DoorPrompt.show_message("Door is locked. Unlock it through the computer.")
		_:
			DoorPrompt.show_message("This door doesn't respond.")
	transitioning = false		





func _on_SecondDoorInteractionArea_body_entered(body):
	if body.is_in_group("player"):
		print("Player entered ", door_id)
		print("Player entered interaction area")
		player_in_range = true
		DoorPrompt.show_prompt("Press Q to enter")


func _on_SecondDoorInteractionArea_body_exited(body):
	if body.is_in_group("player"):
		print("Player exited interaction area")
		player_in_range = false
		DoorPrompt.hide_prompt()
		DoorPrompt.hide_message()

