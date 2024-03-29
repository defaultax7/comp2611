# Student name : Cheng Alex
# Student id : 20713598
# Email : achengad@connect.ust.hk

.data
# game setting
temp :.asciiz " "
temp2 :.asciiz "\n"

start_time : .word 0 # for saving the start time in unit time stamp ( only save the low 32bit as it is big enough)
timer_mes :  .asciiz "0" # base address for calling syscall 105 to show the timer
timer_loc : .word 450 400 # location of the timer

score : .word 0 # score
score_digits : .word 4 # number of digits of score message
score_mes : .asciiz "0000" # base address for calling syscall 105 to show the score
score_loc : .word 430 20 # location of the score

cursor_index : .word 0 # index of menu cursor
cursor_max_index : .word 4 # number of options in menu
cursor_loc : .word 115 237 # location of the cursor
cursor_gapY: .word 42 # gap in y axis for every option
started : .word 0 # boolean : check for if the game is started 

life : .word 1 # number of life
life_mes : .asciiz "0" # base address for calling syscall 105 to show the life
life_loc : .word 450 400 # location of the life

timer_for_wait_screen : .word 0 # reference point for wait screen time 
finish_waiting : .word 0 # boolean : check for if the waiting is finished

# the file name of score file
score_file : .asciiz "score.txt" 
# message box 
create_score_file_mes : .asciiz "No score file is found! A new one is created"

survive_started : .word 0 # boolean : check for if the survive mode is started
survive_enemy_num : .word 0 # track the number of enemy in survive mode

# hardcode for testing, later read by file
map_row : .word 26 # number of row of the bitmap 
map_col : .word 26 # number of col of the bitmap

cheat_code_match_count : .word 0 # count the number of match input for cheat code
cheat_code : .asciiz "vfvf" # cheat code
winned: .word 0 # cheat code : when activated (=1), the player wins directly

timeup_time : .word 60 # timeup when it is over 60s
danger_time : .word 50 # trigger danger when time lapse is over 50s
danger : .word 0 # boolean : check if danger is triggered
after_danger : .word 0 # boolean : check if the action for danger is done

selected_tank : .word 0 # boolean : check for if player select a tank
tank_selection_index : .word 0 # cursor index of tank selection
tank_selection_max_index : .word 2 # currently support 2 tanks only

### my argument

enemy_num: 		.word 	0	# the number of enemys
enemy_alive_num: 		.word 	0	# the number of alive enemys
input_enemy_num:	.asciiz	"Enter the number of enemys (in the range [1,2]): "
game_win_text: .asciiz	"You Win!"
new_line: .asciiz "\n"

enemy1_pos_num: .word 4 
enemy1_locs: .word 0 0
enemy1_alive: .word 1

enemy2_pos_num: .word 4
enemy2_locs: .word 384 0

enemy2_alive: .word 1

enemy_ids: .word 0 1



# movement
input_key:	.word 0 # input key from the user
move_iteration: .word 0 # remaining number of game iterations for last player movement    
initial_move_iteration: .word 8 # default number of game iterations for a player movement
move_key:	.word 0 # last processed key for a player movement
buffered_move_key: .word 0 # latest buffered movement input during an in-progress player movement

# player properties
player_id: 	.word 0 # id of player object is set to 0
player_locs:	.word -1:2 # initialized location of player object
player_speed:	.word 2
player_dir:   		.word 0 #player direction
remaining_bullet:   .word 1



# bullet
bullet_id:		.word 0
bullet_locs:		.word -1:2 
bullet_type:      .word 3
bullet_half_size:      .word 3 3 #1/2 of bullet's weight and height
bullet_dir:       .word 0 
bullet_speed:     .word 10
bullet_collision: .word 0 # set to 1 when enemy's bullet collides with players bullet


tank_explosion_id: .word 0


# size properties
player_size:	.word 32 32 # width and height of player object

maze_size:		.word 416 416 # width and height of the maze
grid_cell_size:	.word 16 16 # width and height of a grid cell
grid_row_num:	.word 26 # the number of rows in the grid of the maze
grid_col_num:	.word 26 # the number of columns in the grid of the maze

home_locs:      .word 192 384
broken_home_id: .word 0
game_over:  .word 0
maze_destroy:	.word -1:8

game_over_locs: .word 0xb0 0xc0
game_win_locs: .word 0xb0 0xc0
# maze bit map
# 1:brick wall 2:stone -1:river 0:open path or grass (since both tanks and bullets can go through grass, we denote grass as 0)
maze_bitmap: .byte
0 0 0 0 1 1 0 0 0 0 1 1 0 0 0 0 0 0 1 1 0 0 0 0 0 0
0 0 0 0 1 1 0 0 0 0 1 1 0 0 1 1 0 0 1 1 0 0 0 0 0 0 
0 0 1 1 1 1 1 1 0 0 1 1 0 0 0 0 0 0 1 1 1 0 0 0 0 0 
0 0 1 1 1 1 1 1 0 0 1 1 0 0 2 2 0 0 1 1 1 0 0 0 0 0 
0 0 0 0 0 0 0 0 0 0 1 1 0 0 1 1 0 0 1 1 0 0 0 1 1 0 
0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 1 1 0 
0 0 -1 -1 -1 -1 1 1 1 1 1 1 1 1 -1 -1 -1 -1 1 1 1 1 0 0 -1 -1
0 0 -1 -1 -1 -1 1 1 1 1 1 1 1 1 -1 -1 -1 -1 1 1 1 1 0 0 -1 -1
0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
0 0 1 1 0 0 0 0 0 0 0 0 1 1 1 1 0 0 0 0 0 0 0 0 0 0 
0 0 0 0 1 1 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 
0 0 0 0 1 1 0 0 0 0 0 1 1 1 1 1 0 0 1 1 0 0 0 0 0 0 
1 1 1 1 0 0 1 1 0 0 0 1 1 1 1 1 0 0 1 1 0 0 0 0 1 1 
1 1 1 1 0 0 1 1 0 0 0 1 1 1 1 1 0 0 1 1 2 2 2 2 1 1 
0 0 0 0 0 0 2 2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
0 0 0 0 0 0 2 2 0 0 2 2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
-1 -1 -1 -1 0 0 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 0 0 1 1 1 1 -1 -1 -1 -1
-1 -1 -1 -1 0 0 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 0 0 1 1 1 1 -1 -1 -1 -1
0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 1 0 0 0 0 1 1 1 1 0 0 0 0 0 0 0 0 0 0 
0 0 0 0 1 1 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 1 1 0 0 
0 0 0 0 1 1 0 0 1 0 0 0 0 0 0 1 0 0 2 2 1 1 1 1 0 0 
0 0 0 0 1 1 0 0 1 0 0 0 0 0 0 0 0 0 1 1 0 0 1 1 0 0 
0 0 2 2 1 1 0 0 1 0 0 1 1 1 1 0 0 0 0 0 0 0 1 1 0 0 
0 0 0 0 0 0 0 0 0 0 0 1 9 8 1 0 0 0 0 0 0 0 1 1 0 0 
0 0 0 0 0 0 0 0 0 0 0 1 8 8 1 0 0 0 1 1 0 0 0 0 0 0 


buffer : .word 20 # buffer for file reading 

.text

main:	

	# show menu screen
	li $v0 , 120
	syscall
	
menu_loop:
	jal get_keyboard_input

	jal process_menu_cursor
	
	li $a0, 30 # wait for 30ms 
	jal have_a_nap
	
	# break the menu loop if "start" was choosen
	la $t0 , started
	lw $t0 , ($t0)
	bne $t0 , $zero , started_game

	# break the menu loop if "survive" was choosen	
	la $t0 , survive_started
	lw $t0 , ($t0)
	bne $t0 , $zero , survive_mode 
	
	j menu_loop
	
survive_mode:
	
	li $v0 , 1
	la $t0, survive_enemy_num
	sw $v0, 0($t0)
	la $t0, enemy_alive_num
	sw $v0, 0($t0)
	# create survive game screen
	li $v0 , 150
	syscall
	
	# load the bitmap to maze_bitmap(data)
	jal loop_survive_map
	
	# initialization for survive mode
	jal init_survive_mode
	
	# play bgm
	li $a0, 7
	li $a1, 1
	li $v0, 102
	syscall

survive_loop:
	jal get_keyboard_input
	
	la $t0 , game_over
	lw $t1 , 0($t0)
	li $t0 , 1
	beq $t0 , $t1 , process_survive_game_over
	
	la $t0 , enemy_alive_num
	lw $t1 , 0($t0)
	beq $t1 , $zero , respawn_enemy
	
	# enable shoot and move
	jal process_tank_shoot
	jal process_move_input
	jal game_move_enemy1
	# $a0 , only enemy 1 shooting
	li $a0, 0
	jal enemy_shoot
	jal update_score
	jal update_life
	
survive_game_refresh:
	li $v0 , 101
	syscall
	
	li $a0 , 30 # wait for 30ms
	jal have_a_nap	
	

	j survive_loop	
	
process_survive_game_over:
	li $v0 , 103
	li $a0 , 0
	la $t0 , game_over_locs
	lw $a1 , 0($t0)
	lw $a2 , 4($t0)
	li $a3 , 7
	syscall
	j survive_game_refresh	

### end of survive mode	
		
started_game:

#	jal input_game_params
#	current design , start with 2 enemies with no other choice
	li $v0 , 2
	la $t0, enemy_num
	sw $v0, 0($t0)
	la $t0, enemy_alive_num
	sw $v0, 0($t0)
	li $v0, 100 # create the screen
	syscall
	
	###  play bgm
	li $a0, 7
	li $a1, 1
	li $v0, 102
	syscall
	###

	
	# Initialize the game
	jal init_game
	
	# change sprite
	li $v0 , 128
	la $t0 , tank_selection_index
	lw $a0 , ($t0)
	syscall

	# save the reference time for counting 1 seconds
	la $t0 , timer_for_wait_screen
	li $v0 , 30
	syscall
	sw $a0 , 0($t0) # save the low 32 bits to first word of reference time
	
