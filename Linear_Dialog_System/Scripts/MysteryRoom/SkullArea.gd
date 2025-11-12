extends Area2D


var player_in_range = false

onready var skull_sound = $SkullSound
# Called when the node enters the scene tree for the first time.
func _ready():
	DoorPrompt.hide_prompt()


func _process(delta):
	if player_in_range:
		
		DoorPrompt.show_message("The scarf felt recent… but the skull? It’s as if it’s been waiting. Watching. As though time never truly left this place...")


func _on_SkullArea_body_entered(body):
	skull_sound.play()
	if body.is_in_group("player"):
		player_in_range = true# Replace with function body.


func _on_SkullArea_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false
		DoorPrompt.hide_message()
