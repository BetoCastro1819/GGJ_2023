extends Node2D

var can_pickup: bool = false

func _process(delta):
	if can_pickup and Input.is_action_pressed("interact"):
		$"../Player".pickup_light_gem()
		queue_free()

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		can_pickup = true
		print("can pickup gem")

func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		can_pickup = false
		print("moved away from gem")
