extends StaticBody3D

# StaticBody3D, mühendislik düğümünün alt elemanı olduğu için
# get_parent() fonksiyonu bize direkt 'mühendislik' (görsel) düğümünü verir.
@onready var bina_mesh = get_parent()

func _input_event(_camera, event, _position, _normal, _shape_idx):
	# Fare sol tık kontrolü
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		parlama_yap()

func parlama_yap():
	# Binanın ana materyalini alıyoruz
	var mat = bina_mesh.get_active_material(0)
	
	if mat:
		# Sadece bu binayı etkilemek için materyali kopyalıyoruz
		var yeni_mat = mat.duplicate()
		bina_mesh.set_surface_override_material(0, yeni_mat)
		
		# Parlama (Emission) ayarları
		yeni_mat.emission_enabled = true
		yeni_mat.emission = Color(1, 1, 1) # Beyaz parlama
		yeni_mat.emission_energy_multiplier = 15.0 # Parlama gücü
		
		# 0.4 saniye içinde sönme efekti (Tween)
		var tween = create_tween()
		tween.tween_property(yeni_mat, "emission_energy_multiplier", 0.0, 0.4)
