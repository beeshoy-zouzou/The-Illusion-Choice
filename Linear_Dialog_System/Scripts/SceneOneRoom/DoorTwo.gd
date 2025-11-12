extends Area2D


signal request_transition(target_map_name, target_door_name)
export(String) var target_map_name = ""
export(String) var target_door_name = ""



export(String) var door_id = ""  # example: "toMap3" or "toMap1"
export(String, FILE, "*.tscn") var target_scene_path = "" 
var player_in_range = false
var unlocked = false

onready var door_lock = $DoorLock

func _ready():
	DoorPrompt.hide_prompt()

func _process(delta):
	if player_in_range and Input.is_action_just_pressed("interact"):
		door_lock.play()
#		if Globals.talked_to_beeshoy:
		DoorPrompt.show_message("Returning back to previous room...")
		yield(get_tree().create_timer(1.5), "timeout")  
		DoorPrompt.hide_message()
		DoorPrompt.hide_prompt()
		yield(get_tree().create_timer(1.0), "timeout")
		emit_signal("request_transition", target_map_name, target_door_name)  # Example map and door
			
			
#		else:
#			DoorPrompt.show_message("Door is locked. Talk to Beeshoy first.")
#		if unlocked:
#			DoorPrompt.show_message("Door is unlocked.")
#			# Later: trigger transition
#		else:
#			DoorPrompt.show_message("Door is locked. Talk to Beeshoy first.")

func unlock():
	unlocked = true

func _on_DoorTwo_body_entered(body):
	if body.is_in_group("player"):
		player_in_range = true
		DoorPrompt.show_prompt("Press Q to enter")


func _on_DoorTwo_body_exited(body):
		if body.is_in_group("player"):
			player_in_range = false
			DoorPrompt.hide_prompt()
			DoorPrompt.hide_message()
