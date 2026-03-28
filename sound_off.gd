extends TextureRect

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		# Sesi Aç (Mute'u kaldır)
		AudioServer.set_bus_mute(0, false)
		
		# Kendini (kırmızı hoparlörü) gizle, mavi hoparlörü göster
		hide()
		$"../SoundOn".show()
		
		accept_event()
