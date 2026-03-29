extends Control

# Butonlara tıklandığında dışarıdan çağrılacak fonksiyon
func hiz_ayarla(carpan):
	Engine.time_scale = carpan
	print("Oyun hızı şu an: ", carpan, "x")
