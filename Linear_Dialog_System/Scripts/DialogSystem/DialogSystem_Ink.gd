# warning-ignore-all:return_value_discarded

extends Control
#signal dialog_finished
# ############################################################################ #
# Imports
# ############################################################################ #

var InkPlayer = load("res://addons/inkgd/ink_player.gd")
onready var button = load("res://Scenes/DialogSystem/DialogButton.tscn")
onready var tween = $DialogBox/Tween
onready var next_indicator = $"DialogBox/next-indicator"
onready var dialog_box = $DialogBox
onready var dialog_text = $DialogBox/DialogText
onready var choice_container = $DialogBox/ChoiceContainer

# ############################################################################ #
# Public Nodes
# ############################################################################ #

# Alternatively, it could also be retrieved from the tree.
#onready var _ink_player = $InkPlayer
onready var _ink_player = InkPlayer.new()
onready var _buttons = []
var finished = false

# ############################################################################ #
# Lifecycle
# ############################################################################ #

func _ready():





	# Adds the player to the tree.
	add_child(_ink_player)

	# Replace the example path with the path to your story.
	# Remove this line if you set 'ink_file' in the inspector.
	_ink_player.ink_file = load("res://Stories/LinearDialog/PartOne/PartOne.ink.json")

	# It's recommended to load the story in the background. On platforms that
	# don't support threads, the value of this variable is ignored.
	_ink_player.loads_in_background = true

	_ink_player.connect("loaded", self, "_story_loaded")

	# Creates the story. 'loaded' will be emitted once Ink is ready
	# continue the story.
	_ink_player.create_story()


# ############################################################################ #
# Signal Receivers
# ############################################################################ #
func _process(delta):
	next_indicator.visible = finished


func _story_loaded(successfully: bool):
	if !successfully:
		return


	# _observe_variables()
	# _bind_externals()
	tween.interpolate_property(
	dialog_box, "modulate:a",0, 1,1.0, 
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	tween.start()
	yield(tween, "tween_completed")

	_continue_story()


# ############################################################################ #
# Private Methods
# ############################################################################ #

func _continue_story():
	while _ink_player.can_continue:
		
		var text = _ink_player.continue_story()
		var tags = _ink_player.current_tags
		# This text is a line of text from the ink story.
		# Set the text of a Label to this value to display it in your game.
		dialog_text.text = text
		dialog_text.percent_visible = 0
		tween.interpolate_property(
			dialog_text, "percent_visible", 0, 1, 2.0, 
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
		tween.start()
		yield(tween, "tween_completed")
		yield(get_tree().create_timer(1.0), "timeout")
	if _ink_player.has_choices:
		# 'current_choices' contains a list of the choices, as strings.

		for choice in _ink_player.current_choices:
			var btn = button.instance()
			btn.text = choice.text
			btn.connect("pressed", self, "_choose_index", [btn])
			_buttons.append(btn)
			choice_container.add_child(btn)
#			print(choice.text)
#			print(choice.tags)
		# '_select_choice' is a function that will take the index of
		# your selection and continue the story.
#		_select_choice(0)
	else:
		# This code runs when the story reaches it's end.
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
#		emit_signal("dialog_finished")

func _choose_index(btn):
	
	var index = _buttons.find(btn)
	if index != -1:
		_select_choice(index)

func _select_choice(index):
	for button in choice_container.get_children():
		choice_container.remove_child(button)
		_buttons.erase(button)
	_ink_player.choose_choice_index(index)
	_continue_story()

#func _on_Tween_tween_completed(object, key):
#	finished = true

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

#func start_dialog(ink_path: String):
#	_ink_player.ink_file = load(ink_path)
#	_ink_player.create_story()
#	dialog_box.visible = true
