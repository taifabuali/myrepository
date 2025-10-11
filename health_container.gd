extends HBoxContainer

@export var apple_full: Texture2D
@export var apple_empty: Texture2D

var player: Node = null

func _ready() -> void:
	await get_tree().process_frame
	var players = get_tree().get_nodes_in_group("Player")
	if players.size() > 0:
		player = players[0]
		player.connect("health_changed", Callable(self, "_on_health_changed"))

	# Initialize display
	if player:
		_on_health_changed(player.health, player.max_health)


func _on_health_changed(current_health: int, max_health: int) -> void:
	# Clear old icons
	for child in get_children():
		child.queue_free()

	# Add icons for each health slot
	for i in range(max_health):
		var icon = TextureRect.new()
		icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		icon.custom_minimum_size = Vector2(32, 32)  # size of apple

		if i < current_health:
			icon.texture = apple_full
		else:
			icon.texture = apple_empty

		add_child(icon)