show_stage1_screen:	
	
	jal process_stage_waiting_time
	
	la $t0 , finish_waiting
	lw $t0 , ($t0)
	bne $t0 , $zero , game_loop # start the game when 1 second has passed
	
	li $a0, 30 # wait for 30ms 
	jal have_a_nap
	j show_stage1_screen


game_loop:	
	jal get_keyboard_input
	
	jal checking_cheat_code	
	
	# cheat code
	la $t0 , winned
	lw $t0 , ($t0)
	bne $t0 , $zero , process_instant_win
	
	la $t0, game_over
	lw $t1, 0($t0)
	li $t0,1
	beq $t0,$t1,process_game_over

	la $t0,enemy_alive_num
	lw $t1,0($t0)
	beq $t1,$zero, process_game_win
	
time_almost_up:
	jal process_time_almost_up
		
pause_screen:
	jal process_pause_screen

game_tank_shoot:
	jal process_tank_shoot

game_move_user:
	jal process_move_input
	 
game_move_enemy:
	jal game_move_enemy1
	la $t0, enemy_num
	lw $t1, 0($t0)
	li $t2,1
	beq $t1, $t2,game_enemy_shoot
	jal game_move_enemy2

game_enemy_shoot:
	li $a0, 0
	jal enemy_shoot

	la $t0, enemy_num
	lw $t1, 0($t0)
	li $t2,1
	beq $t1, $t2,update_score
	li $a0, 1
	jal enemy_shoot
		
	jal update_score
	
	jal update_timer # return time lapse in second

	# if it is timeup, it is a game over
	la $t0 , timeup_time
	lw $t0 , ($t0)
	beq $v0 , $t0 , time_up
	j game_refresh
time_up:
	la $t0, game_over
	li $t1,1
	sw $t1,0($t0)
	j process_game_over

game_refresh: # refresh screen
	li $v0, 101
	syscall
	

	li $a0, 30 # iteration gap: 30 milliseconds
	jal have_a_nap
	j game_loop


process_game_over:
	li $v0, 103
	li $a0,0
	la $t0,game_over_locs
	lw $a1,0($t0)
	lw $a2,4($t0)
	li $a3,7
	syscall
	j game_refresh

process_game_win:
	li $v0, 105
	li $a0,0
	la $t0,game_win_locs
	lw $a1,0($t0)
	lw $a2,4($t0)
	la $a3,game_win_text
	syscall
	j game_refresh
	
process_instant_win:

	jal hit_enemy1
	jal hit_enemy2

	j process_game_win	
#--------------------------------------------------------------------
# enemy_shoot
#--------------------------------------------------------------------

enemy_shoot:
	la $t0 , life
	lw $t0 , ($t0)
	li $t1 , 1
	li $a3 , 0
	bne $t0 , $t1 , not_die_yet
	li $a3 , 1
	
not_die_yet:	

	# call Enemyshot syscall
	li $a1,0 #$a0 and $a1 will be used for storing brick walls hit by enemy bullet
	li $v0, 112
	syscall
	li $t0,1
	beq $v0, $t0, es_enemy_hit_success # $v0=1 means enemy bullet hits the player or the home and the player loses.
	li $t0,2
	beq $v0, $t0, es_bullet_crash # $v0=2 means enemy bullet hits the player's bullet and they both disappear.
	beq $v1, $zero, es_exit # $v1=1 or 2 denotes the number of brick walls the enemy bullet hits.
	la $t0, maze_bitmap # edit bitmap
	add $t0, $t0, $a0
	sb $zero, 0($t0)
	li $t0, 1
	beq $v1, $t0, es_exit 
	la $t0, maze_bitmap 
	add $t0, $t0, $a1
	sb $zero, 0($t0)
es_exit:
	jr $ra

es_enemy_hit_success:
	# life -1
	la $t0 , life
	lw $t1 , ($t0)
	addi $t1 , $t1 , -1 
	sw $t1 , ($t0) # save it back to the data 
	
	# if life go 0, game over
	beq $t1 , $zero , es_gameover
	j es_exit
	
es_gameover:

	la $t0, game_over
	li $t1,1
	sw $t1,0($t0)
	j es_exit
es_bullet_crash:
	la $t0, remaining_bullet
	lw $t1, 0($t0)
	addi $t1, $t1, 1
	sw $t1, 0($t0)
	j es_exit




#--------------------------------------------------------------------
# input_game_params
#--------------------------------------------------------------------
input_game_params:
	la $a0, input_enemy_num
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	addi $t0, $v0, 0
	addi $v0, $t0, 0
	jr $ra

#--------------------------------------------------------------------
# procedure: init_game
# Initialize a new game:
# 1. end any last movement of the player object
# 2. create the player object: located at the point
# 3. create enemy_num enemy objects;
#    their locations are random on the paths of the game maze.
#--------------------------------------------------------------------
init_game:
	addi $sp, $sp, -12
	sw $ra, 8($sp)
	sw $s0, 4($sp)
	sw $s1, 0($sp)

	la $t0, move_iteration
	sw $zero, 0($t0) # reset any last movement of player
	la $t0, buffered_move_key
	sw $zero, 0($t0) # reset latest buffered movement input of player

ig_start:

	# create the player object
	li $v0, 103
	la $t0, player_id
	lw $a0, 0($t0) # the id of player object
	li $a1, 96 # initial place
	li $a2, 384
	li $a3, 1
	la $t0, player_locs
	sw $a1, 0($t0)
	sw $a2, 4($t0)
	syscall
	


	# create bullets
	li $v0, 103
	la $t0, bullet_id
	lw $a0, 0($t0) # the id of bullet object
	li $a1, 1000 # out of screen (hidden)
	li $a2, 1000
	li $a3, 3
	la $t0, player_id #id of the corresponding tank 
	lw $t1, 0($t0)
	la $t0, bullet_locs
	sw $a1, 0($t0)
	sw $a2, 4($t0)
	syscall

	# create the specified number of enemys
	la $t0, enemy_num
	lw $a0, 0($t0) # num of enemy objects

	la $t0, enemy_ids
	lw $a1, 0($t0)
	lw $a2, 4($t0)
	li $v0, 108
	syscall

	# create the broken home and hide
	la $t0, broken_home_id
	lw $a0, 0($t0)
	# la $t0, home_locs
	li $a1, 1000
	li $a2, 1000
	li $a3, 6
	li $v0, 103
	syscall

ig_exit:
	li $v0, 101 # refresh the screen
	syscall
	lw $ra, 8($sp)
	lw $s0, 4($sp)
	lw $s1, 0($sp)
	addi $sp, $sp, 12
	jr $ra


#--------------------------------------------------------------------
# procedure: have_a_nap(nap_time)
#--------------------------------------------------------------------
have_a_nap:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	li $v0, 32 # syscall: let mars java thread sleep $a0 milliseconds
	syscall

	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra

#--------------------------------------------------------------------
# procedure: get_keyboard_input
# If an input is available, save its ASCII value in the array input_key,
# otherwise save the value 0 in input_key.
#--------------------------------------------------------------------
get_keyboard_input:
	
	add $t2, $zero, $zero
	lui $t0, 0xFFFF
	lw $t1, 0($t0)
	andi $t1, $t1, 1
	beq $t1, $zero, gki_exit
	lw $t2, 4($t0)

gki_exit:	
	la $t0, input_key 
	sw $t2, 0($t0) # save input key
	

	jr $ra

#--------------------------------------------------------------------
# procedure: game_move_enemy1
#--------------------------------------------------------------------
game_move_enemy1: 
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	la $t0, enemy1_alive
	lw $t1, 0($t0)
	beq $t1, $zero,gme1_exit

gme1_move:
	la $t0,enemy_ids
	lw $a0, 0($t0)
	li $v0, 109 
	syscall
	la $t0,enemy1_locs # ($v0,$v1) is the up-to-date enemy location.
	sw $v0, 0($t0)
	sw $v1, 4($t0)

gme1_exit:
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra

#--------------------------------------------------------------------
# procedure: game_move_enemy2
#--------------------------------------------------------------------
game_move_enemy2: 
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	la $t0, enemy2_alive
	lw $t1, 0($t0)
	beq $t1, $zero,gme2_exit

gme2_move:
	la $t0,enemy_ids
	lw $a0, 4($t0)
	li $v0, 109 
	syscall
	la $t0,enemy2_locs
	sw $v0, 0($t0)
	sw $v1, 4($t0)

gme2_exit:
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra



#--------------------------------------------------------------------
# procedure: process_tank_shoot
#--------------------------------------------------------------------

process_tank_shoot:
# The player tank have 1 bullet only, so it can only shoot bullet after the previous shot bullet 
# hit something (brick, stone, enemy tanks or borders of the map).
	addi $sp, $sp, -24
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	sw $s4, 20($sp)
	la $t0, remaining_bullet 
	lw $t1, 0($t0)
	beq $t1, $zero, pts_bullet_move# If there is no remaining bullet, move the current bullet forward
	j pts_new_bullet # else shoot a new bullet

pts_bullet_move:
	jal bullet_move
	j pts_check_bullet_collision

pts_new_bullet:
	la $t0, input_key
	lw $t1, 0($t0)
	addi, $t2, $zero, 32
	bne $t1, $t2, pts_exit # If the input_key is not space key, exit.
	jal new_bullet

pts_check_bullet_collision:
	addi $a0,$v0,0 # ($v0,$v1) is the updated bullet location.
	addi $a1,$v1,0
	la $t0,bullet_half_size
	lw $a2,0($t0)
	jal check_bullet_collision

pts_exit:
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	lw $s4, 20($sp)
	addi $sp, $sp, 24
	jr $ra


