extends Area2D

var player_in_range = false
onready var computer_open = $ComputerOpen
#
func _ready():
	var x = ComputerUI.get_node("Panel")
	x.rect_position.x += 100


func _process(delta):
	if player_in_range and Input.is_action_just_pressed("interact"):
		computer_open.play()
		open_computer_ui()

func open_computer_ui():
	DoorPrompt.hide_prompt()
#	var x = ComputerUI.get_node("Panel")
#	x.rect_position.x += 100
	var first_ref = funcref(self, "_handle_first_door")
	var second_ref = funcref(self, "_handle_second_door")
	ComputerUI.show_ui(first_ref, second_ref)
	ComputerUI.show_message("Doors are locked.")

func _handle_first_door():
	ComputerUI.show_message("Access denied. This door cannot be unlocked.")

func _handle_second_door():
	if not Globals.second_door_unlocked:
		Globals.second_door_unlocked = true
		ComputerUI.show_message("Second door unlocked.")
		print("DEBUG: Globals.second_door_unlocked set to TRUE")
	else:
		ComputerUI.show_message("Second door was already unlocked")
	
func interact():
	print("Interacted with computer:", name)
	# Future logic: open door, load scene, etc.


func _on_ComputerInteractionArea_body_entered(body):
	if body.is_in_group("player"):
		print("Player entered interaction area")
		player_in_range = true
		DoorPrompt.show_prompt("Press Q to access terminal")
		


func _on_ComputerInteractionArea_body_exited(body):
	if body.is_in_group("player"):
		print("Player exited interaction area")
		player_in_range = false
		DoorPrompt.hide_prompt()
		ComputerUI.hide_ui()
		



