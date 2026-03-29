extends TextureRect

# Geri butonundan UI'a ulaşmak için:
@onready var ana_ui = $"../../UI" 

# Geri butonunun hemen bir üstündeki HaritaEkrani:
@onready var harita_ekrani = $".." 

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		harita_ekrani.hide()
		ana_ui.show()
		accept_event()
