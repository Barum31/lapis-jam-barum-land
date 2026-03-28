extends Node
var current_tick = 0
@export var tick_interval = 5.0
@onready var menu_camera = $CanvasLayer/MainMenu/MenuCamera
@onready var player_camera = $CameraPivot/CameraGimbal/PlayerCamera
@onready var animation_player = $CanvasLayer/MainMenu/AnimationPlayer
@onready var main_menu = $CanvasLayer/MainMenu

var kaynaklar = {
	"moral": 100,
	"nufus": 50,
	"para": 1000,
	"metal": 0,
	"yemek": 200,
	"ahsap": 50
}
var gelir_oranlari = {
	"para": 10,    # Her tickte +10 para
	"yemek": -5,   # Her tickte -5 yemek (Nüfus yiyor)
	"moral": -1    # Zamanla moral düşer
}
func _ready():
	# Oyun başlar başlamaz menü kamerasını aktif et
	menu_camera.make_current()
	


# Animasyonun EN SONUNDA çağrılacak fonksiyon
func oyunu_baslat():
	# Bayrağı oyuncu kamerasına devret
	player_camera.make_current()
	player_camera.set_process(true)
	# Bir Timer oluştur ve bağla
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = tick_interval
	timer.autostart = true
	timer.timeout.connect(_on_tick_timeout)
	timer.start()
	

	
	# Oyuncunun hareket script'ini burada aktif edebilirsin
func _on_tick_timeout():
	current_tick += 1
	print("Yeni Tick: ", current_tick)
	apply_tick_mechanics()
	tick_changed.emit(current_tick)
	kaynak_guncelle()
func apply_tick_mechanics():
	# Belirli tick sayılarında farklı olaylar tetikle
		match current_tick % 4:
			0:print("event")
		
			1:print("event")
		
			2:print("event")
		
			3:print("event")

signal tick_changed(new_tick_value)
func kaynak_guncelle():
	kaynaklar["para"] += gelir_oranlari["para"]
	kaynaklar["yemek"] += gelir_oranlari["yemek"]
	kaynaklar["moral"] += gelir_oranlari["moral"]
