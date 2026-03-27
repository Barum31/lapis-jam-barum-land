extends StaticBody3D

# Materyali kodla kontrol etmek için değişken
var material: StandardMaterial3D

func _ready():
	# Binanın görselindeki materyali alıyoruz (0. indexteki materyal)
	# MeshInstance3D'nin adının "MeshInstance3D" olduğundan emin ol
	material = $MeshInstance3D.get_active_material(0)
	
	# Eğer materyal yoksa yeni bir tane oluştur (Hata almamak için)
	if not material:
		material = StandardMaterial3D.new()
		$MeshInstance3D.set_surface_override_material(0, material)

func _input_event(camera, event, position, normal, shape_idx):
	# Fare ile sol tık yapıldı mı kontrolü
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		parlat()

func parlat():
	# 3D'de parlama "Emission" (Işıma) ile yapılır
	material.emission_enabled = true
	material.emission = Color(1, 1, 1) # Beyaz ışık
	material.emission_energy_multiplier = 5.0 # Parlaklık gücü
	
	# 0.2 saniye sonra söndür
	var tween = create_tween()
	tween.tween_property(material, "emission_energy_multiplier", 0.0, 0.2)
