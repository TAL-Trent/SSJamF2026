extends Node

@export var Player: RigidBody2D
@export var PlayerSprite: Sprite2D

func _input(event):
	if event.is_action_pressed("jump"):
		var myForce: Vector2
		myForce.x = 0;
		myForce.y = -500;
		#Player.apply_force(myForce)
		Player.apply_impulse(myForce);
		print("Jumped!")
	if event.is_action_pressed("left"):
		var myForce: Vector2
		myForce.x = -200;
		myForce.y = 0;
		#Player.apply_force(myForce)
		Player.apply_impulse(myForce);
	if event.is_action_pressed("right"):
		var myForce: Vector2
		myForce.x = 200;
		myForce.y = 0;
		#Player.apply_force(myForce)
		Player.apply_impulse(myForce);
		
		
		

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
