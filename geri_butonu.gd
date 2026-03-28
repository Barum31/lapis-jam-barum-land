extends TextureRect

@onready var ana_ui = %UI
@onready var harita_ekrani = %HaritaEkrani

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		harita_ekrani.hide()
		ana_ui.show()
		accept_event()
