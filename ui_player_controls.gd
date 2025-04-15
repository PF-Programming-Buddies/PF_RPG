extends Panel

@export var player: Player

func _on_up_pressed():
	player.move(Vector3(0, 0, -1))


func _on_rr_pressed():
	player.rotate_body(-90)


func _on_rl_pressed():
	player.rotate_body(90)


func _on_down_pressed():
	player.move(Vector3(0, 0, 1))


func _on_left_pressed():
	player.move(Vector3(-1, 0, 0))


func _on_right_pressed():
	player.move(Vector3(1, 0, 0))
