extends KinematicBody2D

export var speed = 100
var velocity = Vector2()
var last_direction = "right"  # Track direction for idle animation

func _physics_process(delta):

	if !Globals.player_can_move:
		return

	# Normal movement code here

	velocity.x = 0

	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		last_direction = "right"
	elif Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		last_direction = "left"

	velocity = velocity.normalized() * speed
	move_and_slide(velocity)

	update_animation()

func update_animation():
	var anim_sprite = $AnimatedSprite

	if velocity.x == 0:
		# Show idle animation based on last direction
		anim_sprite.animation = "idle_" + last_direction
	else:
		anim_sprite.animation = "walk_" + last_direction

	anim_sprite.play()
