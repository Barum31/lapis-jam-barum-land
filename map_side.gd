extends TextureRect

# Artık % işareti sayesinde Godot bu düğümleri nerede olurlarsa olsunlar şak diye bulacak!
@onready var ana_ui = %UI
@onready var harita_ekrani = %HaritaEkrani

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		ana_ui.hide() 
		harita_ekrani.show() 
		accept_event()