#--------------------------------------------------------------------
# procedure: new_bullet
#--------------------------------------------------------------------
new_bullet:	
	addi $sp, $sp, -24
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	sw $s4, 20($sp)

	

	#shoot sound
	li $v0,102
	li $a0,4
	li $a1,0
	syscall

	la $t0, remaining_bullet #set the remaining_bullet=0
	sw $zero, 0($t0)

	la $t0, bullet_id
	lw $s0, 0($t0)

	la $t0, player_locs
	lw $s1, 0($t0) # tank location
	lw $s2, 4($t0)
	addi $s1,$s1, 16
	addi $s2,$s2, 16 #tank midpoint

	la $t0, bullet_half_size
	lw $s3, 0($t0)


	la $t0, player_dir #let bullet_dir=player_dir
	lw $t4, 0($t0)

	la $t0, bullet_dir
	sw $t4, 0($t0)

	li $v0, 107  #set bullet direction
	add $a0, $s0, $zero
	li $a1, 3 #bullet type
	add $a2, $t4, $zero
	syscall



	addi $t5, $zero, 0
	beq $t4, $t5, nb_up_bullet

	addi $t5, $zero, 1
	beq $t4, $t5, nb_left_bullet

	addi $t5, $zero, 2
	beq $t4, $t5, nb_down_bullet

	addi $t5, $zero, 3
	beq $t4, $t5, nb_right_bullet
	j nb_exit

nb_up_bullet:
	sub $s1,$s1, $s3
	sub $s2,$s2, $s3  
	sub $s2, $s2, $s3
	subi $s2, $s2, 16
	la $t0, bullet_locs
	sw $s1, 0($t0)
	sw $s2, 4($t0)
	addi $v0, $s1,0
	addi $v1, $s2,0
	j nb_exit


# Task4: complete nb_down_bullet and nb_left_bullet
# Hint: 1. Calculate the location of the top-left corner of the bullet and store into bullet_locs
# 2. Set ($v0,$v1) the location
# 3. You can refer to nb_up_bullet and nb_right_bullet
#*** Your code starts here

nb_down_bullet:
	
	# as the location start from top-left, adjustment by adding half of the bullet size is needed to make it start from the center
	sub $s1 , $s1 , $s3 
	sub $s2 , $s2 , $s3
	
	sub $s2 , $s2 , $s3
	addi $s2 , $s2 , 16 # add 16 as $s2 is the center y location of the tank 
	la $t0, bullet_locs # point to bullet_locs
	sw $s1, 0($t0) # update the x location of bullet
	sw $s2, 4($t0) # update the y location of the bullet
	addi $v0, $s1 , 0 # return the x location
	addi $v1, $s2 , 0 # return the y location
	j nb_exit

nb_left_bullet:

	# as the location start from top-left, adjustment by adding half of the bullet size is needed to make it start from the center
	sub $s1 , $s1 , $s3 
	sub $s2 , $s2 , $s3
	
	sub $s1 , $s1 , $s3
	subi $s1 , $s1 , 16 # subtract 16 as $s1 is the center x location of the tank
	la $t0, bullet_locs # point to bullet_locs
	sw $s1, 0($t0) # update the x location of bullet
	sw $s2, 4($t0) # update the y location of the bullet
	addi $v0, $s1 , 0 # return the x location
	addi $v1, $s2 , 0 # return the y location
	j nb_exit

#*** Your code ends here	

nb_right_bullet:
	sub $s2, $s2, $s3
	addi $s1, $s1, 16
	la $t0, bullet_locs
	sw $s1, 0($t0)
	sw $s2, 4($t0)
	addi $v0, $s1,0
	addi $v1, $s2,0
	j nb_exit

nb_exit:
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	lw $s4, 20($sp)
	addi $sp, $sp, 24
	jr $ra



#--------------------------------------------------------------------
# procedure: bullet_move
# Since the current bullet is on the fly, move it foward
#--------------------------------------------------------------------
bullet_move: 
	addi $sp, $sp, -24
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	sw $s4, 20($sp)

	# get bullet_locs, bullet_speed and bullet_dir
	la $t0, bullet_locs
	lw $s1, 0($t0)
	lw $s2, 4($t0)
	la $t0, bullet_speed
	lw $a3, 0($t0)

	la $t0, bullet_dir
	lw $t4, 0($t0)

	addi $t5, $zero, 0

	beq $t4, $t5, bm_up_move

	addi $t5, $zero, 1
	beq $t4, $t5, bm_left_move

	addi $t5, $zero, 2
	beq $t4, $t5, bm_down_move

	addi $t5, $zero, 3
	beq $t4, $t5, bm_right_move
	j pts_exit

bm_up_move:
	sub $s2, $s2, $a3 # reduce y 
	la $t0, bullet_locs # update the coordinates
	sw $s1, 0($t0)
	sw $s2, 4($t0)
	addi $v0, $s1,0  # set ($v0,$v1) the updated coordinates
	addi $v1, $s2,0
	j bm_exit
bm_down_move:
	add $s2, $s2, $a3
	la $t0, bullet_locs
	sw $s1, 0($t0)
	sw $s2, 4($t0)
	addi $v0, $s1,0
	addi $v1, $s2,0
	j bm_exit
bm_left_move:
	sub $s1, $s1, $a3
	la $t0, bullet_locs
	sw $s1, 0($t0)
	sw $s2, 4($t0)
	addi $v0, $s1,0
	addi $v1, $s2,0
	j bm_exit
bm_right_move:
	add $s1, $s1, $a3
	la $t0, bullet_locs
	sw $s1, 0($t0)
	sw $s2, 4($t0)
	addi $v0, $s1,0
	addi $v1, $s2,0
	j bm_exit

bm_exit:
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	lw $s4, 20($sp)
	addi $sp, $sp, 24
	jr $ra

#--------------------------------------------------------------------
# procedure: check_bullet_collision(x,y,size)
# Check whether the bullet collides with border, enemys, brick wall, stone or home
# collision type: 0:no collision; 1:brick wall; 2:border&stone; 4:enemy1; 5:enemy2; 8 or 9: home
#--------------------------------------------------------------------

check_bullet_collision:
	addi $sp, $sp, -24
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	sw $s4, 20($sp)
	addi $s1,$a0,0
	addi $s2,$a1,0
	addi $s3,$a2,0
	add $a2,$a2,$a2 #pass the full size
	jal hit_border
	li $a0, 2 #collision type
	la $a2, ($v0) # pass if out-bound to process_collision
	beq $v0, $zero, cbc_top_left
	jal process_collision

# check 4 corners of the bullet respectively
cbc_top_left:
	addi $a0, $s1, 0 
	addi $a1, $s2, 0
	jal check_hit_enemy
	add $a0,$v0,$zero
	slt $v0, $zero, $v0 
	beq $v0, $zero, cbc_top_left_grid
	jal process_collision
cbc_top_left_grid:
	addi $a0, $s1, 0 
	addi $a1, $s2, 0
	jal get_bitmap_cell
	add $a0,$v0,$zero
	slt $v0, $zero, $v0 
	beq $v0, $zero, cbc_top_right
	addi $a1, $v1, 0
	jal process_collision

# Task5: Complete cbc_top_right and cbc_bottom_left
# Hints: 1. calculate the coordinates of the corner as ($a0,$a1) and call check_hit_enemy
# 2. If it hits enemy, do $a0=$v0 and call process_collision
# 3. If it does not hit enemy, use get_bitmap_cell to see wether it hits brick wall, stone or home
# 4. get_bitmap_cell will return the location where the collision happens (the index of the bitmap cell)
#*** Your code starts here
cbc_top_right:

	# $a0 is the right edge of bullet
	add $a0 , $s1 , $s3 
	add $a0 , $a0 , $s3
	#addi $a0 , $a0 , -1 # -1 as after adding the full size of the bullet, the location is point to the next grid instead of right most end of the bullet
	
	# $a1 point to the top
	add $a1 , $s2 , 0
	
	jal check_hit_enemy 
	
	# save the original $v0 to argument $a0 first
	add $a0 , $zero , $v0
	# bullet can pass through sea(-1) too, add this instead of beq $v0 directly
	slt $v0 , $zero , $v0
	
	beq $v0 , $zero , cbc_top_right_grid # if the result of check_hit_enemy is 0 it means no enemy hit

	jal process_collision 
	
cbc_top_right_grid:

	# $a0 point to the right edge of the bullet
	add $a0 , $s1 , $s3 
	add $a0 , $a0 , $s3
	addi $a0 , $a0 , -1 # -1 as after adding the full size of the bullet, the location is point to the next grid instead of right most end of the bullet
	
	# $a1 point to the top
	add $a1 , $s2 , 0	
	
	jal get_bitmap_cell # check what the bullet hit (wall, stone, etc.)
	
	# save the original $v0 to argument $a0 first
	add $a0 , $zero , $v0
	# bullet can pass through sea(-1) too, if add this instead of beq $v0 directly
	slt $v0 , $zero , $v0
	
	beq $v0 , $zero , cbc_bottom_left # if the result of get_bitmap_cell is 0, it means the bullet does not hit anything that can stop it
	add $a1 , $v1 , $zero # pass the hit result to process_collision
	jal process_collision
	

#*** Your code ends here

cbc_bottom_left:
	add $a0, $s1, $zero 	
	add $a1, $s2, $s3
	add $a1, $a1, $s3
	# addi $a1, $a1, -1 This line is removed
	jal check_hit_enemy
	add $a0,$v0,$zero
	slt $v0, $zero, $v0 
	beq $v0, $zero, cbc_bottom_left_grid
	jal process_collision
cbc_bottom_left_grid:
	add $a0, $s1, $zero 	
	add $a1, $s2, $s3
	add $a1, $a1, $s3
	addi $a1, $a1, -1 
	jal get_bitmap_cell
	add $a0,$v0,$zero
	
	slt $v0, $zero, $v0 
	beq $v0, $zero, cbc_bottom_right

	addi $a1, $v1,0
	jal process_collision

cbc_bottom_right:
	add $a0, $s1, $s3 
	add $a0, $a0, $s3 
	# addi $a0, $a0, -1 This line is removed
	add $a1, $s2, $s3
	add $a1, $a1, $s3
	# addi $a1, $a1, -1 This line is removed
	jal check_hit_enemy
	add $a0,$v0,$zero
	slt $v0, $zero, $v0 
	beq $v0, $zero, cbc_bottom_right_grid
	jal process_collision
