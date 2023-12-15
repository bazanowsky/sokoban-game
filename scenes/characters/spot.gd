extends Area2D
class_name Spot

signal crate_entered(body: Crate)
signal crate_exited(body: Crate)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_body_entered(body):
	if body is Crate:
		crate_entered.emit(body);


func _on_body_exited(body):
	if body is Crate:
		crate_exited.emit(body);
