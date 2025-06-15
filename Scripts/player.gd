extends CharacterBody3D
class_name Player

@export var speed:float = 8.0

#Rotaciones
@export var rotacion_speed:float = 0.8
var target_rotation = Vector2()
var rot_z = 0.0

#Interpolacion Velocidad
@export var weight_interpolated:float = 3.0

#Nodos  
@export var model_player:Node3D 

func _physics_process(delta: float) -> void:
	_gravity(delta)
	_rotating(delta)
	_move_player(delta)
	move_and_slide()

func _move_player(delta):
	velocity.x = lerpf(velocity.x , model_player.get_global_transform().basis.z.x * speed , weight_interpolated * delta)
	velocity.y = lerpf(velocity.y , model_player.get_global_transform().basis.z.y * speed , weight_interpolated * delta)
	velocity.z = lerpf(velocity.z , model_player.get_global_transform().basis.z.z * speed , weight_interpolated * delta)

func _rotating(delta):
	target_rotation += _get_axis() * rotacion_speed * delta
	target_rotation.x = clampf(target_rotation.x , -360 , 360)
	target_rotation.y = clampf(target_rotation.y , -360 , 360)

	if _get_axis().length() > 0:
		rot_z += -_get_axis().x * rotacion_speed * delta
		rot_z = clampf(rot_z , deg_to_rad(-30) , deg_to_rad(30))
	else:
		rot_z = lerpf(rot_z , 0.0 , weight_interpolated * delta)

	if model_player:
		model_player.rotation.y = lerp_angle(model_player.rotation.y , target_rotation.x , weight_interpolated * delta)
		model_player.rotation.x = lerp_angle(model_player.rotation.x , target_rotation.y , weight_interpolated * delta)
		model_player.rotation.z = lerp_angle(model_player.rotation.z , rot_z , weight_interpolated * delta)

func _gravity(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta

func _get_axis() -> Vector2:
	return Input.get_vector("ui_right","ui_left","ui_up","ui_down")