cbc_bottom_right_grid:
	add $a0, $s1, $s3 
	add $a0, $a0, $s3 
	addi $a0, $a0, -1 	
	add $a1, $s2, $s3
	add $a1, $a1, $s3
	addi $a1, $a1, -1

	jal get_bitmap_cell
	addi $a0,$v0,0
	
	slt $v0, $zero, $v0 
	beq $v0, $zero, cbc_end
	addi $a1, $v1,0
	jal process_collision

cbc_end:
	la $t0,bullet_collision
	lw $t1,0($t0)
	sw $zero, 0($t0) # set bullet_collision to 0 after each check
	beq $t1, $zero, cbc_no_collision #process_collision will set bullet_collision to 1, so if bullet_collision is 0 means no collision happened


	la $t0, remaining_bullet # set remaining_bullet to 1 if collision happened
	li $t1,  1
	sw $t1, 0($t0)

	la $t0, bullet_id
	lw $a0, 0($t0)
	li $a3, 3
	li $a1, 1000  # hide the bullet
	li $a2, 1000
	li $v0, 104
	syscall  
	j cbc_exit

cbc_no_collision:
	la $t0, bullet_id
	lw $a0, 0($t0)
	add $a1, $s1, $zero
	add $a2, $s2, $zero
	li $a3, 3
	li $v0, 104 #set bullet location 
	syscall
	j cbc_exit

cbc_exit:
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	lw $s4, 20($sp)
	addi $sp, $sp, 24
	jr $ra


#--------------------------------------------------------------------
# procedure: check_hit_enemy(x,y)
# Check whether the bullet collides with enemys
# (x,y) is one corner of the bullet
# If the bullet collides with enemy1, set $v0=4 and return
# If the bullet collides with enemy2, set $v0=5 and return
#--------------------------------------------------------------------


check_hit_enemy:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	li $v0,0
che_enemy1:
# Task6:  you need to complete this procedure check_hit_enemy to perform its operations as described in comments above. 
# Hints: 1. check wether the enemy is alive.
# 2. if it's alive get enemy1_locs (x0,y0)
# 3. calculate the y1=y0+32 and x1=x0+32
# 4. Only if x0<x<x1 and y0<y<y1, return $v0=4 or return $v0=0
#*** Your code starts here

	# load the living state of enemy 1
	la $t0 , enemy1_alive 
	lw $t0 , 0($t0)
	
	beq $t0 , $zero , che_enemy2 # if enemy 1 is already dead, go to check enemy 2
	
	# load the location of enemy 1
	la $t0 , enemy1_locs
	lw $t1 , 0($t0) # load the x location of enemy 1 to $t1
	lw $t2 , 4($t0) # load the y location of enemy 1 to $t2
	
	addi $t3 , $t1 , 32 # x1 = x + 32
	addi $t4 , $t2 , 32 # y1 = y + 32
	
	slt $t0 , $a0 , $t3 # check if bullet_x < x1
	beq $t0 , $zero , che_enemy2 # go to check enemy2 if the above conditon is not true
	slt $t0 , $t1 , $a0 # check if x < bullet_x
	beq $t0 , $zero , che_enemy2 # go to check enemy2 if the above conditon is not true
	slt $t0 , $a1 , $t4 # check if bullet_y < y1
	beq $t0 , $zero , che_enemy2 # go to check enemy2 if the above conditon is not true
	slt $t0 , $t2 , $a1 # check if y < bullet_y
	beq $t0 , $zero , che_enemy2 # go to check enemy2 if the above conditon is not true	
	# return 4
	li $v0 , 4
	j che_exit

che_enemy2:
# similar to che_enemy1

	# load the living state of enemy 1
	la $t0 , enemy2_alive 
	lw $t0 , 0($t0)
	
	beq $t0 , $zero , che_exit # if enemy 1 is already dead, go to check enemy 2
	
	# load the location of enemy 1
	la $t0 , enemy2_locs
	lw $t1 , 0($t0) # load the x location of enemy 1 to $t1
	lw $t2 , 4($t0) # load the y location of enemy 1 to $t2
	
	addi $t3 , $t1 , 32 # x1 = x + 32
	addi $t4 , $t2 , 32 # y1 = y + 32
	
	slt $t0 , $a0 , $t3 # check if bullet_x < x1
	beq $t0 , $zero , che_exit # go to check enemy2 if the above conditon is not true
	slt $t0 , $t1 , $a0 # check if x < bullet_x
	beq $t0 , $zero , che_exit # go to check enemy2 if the above conditon is not true
	slt $t0 , $a1 , $t4 # check if bullet_y < y1
	beq $t0 , $zero , che_exit # go to check enemy2 if the above conditon is not true
	slt $t0 , $t2 , $a1 # check if y < bullet_y
	beq $t0 , $zero , che_exit # go to check enemy2 if the above conditon is not true	
	# return 5
	li $v0 , 5
	j che_exit

#*** Your code ends here
che_exit:
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra

#--------------------------------------------------------------------
# procedure: process_collision(type,index,out_bound)
# process bullet collision
# Only when type is 1, we need the index parameter which denotes the index of the bitmap cell where the collision happened
#--------------------------------------------------------------------
process_collision: 
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	la $t0, bullet_collision # set bullet_collision to 1
	li $t1,1
	sw $t1, 0($t0)
	# swtich case
	li $t1,1
	beq $a0,$t1,pc_hit_brick
	
	# new tank sepcial ability : break stone
	la $t2 , tank_selection_index
	lw $t2 , ($t2)
	beq $t2 , $zero , no_break_stone
	
	bne $a2 , $zero , no_break_stone # out_bound is 1, that mean nothing to break
	
	li $t1 , 2
	beq $a0 , $t1 , pc_hit_brick
no_break_stone:
		
	li $t1,4
	beq $a0,$t1,pc_hit_enemy1
	li $t1,5
	beq $a0,$t1,pc_hit_enemy2
	li $t1,8
	beq $a0,$t1,pc_hit_home
	li $t1,9
	beq $a0,$t1,pc_hit_home

	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra




pc_hit_brick:
	la $t0, maze_bitmap
	add $t0,$t0,$a1
	sb $zero, 0($t0) # edit bitmap cell to 0 (open path)
	addi $a0, $a1,0
	li $v0, 110 
	syscall
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra

hit_enemy1:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	li $v0,102
	li $a0,2
	li $a1,0
	syscall

	li $a0,0  #get enemy1 locs
	li $v0,106
	syscall

	la $t0, tank_explosion_id
	lw $a0, 0($t0)
	addi $t1,$a0,1
	sw $t1,0($t0)

	addi $a1 ,$v0,0
	addi $a2,$v1,0
	li $a3, 5
	li $v0,103  #create tank explosion object
	syscall


	li $a0,0
	li $v0,111
	syscall
	la $t0, enemy1_alive # set enemy1_alive to 0
	sw $zero, 0($t0)
	la $t0, enemy_alive_num
	lw $t1,0($t0)
	subi $t1,$t1,1
	sw $t1,0($t0)
	
	jal add_score
	
	lw $ra, 0($sp)
	addi $sp,$sp,4
	
	jr $ra

pc_hit_enemy1:

	jal hit_enemy1

	lw $ra, 0($sp)
	addi $sp,$sp,4
	jr $ra

hit_enemy2:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	li $v0,102
	li $a0,4
	li $a1,0
	syscall

	li $a0,1  #get enemy2 locs
	li $v0,106
	syscall

	la $t0, tank_explosion_id
	lw $a0, 0($t0)
	addi $t1,$a0,1
	sw $t1,0($t0)

	addi $a1 ,$v0,0
	addi $a2,$v1,0
	li $a3, 5
	li $v0,103  
	syscall

	li $a0,1
	li $v0,111
	syscall
	la $t0, enemy2_alive
	sw $zero, 0($t0)
	la $t0, enemy_alive_num
	lw $t1,0($t0)
	subi $t1,$t1,1
	sw $t1,0($t0)
	
	jal add_score
	
	lw $ra, 0($sp)
	addi $sp,$sp,4
	
	jr $ra

pc_hit_enemy2:

	jal hit_enemy2
	
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra

pc_hit_home:
	la $t0, broken_home_id
	lw $a0, 0($t0)
	la $t0, home_locs
	lw $a1, 0($t0)
	lw $a2, 4($t0)
	li $a3, 6
	li $v0, 104 # move broken home object to the location of home
	syscall
	la $t0,game_over # set game_over to 1
	li $t1,1
	sw $t1,0($t0)
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra





#--------------------------------------------------------------------
# procedure: process_move_input
# Continue any last in-progress movement repesented by move_key, and 
# save any latest movement input key during that process to the
# buffer buffered_move_key.
# If no in-progress movement, perform the action of the new keyboard
# input input_key if it is a valid movement input for the player object,
# otherwise perform the action of any buffered movement input key
# if it is a valid movement input.
# If an input is processed but it cannot actually move the player
# object (e.g. due to a wall), no more movements will be made in later
# iterations for this input. 
#--------------------------------------------------------------------
process_move_input:	
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	la $t6, move_iteration
	lw $t5, 0($t6) # remaining number of game iterations for last movement
	bne $t5, $zero, pmi_last_move # last movement is not completed, so process it
	la $t0, input_key 
	lw $t1, 0($t0) # new input key
	la $t0, initial_move_iteration
	lw $t2, 0($t0)
	addi $t2, $t2, -1 # count this game iteration for any new movement
	sw $t2, 0($t6) # first assume new input key is valid
	la $t8, move_key 
	sw $t1, 0($t8) # save new input key in case it is a movement key
	j pmi_check_buffer

pmi_last_move:
	la $t0, input_key 
	lw $t7, 0($t0) # new input key
	li $t0, 119 # corresponds to key 'w'
	beq $t7, $t0, pmi_buffer  
	li $t0, 115 # corresponds to key 's'
	beq $t7, $t0, pmi_buffer
	li $t0, 97 # corresponds to key 'a'
	beq $t7, $t0, pmi_buffer
	li $t0, 100 # corresponds to key 'd'
	beq $t7, $t0, pmi_buffer
	j pmi_start_move

pmi_buffer:
	la $t0, buffered_move_key
	sw $t7, 0($t0) # buffer latest movement input of player during the in-progress movement

