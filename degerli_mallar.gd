extends Control 

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_on_pressed()

func _on_pressed():
	print("Sinyal Gönderiliyor...")
	# Gruba dahil olan her şeye bu fonksiyonu çalıştır diyoruz
	get_tree().call_group("degerli_panel", "panel_ac_kapat")
