extends Area2D


var player_in_range = false

onready var skull_sound = $SkullSound
# Called when the node enters the scene tree for the first time.
func _ready():
	DoorPrompt.hide_prompt()


func _process(delta):
	if player_in_range:
		
		DoorPrompt.show_message("Two more victims. The plot thickens.")


func _on_SkullsArea_body_entered(body):
	skull_sound.play()
	if body.is_in_group("player"):
		player_in_range = true


func _on_SkullsArea_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false
		DoorPrompt.hide_message()
