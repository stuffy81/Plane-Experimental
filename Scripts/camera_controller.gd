extends Node3D
class_name CameraController

@onready var player:Player = self.owner

func _physics_process(delta: float) -> void:
	rotation.y = lerpf(rotation.y , player.model_player.rotation.y , delta)   
	rotation.x = lerpf(rotation.x , player.model_player.rotation.x , delta) 
