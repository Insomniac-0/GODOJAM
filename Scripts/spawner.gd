extends Node3D
@onready var spawnTimer: Timer = $SpawnDelay
@onready var enemy_count_text: Label = $CanvasLayer/EnemyCountText


@export var enemyRef : PackedScene
var spawnPoints : Array[Vector3]

var totalEnemiesKilled : int = 0
var enemyCount : int = 0
var enemiesKilled : int = 0
@export var maxEnemies : int = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for spawnpoint in get_children(false):
		if (spawnpoint.is_in_group("SpawnPoints")): 
			spawnPoints.append(spawnpoint.global_position)
	print(spawnPoints)
	
	spawnTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	enemy_count_text.text = str(totalEnemiesKilled)


func _on_spawn_delay_timeout() -> void:
	if (enemyCount < maxEnemies):
		spawnEnemy()
		enemyCount += 1
	elif (enemiesKilled >= maxEnemies):
		enemyCount = 0
		enemiesKilled = 0
	
	spawnTimer.start()

func spawnEnemy() -> void:
	print("spawned new enemy")
	var enemy : Enemy = enemyRef.instantiate()
	add_child(enemy)
	enemy.global_position = spawnPoints[randi_range(0,spawnPoints.size()-1)]
	enemy.death.connect(enemyDead)

func enemyDead(enemy : Enemy) -> void:
	enemy.queue_free()
	enemiesKilled += 1
	totalEnemiesKilled += 1
