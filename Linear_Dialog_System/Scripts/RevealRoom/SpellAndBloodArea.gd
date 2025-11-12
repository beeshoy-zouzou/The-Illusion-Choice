extends Area2D


var player_in_range = false

onready var spell_sound = $SpellSound
# Called when the node enters the scene tree for the first time.
func _ready():
	DoorPrompt.hide_prompt()



func _process(delta):
	if player_in_range:
		
		DoorPrompt.show_message("The spell is dry now. But the blood remembers… and so do the shadows that watched it all unfold.")


func _on_SpellAndBloodArea_body_entered(body):
	spell_sound.play()
	if body.is_in_group("player"):
		player_in_range = true


func _on_SpellAndBloodArea_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false
		DoorPrompt.hide_message()
