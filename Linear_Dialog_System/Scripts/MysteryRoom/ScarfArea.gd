extends Area2D


var player_in_range = false
onready var animated_sprite = get_parent() as AnimatedSprite

onready var scarf_sound = $ScarfSound

# Called when the node enters the scene tree for the first time.
func _ready():
	DoorPrompt.hide_prompt()


func _process(delta):
	if player_in_range:
		
		DoorPrompt.show_message("A delicate scarf lies here… faintly perfumed, but covered in dust. It might have belonged to the person whod died.")
		


func _on_ScarfArea_body_entered(body):
	scarf_sound.play()
	if body.is_in_group("player"):
		player_in_range = true


func _on_ScarfArea_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false
		DoorPrompt.hide_message()
