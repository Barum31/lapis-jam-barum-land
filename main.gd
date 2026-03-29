extends Node
var current_tick = 0
@export var tick_interval = 5.0
@onready var menu_camera = $OyunArayuzu/MainMenu/MenuCamera
@onready var player_camera = $CameraPivot/CameraGimbal/PlayerCamera
@onready var animation_player = $OyunArayuzu/MainMenu/AnimationPlayer
@onready var main_menu = $OyunArayuzu/MainMenu
@onready var paraL = $"OyunArayuzu/UI/ÜstMenü/Para"
@onready var ahsapL = $"OyunArayuzu/UI/ÜstMenü/Ahşap"
@onready var yemekL = $"OyunArayuzu/UI/ÜstMenü/Yemek"
@onready var metalL = $"OyunArayuzu/UI/ÜstMenü/Metal"
@onready var moralL = $"OyunArayuzu/UI/ÜstMenü/Moral"
@onready var nufusL = $"OyunArayuzu/UI/ÜstMenü/Nufus"
@onready var ui =$OyunArayuzu/UI
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
	ui.hide()
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
	timer.one_shot = false # Tek seferlik olmasın
	timer.autostart = true
	timer.timeout.connect(_on_tick_timeout)
	timer.start()
	print("2. Timer baslatildi, bekleme suresi: ", tick_interval)
	ui.show()

	get_node("CameraPivot/CameraGimbal/PlayerCamera").make_current()
	
func ui_guncelle():
	paraL.text =  str(kaynaklar["para"])
	yemekL.text =  str(kaynaklar["yemek"])
	moralL.text =   str(kaynaklar["moral"])
	nufusL.text =  str(kaynaklar["nufus"])
	metalL.text = str(kaynaklar["metal"])
	ahsapL.text = str(kaynaklar["ahsap"])
	if kaynaklar["moral"] < 20:
		moralL.add_theme_color_override("font_color", Color.RED)
	else:
		moralL.add_theme_color_override("font_color", Color.WHITE)
	print("ananına koyayım")
	
	
	# Oyuncunun hareket script'ini burada aktif edebilirsin
func _on_tick_timeout():
	print("3. TICK TETIKLENDI!") # Bu gelmiyorsa sorun Timer'dadır.
	current_tick += 1
	kaynak_guncelle()
	ui_guncelle()
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
func _on_tick():
	# Kaynak artış/azalış mantığı
	kaynaklar["para"] += 10          # Her tick +10 para
	kaynaklar["yemek"] -= 2          # Nüfus yemek tüketiyor
	if kaynaklar["yemek"] <= 0:
		kaynaklar["yemek"] = 0
		kaynaklar["moral"] -= 5      # Açlık moral bozuyor
	
	# Hesaplama bittikten sonra görseli güncelle
func _on_texture_button_start_pressed() -> void:
	get_node("OyunArayuzu/MainMenu").hide()
	
	
	animation_player.play("MenuZoom")
