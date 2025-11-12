extends KinematicBody2D


signal talk_to_npc
signal talk_started

var player_in_range = false
var in_conversation = false
onready var sprite = $AnimatedSprite
var is_dead = false
onready var tween = $Tween
onready var death_sound = $DeathSound
var dialog_scene = preload("res://Scenes/DialogSystem/ButlerDialogSystem.tscn")
var dialog_instance = null
var has_talked_to_player = false


func _ready():
	sprite.play("idle")


func _process(delta):
	if player_in_range and Input.is_action_just_pressed("interact") and not in_conversation:
		in_conversation = true
		start_conversation()

func start_conversation():
	Globals.player_can_move = false

	emit_signal("talk_started")
	DoorPrompt.hide_prompt()  # If you're using a global autoload prompt
	sprite.play("idle")
	#Dialog logic
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
#	Globals.talked_to_butler = true 
#	print("Conversation finished. Doors can unlock.")
	emit_signal("talk_to_npc")
	
func remove_dialog_instance():
	if dialog_instance:
		dialog_instance.queue_free()
		dialog_instance = null

func end_conversation():

#	sprite.play("idle")
#	yield(get_tree().create_timer(3), "timeout")
	Globals.player_can_move = true
	has_talked_to_player = true
#	yield(sprite, "animation_finished")

	in_conversation = false
	Globals.talked_to_butler = true 
	print("Conversation finished. Doors can unlock.")
	emit_signal("talk_to_npc")
	
func _on_Area2D_body_entered(body):
	if body.is_in_group("player") and not is_dead:
		player_in_range = true
		DoorPrompt.show_prompt("Press Q to talk")


func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false
		DoorPrompt.hide_prompt()
		if has_talked_to_player and not is_dead:
			sprite.play("die")
			DoorPrompt.hide_prompt()
			yield(sprite, "animation_finished")
			sprite.stop()
			sprite.frame = sprite.frames.get_frame_count("die") - 1
			in_conversation = false
			is_dead = true
			end_conversation()
			remove_dialog_instance()
			death_sound.play()
			tween.interpolate_property(
				sprite, "modulate:a", 1.0, 0.0, 1.5, 
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
				)
			tween.start()
			yield(tween, "tween_completed")
			queue_free()
			
