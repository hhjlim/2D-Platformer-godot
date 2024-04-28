extends CharacterBody2D

var gravity = 1000
#var customVelocity = Vector2.ZERO
var maxHorizontalSpeed = 140
var horizontalAcceleration = 2000
var jumpspeed = 360
var jumpTerminatiionMultiplier = 4

func _physics_process(delta):
	var moveVector = get_movement_vector()
	
	velocity.x += moveVector.x * horizontalAcceleration * delta
	if(moveVector.x ==0):
		velocity.x = lerp(0,int(velocity.x),pow(2,-50*delta))
	
	velocity.x = clamp(velocity.x,-maxHorizontalSpeed,maxHorizontalSpeed)
	
	if(moveVector.y < 0 && is_on_floor()):
		velocity.y = moveVector.y * jumpspeed
		
	if(velocity.y <0 && !Input.is_action_pressed("ui_accept")):
		velocity.y += gravity * jumpTerminatiionMultiplier * delta
	else:
		velocity.y += gravity * delta

	move_and_slide()
	
func get_movement_vector():
	var moveVector = Vector2.ZERO
	moveVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	moveVector.y = -1 if Input.is_action_just_pressed("ui_accept") else 0
	return moveVector