pmi_start_move:
	addi $t5, $t5, -1 # process last movement for one more game iteration
	sw $t5, 0($t6)
	la $t0, move_key 
	lw $t1, 0($t0) # last movement key
	li $a0, 0 # no needs to check again whether this movement can actually move the object 
	j pmi_check

pmi_check_buffer:
	li $a0, 1 # check whether this movement can actually move the player object
	la $t0, buffered_move_key
	lw $t9, 0($t0) # check whether buffered movement input is valid
	sw $zero, 0($t0) # reset buffer
	li $t0, 119 # corresponds to key 'w'
	beq $t1, $t0, pmi_move_up  
	li $t0, 115 # corresponds to key 's'
	beq $t1, $t0, pmi_move_down
	li $t0, 97 # corresponds to key 'a'
	beq $t1, $t0, pmi_move_left
	li $t0, 100 # corresponds to key 'd'
	beq $t1, $t0, pmi_move_right
	sw $t9, 0($t8) # save buffered input key in case it is a movement key
	addi $t1, $t9, 0

pmi_check:
	li $t0, 119 # corresponds to key 'w'
	beq $t1, $t0, pmi_move_up  
	li $t0, 115 # corresponds to key 's'
	beq $t1, $t0, pmi_move_down
	li $t0, 97 # corresponds to key 'a'
	beq $t1, $t0, pmi_move_left
	li $t0, 100 # corresponds to key 'd'
	beq $t1, $t0, pmi_move_right
	sw $zero, 0($t6) # above assumption of new input key or buffered key being valid is wrong
	j pmi_exit

pmi_move_up: 
	la $t0, player_dir
	addi $t1, $zero, 0
	sw $t1, 0($t0)
	jal pmi_change_dir
	jal move_player_up
	j pmi_after_move

pmi_move_down:
	la $t0, player_dir
	addi $t1, $zero, 2
	sw $t1, 0($t0)
	jal pmi_change_dir
	jal move_player_down
	j pmi_after_move

pmi_move_left:
	la $t0, player_dir
	addi $t1, $zero, 1
	sw $t1, 0($t0)
	jal pmi_change_dir
	jal move_player_left
	j pmi_after_move

pmi_move_right:
	la $t0, player_dir
	addi $t1, $zero, 3
	sw $t1, 0($t0)
	jal pmi_change_dir
	jal move_player_right		

pmi_after_move:
	bne $v0, $zero, pmi_exit # actual movement has been made
	la $t6, move_iteration
	sw $zero, 0($t6) # current movement is blocked by a wall, so no more movements in later iterations for the move_key
	j pmi_exit

pmi_exit: 
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra

pmi_change_dir:
	li $v0, 107
	la $t0, player_id
	lw $a0, 0($t0)
	li $a1, 1
	la $t0, player_dir
	lw $a2, 0($t0)
	syscall
	jr $ra

#--------------------------------------------------------------------
# procedure: hit_border(x,y,size)
# Check wether an object hits the border of the maze
# We assume the object is a square (width=height)
# (x,y) is the coordinates of the top left corner of the object
# $v0=1 if the object hit the border 
# $v0=0 otherwise (Notice that if the object is tangent to the border $v0 should also be set to 0)
#--------------------------------------------------------------------	
# *****Task3: you need to complete this procedure hit_border to perform its operations as described in comments above. 
# Hints: 1. check wether the upper border of the object has y<0 
# 2. check wether the lower border of the object has y> maze_size
# 3. check wether the left border of the object has x<0
# 4. check wether the right border of the object has x>maze_size
# 5. If either of obove conditions is satisfied, set $v0=1. Otherwise, set $v0=0.

hit_border:
#*** Your code starts here

	la $t0 , maze_size # point to the maze_size
	lw $t1 , 0($t0) # load the maze width to $t1 
	lw $t2 , 4($t0) # load the maze height to $t2
	
	li $v0 , 1 # set return value be 1 first

	slt $t3 , $a1 , $zero # check if y < 0
	bne $t3 , $zero , hit_exit # if y < 0 , it hit the border
	
	slt $t3 , $a0 , $zero # check if x < 0
	bne $t3 , $zero , hit_exit # if x < 0 , it hit the border
	
	add $t3 , $a2 , $a1 # the location of the lower border of the object
	slt $t3 , $t2 , $t3 # check if the y location of the lower border > the height of the maze
	bne $t3 , $zero , hit_exit # if it is true, it hit the border
	
	add $t3 , $a2 , $a0 # the location of the right border of the object
	slt $t3 , $t1 , $t3 # check if the x location of the right border > the width of the maze
	bne $t3 , $zero , hit_exit # if it is true, it hit the border
	
no_hit:
	li $v0 , 0 # set return value to 0 when not hit the border
	
hit_exit:

#*** Your code ends here
	
	jr $ra
#--------------------------------------------------------------------
# procedure: move_player_up()
# Move the player object upward by one step which is its speed.
# Move the object only when the object will not overlap with a wall cell afterward. 
# $v0=1 if a movement has been made, otherwise $v0=0.
#--------------------------------------------------------------------	

move_player_up:
		addi $sp, $sp, -24
		sw $ra, 0($sp)
		sw $s0, 4($sp)
		sw $s1, 8($sp)
		sw $s2, 12($sp)
		sw $s3, 16($sp)
		sw $s4, 20($sp)

		la $t0, player_size
		lw $s3, 0($t0) # player width	
		lw $s4, 4($t0) # player height	
		la $t0, maze_size
		lw $t2, 4($t0) # maze height	

		la $t0, player_speed
		lw $t3, 0($t0) # player speed
		la $s2, player_locs
		lw $s0, 0($s2) # x_loc
		lw $s1, 4($s2) # y_loc
		add $t9, $s1, $zero
		addi $t9, $t9, -1 # y-coordinate of player's bottom corners		
		slt $t4, $t9, $zero # y-coordinate of upper-border is 0
		beq $t4, $zero, mpu_check_path1 
		
		j mpu_no_move

mpu_check_path1:	
		# check whether player's top-left corner is in a wall 
		sub $s1, $s1, $t3 # new y_loc
		addi $a0, $s0, 0
		addi $a1, $s1, 0
		jal get_bitmap_cell
		# slt $v0, $zero, $v0 
		bne $v0, $zero, mpu_no_move 

mpu_check_path2:
		# check whether player's top-left corner is in a wall 
		# Many student ask about why $a0=$s0+16 not $a0=$s0+32
		# Since the tank coordinates are always multiple of 16, add 16 is to check whther the right half of the player collides with 16-wide any object.
		addi $a0, $s0, 16
		addi $a1, $s1, 0
		jal get_bitmap_cell
		# slt $v0, $zero, $v0 
		bne $v0, $zero, mpu_no_move  

mpu_save_yloc:	sw $s1, 4($s2) # save new y_loc
		la $t0, player_id
		lw $a0, 0($t0)
		addi $a1, $s0, 0
		addi $a2, $s1, 0
		li $a3, 1 # object type
		li $v0, 104
		syscall # set new object location
		li $v0, 1
		j mpu_exit
	
mpu_no_move:	li $v0, 0		 
mpu_exit:	lw $ra, 0($sp)
		lw $s0, 4($sp)
		lw $s1, 8($sp)
		lw $s2, 12($sp)
		lw $s3, 16($sp)
		lw $s4, 20($sp)
		addi $sp, $sp, 24
		jr $ra
#--------------------------------------------------------------------
# procedure: move_player_down()
# Move the player object downward by one step which is its speed.
# Move the object only when the object will not overlap with a wall cell afterward. 
# $v0=1 if a movement has been made, otherwise $v0=0.
#--------------------------------------------------------------------	
move_player_down:
		addi $sp, $sp, -24
		sw $ra, 0($sp)
		sw $s0, 4($sp)
		sw $s1, 8($sp)
		sw $s2, 12($sp)
		sw $s3, 16($sp)
		sw $s4, 20($sp)

		la $t0, player_size
		lw $s3, 0($t0) # player width	
		lw $s4, 4($t0) # player height	
		la $t0, maze_size
		lw $t2, 4($t0) # maze height	

		la $t0, player_speed
		lw $t3, 0($t0) # player speed
		la $s2, player_locs
		lw $s0, 0($s2) # x_loc
		lw $s1, 4($s2) # y_loc
		

		addi $t2, $t2, -1 # y-coordinate of lower-border is (height - 1)
		add $t9, $s1, $s4
		slt $t4, $t2, $t9
		beq $t4, $zero, mpd_check_path1 
		# li $s1, 0
		# j mbd_save_yloc
		j mpd_no_move

mpd_check_path1:	
		# check whether player's bottom-left corner is in a wall
		add $s1, $s1, $t3 # new y_loc
		addi $a0, $s0, 0
		add $a1, $s1, $s4
		addi $a1, $a1, -1 # y-coordinate of player's bottom corners	
		jal get_bitmap_cell
		# slt $v0, $zero, $v0 
		bne $v0, $zero, mpd_no_move  

mpd_check_path2:	
		# check whether player's bottom-left corner is in a wall
		addi $a0, $s0, 16
		add $a1, $s1, $s4
		addi $a1, $a1, -1 # y-coordinate of player's bottom corners	
		jal get_bitmap_cell
		# slt $v0, $zero, $v0 
		bne $v0, $zero, mpd_no_move  

mpd_save_yloc:	sw $s1, 4($s2) # save new y_loc
		la $t0, player_id
		lw $a0, 0($t0)
		addi $a1, $s0, 0
		addi $a2, $s1, 0
		li $a3, 1 # object type
		li $v0, 104
		syscall # set new object location
		li $v0, 1
		j mpd_exit
	
mpd_no_move:	li $v0, 0				 
mpd_exit:	lw $ra, 0($sp)
		lw $s0, 4($sp)
		lw $s1, 8($sp)
		lw $s2, 12($sp)
		lw $s3, 16($sp)
		lw $s4, 20($sp)
		addi $sp, $sp, 24
		jr $ra


