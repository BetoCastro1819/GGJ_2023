extends Node2D

var can_activate_light_beam = false

func _process(delta):
	if can_activate_light_beam and Input.is_action_pressed("interact"):
		$Line2D/AnimationPlayer.play("LightBeam1")

func _on_Area2D_body_entered(body: Node):
	if body.is_in_group("Player") and $"../Player".has_light_gem():
		print("player with gem in lightbeam area")
		can_activate_light_beam = true
		

func _on_Area2D_body_exited(body):
	if body.is_in_group("Player"):
		can_activate_light_beam = false
