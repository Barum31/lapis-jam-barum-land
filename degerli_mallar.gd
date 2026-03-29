extends TextureRect # Button yerine TextureRect yaptık

func _gui_input(event):
	# TextureRect'te tıklamayı algılamak için bu fonksiyon kullanılır
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_on_pressed()

func _on_pressed():
	print("DEĞERLİ MALLAR PANELİ AÇILIYOR...")
