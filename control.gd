extends TextureRect # Tipin neyse o kalabilir

# Control2 düğümüne ulaşmak için yolu belirtiyoruz
@onready var alt_panel = $Control2 

func _gui_input(event):
	# Fareyle üzerine tıklandığını kontrol et
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		# Şu anki görünürlük durumunun tersini yap (Açıksa kapat, kapalıysa aç)
		alt_panel.visible = !alt_panel.visible
		
		# Tıklama olayının arkadaki objelere gitmesini engelle
		accept_event()
