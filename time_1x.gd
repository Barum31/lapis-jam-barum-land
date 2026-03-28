extends TextureRect

@onready var zaman_yoneticisi = $".." # Bir üstteki düğümü (Manager) seç

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		zaman_yoneticisi.hiz_ayarla(1.0) # Normal hız
		accept_event()
