extends CharacterBody2D


@export var MOVEMENT_DURATION = 0.2

var moving = false
var movement_distance = 64;

func move(direction):
	# rotate animation
	if direction:
		$Sprite2D.rotation_degrees = rad_to_deg(direction.angle()) + 90
		$AnimationPlayer.play('move_animation')	
	elif not moving:
		$AnimationPlayer.stop()
		
	
	if not moving and direction:
		var position_tween = create_tween();
		position_tween.tween_property(self, 'position', position + (direction * movement_distance), MOVEMENT_DURATION)
		moving = true;
		await position_tween.finished
		moving = false
	

func _process(_delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction: Vector2
	var h_direction = 0
	var v_direction = 0
	
	# don't move if left and right are pressed at the same time (h_direction will be set to 0)
	h_direction = int(Input.is_action_pressed('move_right')) - int(Input.is_action_pressed('move_left'))
	# don't move if up and down are pressed at the same time (v_direction will be set to 0)
	v_direction = int(Input.is_action_pressed('move_down')) - int(Input.is_action_pressed('move_top'))
	
	
	# don't move if a "horizontal" and a "vertical" key is pressed
	if not moving and (not h_direction or not v_direction):
		if h_direction:
			direction = Vector2(h_direction, 0)
		else:
			direction = Vector2(0, v_direction)
	
	move(direction);
	
	

