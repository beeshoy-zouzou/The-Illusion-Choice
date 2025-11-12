extends Area2D


var player_in_range = false
onready var animated_sprite = get_parent() as AnimatedSprite
onready var scroll_sound = $ScrollSound

# Called when the node enters the scene tree for the first time.
func _ready():
	DoorPrompt.hide_prompt()


func _process(delta):
	if player_in_range:
		
		DoorPrompt.show_message("Someone died here... You have to identify the culprit")
#		yield(get_tree().create_timer(1.5), "timeout") 
#		DoorPrompt.hide_message()
#		DoorPrompt.hide_prompt()
#		yield(get_tree().create_timer(1.5), "timeout")


func _on_ScrollArea_body_entered(body):
	animated_sprite.play("open")
	scroll_sound.play()
	if body.is_in_group("player"):
		player_in_range = true
	


func _on_ScrollArea_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false
		DoorPrompt.hide_message()
