class_name EventChoice
extends Resource

@export var choice_text: String = ""
@export var outcome_id: String = ""

@export_group("Kaynak Bedelleri")
@export var ev_para: int = 0  # para
@export var ev_odun: int = 0  # odun
@export var ev_yemek: int = 0  # yemek
@export var ev_metal: int = 0  # metal
@export_group("İliski Bedelleri")
@export var ev_iliski_z: int = 0  # ilişki zumre
@export var ev_iliski_k: int =0 #	ilişki kasim
@export var ev_iliski_pdak: int =0 #iliski dıs1
@export var ev_iliski_yu: int=0		#iliski dıs2
@export var ev_iliski_gat: int=0	#iliski dıs3
@export var ev_iliski_uy: int=0		#iliski dıs4
@export var ev_iliski_uh: int=0		#iliski dıs5
@export var ev_iliski_ec: int=0		#iliski dıs6
