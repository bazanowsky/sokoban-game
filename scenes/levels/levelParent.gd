extends Node2D
class_name LevelParent

var completed: bool = false
@export var next_level: PackedScene
@onready var crates = $Crates.get_tree().get_nodes_in_group('crates')
var spots: Array[Node]

# Called when the node enters the scene tree for the first time.
func _ready():
	spots = $Spots.get_tree().get_nodes_in_group('spots')
	for spot in spots:
		if spot is Spot:
			spot.crate_entered.connect(_on_crate_spot_entered)
			spot.crate_exited.connect(_on_crate_spot_exited)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var spots_count = len(spots);
	var active_crates_count: int = 0
	for crate in crates:
		if crate.activated:
			active_crates_count += 1
	
	if active_crates_count == spots_count:
		complete_level()
	

func _on_crate_spot_entered(crate: Crate):
	crate.activate();
	
func _on_crate_spot_exited(crate: Crate):
	crate.deactivate();

func complete_level():
	if not completed:
		completed = true
		if next_level:
			print('Level completed!')
			get_tree().change_scene_to_packed(next_level)
		else:
			print('Game completed!')
