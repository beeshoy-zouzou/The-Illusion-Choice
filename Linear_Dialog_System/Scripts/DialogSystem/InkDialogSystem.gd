# warning-ignore-all:return_value_discarded

extends Control

# ############################################################################ #
# Imports
# ############################################################################ #

var InkPlayer = load("res://addons/inkgd/ink_player.gd")
onready var button = load("res://Scenes/DialogSystem/DialogButton.tscn")
onready var dialog_text = $DialogBox/DialogText
onready var dialog_box = $DialogBox
onready var choice_container = $DialogBox/ChoiceContainer
onready var choice_sound = $ChoiceSound
# ############################################################################ #
# Public Nodes
# ############################################################################ #

# Alternatively, it could also be retrieved from the tree.
# onready var _ink_player = $InkPlayer
onready var _ink_player = InkPlayer.new()
onready var _buttons = []
onready var tween = $DialogBox/Tween
var should_continue = true
var caller_npc = null
# ############################################################################ #
# Lifecycle
# ############################################################################ #

func _ready():
	# Adds the player to the tree.
	add_child(_ink_player)

	# Replace the example path with the path to your story.
	# Remove this line if you set 'ink_file' in the inspector.
	_ink_player.ink_file = load("res://Stories/Testing/PartFour.ink.json")

	# It's recommended to load the story in the background. On platforms that
	# don't support threads, the value of this variable is ignored.
	_ink_player.loads_in_background = true

	_ink_player.connect("loaded", self, "_story_loaded")
	_ink_player.connect("continued", self, "_continued")
	_ink_player.connect("prompt_choices", self, "_prompt_choices")
	_ink_player.connect("ended", self, "_ended")

	# Creates the story. 'loaded' will be emitted once Ink is ready
	# continue the story.
	_ink_player.create_story()

# ############################################################################ #
# Signal Receivers
# ############################################################################ #

func _story_loaded(successfully: bool):
	if !successfully:
		return

	# _observe_variables()
	# _bind_externals()

	# Here, the story is started immediately, but it could be started
	# at a later time.
	tween.interpolate_property(
	dialog_box , "modulate:a",0, 1,2.0, 
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	tween.start()
	yield(tween, "tween_completed")
	_ink_player.continue_story()


func _continued(text, tags):
#	print(text)
	# Here you could yield for an hypothetical signal, before continuing.
	# yield(self, "event")
	dialog_text.text = text
	var base_speed = 0.05  # seconds per character
	var char_count = text.length()
	var duration = clamp(char_count * base_speed, 0.3, 5)
	tween.interpolate_property(
	dialog_text, "percent_visible", 0, 1, duration,
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	tween.start()
	yield(tween, "tween_completed")
	yield(get_tree().create_timer(1.0), "timeout")
	_ink_player.continue_story()


# ############################################################################ #
# Private Methods
# ############################################################################ #

func _prompt_choices(choices):
	if !choices.empty():
		for choice in choices:
			var btn = button.instance()
			btn.text = choice.text
			btn.connect("pressed", self, "_choose_index", [btn])
			_buttons.append(btn)
			choice_container.add_child(btn)
#		print(choices)

		# In a real world scenario, _select_choice' could be
		# connected to a signal, like 'Button.pressed'.
#		_select_choice(0)


func _ended():
	print("The End")
	tween.interpolate_property(
		dialog_box, "modulate:a",
		1.0, 0.0,
		1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
	tween.start()
	yield(tween, "tween_completed")
	yield(get_tree().create_timer(1), "timeout")
	dialog_box.visible = false
	if caller_npc != null:
		caller_npc.end_conversation()
		caller_npc.remove_dialog_instance()


func _select_choice(index):
	for button in choice_container.get_children():
		choice_container.remove_child(button)
		_buttons.erase(button)
	_ink_player.choose_choice_index(index)
	_ink_player.continue_story()

func _choose_index(btn):
	choice_sound.play()
	var index = _buttons.find(btn)
	if index != -1:
		_select_choice(index)
# Uncomment to bind an external function.
#
# func _bind_externals():
# 	_ink_player.bind_external_function("<function_name>", self, "_external_function")
#
#
# func _external_function(arg1, arg2):
# 	pass


# Uncomment to observe the variables from your ink story.
# You can observe multiple variables by putting adding them in the array.
# func _observe_variables():
# 	_ink_player.observe_variables(["var1", "var2"], self, "_variable_changed")
#
#
# func _variable_changed(variable_name, new_value):
# 	print("Variable '%s' changed to: %s" %[variable_name, new_value])
