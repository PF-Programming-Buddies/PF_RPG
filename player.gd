extends CharacterBody3D

@onready var ray = $RayCast3D

var moving = false

var unit_scale = 3.0

func set_can_move():
	moving = false

func rotate_body(dir: float):
	var tween = create_tween()
	tween.tween_property(self, "rotation_degrees:y", rotation_degrees.y + dir, 0.2)

func move(dir: Vector3):
	var new_movement = (basis * (dir*3))
	ray.target_position = dir * 3
	ray.force_raycast_update() 
	if not ray.is_colliding():
		moving = true
		var tween = create_tween()
		var final_pos = global_position + new_movement
		var delay = 0.15
		tween.tween_property(self, "global_position", final_pos, delay)
		tween.parallel()
		tween.tween_callback(set_can_move).set_delay(delay)
		global_position.x = snappedf(global_position.x, 3)
		global_position.z = snappedf(global_position.z, 3)

func _process(delta):
	
	if Input.is_action_just_pressed("turn_left"):
		rotate_body(90)
	if Input.is_action_just_pressed("turn_right"):
		rotate_body(-90)
	
	if not moving:
		var forward_movement = Input.get_axis("forward", "backward")
		var side_movement = Input.get_axis("left", "right")
		
		if forward_movement:
			move(Vector3(0, 0, forward_movement))
		elif side_movement:
			move(Vector3(side_movement, 0, 0))
