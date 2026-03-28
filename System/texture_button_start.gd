extends TextureButton


func _on_start_button_pressed():
	# Menüyü hemen gizliyoruz
	self.hide() 
	
	# Animasyonu ismini yazarak başlatıyoruz
	# Not: $ işareti ile AnimationPlayer'ın adını doğru yazdığından emin ol
	get_node("AnimationPlayer").play("Zoom_Efekti")
