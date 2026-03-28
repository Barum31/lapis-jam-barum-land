extends StaticBody3D

var tum_parcalar = []
var secili_mi = false

func _ready():
	add_to_group("binalar")
	# Mesh parçalarını bul
	_derin_tarama(get_parent())

func _derin_tarama(dugum):
	if dugum is MeshInstance3D:
		tum_parcalar.append(dugum)
	for child in dugum.get_children():
		_derin_tarama(child)

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var ray_sonucu = _get_raycast_hit()
		
		# Önce ray_sonucu boş mu değil mi (bir şeye çarptı mı) diye bakıyoruz
		if ray_sonucu and not ray_sonucu.is_empty():
			# Bir şeye çarptı, şimdi çarptığı şey bu bina mı diye bakıyoruz
			if ray_sonucu.collider == self:
				get_viewport().set_input_as_handled()
				if secili_mi:
					sondur()
				else:
					get_tree().call_group("binalar", "sondur")
					parlat()
			# Başka bir binaya mı çarptı?
			elif ray_sonucu.collider.is_in_group("binalar"):
				if secili_mi:
					sondur()
		else:
			# Hiçbir şeye çarpmadı (gökyüzüne veya boşluğa tıklandı)
			if secili_mi:
				sondur()

# Farenin altındaki objeyi bulan fonksiyon
func _get_raycast_hit():
	var mouse_pos = get_viewport().get_mouse_position()
	var camera = get_viewport().get_camera_3d()
	if not camera: return null
	
	var ray_origin = camera.project_ray_origin(mouse_pos)
	var ray_end = ray_origin + camera.project_ray_normal(mouse_pos) * 2000
	var query = PhysicsRayQueryParameters3D.create(ray_origin, ray_end)
	
	var space_state = get_world_3d().direct_space_state
	return space_state.intersect_ray(query)

func parlat():
	secili_mi = true
	for parca in tum_parcalar:
		if parca.mesh:
			for i in parca.mesh.get_surface_count():
				var mat = parca.get_active_material(i)
				if mat:
					var yeni_mat = mat.duplicate()
					parca.set_surface_override_material(i, yeni_mat)
					yeni_mat.emission_enabled = true
					yeni_mat.emission = Color(1, 1, 1)
					yeni_mat.emission_energy_multiplier = 0.15 # Hafif beyaz
					yeni_mat.rim_enabled = true

func sondur():
	secili_mi = false
	for parca in tum_parcalar:
		if parca.mesh:
			for i in parca.mesh.get_surface_count():
				parca.set_surface_override_material(i, null)
