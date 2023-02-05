extends Node2D

var can_activate_light_beam = false
var boxlight_in_position = false
var lightbeam_active = false

func _process(delta):
	# assuming player already has light gem
	if can_activate_light_beam and Input.is_action_pressed("interact"):
#		print("playing lightbeam2 animation")
#		$AnimationPlayer.play("LightBeam1")
		$Line2D.visible = true
		lightbeam_active = true
	
		var puzzle_completed = lightbeam_active and boxlight_in_position
		$BoxLightBeam.visible = puzzle_completed
		
		if puzzle_completed:
			$AnimationPlayer.play("LowerWall")	

func _on_LightStartArea2D_body_entered(body):
	if body.is_in_group("player"):
		can_activate_light_beam = true

func _on_LightStartArea2D_body_exited(body):
	if body.is_in_group("player"):
		can_activate_light_beam = false

func _on_BoxLightArea2D_body_entered(body: Node):
	if body.is_in_group("boxlight"):
		print('box light in position')
		boxlight_in_position = true
		
		if lightbeam_active and boxlight_in_position:
			$BoxLightBeam.visible = true	
			$AnimationPlayer.play("LowerWall")	

func _on_BoxLightArea2D_body_exited(body: Node):
	if body.is_in_group("boxlight"):
		boxlight_in_position = false
		$AnimationPlayer.play_backwards("LowerWall")	
		$BoxLightBeam.visible = false
