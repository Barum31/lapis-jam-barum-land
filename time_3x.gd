extends TextureRect

@onready var zaman_yoneticisi = $".."

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		zaman_yoneticisi.hiz_ayarla(2.0) # 4 kat hız (3x butonları genelde 4 kat hızlı yapar)
		accept_event()
