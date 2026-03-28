extends TextureRect

func _gui_input(event):
	# Farenin sol tıkına basıldığında çalışır
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		
		# Assetler gelene kadar sadece konsola yazı yazdırıp test edeceğiz
		print("Harita menüsü açılıyor... (Assetler bekleniyor!)")
		
		# İleride harita sahnesi geldiğinde buraya şu tarz bir kod yazacağız:
		# get_tree().change_scene_to_file("res://harita_sahnesi.tscn") 
		# Veya aynı sahnede açılacaksa: $GelecekHaritaPaneli.show()
		
		# Tıklamanın arkadaki 3D dünyaya geçmesini engelle
		accept_event()
