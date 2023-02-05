extends KinematicBody2D

const speed: float = MovementGlobals.PLAYER_SPEED
const maxSpeed: float = MovementGlobals.MAX_SPEED
const jump_power: float = MovementGlobals.JUMP_POWER
const idle_frame: int = 2

onready var animated_sprite = $AnimatedSprite
var motion = Vector2()
var is_alive = true
var has_light_gem = false

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("respawn"):
		position = $"../Position2D".position
	
	if !is_alive: return

	motion.y += MovementGlobals.GRAVITY

	var friction = false
	var direction: Vector2 = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		if !$WalkingSFX.playing:
			$WalkingSFX.play()
		
		animated_sprite.play("walk")
		animated_sprite.flip_h = false
		motion.x = min(motion.x + speed, maxSpeed)
	elif Input.is_action_pressed("move_left"):
		if !$WalkingSFX.playing:
			$WalkingSFX.play()

		animated_sprite.play("walk")
		animated_sprite.flip_h = true
		motion.x = max(motion.x - speed, -maxSpeed)
	else:
		friction = true
		animated_sprite.frame = idle_frame
		animated_sprite.stop()
		if $WalkingSFX.playing:
			$WalkingSFX.stop()
		
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			motion.y = jump_power
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.5)
	else:
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.5)
		
	motion = move_and_slide(motion, Vector2.UP)

func on_killed() -> void:
	motion = Vector2.ZERO
	is_alive = false

func on_respawn() -> void:
	is_alive = true
	
func pickup_light_gem() -> void:
	print("picked up gem")
	has_light_gem = true
	
func has_light_gem() -> bool:
	return has_light_gem
