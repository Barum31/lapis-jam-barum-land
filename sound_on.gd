extends TextureRect

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		# Sesi Kapat (Mute yap)
		AudioServer.set_bus_mute(0, true)
		
		# Kendini (mavi hoparlörü) gizle, kırmızı hoparlörü göster
		hide()
		$"../SoundOff".show()
		
		accept_event()
