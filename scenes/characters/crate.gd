extends StaticBody2D
class_name Crate

var moving = false;
var can_move = true;
var can_move_up: bool = true
var can_move_right: bool = true
var can_move_down: bool = true
var can_move_left: bool = true
@export var MOVEMENT_DURATION = 0.3
var movement_distance = 64

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	can_move_up = not $RayCastUp.is_colliding()
	can_move_right = not $RayCastRight.is_colliding()
	can_move_down = not $RayCastDown.is_colliding()
	can_move_left = not $RayCastLeft.is_colliding()

func move(direction: Vector2):
	if not moving and direction:
		var position_tween = create_tween()
		position_tween.tween_property(self, 'position', position + (direction * movement_distance), MOVEMENT_DURATION).set_trans(Tween.TRANS_CUBIC)
		moving = true
		await position_tween.finished
		moving = false
