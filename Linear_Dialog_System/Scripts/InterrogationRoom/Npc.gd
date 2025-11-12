extends KinematicBody2D




signal talk_to_npc
signal talk_started

var player_in_range = false
var in_conversation = false

var dialog_scene = preload("res://Scenes/DialogSystem/DialogSystemTwo.tscn")
var dialog_instance = null
onready var sprite = $AnimatedSprite

func _ready():
	sprite.play("idle")
	DoorPrompt.prompt_panel.rect_position.y -= 30
#	DoorPrompt.prompt_panel.rect_size = Vector2(180, 40)
	DoorPrompt.label.align = DoorPrompt.label.ALIGN_CENTER

# Called when the node enters the scene tree for the first time.
func _process(delta):
	if player_in_range and Input.is_action_just_pressed("interact") and not in_conversation:
		in_conversation = true
		start_conversation()

func start_conversation():
	Globals.player_can_move = false
	emit_signal("talk_started")
	DoorPrompt.hide_prompt()
	sprite.play("look_up")
	if dialog_instance:
		dialog_instance.queue_free()
		dialog_instance = null
	dialog_instance = dialog_scene.instance()
	var dialog_script_node = dialog_instance.get_node("DialogSystem")
	dialog_script_node.caller_npc = self
	get_tree().get_root().add_child(dialog_instance)
#	var dialog_instance = dialog_scene.instance()
#	get_tree().get_root().add_child(dialog_instance)
	var x = dialog_instance.get_node("DialogSystem/DialogBox")
	x.rect_position.y += 180
	x.rect_position.x += 15
#	Globals.talked_to_second_beeshoy = true
#	emit_signal("talk_to_npc")
	
func remove_dialog_instance():
	if dialog_instance:
		dialog_instance.queue_free()
		dialog_instance = null
		
func end_conversation():


	Globals.player_can_move = true
#	sprite.play("look_up")
#	yield(get_tree().create_timer(3), "timeout")
#	Globals.player_can_move = true
#	yield(sprite, "animation_finished")
#	Globals.player_can_move = true
	sprite.play("idle")
	in_conversation = false
	Globals.talked_to_second_beeshoy = true 
	print("Conversation finished. Doors can unlock.")
	emit_signal("talk_to_npc")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		player_in_range = true
		DoorPrompt.show_prompt("Press Q to talk")


func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false
		DoorPrompt.hide_prompt()
		if in_conversation:
			remove_dialog_instance()
			end_conversation()
#			remove_dialog_instance()
#		if in_conversation:
#			sprite.play("look_up")
#			yield(sprite, "animation_finished")
#			sprite.play("idle")
#			in_conversation = false
