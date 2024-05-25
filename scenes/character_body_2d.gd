extends CharacterBody2D

var enemy_inattack_range = false
var enemy_attack_cooldown = true
var health = 100
var player_is_alive = true
var attack_ip = false

var speed = 120
var current_dir = "none"

func _ready():
	$AnimatedSprite2D.play('idle')

func _physics_process(delta):
	player_movement(delta)
	enemy_attack()
	attack()

	if health <= 0:
		player_is_alive = false
		health = 0
		self.queue_free()
		# Endgame here

func player_movement(delta):
	if attack_ip == false:
		var input_direction = Vector2.ZERO
		var movement = 0

		if Input.is_action_pressed("ui_right"):
			current_dir = "right"
			input_direction.x += 1
			movement = 1
		elif Input.is_action_pressed("ui_left"):
			current_dir = "left"
			input_direction.x -= 1
			movement = 1
		elif Input.is_action_pressed("ui_down"):
			current_dir = "down"
			input_direction.y += 1
			movement = 1
		elif Input.is_action_pressed("ui_up"):
			current_dir = "up"
			input_direction.y -= 1
			movement = 1

	

		if movement == 1:
			play_anim(1)
		else:
			play_anim(0)

		velocity = input_direction * speed
		move_and_slide()

func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D

	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("walk")
		else:
			anim.play("idle")
	elif dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("walk")
		else:
			anim.play("idle")
	elif dir == "down":
		if movement == 1:
			anim.play("walk")
		else:
			anim.play("idle")
	elif dir == "up":
		if movement == 1:
			anim.play("walk")
		else:
			anim.play("idle")

func player():
	pass    

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_inattack_range = true

func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_inattack_range = false

func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown == true:
		health -= 10
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print("took damage")
		print(health)

func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true

func attack():
	var dir = current_dir
	if Input.is_action_just_pressed("attack"):
		Global.player_current_attack = true
		attack_ip = true
		velocity = Vector2.ZERO  # Stop movement when attacking
		if dir == "right":
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("attack1")
			$deal_attack_cooldown.start()
		elif dir == "left":
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("attack2")
			$deal_attack_cooldown.start()
		elif dir == "down":
			$AnimatedSprite2D.play("attack3")
			$deal_attack_cooldown.start()
		elif dir == "up":
			$AnimatedSprite2D.play("attack1")
			$deal_attack_cooldown.start()
		
		$attack_cooldown.start()  # Start the timer for dealing the attack

func _on_deal_attack_timer_timeout():
	$attack_cooldown.stop()
	attack_ip = false


func _on_deal_attack_cooldown_timeout():
	$deal_attack_cooldown.stop()
	Global.player_current_attack = false
	attack_ip = false
