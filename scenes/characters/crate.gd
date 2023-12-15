extends AnimatableBody2D
class_name Crate

var moving = false;
var activated = false;
var can_move = true;
var can_move_up: bool = true
var can_move_right: bool = true
var can_move_down: bool = true
var can_move_left: bool = true
@export var MOVEMENT_DURATION = 0.3
@export var ACTIVATION_DURATION = 0.
var movement_distance = 64

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	can_move_up = not $RayCastUp.is_colliding()
	can_move_right = not $RayCastRight.is_colliding()
	can_move_down = not $RayCastDown.is_colliding()
	can_move_left = not $RayCastLeft.is_colliding()

func activate():
	activated = true;
	$AnimationPlayer.set_speed_scale(1)
	$AnimationPlayer.play('activate');

func deactivate():
	activated = false;
	$AnimationPlayer.set_speed_scale(2)
	$AnimationPlayer.play_backwards('activate');

func move(direction: Vector2):
	if not moving and direction:
		var position_tween = create_tween()
		position_tween.tween_property(self, 'position', position + (direction * movement_distance), MOVEMENT_DURATION).set_trans(Tween.TRANS_CUBIC)
		moving = true
		await position_tween.finished
		moving = false