#--------------------------------------------------------------------
# procedure: move_player_left()
# Move the player object leftward by one step which is its speed.
# Move the object only when the object will not overlap with a wall cell afterward. 
# $v0=1 if a movement has been made, otherwise $v0=0.
#--------------------------------------------------------------------	
move_player_left:

# *****Task1: you need to complete this procedure move_player_left to perform its operations as described in comments above. 
# Hints:
# Firstly, preserve values $ra, $s0, $s1, $s2, $s3, $s4 with stack
# Then, use the registers as described below:
# 		The x_loc of the player object is in $s0
# 		The y_loc of the player object is in $s1
# 		The address of the player obejct is in $s2
# 		The height of the player object is in $s3
# 		The width of the player object is in $s4 
# Calculate new x_loc of the player object.
# Check whether player's top-left or bottom-left corner is in a wall: 
#		If it is in a wall, then the player can't move
# 		If it is not, then save and set the new x_loc for the player object
# Set $v0=1 if a movement has been made, 0 otherwise
# Lastly, pop and restore values in $ra, $s0, $s1, $s2, $s3, $s4  and return
# Hint: you can refer to move_player_up and move_player_down to get some clues
# *****Your codes start here
		
		# push $ra & $s0-$s4 to the stack
		addi $sp , $sp , -24
		sw $ra , 0($sp)
		sw $s0 , 4($sp)
		sw $s1 , 8($sp)
		sw $s2 , 12($sp)
		sw $s3 , 16($sp)
		sw $s4 , 20($sp)
		
		la $t0 , player_size # $t0 point to player_size
		lw $s0 , 0($t0) # load the player width to $s0
		lw $s1 , 4($t0) # load the player height to $s1
		
		la $t0 , player_speed # $t0 point to player_speed
		lw $t2 , 0($t0) # load the player speed to $t2
		la $s2 , player_locs # $s2 point to player_locs
		lw $s3 , 0($s2) # load the x location to $s3
		lw $s4 , 4($s2) # load the y location to $s4
		
		# check if the move is in bound
		add $t9 , $s3 , $zero # move x location to $t9
		addi $t9 , $t9 , -1 # x -= 1
		slt $t3 , $t9 , $zero # check if it is in bound
		beq $t3 , $zero , ml_check_path1 # if it is in bound, then go to check if there are any osobstacles 
		j ml_no_move
		
		
		ml_check_path1:
		# hitbox checking for player's top-left 
		sub $s3 , $s3 , $t2 # new x-loc = oringinal x-loc - speed 
		addi $a0 , $s3 , 0 # pass x loc to get_bitmap_cell
		addi $a1 , $s4 , 0 # pass y loc to get_bitmap_cell
		jal get_bitmap_cell
		bne $v0 , $zero , ml_no_move # if there is blocking, do no move
		
		ml_check_path2:
		# hitbox checking for player's top-left (bottom half part)
		addi $a0 , $s3 , 0 # pass x loc to get_bitmap_cell
		addi $a1 , $s4 , 16 # the y loc of the bottom half part to get_bitmap_cell
		jal get_bitmap_cell
		bne $v0 , $zero , ml_no_move # if there is blocking, do no move
		
		ml_move:
		sw $s3 , 0($s2) # update the x location
		
		# update the location of the player in the UI
		la $t0 , player_id
		lw $a0 , 0($t0) # argument : player_id
		addi $a1 , $s3 , 0 # argument : new x location
		addi $a2 , $s4 , 0 # argument : new y location
		li $a3 , 1 # argument : object type ( 1 is player )
		li $v0 , 104
		syscall
		li $v0 , 1
		j ml_exit
		
		ml_no_move:
		li $v0 , 0 # return 0 for no moving
		ml_exit:
		
		# pop $ra & $s0-$s4 from the stack
		lw $ra , 0($sp)
		lw $s0 , 4($sp)
		lw $s1 , 8($sp)
		lw $s2 , 12($sp)
		lw $s3 , 16($sp)
		lw $s4 , 20($sp)
		addi $sp , $sp , 24
		
		jr $ra
# *****Your codes end here

#--------------------------------------------------------------------
# procedure: move_player_right()
# Move the player object rightward by one step which is its speed.
# Move the object only when the object will not overlap with a wall cell afterward. 
# $v0=1 if a movement has been made, otherwise $v0=0.
#--------------------------------------------------------------------	
move_player_right:

# *****Task2: you need to complete this procedure move_player_right to perform its operations as described in comments above. 
# Hints:
# Firstly, preserve values $ra, $s0, $s1, $s2, $s3, $s4 with stack
# Then, use the registers as described below:
# 		The x_loc of the player object is in $s0
# 		The y_loc of the player object is in $s1
# 		The address of the player obejct is in $s2
# 		The height of the player object is in $s3
# 		The width of the player object is in $s4 
# Calculate new x_loc of the player object.
# Check whether player's top-right or bottom-right corner is in a wall: 
#		If it is in a wall, then the player can't move
# 		If it is not, then save and set the new x_loc for the player object
# Set $v0=1 if a movement has been made, 0 otherwise
# Lastly, pop and restore values in $ra, $s0, $s1, $s2, $s3, $s4  and return
# Hint: you can refer to move_player_up and move_player_down to get some clues
# *****Your codes start here

		# push $ra & $s0-$s4 to the stack
		addi $sp , $sp , -24
		sw $ra , 0($sp)
		sw $s0 , 4($sp)
		sw $s1 , 8($sp)
		sw $s2 , 12($sp)
		sw $s3 , 16($sp)
		sw $s4 , 20($sp)
		
		la $t0 , player_size # $t0 point to player_size
		lw $s0 , 0($t0) # load the player width to $s0
		lw $s1 , 4($t0) # load the player height to $s1
		la $t0, maze_size
		lw $t3, 0($t0) # maze width for bound checking later 	
		
		la $t0 , player_speed # $t0 point to player_speed
		lw $t2 , 0($t0) # load the player speed to $t2
		la $s2 , player_locs # $s2 point to player_locs
		lw $s3 , 0($s2) # load the x location to $s3
		lw $s4 , 4($s2) # load the y location to $s4
		
		# check if the move is in bound
		addi $t3 , $t3 , -1 # x location of right border is (width - 1)
		add $t9 , $s3 , $s0 # x location of player + player width
		slt $t0 , $t3 , $t9 # check if it is in bound
		beq $t0 , $zero , mr_check_path1 # if it is in bound, then go to check if there are any osobstacles 
		j mr_no_move
		
		mr_check_path1:
		# hitbox checking for player's top-right
		add $s3 , $s3 , $t2 # new x loc = original x-loc + speed
		
		# x loc of right edge of the player to get_bitmap_cell
		add $a0 , $s3 , $s0 
		addi $a0 , $a0 , -1 
		
		
		addi $a1 , $s4 , 0 # pass y loc to get_bitmap_cell
		jal get_bitmap_cell
		bne $v0 , $zero , mr_no_move # if there is blocking , do no move
		
		mr_check_path2:
		# hitbox checking for player's top-right (bottom half part)
		add $a0 , $s3 , $s0 # pass x loc of right edge to get_bitmap_cell
		addi $a0 , $a0 , -1
		addi $a1 , $s4 , 16 # the y loc of the bottom half part to get_bitmap_cell
		jal get_bitmap_cell
		bne $v0 , $zero , mr_no_move # if there is blocking , do no move
		
		mr_move:
		sw $s3 , 0($s2) # update the x location
		
		# update the location of the player in the UI
		la $t0 , player_id
		lw $a0 , 0($t0) # argument : player_id
		addi $a1 , $s3 , 0 # argument : new x location
		addi $a2 , $s4 , 0 # argument : new y location
		li $a3 , 1 # argument : object type ( 1 is player )
		li $v0 , 104
		syscall
		li $v0 , 1
		j mr_exit
		
		mr_no_move:
		li $v0 , 0 # return 0 for no moving
		
		mr_exit:

		# pop $ra & $s0-$s4 from the stack
		lw $ra , 0($sp)
		lw $s0 , 4($sp)
		lw $s1 , 8($sp)
		lw $s2 , 12($sp)
		lw $s3 , 16($sp)
		lw $s4 , 20($sp)
		addi $sp , $sp , 24
		
		jr $ra
# *****Your codes end here

#--------------------------------------------------------------------
# procedure: get_bitmap_cell(x, y)
# Get the bitmap value for the grid cell containing the given pixel coordinate (x, y). 
# The value will be returned in $v0, or -1 will be returned in $v0 if (x, y) is outside the maze.   
# The index of the value in the bitmap array is returned in $v1
#--------------------------------------------------------------------
get_bitmap_cell:
	la $t0, grid_cell_size
	lw $t1, 0($t0) # cell width	
	lw $t2, 4($t0) # cell height	
	la $t0, grid_col_num
	lw $t3, 0($t0) 
	la $t0, maze_size
	lw $t7, 0($t0) # maze width	
	lw $t8, 4($t0) # maze height	
	li $v0, -1 # initialize the return value to -1

	slti $t5, $a0, 0 # check whether x is outside the maze
	bne $t5, $zero, gbc_exit
	slt $t5, $a0, $t7 
	beq $t5, $zero, gbc_exit
	slti $t5, $a1, 0 # check whether y is outside the maze
	bne $t5, $zero, gbc_exit
	slt $t5, $a1, $t8 
	beq $t5, $zero, gbc_exit

	div $a0, $t1
	mflo $t1 # column no. for given x-coordinate
	div $a1, $t2
	mflo $t2 # row no. for given y-coordinate

	# get the cell from the array
	mult $t3, $t2  
	mflo $t3
	add $t3, $t3, $t1 # index of the cell in 1D-array of bitmap
						
	la $t0, maze_bitmap
	add $t0, $t0, $t3
	lb $v0, 0($t0)
	addi $v1,$t3,0
	jr $ra 
	
gbc_exit: 
	jr $ra  
	
### my extra code

### menu section		
	
