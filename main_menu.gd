extends Control

# Yolu (path) senin ağacına göre güncelledim
@onready var animation_player = $AnimationPlayer



func oyunu_baslat():

	get_node("../../CameraPivot/CameraGimbal/PlayerCamera").make_current()


func _on_texture_button_start_pressed() -> void:
	visible = false
	
	animation_player.play("MenuZoom")
