extends Area2D


var player_in_range = false

onready var scroll_sound = $ScrollSound
# Called when the node enters the scene tree for the first time.
func _ready():
	DoorPrompt.hide_prompt()


func _process(delta):
	if player_in_range:
		
		DoorPrompt.show_message("Two skulls, one unanswered question. The truth awaits in the next chapter of the story.")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ScrollArea_body_entered(body):
	scroll_sound.play()
	if body.is_in_group("player"):
		player_in_range = true


func _on_ScrollArea_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false
		DoorPrompt.hide_message()
