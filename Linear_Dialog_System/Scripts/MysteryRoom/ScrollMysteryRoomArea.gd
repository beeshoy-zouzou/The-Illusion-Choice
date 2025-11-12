extends Area2D


var player_in_range = false
onready var scroll_sound = $ScrollSound

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if player_in_range:
		
		DoorPrompt.show_message("Faint ink whispers of the Silhouettes... watchers of truth, or shadows of guilt?")
		

		


func _on_ScrollMysteryRoomArea_body_entered(body):
	scroll_sound.play()
	if body.is_in_group("player"):
		player_in_range = true


func _on_ScrollMysteryRoomArea_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false
		DoorPrompt.hide_message()
