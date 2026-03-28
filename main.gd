extends Node

@onready var menu_camera = $CanvasLayer/MainMenu/MenuCamera
@onready var player_camera = $CameraPivot/CameraGimbal/PlayerCamera
@onready var animation_player = $CanvasLayer/MainMenu/AnimationPlayer
@onready var main_menu = $CanvasLayer/MainMenu

func _ready():
	# Oyun başlar başlamaz menü kamerasını aktif et
	menu_camera.make_current()


# Animasyonun EN SONUNDA çağrılacak fonksiyon
func oyunu_baslat():
	# Bayrağı oyuncu kamerasına devret
	player_camera.make_current()
	player_camera.set_process(true)
	
	# Oyuncunun hareket script'ini burada aktif edebilirsin