process_menu_cursor:
	# have inside jal, so push the stack
	addi $sp , $sp , -4
	sw $ra , ($sp)

	la $t0 , input_key
	lw $a0 , ($t0)

	li $t0 , 119 # w key
	li $t1 , 115 # s key
	li $t2 , 32 # space key

	# load the param for moving cursor when input is w/s 
	beq $a0 , $t0 , cursor_up
	beq $a0 , $t1 , cursor_down
	beq $a0 , $t2 , menu_enter
	j menu_exit
	
menu_enter:
	la $t5 , cursor_index
	lw $a2 , ($t5) # get the action index
	
	li $t0 , 3
	beq $a2 , $t0 , exit_the_programm # check if selected option is exit (3)
	li $t0 , 2
	beq $a2 , $t0 , start_survive_game # check if selected option is survive (2)
	li $t0 , 1
	beq $a2 , $t0 , check_score # check if selected option is score checking (1)
	li $t0 , 0
	beq $a2 , $t0 , start_the_game # check if selected option is start (0)
	j menu_exit

exit_the_programm:

	# close the menu
	li $v0 , 122
	syscall

	# terminate the program 
	li $v0 , 10
	syscall	
	
start_survive_game:
	# close the menu
	li $v0 , 122
	syscall
	
	# set survive_started to 1 
	la $t0 , survive_started
	li $t1 , 1
	sw $t1 , ($t0)
	j menu_exit	
	
check_score:
	# open the score screen
	li $v0 , 124
	syscall
	
	# open score file
	li $v0 , 13
	la $a0 , score_file
	li $a1 , 0 # read only
	syscall
	
	move $t0 , $v0
	
	# lazy way to get 0xFFFFFFFF
	li $t1 , 0
	addi $t1 , $t1 , -1
	
	# if $t0 is 0xFFFFFFFF , that means the score file can not be found/openned
	bne $t0 , $t1 , score_file_found
	
	# tell the user, a new score file will be created
	li $v0 , 55
	la $a0 , create_score_file_mes
	li $a1 , 1
	syscall
	
	# create a score file if not exist
	li $v0 , 125
	la $a0 , score_file
	syscall
	
	j score_screen_loop
	
score_file_found:

	# read the file (80 characters)
	li $v0 , 14
	la $a1 , buffer
	li $a2 , 50
	move $a0 , $t0
	syscall
	
	# fill the score screen
	li $v0 , 126
	la $a0 , ($a1)
	syscall
	
	# close the file
	li $v0 , 16
	move $a0 , $t0
	syscall		
	
score_screen_loop:
	# keep showing the score screen until pressing escape 
	jal get_keyboard_input
	
	la $t0 , input_key
	lw $t0 , ($t0)
	li $t1 , 27 # ascii : escape
	beq $t0 , $t1 , score_screen_loop_exit
	
	li $a0, 30 # wait for 30ms 
	jal have_a_nap
		
	j score_screen_loop
	
score_screen_loop_exit:
	# close the score screen
	li $v0 , 124
	syscall
	
	j menu_exit	
	
start_the_game:

	# show the tank selection screen
	li $v0 , 130
	syscall

tank_selection_loop:
	jal get_keyboard_input
	
	jal process_tank_selection
	
	# check if the player has already selected a tank or not
	la $t0 , selected_tank
	lw $t0 , ($t0)
	bne $t0 , $zero , finish_tank_selection
	
	li $a0 , 30 # wait for 30ms
	jal have_a_nap	

	j tank_selection_loop

finish_tank_selection:		

	# close the menu
	li $v0 , 122
	syscall
	
	# set started to 1 
	la $t0 , started
	li $t1 , 1
	sw $t1 , ($t0)
	
	
	j menu_exit		
	
cursor_up:

	la $t0 , cursor_loc
	lw $a0 , 0($t0) # a0 : x location
	lw $a1 , 4($t0) # a1 : y location
	la $t5 , cursor_index
	lw $a2 , ($t5) # get the previous action index
	addi $a2 , $a2 , -1 # update action index ( move up = -1)
	slt $t1 , $a2 , $zero # check if index become negative
	

	
	beq $t1 , $zero , update_cursor # if it is not negative, go to update directly
	# load the max index
	la $t0 , cursor_max_index
	lw $t0 , ($t0)
	
	add $a2 , $a2 , $t0 # add the max index to make it as circular
	
	j update_cursor
	

cursor_down:

	la $t0 , cursor_loc
	lw $a0 , 0($t0) # a0 : x location
	lw $a1 , 4($t0) # a1 : y location
	la $t5 , cursor_index
	lw $a2 , ($t5) # get the previous action index
	addi $a2 , $a2 , 1 # update action index ( move down = +1)
	
	# load the max index
	la $t0 , cursor_max_index
	lw $t0 , ($t0)
	
	# mod by max index (%=3)
	div $a2 , $t0
	mfhi $a2 # get the remainder 
	
	
update_cursor:

	# update cursor index 
	sw $a2 , ($t5)
	
	# calculate the new y location
	la $t0 , cursor_gapY
	lw $t0 , ($t0)
	mult $t0 , $a2
	mflo $t1
	
	# update the new y location
	add $a1 , $a1 , $t1
	
	li $v0 , 121
	syscall
	j menu_exit
	
menu_exit:
	# pop back from stack
	lw $ra , ($sp)
	addi $sp , $sp , 4

	jr $ra
	syscall

### in game section

# function : process pause menu
process_pause_screen:
	
	la $t0 , input_key
	lw $t0 , ($t0)
	
	# if input is escape
	li $t1 , 27
	bne $t0 , $t1 , pause_screen_exit	
	
pause_screen_exit:
	
	jr $ra
	

# function : control stage wait time
process_stage_waiting_time:
	# get the unit timestamp
	li $v0 , 30
	syscall
	
	la $t0 , timer_for_wait_screen
	lw $t0 , ($t0)
	sub $a0 , $a0 , $t0 # calculate the time lapse from reference time
	li $t1 , 1000
	slt $t0 , $a0 , $t1 # check if the time lapse is < 1 seconds
	beq $t0 , $zero , set_finish_waiting
	j stage_waiting_time_exit
	
set_finish_waiting:
	# set finish waiting to 1
	la $t0 , finish_waiting
	li $t1 , 1
	sw $t1 , ($t0)
	
	# close the waiting screen
	li $v0 , 123
	syscall
	
	# save the start time
	la $t0 , start_time
	li $v0 , 30
	syscall
	sw $a0 , 0($t0) # save the low 32 bits to first word of start time
	
stage_waiting_time_exit:		
	
	jr $ra
	
# function : if almost time up, change the bgm to a more intense one	
process_time_almost_up:

	# action is done (only do once)
	la $t0 , after_danger
	lw $t0 , ($t0)
	bne $t0 , $zero , no_time_almost_up

	# check if danger is triggered
	la $t0 , danger
	lw $t0 , ($t0)
	beq $t0 , $zero , no_time_almost_up
	
	# danger action
	li $v0 , 127
	syscall
	
	# action is done
	la $t0 , after_danger
	li $t1 , 1
	sw $t1 , ($t0)
	
no_time_almost_up:	
	
	jr $ra	
	
### survive section

# function : write to bitmap
loop_survive_map:
	la $t0 , maze_bitmap
	
	# get number of col
	la $t1 , map_row
	lw $t1 , ($t1) 
	
	# get number of row
	la $t2 , map_col
	lw $t2 , ($t2)
	
	# calculate the total number of grids
	mult $t1 , $t2
	mflo $t3
	
	li $t4 , 0 # i = 0
	
load_byte_to_map:
	# save next byte to the map
	add $t1 , $t0 , $t4
	sb $zero , ($t1)
	
	# ??? later implement : load by file
	
	addi $t4 , $t4 , 1 # i++
	bne $t3 , $t4 , load_byte_to_map # i != total number of grids
	
	jr $ra
	
# function : init for survive mode
init_survive_mode:
	addi $sp, $sp, -12
	sw $ra, 8($sp)
	sw $s0, 4($sp)
	sw $s1, 0($sp)
	
	# reset
	la $t0 , move_iteration
	sw $zero , ($t0)
	la $t0 , buffered_move_key
	sw $zero , ($t0)
	
	# set life to 3
	la $t0 , life
	li $t1 , 3
	sw $t1 , ($t0)
	
	# create player
	li $v0 , 103
	la $t0 , player_id
	lw $a0 , ($t0)
	# ??? init player location , can make it random
	li $a1 , 96
	li $a2 , 192
	li $a3 , 1
	la $t0 , player_locs
	sw $a1 ,($t0)
	sw $a2 , 4($t0)
	syscall
	
	# create bullet and hide it
	li $v0, 103
	la $t0, bullet_id
	lw $a0, 0($t0) 
	# some where beyond the screen
	li $a1, 1000 
	li $a2, 1000
	li $a3, 3
	la $t0, player_id #id of the corresponding tank 
	lw $t1, 0($t0)
	la $t0, bullet_locs
	sw $a1, 0($t0)
	sw $a2, 4($t0)
	syscall	
	
	# create the specified number of enemys
	la $t0, survive_enemy_num
	lw $a0, 0($t0) 

	la $t0, enemy_ids
	lw $a1, 0($t0)
	lw $a2, 4($t0)
	li $v0, 108
	syscall
	
	# refresh
	li $v0 , 101
	syscall
	lw $ra, 8($sp)
	lw $s0, 4($sp)
	lw $s1, 0($sp)
	addi $sp, $sp, 12
	jr $ra

# function : respawn enemy for survive mode
respawn_enemy:
	# push to stack
	addi $sp , $sp , -4
	sw $ra , ($sp)

	# reset number of alive enemy
	li $v0 , 1
	la $t0 , enemy_alive_num
	sw $v0 , 0($t0)
	
	li $v0 , 1
	la $t0 , enemy1_alive
	sw $v0 , 0($t0)

	# create the specified number of enemys
	la $t0, survive_enemy_num
	lw $a0, 0($t0) 
	
	jal generate_random_location

	la $t0 , enemy_ids
	lw $a0 , ($t0)
	la $a1 , ($v0) # x location 
	la $a2 , ($v1) # y location
#	li $a1 , 0
#	li $a2 , 0
	li $v0, 131
	syscall

	# pop from stack
	lw $ra , ($sp)
	addi $sp , $sp , 4

	jr $ra	
	
	
