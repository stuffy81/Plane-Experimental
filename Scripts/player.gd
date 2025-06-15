extends CharacterBody3D
class_name Player

@export var model_player:Node3D 
@export var speed:float = 15.0
@export var rotation_speed:float = 0.8
var target_rotation = Vector3()

func _physics_process(delta: float) -> void:
	_gravity(delta)
	_rotating(delta)
	_move_player(delta)
	move_and_slide()

func _move_player(delta):
	var direction = model_player.get_global_transform().basis.z * speed 
	velocity = lerp(velocity , direction , speed * delta)

func _rotating(delta):

	if not model_player:
		return

	if _get_axis().length() > 0:
		target_rotation = Vector3(model_player.rotation.x + _get_axis().y  , model_player.rotation.y + _get_axis().x, model_player.rotation.z + -_get_axis().x)
		model_player.rotation.x = lerp_angle(model_player.rotation.x , target_rotation.x , rotation_speed * delta)
		model_player.rotation.y = lerp_angle(model_player.rotation.y , target_rotation.y , rotation_speed * delta)

		target_rotation.z = clampf(target_rotation.z , deg_to_rad(-60) , deg_to_rad(60))

	else:
		target_rotation = Vector3()

	model_player.rotation.z = lerp_angle(model_player.rotation.z , target_rotation.z , rotation_speed * delta)

func _gravity(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta

func _get_axis() -> Vector2:
	return Input.get_vector("ui_right","ui_left","ui_up","ui_down")
