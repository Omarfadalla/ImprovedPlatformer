extends CanvasLayer

@onready var kill_label: Label = $MarginContainer/KillLabel
@onready var health_bar: ProgressBar = $MarginContainer2/HealthBar
@onready var result_label: Label = $ResultLabel

var total_drones := 0
var drones_killed := 0
var game_over := false

func _ready() -> void:
	result_label.hide()
	call_deferred("_setup")

func _setup() -> void:
	# Grab every drone already present in the scene at start.
	var drones = get_tree().get_nodes_in_group("Drones")
	total_drones = drones.size()
	_update_kill_label()

	if total_drones == 0:
		push_warning("HUD: no nodes found in group 'Drones' - make sure your drone script adds itself with add_to_group(\"Drones\")")

	for drone in drones:
		if drone.has_signal("died"):
			drone.died.connect(_on_drone_died)
		else:
			push_warning("HUD: drone %s has no 'died' signal" % drone.name)

	# Find the player and hook into its death + health signals.
	var player = get_tree().get_first_node_in_group("Player")
	if player:
		if player.has_signal("died"):
			player.died.connect(_on_player_died)
		else:
			push_warning("HUD: player has no 'died' signal")

		if player.has_signal("health_changed"):
			player.health_changed.connect(_on_player_health_changed)

		if "health" in player and "max_health" in player:
			_on_player_health_changed(player.health, player.max_health)
	else:
		push_warning("HUD: no node in group 'Player' found - make sure your player script adds itself with add_to_group(\"Player\")")

func _on_drone_died() -> void:
	if game_over:
		return
	drones_killed += 1
	_update_kill_label()
	if drones_killed >= total_drones:
		_win()

func _on_player_died() -> void:
	if game_over:
		return
	_lose()

func _on_player_health_changed(current: int, max_h: int) -> void:
	health_bar.max_value = max_h
	health_bar.value = current

func _update_kill_label() -> void:
	kill_label.text = "Drones killed: %d / %d" % [drones_killed, total_drones]

func _win() -> void:
	game_over = true
	result_label.text = "YOU WIN"
	result_label.show()
	get_tree().paused = true

func _lose() -> void:
	game_over = true
	result_label.text = "YOU LOSE"
	result_label.show()
	get_tree().paused = true
