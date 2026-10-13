extends Node

@export var Player: RigidBody2D
@export var PlayerSprite: Sprite2D
@export var EolTrigger: Area2D
@export var textChat: RichTextLabel
@export var playerRay: RayCast2D

var isTyping = false
var finishedMessage = ""
var currentMessage = ""
var messageChar = 0
var airJumped = false

func _input(event):
	if event.is_action_pressed("jump"):
		var myForce: Vector2
		myForce.x = 0;
		myForce.y = -500;
		#Player.apply_force(myForce)
		if isTouchingFloor():
			Player.apply_impulse(myForce);
			print("Jumped!")
		else:
			if !airJumped:
				myForce.y = -5000
				Player.apply_impulse(myForce);
				airJumped = true
	if event.is_action_pressed("left"):
		var myForce: Vector2
		myForce.x = -200;
		myForce.y = 0;
		#Player.apply_force(myForce)
		if isTouchingFloor():
			Player.apply_impulse(myForce);
	if event.is_action_pressed("right"):
		var myForce: Vector2
		myForce.x = 200;
		myForce.y = 0;
		#Player.apply_force(myForce)
		if isTouchingFloor():
			Player.apply_impulse(myForce);
		
		
		

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setMessage("Y'know, that might have been a bit too hard, so i gave you a double jump!")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	PlayerSprite.global_position = Player.global_position
	typeChat()
	if (isTouchingFloor() and (airJumped == true)):
		airJumped = false
#called when the player touches the end of level trigger
func _on_area_2d_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	print("EOL trigger touched")
	setMessage("Nice job!")
	await get_tree().create_timer(0.5).timeout
	print("next level")

func typeChat():
	if !(finishedMessage == currentMessage):
		textChat.text = currentMessage + finishedMessage[messageChar]
		messageChar+=1
		currentMessage = textChat.text
	else:
		messageChar = 0
		
func setMessage(message: String):
	textChat.text = ""
	currentMessage = ""
	finishedMessage = message
	messageChar = 0

func isTouchingFloor() -> bool:
	return playerRay.is_colliding()
