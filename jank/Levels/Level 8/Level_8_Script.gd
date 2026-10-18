extends Node

@export var Player: RigidBody2D
@export var PlayerSprite: Polygon2D
@export var EolTrigger: Area2D
@export var textChat: RichTextLabel
@export var playerRay: RayCast2D
@export var brokenBall: RigidBody2D
@export var key: RigidBody2D

var isTyping = false
var finishedMessage = ""
var currentMessage = ""
var messageChar = 0
var airJumped = false
var skewing = false
var timesBroken = 0
var hasKey = false
var keyed = false

func _input(event):
	if event.is_action_pressed("jump"):
		var myForce: Vector2
		myForce.x = 0;
		myForce.y = -500;
		#Player.apply_force(myForce)
		if isTouchingFloor():
			Player.apply_impulse(myForce);
		else:
			if !airJumped:
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
	if event.is_action_pressed("reset"):
		get_tree().reload_current_scene()

		
		

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setMessage("Thank you for playing my game, despite how janky it is! Just touch the orange to go back to the main menu")
	await get_tree().create_timer(3).timeout
	setMessage("Please dont touch the sphere.")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	PlayerSprite.global_position = Player.global_position
	typeChat()
	if (isTouchingFloor() and (airJumped == true)):
		airJumped = false
	if skewing:
		brokenBall.skew = randi_range(-89,89)
		brokenBall.position.x += randi_range(-1,1)
		brokenBall.position.y += randi_range(-1,1)
			
#called when the player touches the end of level trigger
func _on_area_2d_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	print("EOL trigger touched")
	if (timesBroken < 2):
		setMessage("Thank you!")
	elif (timesBroken == 2):
		setMessage("Thanks.")
	else:
		setMessage("Get out.")
	await get_tree().create_timer(0.5).timeout
	print("next level")
	get_tree().change_scene_to_file("res://Levels/Level Menu/Level_Menu.tscn")
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


func _on_ball_body_entered(body: Node, obj: String) -> void:
	if !(skewing) and (body is RigidBody2D) and (obj == "ball"):
		timesBroken += 1
		skewing = true
		print("Skewing = true")
		await get_tree().create_timer(1.5).timeout
		if (timesBroken == 1):
			setMessage("Let me fix it...")
			await get_tree().create_timer(3).timeout
			skewing = false
			brokenBall.skew = 0
			setMessage("There. Its fixed. Dont touch it. Finish the level.")
		elif (timesBroken == 2):
			setMessage("yo can we not")
			await get_tree().create_timer(3).timeout
			skewing = false
			brokenBall.skew = 0
			setMessage("Dude just take the moment and leave")
		else:
			setMessage("............")
			await get_tree().create_timer(3).timeout
			skewing = false
			brokenBall.skew = 0
	elif (obj == "key"):
		print("Key pickup")
