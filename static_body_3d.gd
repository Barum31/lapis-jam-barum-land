extends StaticBody3D

var tum_parcalar = []
var secili_mi = false

func _ready():
	add_to_group("binalar")
	# Mesh parçalarını bulmak için derin tarama
	_derin_tarama(get_parent())
	# Main düğümünü bul ve sinyale bağlan
	# Main düğümünü bul ve sinyale bağlan
	var main_node = get_tree().root.get_node("main")
	

func _derin_tarama(dugum):
	if dugum is MeshInstance3D:
		tum_parcalar.append(dugum)
	for child in dugum.get_children():
		_derin_tarama(child)

# _input yerine _unhandled_input daha sağlıklıdır (UI tıklamalarını ayırır)
func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var ray_sonucu = _get_raycast_hit()
		
		# 1. Bir şeye çarptı mı?
		if ray_sonucu and not ray_sonucu.is_empty():
			var çarpan_obje = ray_sonucu.get("collider")
			
			# 2. Çarpan obje BU bina mı?
			if çarpan_obje == self:
				# Tıklamayı burada bitir, arkaya sızmasın
				get_viewport().set_input_as_handled()
				
				if secili_mi:
					sondur()
				else:
					# Diğerlerini söndür, bunu yak
					get_tree().call_group("binalar", "sondur")
					parlat()
			
			# 3. Başka bir binaya mı tıklandı? (Bu bina seçiliyse söndür)
			elif çarpan_obje and çarpan_obje.is_in_group("binalar"):
				if secili_mi:
					sondur()
		
		# 4. Boşluğa tıklandıysa ve bu bina seçiliyse söndür
		else:
			if secili_mi:
				sondur()

func _get_raycast_hit():
	var mouse_pos = get_viewport().get_mouse_position()
	var camera = get_viewport().get_camera_3d()
	if not camera: return {} # null yerine boş sözlük dönmek daha güvenli
	
	var ray_origin = camera.project_ray_origin(mouse_pos)
	var ray_end = ray_origin + camera.project_ray_normal(mouse_pos) * 2000
	var query = PhysicsRayQueryParameters3D.create(ray_origin, ray_end)
	
	# Raycast'in kendisini (StaticBody) görmezden gelmesini engellemek için:
	query.collide_with_bodies = true
	
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
					yeni_mat.emission_energy_multiplier = 0.15 
					yeni_mat.rim_enabled = true
					yeni_mat.rim = 0.2

func sondur():
	secili_mi = false
	for parca in tum_parcalar:
		if parca.mesh:
			for i in parca.mesh.get_surface_count():
				parca.set_surface_override_material(i, null)
func _on_game_tick_updated(value):
	print("!")
	
	
