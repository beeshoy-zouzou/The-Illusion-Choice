extends Area2D


var player_in_range = false

onready var computer_open = $ComputerOpen

func _process(delta):
	if player_in_range and Input.is_action_just_pressed("interact"):
		computer_open.play()
		DoorPrompt.show_message("Access denied! Terminal can not be accessed here")


func _on_Computer_body_entered(body):
	if body.is_in_group("player"):
		print("Player entered interaction area")
		player_in_range = true
		DoorPrompt.show_prompt("Press Q to access terminal")


func _on_Computer_body_exited(body):
	if body.is_in_group("player"):
		print("Player exited interaction area")
		player_in_range = false
		DoorPrompt.hide_prompt()
		DoorPrompt.hide_message()
