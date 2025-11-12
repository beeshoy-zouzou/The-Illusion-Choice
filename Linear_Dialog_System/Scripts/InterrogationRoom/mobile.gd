extends Area2D


var player_in_range = false
onready var animated_sprite = get_parent() as AnimatedSprite
onready var mobile_ring = $MobileRing

# Called when the node enters the scene tree for the first time.
func _ready():
	DoorPrompt.hide_prompt()


func _process(delta):
	if player_in_range:
		
		DoorPrompt.show_message("You have a message in the scroll, read it before leaving...")



func _on_Area2D_body_entered(body):
	animated_sprite.play("mobile_fire")
	mobile_ring.play()
	if body.is_in_group("player"):
		player_in_range = true


func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false
		DoorPrompt.hide_message()
