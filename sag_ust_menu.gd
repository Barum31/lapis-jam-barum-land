extends TextureRect

# Aşağıdaki satırı Godot kendi yazmış olacak (yol farklı olabilir, Godot'ya güven)
@onready var menu_container = $MenuContainer 

func _ready():
	# Oyun başlarken çantayı gizle
	menu_container.hide()

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		# Çantayı aç/kapat
		menu_container.visible = !menu_container.visible
		accept_event()
