extends TextureRect

@onready var zaman_yoneticisi = $".."

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		zaman_yoneticisi.hiz_ayarla(4.0) # 2 kat hız
		accept_event()
