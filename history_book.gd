extends TextureRect

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("Kitap sahnene ileride buradan geçiş yapacağız!")
		accept_event()
