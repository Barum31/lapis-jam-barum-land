# EventManager.gd (Event Node'una bağlı)
extends Control

@onready var main_script = get_tree().root.get_parent()

func _on_option_selected(data: GameEvent):
	# Resource içindeki değerleri al (Örn: {"para": -50, "moral": 10})
	var effects = {
		"para": data.para_etkisi,
		"yemek": data.yemek_etkisi,
		"moral": data.moral_etkisi,
		"metal":data.metal_etkisi,
		"nufus":data.nufus_etkisi,
		"ahsap":data.ahsap_etkisi
		
	}
	
	# Main scriptindeki fonksiyonu tetikle
	main_script.apply_event_effects(effects)
	
	# Paneli kapat
	self.hide()
