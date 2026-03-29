extends Control

#label eksik !!!
@onready var label_baslık = $TitleLabel
@onready var label_desc = $DescLabel
@onready var secenekler: Array[Button] = [$secenek1, $secenek2, $secenek3, $secenek4]

# Inspector'dan sürükleyip bırakacağımız o anki olay dosyası (.tres)
@export var current_event: GameEvent

# Oyuncunun cebindeki mevcut kaynaklar (Test için şimdilik buraya yazıyoruz)
var ev_para: int = 100 # Altın
var ev_odun: int = 50  # Odun
var ev_yemek: int = 10  # Erzak
var ev_demir: int = 5   # Demir
var ev_iliski_z: int = 0   # zümre
var ev_iliski_k: int = 0   # zümre
var ev_iliski_pdak: int = 0   # zümre
var ev_iliski_yu: int = 0   # zümre
var ev_iliski_gat: int = 0   # zümre
var ev_iliski_uy: int = 0   # zümre
var ev_iliski_uh: int = 0   # zümre
var ev_iliski_ec: int = 0   # zümre

# --- çağırma fonksiyonu boş!!! ---
func _ready():
	if current_event:
		load_event(current_event)


# --- 4. İŞTE BAHSETTİĞİMİZ O FONKSİYON (BİZ YARATIYORUZ) ---
# Bu fonksiyon, içine verdiğimiz olayın (event'in) bilgilerini alıp ekrana basar.
func load_event(event: GameEvent):
	# Başlığı ve hikayeyi Labellara yazdır
	title_label.text = event.event_title
	desc_label.text = event.event_description
	
	# 4 Butonu sırayla dolaş ve ayarla
	for i in range(4):
		# Eğer bu buton için bir seçenek (EventChoice) oluşturulmamışsa butonu gizle
		if i >= event.choices.size() or event.choices[i] == null or event.choices[i].choice_text == "":
			secenekler[i].hide()
			continue 
			
		# Seçenek var, butonu göster ve metnini yaz
		var choice = event.choices[i]
		secenekler[i].show()
		secenekler[i].text = choice.choice_text
		
		# --- KAYNAK KONTROLÜ ---
		var can_afford: bool = true
		var eksik_kaynaklar = ""
		
		# Parası yetmiyor mu diye tek tek bakıyoruz
		if ev_para < choice.cost_res_1: 
			can_afford = false
			eksik_kaynaklar += " Altın,"
		if ev_odun < choice.cost_res_2: 
			can_afford = false
			eksik_kaynaklar += " Odun,"
		if ev_yemek < choice.cost_res_3: 
			can_afford = false
			eksik_kaynaklar += " Erzak,"
		if ev_demir < choice.cost_res_4: 
			can_afford = false
			eksik_kaynaklar += " Demir,"
			
		# Tüm kontroller bittikten sonra butonu kilitle veya aç
		if can_afford:
			secenekler[i].disabled = false # Parası yetiyor, tıklanabilir.
		else:
			secenekler[i].disabled = true  # PARASI YETMİYOR, KİLİTLE.
			# Sondaki fazla virgülü sil ve oyuncuya uyarıyı göster
			eksik_kaynaklar = eksik_kaynaklar.trim_suffix(",")
			secenekler[i].text += " (Yetersiz:" + eksik_kaynaklar + ")"
