extends Node3D

@onready var animation_player = $"../CanvasLayer/MainMenu/AnimationPlayer"
@export_group("Hareket Ayarları")
@export var move_speed: float = 120.0
@export var rotation_speed: float = 1
@export var edge_margin: int = 20

@export_group("Zoom Ayarları")
@export var zoom_speed: float = 15.0 # Hızı biraz artırdım daha belirgin olsun diye
@export var min_zoom: float = 50.0   
@export var max_zoom: float = 300.0  
@export var starting_zoom: float = 150.0 

# HATA BURADAYDI: 2.0 değeri min_zoom(100)'un altında kaldığı için kilitleniyordu.
var target_zoom: float = 150.0 
@onready var camera = $CameraGimbal/PlayerCamera

func _ready():
	target_zoom = starting_zoom
	if camera:
		camera.position.z = target_zoom
		camera.position.y = target_zoom

func _process(delta):
	# 1. HAREKET HESAPLAMA
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var move_vec = Vector2(input_dir.x, input_dir.y)

	if move_vec.length() == 0:
		var mouse_pos = get_viewport().get_mouse_position()
		var win_size = get_viewport().get_visible_rect().size
		if mouse_pos.x < edge_margin: move_vec.x = -1
		elif mouse_pos.x > win_size.x - edge_margin: move_vec.x = 1
		if mouse_pos.y < edge_margin: move_vec.y = -1
		elif mouse_pos.y > win_size.y - edge_margin: move_vec.y = 1

	# 2. DÜNYA ÜZERİNDE HAREKET
	if move_vec.length() > 0:
		var forward = transform.basis.z.normalized()
		var right = transform.basis.x.normalized()
		var direction = (forward * move_vec.y + right * move_vec.x)
		direction.y = 0 
		global_translate(direction.normalized() * move_speed * delta)

	# 3. YUMUŞAK ZOOM
	if camera:
		camera.position.z = lerp(camera.position.z, target_zoom, delta * 8.0)
		camera.position.y = camera.position.z 

func _unhandled_input(event):
	# 4. MOUSE İLE DÖNDÜRME
	if event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		rotate_y(-event.relative.x * rotation_speed * 0.01)

	# 5. ZOOM GİRİŞİ
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			target_zoom = clamp(target_zoom - zoom_speed, min_zoom, max_zoom)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			target_zoom = clamp(target_zoom + zoom_speed, min_zoom, max_zoom)

func oyunu_baslat():
	# Animasyon bittiğinde kamerayı aktif et
	$CameraGimbal/PlayerCamera.make_current()
	# UYUŞMAZLIK ÇÖZÜMÜ: Kodun hedef zoom değerini, animasyonun bıraktığı yere eşitle
	# Böylece geçişten sonra kamera aniden başka yere sıçramaz.
	target_zoom = $CameraGimbal/PlayerCamera.position.z
	print("Oyun başladı, zoom eşitlendi: ", target_zoom)
