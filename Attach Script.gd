extends Control 

func _ready():
	visible = false 
	add_to_group("degerli_panel")

func panel_ac_kapat():
	# Panel görünürlüğünü tersine çevir
	visible = !visible
	print("Panel Görünürlüğü: ", visible)
	
	# Arka plandaki UI'ı dondurma/açma
	var ana_ui = get_tree().root.find_child("UI", true, false)
	if ana_ui:
		if visible:
			ana_ui.mouse_filter = Control.MOUSE_FILTER_IGNORE
		else:
			ana_ui.mouse_filter = Control.MOUSE_FILTER_STOP

# Kapat butonuna tıklandığında (Sinyal buna bağlı olmalı!)
func _on_kapat_buton_pressed():
	print("Kapat butonuna basıldı, panel gizleniyor.")
	visible = false
	# Arka planı tekrar tıklanabilir yap
	var ana_ui = get_tree().root.find_child("UI", true, false)
	if ana_ui:
		ana_ui.mouse_filter = Control.MOUSE_FILTER_STOP
