extends TextureRect

@onready var ses_acik = $SoundOn
@onready var ses_kapali = $SoundOff

func _ready():
	# Oyun başlarken ses ikonları gizli olsun, sadece çark görünsün
	ses_acik.hide()
	ses_kapali.hide()

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		# Ses ikonları şu an ekranda açık mı?
		var ikonlar_gorunuyor_mu = ses_acik.visible or ses_kapali.visible
		
		if ikonlar_gorunuyor_mu:
			# Eğer ekrandalarsa onları gizle
			ses_acik.hide()
			ses_kapali.hide()
		else:
			# Eğer gizlilerse, oyunun o anki ses durumunu kontrol et
			var ses_kapatilmis_mi = AudioServer.is_bus_mute(0)
			
			# Doğru ikonu göster
			ses_kapali.visible = ses_kapatilmis_mi
			ses_acik.visible = !ses_kapatilmis_mi
			
		accept_event()
