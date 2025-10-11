extends Node

var coins: int = 0
var diamonds: int = 0
var score: int = 0

@export var required_coins: int = 10
@export var required_diamonds: int = 3
@onready var player = $"../player2"

@onready var coin_label: Label = $"../CanvasLayer/Coin Lable"
@onready var diamond_label: Label = $"../CanvasLayer/Daimond Lable"
@onready var score_label: Label = $"../CanvasLayer/Score Lable3"
@onready var win_label: Label =  $"../CanvasLayer/Win Label" 
@onready var start_message: Label = $"../CanvasLayer/StartMessage"

func _ready() -> void:
	_update_ui()
	
	win_label.visible = false 
	
	start_message.text = "Collect %d coins and %d diamonds to win!" % [required_coins, required_diamonds]
	start_message.visible = true

	await get_tree().create_timer(3.0).timeout
	start_message.visible = false
	
	for collectible in get_tree().get_nodes_in_group("collectibles"):
		collectible.connect("collected", Callable(self, "_on_collectible_collected"))
	
	player.connect("player_died", Callable(self, "_on_player_died"))


func _on_player_died():
	print("Player died. Respawning...")
	player.respawn()
	reset_Collectables()
	
func reset_Collectables() -> void:
	coins = 0
	diamonds =0
	score = 0
	_update_ui()
	

func _on_collectible_collected(collectible_type: String, value: int) -> void:
	if collectible_type == "coin":
		coins += value
		score += value
	elif collectible_type == "diamond":
		diamonds += value
		score += value * 5 

	_update_ui()
	_check_win_condition()


func _check_win_condition() -> void:
	if coins >= required_coins and diamonds >= required_diamonds:
		print("YOU WIN")
		win_label.text = "YOU WIN"
		win_label.visible = true
		get_tree().paused = true  


func _update_ui() -> void:
	if coin_label:
		coin_label.text = "Coins: %d / %d" % [coins, required_coins]
	if diamond_label:
		diamond_label.text = "Diamonds: %d / %d" % [diamonds, required_diamonds]
	if score_label:
		score_label.text = "Score: %d" % score