### tank selection section
process_tank_selection:

	la $t0 , input_key
	lw $t0 , ($t0)
	
	li $t1 , 97 # ascii code of a 		
	beq $t0 , $t1 , tank_selection_cursor_move_left
	li $t1 , 100 # ascii code of d 		
	beq $t0 , $t1 , tank_selection_cursor_move_right
	li $t1 , 32 # ascii code of space 		
	beq $t0 , $t1 , tank_selection_enter	

	j process_tank_selection_exit
tank_selection_cursor_move_left:


	# tank selection move left (-1)
	la $t0 , tank_selection_index
	lw $a0 , ($t0)
	addi $a0 , $a0 , -1
	
	slt $t1 , $a0 , $zero # check if index become negative
	beq $t1 , $zero , update_tank_index
	
	# load the max index
	la $t0 , tank_selection_max_index
	lw $t0 , ($t0)
	
	add $a0 , $a0 , $t0 # add the max index to make it as circular

	j update_tank_index
	
tank_selection_cursor_move_right:
	# tank selection move right (+1)
	la $t0 , tank_selection_index
	lw $a0 , ($t0)
	addi $a0 , $a0 , 1
	
	# load the max index
	la $t0 , tank_selection_max_index
	lw $t0 , ($t0)
	
	# mod by max index (%=2)
	div $a0 , $t0
	mfhi $a0 # get the remainder 

	j update_tank_index
	
update_tank_index:

	# update the tank index in data
	la $t0 , tank_selection_index
	sw $a0 , ($t0)

	# update selected tank image ($a0 is ready)
	li $v0 , 129
	syscall

	j process_tank_selection_exit		
	
tank_selection_enter:

	# update selected_tank to 1
	la $t0 , selected_tank
	li $t1 , 1
	sw $t1 , ($t0)
	
	
	j process_tank_selection_exit
	
process_tank_selection_exit:
	
	jr $ra	
	
	
### helper procedure

# function : print bitmap in console
print_the_bitmap:
	la $t0 , maze_bitmap
	
	# get number of col
	la $t1 , map_row
	lw $t1 , ($t1) 
	
	# get number of row
	la $t2 , map_col
	lw $t2 , ($t2)
	
	# calculate the total number of grids
	mult $t1 , $t2
	mflo $t3
	
	li $t4 , 0 # i = 0
	li $t5 , 0 # j = 0
	
print_map_loop:
	# get next byte of the map
	add $t6 , $t0 , $t4
	lbu $t6 , ($t6)
	
	# print the byte
	li $v0 , 1
	la $a0 , ($t6)
	syscall
	
	# print a space
	li $v0 , 4
	la $a0 , temp
	syscall
	
	addi $t5 , $t5 , 1 # j++
	
	bne $t5 , $t2 , no_new_line # j != number of col
	
	# print 
	li $v0 , 4
	la $a0 , temp2
	syscall
	
	la $t5 , ($zero)
no_new_line:

	addi $t4 , $t4 , 1 # i++
	bne $t3 , $t4 , print_map_loop # i != total number of grids	
	
	jr $ra	
	

# function : update score text
# update the score text
update_score:
	# get the score
	la $t0 , score
	lw $t0 , ($t0)
	
	# get the number of digits of the score text
	la $t1 , score_digits
	lw $t1 , ($t1)
	
	la $t2 , ($t1) # i = number of digits
	
# update score message, digit by digit	
update_score_loop:
	la $t3 , ($t2) # j = i
	li $t4 , 1 # k = 1
	
time_ten_loop:

	addi $t3 , $t3 , -1 # j--
	beq $t3 , $zero , time_ten_loop_exit # if j == 0 , stop time ten

	# k *= 10
	li $t5 , 10
	mult $t4 , $t5
	mflo $t4
	
	j time_ten_loop	
	
time_ten_loop_exit:

	div $t0 , $t4 # score / k
	mflo $t4 # number in i(th) digit
	mfhi $t0 # move remainder to score
	
	addi $t4 , $t4 , 48 # ascii 0 = 48
	
	# j = number of digits - i
	la $t3 , ($t1) 
	sub $t3 , $t3 , $t2 

	la $t5 , score_mes	
# save the ascii code back to the right bit
digit_shifting_loop:	

	beq $t3 , $zero , digit_shifting_loop_exit # if j == 0 , stop shifting
	addi $t3 , $t3 , -1 # j--
	add $t5 , $t5 , 1 # shift by 1 digit
	
	j digit_shifting_loop
	
digit_shifting_loop_exit:

	# update the i(th) digit in score message
	sb $t4 , ($t5)
	
	addi $t2 , $t2 , -1 # i--
	beq $t2 , $zero , update_score_loop_exit # if i == 0 , it is finished		

	j update_score_loop	

update_score_loop_exit:		

	li $v0 , 105
	li $a0 , 11
	la $t0 , score_loc
	lw $a1 , 0($t0)
	lw $a2 , 4($t0)
	la $a3 , score_mes
	syscall
	jr $ra

# function : update timer
# update the timer and return the time lapse (unit : second)
update_timer:
	
	# get the unit timestamp
	li $v0 , 30
	syscall
	
	la $t0 , start_time
	lw $t0 , ($t0)
	sub $a0 , $a0 , $t0 # calculate the time lapse since the start time
	
	li $t1 , 1000 # used to change ms to s
	div $a0 , $t1 # divide the time lapse by 1000
	mflo $a0 # move the quotient to $a0
	la $t7 , ($a0) # back up the time lapse (sec) to $t7
	
	# check if it is almost time up
	la $t5 , danger_time
	lw $t5 , ($t5)
	slt $t4 , $t5 , $t7 
	beq $t4 , $zero , no_danger
	
	# trigger danger 
	la $t5 , danger
	li $t4 , 1
	sw $t4 , ($t5)
	
no_danger:	
	
	# only support 0-99 second
	
	li $t1 , 10 # used to get the first digit of the timer
	div $a0 , $t1 # divide the time lapse (sec) by 10
	mflo $a1 # move the first digit of the timer to $a1
	mfhi $a0 # move the second digit of the timer to $a0
	
	la $t0 , timer_mes
	
	addi $a0 , $a0 , 48 # ascii 0 = 48
	sll $a0 , $a0 , 8 # shift 8 bits (ascii take 8 bits per char) & little endian, so start with last digit
	addi $a1 , $a1 , 48 # ascii 0 = 48
	
	add $t0 , $a0 , $zero
	add $t0 , $a1 , $t0
	sw $t0 , timer_mes
	
	li $v0, 105
	li $a0,10
	la $t0,timer_loc
	lw $a1,0($t0)
	lw $a2,4($t0)
	la $a3,timer_mes
	syscall
	
	# return the time lapse
	la $v0 , ($t7)
	
	jr $ra			

# function : add score		
add_score:
	# get the current score
	la $t0 , score
	lw $t1 , ($t0)
	
	# add it by 10
	li $t2 , 10
	add $t1 , $t1 , $t2
	
	# update the score
	sw $t1 , ($t0)
	
	jr $ra	

# function : check cheat code
checking_cheat_code:
	la $t0 , input_key
	lw $t0 , ($t0)
	
	beq $t0 , $zero , checking_cheat_code_exit # input key 0 = no input
	
	# get how the number of success cheat code match count
	la $t1 , cheat_code_match_count
	lw $t2 , ($t1)
	
	# get the next code to check
	la $t3 , cheat_code
	add $t3 , $t3 , $t2	
	lbu $t3 , ($t3)
	
	bne $t0 , $t3 , cheat_code_not_match # if the next code is not the input key
	
	# match count ++
	addi $t2 , $t2 , 1
	# update the match count
	sw $t2 , ($t1)

	# hardcode , later implement
	li $t5 , 4
	bne $t2 , $t5 , checking_cheat_code_exit # if the cheat code is not activated yet
	
	# reset cheat code count
	sw $zero , ($t1)
	
	# activate the instant win
	la $t5 , winned
	li $t4 , 1
	sw $t4 , ($t5)

cheat_code_not_match:
	# reset the cheat code count
	sw $zero , ($t1) 			

checking_cheat_code_exit:
	
	jr $ra
	
# function : check if the given location is open for spawn new thing or not	
# $v0 : 0 = is open
check_if_location_is_open:

	# push $ra to stack
	addi $sp , $sp , -4
	sw $ra , ($sp)

	# check for bitmap first
	jal get_bitmap_cell
	
	# pop $ra from stack
	lw $ra , ($sp)
	addi $sp , $sp , 4

	jr $ra

# function : print $a0 for testing
testing_print:
	li $v0 , 1
	syscall		
	jr $ra 	

# function : generate random location inside the map
# v0 : x loc , v1 : y loc
generate_random_location:

	# see as system time
	li $v0 , 30
	syscall
	la $t1 , ($a0) # backup the system time for generating col later
	la $a1 , ($a0)
	li $a0 , 0
	li $v0 , 40
	syscall
	
	# hardcode number of row 
	li $a1 , 25
	
	li $a0 , 0
	li $v0 , 42
	syscall
	# x location (16x16 pixel per grid) , save it as $t5 and return as $v0 later
	li $t0 , 16
	mult $a0 , $t0 # x * 16
	mflo $t5
	
	# hardcode number of rcol
	li $a1 , 25
	
	li $a0 , 0
	li $v0 , 42
	syscall
	# y location (16x16 pixel per grid) , save it as $v1 for return
	li $t0 , 16
	mult $a0 , $t0 # y * 16
	mflo $v1
	
	la $v0 , ($t5) # load x location to $v0 for return	

	jr $ra	
	
# function : update the life to the screen	
update_life:
	la $t0 , life
	lw $t0 , ($t0)
	
	addi $t0 , $t0 , 48 # ascii 0 = 48
	
	sw $t0 , life_mes
	
	li $v0 , 105
	li $a0 , 10
	la $t0 , life_loc
	lw $a1 , 0($t0)
	lw $a2 , 4($t0)
	la $a3 , life_mes
	syscall

	jr $ra					
