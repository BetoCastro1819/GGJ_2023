extends KinematicBody2D

const speed: float = MovementGlobals.PLAYER_SPEED
const maxSpeed: float = MovementGlobals.MAX_SPEED
const jump_power: float = MovementGlobals.JUMP_POWER

var motion = Vector2()

var can_grab = false

onready var cached_player = $"../Player"

func _physics_process(delta: float) -> void:
	if false:
		if can_grab and Input.is_action_pressed("grab"):
			motion = cached_player.motion
			motion = move_and_slide(motion, Vector2.UP)

	if !is_on_floor():
		motion.y += MovementGlobals.GRAVITY;

	var friction = false
	
	var is_grabbing: bool = false
	if can_grab and Input.is_action_pressed("grab"):
		is_grabbing = true

	if is_grabbing:
		# print("player is grabbing box")
		if Input.is_action_pressed("move_right"):
			motion.x = min(motion.x + speed, maxSpeed)
		elif Input.is_action_pressed("move_left"):
			motion.x = max(motion.x - speed, -maxSpeed)
			
		if is_on_floor():
			if Input.is_action_just_pressed("jump"):
				motion.y = jump_power
			if friction == true:
				motion.x = lerp(motion.x, 0, 0.5)
		else:
			if friction == true:
				motion.x = lerp(motion.x, 0, 0.5)
	else:
		friction = true

	if friction == true:
		motion.x = lerp(motion.x, 0, 0.5)
	
	motion = move_and_slide(motion, Vector2.UP)
	
func _on_PushDetector_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		cached_player = body
		can_grab = true
		# print("player can grab box")

func _on_PushDetector_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		can_grab = false
		# print("player cannot grab box")
