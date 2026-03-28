extends Node3D

func _ready():
	# Sahne altındaki tüm StaticBody3D düğümlerini bul ve gruba ekle
	for child in get_children():
		recursive_group_adder(child)

func recursive_group_adder(node):
	if node is StaticBody3D:
		node.add_to_group("building")
		print("Gruba eklendi: ", node.name)
	
	# Eğer alt düğümleri varsa onları da kontrol et
	for child in node.get_children():
		recursive_group_adder(child)
