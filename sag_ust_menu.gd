extends TextureRect

# Aşağıdaki satırı Godot kendi yazmış olacak (yol farklı olabilir, Godot'ya güven)
@onready var menu_container = $MenuContainer 

func _ready():
	# (Eğer _ready içinde yazdığın başka şeyler varsa onlar kalsın, altına şunları ekle:)
	
	# Fare üzerine gelince ve gidince çalışacak sinyalleri koda bağlıyoruz
	mouse_entered.connect(_fare_uzerinde)
	mouse_exited.connect(_fare_gitti)

# --- YENİ EKLENEN FONKSİYONLAR ---

func _fare_uzerinde():
	# Renk çarpanını artırarak objeye beyaz/parlak bir "glow" (ışıltı) efekti veriyoruz.
	# Buradaki 1.5 değerlerini zevkine göre 1.2 veya 2.0 yapabilirsin.
	modulate = Color(1.5, 1.5, 1.5) 

func _fare_gitti():
	# Fare çekilince rengi orijinal (normal) haline döndür
	modulate = Color(1.0, 1.0, 1.0) 

# ... (Alttaki _gui_input tıklama fonksiyonun aynen kalsın) ...

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		# Çantayı aç/kapat
		menu_container.visible = !menu_container.visible
		accept_event()
