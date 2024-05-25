extends CharacterBody2D


@export var speed = 70
var player = null
var player_chase = false

var health = 100
var player_inattack_zone = false
var can_take_damage = true

func _ready():
	pass


func _physics_process(delta):
	deal_with_damage()
	
	if player_chase:
		position += (player.position - position)/ speed
		$AnimatedSprite2D.play("walk")
		
		if(player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("idle")


func enemy():
	pass



func deal_with_damage():
	if player_inattack_zone and Global.player_current_attack == true:
		if can_take_damage:
			$take_dmg_cooldown.start()
			health = health - 20
			can_take_damage = false
			print("enemy healt = ", health)
			if health <= 0:
				self.queue_free()


func _on_take_dmg_cooldown_timeout():
	can_take_damage = true


func _on_hitbox_area_body_entered(body):
	if body.has_method("player"):
		player_inattack_zone = true


func _on_hitbox_area_body_exited(body):
	if body.has_method("player"):
		print("this is player")
		player_inattack_zone = false


func _on_detection_area_body_entered(body):
	player = body
	player_chase = true


func _on_detection_area_body_exited(body):
	player = null
	player_chase = false
