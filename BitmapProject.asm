#Zeeshan Khurram
#Bitmap Project
#Pattern Recognition Game - RING

#################################################################################################################################
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	INSTRUCTIONS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#1.	The game is called Ring, it is a pattern recognition game. You will be shown 10 commands.			      	#
#2.	The goal is to press those 10 commands in the order they light up, if you get them right you win, else you lose     	#
#3.	To start the game, open the bitmap display and keyboard display, connect both to mips					#
#4.---- IN BITMAP DISPLAY, SET UNIT WIDTH AND HEIGHT OF PIXELS TO 4. DISPLAY WIDTH AND HEIGHT TO 256, BASE ADDRESS TO GP--------#
#5.	Then Assemble and Run the program, you will be promted to the home screen, which says RING				#
#6.	Type 0 in the keyboard display to start the game, press space button to terminate					#
#7.	Once you start the game, a red board screen will show up, it will look like a 3x3 box with dots to indicate numbers	#
#8.	One dot means 1, 9 dots means 9, etc... a box will be highlighted at random, then pause, then highlight again		#
#9.	This will continue 10 times, meaning 10 boxes will be highlighted, keep track of the number and order they highlight	#
#10.	Once they are finished highlighting, the box turns white, that means this is your turn to input in the Keyboard Display	#
#11.	Input the numbers of the boxes that were highlighted in the order they were highlighted					#
#12.	After typing a number, if the number was correct, the box highlights green						#
#13.	Wait for the box to turn white again, then input the next number							#	#
#14.	If you type all the 10 numbers correctly, a win message in the console will show up.					#
#15.	If any number was wrong, a lose screen will show up and program terminates, GAME OVER					#
#16.	Reset Bitmap Display and re execute program if you want to play again							#
#################################################################################################################################


# set up some constants
# width of screen in pixels
# 256 / 8 = 32
.eqv WIDTH 64
# height of screen in pixels
.eqv HEIGHT 64
# colors
.eqv	RED 	0x00FF0000
.eqv 	BLACK	0x00000000
.eqv	GREEN 	0x0000FF00
.eqv	WHITE	0x00FFFFFF

.data
int1:		.word		1
int2:		.word		1
int3:		.word		1
int4:		.word		1
int5:		.word		1
int6:		.word		1
int7:		.word		1
int8:		.word		1
int9:		.word		1
int10:		.word		1
delay:		.word		500
sdelay:		.word		250
winner:		.word		0	#0 if not winner, 1 if winner
msg:		.asciiz		"You have won!"

.text
main:
	# set up starting position
	addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi 	$a2, $0, RED  # a2 = red (ox00RRGGBB)
	
loop:
	addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	jal	draw_R
	
	# check for input
	lw $t0, 0xffff0000  #t1 holds if input available
    	beq $t0, 0, loop   #If no input, keep displaying
    	
    	# process input
	lw 	$s1, 0xffff0004
	beq	$s1,	48,	gameS	#if input 0, start the game
	beq	$s1, 32, exit	# input space

	# invalid input, ignore
	j	loop
	
gameS:	
	addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi 	$a2, $0, BLACK  # a2 = red (ox00RRGGBB)
	jal	draw_R					#Black out the RING message
	
	addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi 	$a2, $0, RED  # a2 = red (ox00RRGGBB)
	jal	draw_B					#draw out the board
	
	#########################Generate 10 random integers##################
	li 	$a1, 	9 	#max bound =9, the numbers are 0-8 
	li	$v0,	42
	syscall
	sw	$a0,	int1
	li	$v0,	42
	syscall
	sw	$a0,	int2
	li	$v0,	42
	syscall
	sw	$a0,	int3
	li	$v0,	42
	syscall
	sw	$a0,	int4
	li	$v0,	42
	syscall
	sw	$a0,	int5
	li	$v0,	42
	syscall
	sw	$a0,	int6
	li	$v0,	42
	syscall
	sw	$a0,	int7
	li	$v0,	42
	syscall
	sw	$a0,	int8
	li	$v0,	42
	syscall
	sw	$a0,	int9
	li	$v0,	42
	syscall
	sw	$a0,	int10
	##############################Highlight the numbers on screen#############
	lw	$a3,	int1
	jal	highlight
	jal	pause
	lw	$a3,	int2
	jal	highlight
	jal	pause
	lw	$a3,	int3
	jal	highlight
	jal	pause
	lw	$a3,	int4
	jal	highlight
	jal	pause
	lw	$a3,	int5
	jal	highlight
	jal	pause
	lw	$a3,	int6
	jal	highlight
	jal	pause
	lw	$a3,	int7
	jal	highlight
	jal	pause
	lw	$a3,	int8
	jal	highlight
	jal	pause
	lw	$a3,	int9
	jal	highlight
	jal	pause
	lw	$a3,	int10
	jal	highlight
	jal	pause
	###################Turn the board green to signal end############################
	addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi 	$a2, $0, WHITE
	
	jal	draw_B
	######################Check for input and see if it is correct########################
	jal	check
	addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi 	$a2, $0, BLACK  # a2 = red (ox00RRGGBB)	#reset screen for winner/loser screen
	jal	draw_B
	lw	$t5,	winner
	beq	$t5,	1,	isw
	j	isl	#if not winner, jump to loser screen
exit:	li	$v0, 10
	syscall
	
#############################If loser, go to loser screeen#############################
isl:	
	addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi 	$a2, $0, RED	#reset coords
	addi	$a0,	$a0,	-15
	addi	$a1,	$a1,	-15
	
	li	$t1,	30
	li	$t2,	0	#counter for loop
lloop:	beq	$t2,	$t1,	ello	#base case
	jal	draw_pixel
	addi	$a1,	$a1,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	jal	draw_pixel
	addi	$a1,	$a1,	-3
	addi	$a0,	$a0,	1
	addi	$t2,	$t2,	1
	j	lloop
ello:
	li	$t2,	0
	addi	$a1,	$a1,	-30
lloop2:	beq	$t2,	$t1,	ello2	#base case
	jal	draw_pixel
	addi	$a1,	$a1,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	jal	draw_pixel
	addi	$a1,	$a1,	-3
	addi	$a0,	$a0,	-1
	addi	$t2,	$t2,	1
	j	lloop2
ello2:
	j	exit
	
########################################Function to check if inputs are right
check:
	addi	$sp,	$sp,	-4
	sw	$ra,	($sp)
	#increase all the values of the int plus 49 to help with beq
	lw	$t1,	int1
	addi	$t1,	$t1,	49
	sw	$t1,	int1
	lw	$t1,	int2
	addi	$t1,	$t1,	49
	sw	$t1,	int2
	lw	$t1,	int3
	addi	$t1,	$t1,	49
	sw	$t1,	int3
	lw	$t1,	int4
	addi	$t1,	$t1,	49
	sw	$t1,	int4
	lw	$t1,	int5
	addi	$t1,	$t1,	49
	sw	$t1,	int5
	lw	$t1,	int6
	addi	$t1,	$t1,	49
	sw	$t1,	int6
	lw	$t1,	int7
	addi	$t1,	$t1,	49
	sw	$t1,	int7
	lw	$t1,	int8
	addi	$t1,	$t1,	49
	sw	$t1,	int8
	lw	$t1,	int9
	addi	$t1,	$t1,	49
	sw	$t1,	int9
	lw	$t1,	int10
	addi	$t1,	$t1,	49
	sw	$t1,	int10
	
	lw	$t6,	int1
cloop:	
	# check for input
	lw $t0, 0xffff0000  #t1 holds if input available
    	beq $t0, 0, cloop   #If no input, keep displaying
    	
    	# process input
	lw 	$s1, 0xffff0004
	beq	$s1,	$t6,	corr	#the input was correct, move to second check

	# invalid input, exit
	j	wrong	
corr:
	addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi 	$a2, $0, GREEN  # a2 = red (ox00RRGGBB)
	jal	draw_B
	jal	spause
	addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi 	$a2, $0, WHITE  # a2 = red (ox00RRGGBB)
	jal	draw_B
	lw	$t6,	int2
cloop2:
	lw $t0, 0xffff0000  #t1 holds if input available
    	beq $t0, 0, cloop2   #If no input, keep displaying
    	
    	# process input
	lw 	$s1, 0xffff0004
	beq	$s1,	$t6,	corr2	#the input was correct, move to next check

	# invalid input, exit
	j	wrong	
corr2:
addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi 	$a2, $0, GREEN  # a2 = red (ox00RRGGBB)
	jal	draw_B
	jal	spause
	addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi 	$a2, $0, WHITE  # a2 = red (ox00RRGGBB)
	jal	draw_B
lw	$t6,	int3
cloop3:
	lw $t0, 0xffff0000  #t1 holds if input available
    	beq $t0, 0, cloop3   #If no input, keep displaying
    	
    	# process input
	lw 	$s1, 0xffff0004
	beq	$s1,	$t6,	corr3	#the input was correct, move to next check

	# invalid input, exit
	j	wrong	
corr3:
addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi 	$a2, $0, GREEN  # a2 = red (ox00RRGGBB)
	jal	draw_B
	jal	spause
	addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi 	$a2, $0, WHITE  # a2 = red (ox00RRGGBB)
	jal	draw_B
lw	$t6,	int4
cloop4:
	lw $t0, 0xffff0000  #t1 holds if input available
    	beq $t0, 0, cloop4   #If no input, keep displaying
    	
    	# process input
	lw 	$s1, 0xffff0004
	beq	$s1,	$t6,	corr4	#the input was correct, move to next check

	# invalid input, exit
	j	wrong	
corr4:
addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi 	$a2, $0, GREEN  # a2 = red (ox00RRGGBB)
	jal	draw_B
	jal	spause
	addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi 	$a2, $0, WHITE  # a2 = red (ox00RRGGBB)
	jal	draw_B
lw	$t6,	int5
cloop5:
	lw $t0, 0xffff0000  #t1 holds if input available
    	beq $t0, 0, cloop5   #If no input, keep displaying
    	
    	# process input
	lw 	$s1, 0xffff0004
	beq	$s1,	$t6,	corr5	#the input was correct, move to next check

	# invalid input, exit
	j	wrong	
corr5:
addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi 	$a2, $0, GREEN  # a2 = red (ox00RRGGBB)
	jal	draw_B
	jal	spause
	addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi 	$a2, $0, WHITE  # a2 = red (ox00RRGGBB)
	jal	draw_B
lw	$t6,	int6
cloop6:
	lw $t0, 0xffff0000  #t1 holds if input available
    	beq $t0, 0, cloop6   #If no input, keep displaying
    	
    	# process input
	lw 	$s1, 0xffff0004
	beq	$s1,	$t6,	corr6	#the input was correct, move to next check

	# invalid input, exit
	j	wrong	
corr6:
addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi 	$a2, $0, GREEN  # a2 = red (ox00RRGGBB)
	jal	draw_B
	jal	spause
	addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi 	$a2, $0, WHITE  # a2 = red (ox00RRGGBB)
	jal	draw_B
lw	$t6,	int7
cloop7:
	lw $t0, 0xffff0000  #t1 holds if input available
    	beq $t0, 0, cloop7   #If no input, keep displaying
    	
    	# process input
	lw 	$s1, 0xffff0004
	beq	$s1,	$t6,	corr7	#the input was correct, move to next check

	# invalid input, exit
	j	wrong	
corr7:
addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi 	$a2, $0, GREEN  # a2 = red (ox00RRGGBB)
	jal	draw_B
	jal	spause
	addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi 	$a2, $0, WHITE  # a2 = red (ox00RRGGBB)
	jal	draw_B
lw	$t6,	int8
cloop8:
	lw $t0, 0xffff0000  #t1 holds if input available
    	beq $t0, 0, cloop8   #If no input, keep displaying
    	
    	# process input
	lw 	$s1, 0xffff0004
	beq	$s1,	$t6,	corr8	#the input was correct, move to next check

	# invalid input, exit
	j	wrong	
corr8:
addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi 	$a2, $0, GREEN  # a2 = red (ox00RRGGBB)
	jal	draw_B
	jal	spause
	addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi 	$a2, $0, WHITE  # a2 = red (ox00RRGGBB)
	jal	draw_B
lw	$t6,	int9
cloop9:
	lw $t0, 0xffff0000  #t1 holds if input available
    	beq $t0, 0, cloop9   #If no input, keep displaying
    	
    	# process input
	lw 	$s1, 0xffff0004
	beq	$s1,	$t6,	corr9	#the input was correct, move to next check

	# invalid input, exit
	j	wrong	
corr9:
addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi 	$a2, $0, GREEN  # a2 = red (ox00RRGGBB)
	jal	draw_B
	jal	spause
	addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi 	$a2, $0, WHITE  # a2 = red (ox00RRGGBB)
	jal	draw_B
lw	$t6,	int10
cloop10:
	lw $t0, 0xffff0000  #t1 holds if input available
    	beq $t0, 0, cloop10   #If no input, keep displaying
    	
    	# process input
	lw 	$s1, 0xffff0004
	beq	$s1,	$t6,	corr10	#the input was correct, move to next check

	# invalid input, exit
	j	wrong	
corr10:
addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi 	$a2, $0, GREEN  # a2 = red (ox00RRGGBB)
	jal	draw_B
	jal	spause
	addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi 	$a2, $0, WHITE  # a2 = red (ox00RRGGBB)
	jal	draw_B
	lw	$t6,	winner
	addi	$t6,	$t6,	1
	sw	$t6,	winner
wrong:	
	addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi 	$a2, $0, RED  # a2 = red (ox00RRGGBB)
	jal	draw_B
	lw	$ra,	($sp)
	addi	$sp,	$sp,	4
	jr 	$ra
	
	
#a3 contains the int to highlight
highlight:
	addi	$sp,	$sp,	-4
	sw	$ra,	($sp)

	beq	$a3,	0,	hi1
	beq	$a3,	1,	hi2
	beq	$a3,	2,	hi3
	beq	$a3,	3,	hi4
	beq	$a3,	4,	hi5
	beq	$a3,	5,	hi6
	beq	$a3,	6,	hi7
	beq	$a3,	7,	hi8
	beq	$a3,	8,	hi9
return1:
return2:
return3:
return4:
return5:
return6:
return7:
return8:
return9:
	jal	pause
	lw	$ra,	($sp)
	addi	$sp,	$sp,	4
	jr 	$ra

#################################################
# subroutine to draw a pixel
# $a0 = X
# $a1 = Y
# $a2 = color
draw_pixel:
	# s1 = address = $gp + 4*(x + y*width)
	addi	$sp,	$sp,	-4
	sw	$ra,	($sp)
	
	mul	$t9, $a1, WIDTH   # y * WIDTH
	add	$t9, $t9, $a0	  # add X
	mul	$t9, $t9, 4	  # multiply by 4 to get word offset
	add	$t9, $t9, $gp	  # add to base address
	sw	$a2, ($t9)	  # store color at memory location
	
	lw	$ra,	($sp)
	addi	$sp,	$sp,	4
	jr 	$ra
	
	#########################highlight the first box#######################
hi1:

	addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi	$a0,	$a0,	-5
	addi	$a1,	$a1,	-15
	
	li	$t3,	0	#loop counter
	li	$t4,	10	#number of times to loop
hil1:	beq	$t3,	$t4,	ehi1
	addi	$a0,	$a0,	-10
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	addi	$t3,	$t3,	1
	j	hil1
ehi1:	
	jal	pause
	addi 	$a2, $0, BLACK  # a2 = red (ox00RRGGBB)
	
	addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi	$a0,	$a0,	-5
	addi	$a1,	$a1,	-15
	
	li	$t3,	0	#loop counter
	li	$t4,	10	#number of times to loop
uhil1:	beq	$t3,	$t4,	uehi1
	addi	$a0,	$a0,	-10
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	addi	$t3,	$t3,	1
	j	uhil1
uehi1:
	addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi 	$a2, $0, RED  # a2 = red (ox00RRGGBB)
	jal	draw_B
	
	j	return1

#########################highlight the second box#######################
hi2:

	addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi	$a0,	$a0,	5
	addi	$a1,	$a1,	-15
	
	li	$t3,	0	#loop counter
	li	$t4,	10	#number of times to loop
hil2:	beq	$t3,	$t4,	ehi2
	addi	$a0,	$a0,	-10
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	addi	$t3,	$t3,	1
	j	hil2
ehi2:	
	jal	pause
	addi 	$a2, $0, BLACK  # a2 = red (ox00RRGGBB)
	
	addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi	$a0,	$a0,	5
	addi	$a1,	$a1,	-15
	
	li	$t3,	0	#loop counter
	li	$t4,	10	#number of times to loop
uhil2:	beq	$t3,	$t4,	uehi2
	addi	$a0,	$a0,	-10
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	addi	$t3,	$t3,	1
	j	uhil2
uehi2:
	addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi 	$a2, $0, RED  # a2 = red (ox00RRGGBB)
	jal	draw_B
	
	j return2
	
#########################highlight the third box#######################
hi3:

	addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi	$a0,	$a0,	15
	addi	$a1,	$a1,	-15
	
	li	$t3,	0	#loop counter
	li	$t4,	10	#number of times to loop
hil3:	beq	$t3,	$t4,	ehi3
	addi	$a0,	$a0,	-10
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	addi	$t3,	$t3,	1
	j	hil3
ehi3:	
	jal	pause
	addi 	$a2, $0, BLACK  # a2 = red (ox00RRGGBB)
	
	addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi	$a0,	$a0,	15
	addi	$a1,	$a1,	-15
	
	li	$t3,	0	#loop counter
	li	$t4,	10	#number of times to loop
uhil3:	beq	$t3,	$t4,	uehi3
	addi	$a0,	$a0,	-10
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	addi	$t3,	$t3,	1
	j	uhil3
uehi3:
	addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi 	$a2, $0, RED  # a2 = red (ox00RRGGBB)
	jal	draw_B
	
	j return3
	
	#########################highlight the foruth box#######################
hi4:

	addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi	$a0,	$a0,	-5
	addi	$a1,	$a1,	-5
	
	li	$t3,	0	#loop counter
	li	$t4,	10	#number of times to loop
hil4:	beq	$t3,	$t4,	ehi4
	addi	$a0,	$a0,	-10
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	addi	$t3,	$t3,	1
	j	hil4
ehi4:	
	jal	pause
	addi 	$a2, $0, BLACK  # a2 = red (ox00RRGGBB)
	
	addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi	$a0,	$a0,	-5
	addi	$a1,	$a1,	-5
	
	li	$t3,	0	#loop counter
	li	$t4,	10	#number of times to loop
uhil4:	beq	$t3,	$t4,	uehi4
	addi	$a0,	$a0,	-10
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	addi	$t3,	$t3,	1
	j	uhil4
uehi4:
	addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi 	$a2, $0, RED  # a2 = red (ox00RRGGBB)
	jal	draw_B
	
	j	return4
	
#########################highlight the fifth box#######################
hi5:

	addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi	$a0,	$a0,	5
	addi	$a1,	$a1,	-5
	
	li	$t3,	0	#loop counter
	li	$t4,	10	#number of times to loop
hil5:	beq	$t3,	$t4,	ehi5
	addi	$a0,	$a0,	-10
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	addi	$t3,	$t3,	1
	j	hil5
ehi5:	
	jal	pause
	addi 	$a2, $0, BLACK  # a2 = red (ox00RRGGBB)
	
	addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi	$a0,	$a0,	5
	addi	$a1,	$a1,	-5
	
	li	$t3,	0	#loop counter
	li	$t4,	10	#number of times to loop
uhil5:	beq	$t3,	$t4,	uehi5
	addi	$a0,	$a0,	-10
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	addi	$t3,	$t3,	1
	j	uhil5
uehi5:
	addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi 	$a2, $0, RED  # a2 = red (ox00RRGGBB)
	jal	draw_B
	
	j	return5
	
#########################highlight the fifth box#######################
hi6:

	addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi	$a0,	$a0,	15
	addi	$a1,	$a1,	-5
	
	li	$t3,	0	#loop counter
	li	$t4,	10	#number of times to loop
hil6:	beq	$t3,	$t4,	ehi6
	addi	$a0,	$a0,	-10
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	addi	$t3,	$t3,	1
	j	hil6
ehi6:	
	jal	pause
	addi 	$a2, $0, BLACK  # a2 = red (ox00RRGGBB)
	
	addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi	$a0,	$a0,	15
	addi	$a1,	$a1,	-5
	
	li	$t3,	0	#loop counter
	li	$t4,	10	#number of times to loop
uhil6:	beq	$t3,	$t4,	uehi6
	addi	$a0,	$a0,	-10
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	addi	$t3,	$t3,	1
	j	uhil6
uehi6:
	addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi 	$a2, $0, RED  # a2 = red (ox00RRGGBB)
	jal	draw_B
	
	j	return6
	
	#########################highlight the secenth box#######################
hi7:

	addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi	$a0,	$a0,	-5
	addi	$a1,	$a1,	6
	
	li	$t3,	0	#loop counter
	li	$t4,	10	#number of times to loop
hil7:	beq	$t3,	$t4,	ehi7
	addi	$a0,	$a0,	-10
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	addi	$t3,	$t3,	1
	j	hil7
ehi7:	
	jal	pause
	addi 	$a2, $0, BLACK  # a2 = red (ox00RRGGBB)
	
	addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi	$a0,	$a0,	-5
	addi	$a1,	$a1,	6
	
	li	$t3,	0	#loop counter
	li	$t4,	10	#number of times to loop
uhil7:	beq	$t3,	$t4,	uehi7
	addi	$a0,	$a0,	-10
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	addi	$t3,	$t3,	1
	j	uhil7
uehi7:
	addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi 	$a2, $0, RED  # a2 = red (ox00RRGGBB)
	jal	draw_B
	
	j	return7

	#########################highlight the eigth box#######################
hi8:

	addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi	$a0,	$a0,	5
	addi	$a1,	$a1,	6
	
	li	$t3,	0	#loop counter
	li	$t4,	10	#number of times to loop
hil8:	beq	$t3,	$t4,	ehi8
	addi	$a0,	$a0,	-10
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	addi	$t3,	$t3,	1
	j	hil8
ehi8:	
	jal	pause
	addi 	$a2, $0, BLACK  # a2 = red (ox00RRGGBB)
	
	addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi	$a0,	$a0,	5
	addi	$a1,	$a1,	6
	
	li	$t3,	0	#loop counter
	li	$t4,	10	#number of times to loop
uhil8:	beq	$t3,	$t4,	uehi8
	addi	$a0,	$a0,	-10
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	addi	$t3,	$t3,	1
	j	uhil8
uehi8:
	addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi 	$a2, $0, RED  # a2 = red (ox00RRGGBB)
	jal	draw_B
	
	j	return8
	
	#########################highlight the ninth box#######################
hi9:

	addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi	$a0,	$a0,	15
	addi	$a1,	$a1,	6
	
	li	$t3,	0	#loop counter
	li	$t4,	10	#number of times to loop
hil9:	beq	$t3,	$t4,	ehi9
	addi	$a0,	$a0,	-10
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	addi	$t3,	$t3,	1
	j	hil9
ehi9:	
	jal	pause
	addi 	$a2, $0, BLACK  # a2 = red (ox00RRGGBB)
	
	addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi	$a0,	$a0,	15
	addi	$a1,	$a1,	6
	
	li	$t3,	0	#loop counter
	li	$t4,	10	#number of times to loop
uhil9:	beq	$t3,	$t4,	uehi9
	addi	$a0,	$a0,	-10
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	addi	$t3,	$t3,	1
	j	uhil9
uehi9:
	addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi 	$a2, $0, RED  # a2 = red (ox00RRGGBB)
	jal	draw_B
	
	j	return9
#################################################################
#Draws the Board for the game
draw_B:
	addi	$sp,	$sp,	-4
	sw	$ra,	($sp)
	
	li	$t8,	0	#counter for loop
	li	$t7,	30	#number of times to loop
	
	addi	$a0,	$a0,	-15
	addi	$a1,	$a1,	-15
	jal 	draw_pixel
#draw the top side of the box 
up_L:	bgt	$t8,	$t7,	e_up
	jal	draw_pixel
	addi	$t8,	$t8,	1
	addi	$a0,	$a0,	1
	j	up_L
e_up:
	li	$t8,	0
#draw the right side of the box	
rigt_L:	bgt	$t8,	$t7,	e_rigt
	jal	draw_pixel
	addi	$t8,	$t8,	1
	addi	$a1,	$a1,	1
	j	rigt_L
e_rigt:
	li	$t8,	0
#draw the down side of the box
down_L:	bgt	$t8,	$t7,	e_down
	jal	draw_pixel
	addi	$t8,	$t8,	1
	addi	$a0,	$a0,	-1
	j	down_L
e_down:
	li	$t8,	0
#draw the left side of the box
left_L:	bgt	$t8,	$t7,	e_left
	jal	draw_pixel
	addi	$t8,	$t8,	1
	addi	$a1,	$a1,	-1
	j	left_L
e_left:
	li	$t8,	0
	
	#draw line going through 1/3 of the way
	addi	$a0,	$a0,	10
lin1_L:	bgt	$t8,	$t7,	e_lin1
	jal	draw_pixel
	addi	$t8,	$t8,	1
	addi	$a1,	$a1,	1
	j	lin1_L
e_lin1:
	li	$t8,	0
	
	#draw line going through 2/3 of the way
	addi	$a0,	$a0,	10
lin2_L:	bgt	$t8,	$t7,	e_lin2
	jal	draw_pixel
	addi	$t8,	$t8,	1
	addi	$a1,	$a1,	-1
	j	lin2_L
e_lin2:
	li	$t8,	0
	
	#draw	line going through 1/3 the way but horizantal
	addi	$a0,	$a0,	-20
	addi	$a1,	$a1,	10
lin3_L:	bgt	$t8,	$t7,	e_lin3
	jal	draw_pixel
	addi	$t8,	$t8,	1
	addi	$a0,	$a0,	1
	j	lin3_L
e_lin3:
	li	$t8,	0
	
	#draw	line going through 2/3 the way but horizantal
	addi	$a0,	$a0,	-30
	addi	$a1,	$a1,	10
lin4_L:	bgt	$t8,	$t7,	e_lin4
	jal	draw_pixel
	addi	$t8,	$t8,	1
	addi	$a0,	$a0,	1
	j	lin4_L
e_lin4:
	li	$t8,	0
	######################Draw the numbers################################
	addi	$a0,	$a0,	-47
	addi	$a1,	$a1,	-15
	#Draw 1
	addi	$a0,	$a0,	10
	addi	$a0,	$a0,	10
	jal	draw_pixel
	#Draw 2
	addi	$a0,	$a0,	9
	jal	draw_pixel
	addi	$a0,	$a0,	2
	jal	draw_pixel
	#draw 3
	addi	$a0,	$a0,	8
	jal	draw_pixel
	addi	$a0,	$a0,	2
	jal	draw_pixel
	addi	$a0,	$a0,	-1
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	#draw 4
	addi	$a0,	$a0,	-21
	addi	$a1,	$a1,	10
	jal	draw_pixel
	addi	$a0,	$a0,	2
	jal	draw_pixel
	addi	$a1,	$a1,	2
	jal	draw_pixel
	addi	$a0,	$a0,	-2
	jal	draw_pixel
	#draw 5
	addi	$a0,	$a0,	10
	addi	$a1,	$a1,	-2
	jal	draw_pixel
	addi	$a0,	$a0,	2
	jal	draw_pixel
	addi	$a1,	$a1,	2
	jal	draw_pixel
	addi	$a0,	$a0,	-2
	jal	draw_pixel
	addi	$a0,	$a0,	1
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	#draw	6
	addi	$a0,	$a0,	8
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a0,	$a0,	2
	jal	draw_pixel
	addi	$a0,	$a0,	2
	jal	draw_pixel
	addi	$a1,	$a1,	2
	jal	draw_pixel
	addi	$a0,	$a0,	-2
	jal	draw_pixel
	addi	$a0,	$a0,	-2
	jal	draw_pixel
	#draw 7
	addi	$a0,	$a0,	-20
	addi	$a1,	$a1,	9
	jal	draw_pixel
	addi	$a0,	$a0,	2
	jal	draw_pixel
	addi	$a0,	$a0,	2
	jal	draw_pixel
	addi	$a1,	$a1,	2
	jal	draw_pixel
	addi	$a0,	$a0,	-2
	jal	draw_pixel
	addi	$a0,	$a0,	-2
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	addi	$a0,	$a0,	1
	jal	draw_pixel
	#draw 8
	addi	$a0,	$a0,	9
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a0,	$a0,	2
	jal	draw_pixel
	addi	$a0,	$a0,	2
	jal	draw_pixel
	addi	$a1,	$a1,	2
	jal	draw_pixel
	addi	$a0,	$a0,	-2
	jal	draw_pixel
	addi	$a0,	$a0,	-2
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	2
	jal	draw_pixel
	#draw 9
	addi	$a0,	$a0,	7
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a0,	$a0,	2
	jal	draw_pixel
	addi	$a0,	$a0,	2
	jal	draw_pixel
	addi	$a1,	$a1,	2
	jal	draw_pixel
	addi	$a0,	$a0,	-2
	jal	draw_pixel
	addi	$a0,	$a0,	-2
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	addi	$a0,	$a0,	1
	jal	draw_pixel
	addi	$a0,	$a0,	2
	jal	draw_pixel
	addi	$a0,	$a0,	2
	jal	draw_pixel

	lw	$ra,	($sp)
	addi	$sp,	$sp,	4
	jr 	$ra
	

#################################################################
#Draws the RING open screen
draw_R:
	addi	$sp,	$sp,	-4
	sw	$ra,	($sp)
	############DRAW THE R##########################
	addi	$a0,	$a0,	-18
	addi	$a1,	$a1,	-9
	jal	draw_pixel
	addi	$a1,	$a1,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	jal	draw_pixel
	
	addi	$a1,	$a1,	-15
	addi	$a0,	$a0,	1
	jal draw_pixel
	addi	$a0,	$a0,	1
	jal draw_pixel
	addi	$a0,	$a0,	1
	jal draw_pixel
	addi	$a0,	$a0,	1
	jal draw_pixel
	addi	$a0,	$a0,	1
	jal draw_pixel
	addi	$a0,	$a0,	1
	jal draw_pixel
	addi	$a0,	$a0,	1
	jal draw_pixel
	addi	$a0,	$a0,	1
	jal draw_pixel
	
	addi	$a1,	$a1,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	jal	draw_pixel
	
	addi	$a0,	$a0,	-1
	jal draw_pixel
	addi	$a0,	$a0,	-1
	jal draw_pixel
	addi	$a0,	$a0,	-1
	jal draw_pixel
	addi	$a0,	$a0,	-1
	jal draw_pixel
	addi	$a0,	$a0,	-1
	jal draw_pixel
	addi	$a0,	$a0,	-1
	jal draw_pixel
	addi	$a0,	$a0,	-1
	jal draw_pixel
	addi	$a0,	$a0,	-1
	jal draw_pixel
	
	addi	$a0,	$a0,	1
	addi	$a1,	$a1,	1
	jal draw_pixel
	addi	$a0,	$a0,	1
	addi	$a1,	$a1,	1
	jal draw_pixel
	addi	$a0,	$a0,	1
	addi	$a1,	$a1,	1
	jal draw_pixel
	addi	$a0,	$a0,	1
	addi	$a1,	$a1,	1
	jal draw_pixel
	addi	$a0,	$a0,	1
	addi	$a1,	$a1,	1
	jal draw_pixel
	addi	$a0,	$a0,	1
	addi	$a1,	$a1,	1
	jal draw_pixel
	addi	$a0,	$a0,	1
	addi	$a1,	$a1,	1
	jal draw_pixel
	addi	$a0,	$a0,	1
	addi	$a1,	$a1,	1
	jal draw_pixel
	##########################DRAW THE I##################################
	addi	$a0,	$a0,	3
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	#######################DRAW THE N###############################
	addi	$a0,	$a0,	3
	addi	$a1,	$a1,	15
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a0,	$a0,	1
	addi	$a1,	$a1,	2
	jal	draw_pixel
	addi	$a0,	$a0,	1
	addi	$a1,	$a1,	2
	jal	draw_pixel
	addi	$a0,	$a0,	1
	addi	$a1,	$a1,	2
	jal	draw_pixel
	addi	$a0,	$a0,	1
	addi	$a1,	$a1,	2
	jal	draw_pixel
	addi	$a0,	$a0,	1
	addi	$a1,	$a1,	2
	jal	draw_pixel
	addi	$a0,	$a0,	1
	addi	$a1,	$a1,	2
	jal	draw_pixel
	addi	$a0,	$a0,	1
	addi	$a1,	$a1,	2
	jal	draw_pixel
	
	addi	$a0,	$a0,	1
	addi	$a1,	$a1,	1
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
###################################DRAW THE G########################################
	addi	$a0,	$a0,	3
	jal 	draw_pixel
	addi	$a0,	$a0,	8
	addi	$a0,	$a0,	-1
	jal	draw_pixel
	addi	$a0,	$a0,	-1
	jal	draw_pixel
	addi	$a0,	$a0,	-1
	jal	draw_pixel
	addi	$a0,	$a0,	-1
	jal	draw_pixel
	addi	$a0,	$a0,	-1
	jal	draw_pixel
	addi	$a0,	$a0,	-1
	jal	draw_pixel
	addi	$a0,	$a0,	-1
	jal	draw_pixel
	addi	$a0,	$a0,	-1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	jal	draw_pixel
	addi	$a1,	$a1,	1
	jal	draw_pixel
	
	addi	$a0,	$a0,	8
	addi	$a0,	$a0,	-1
	jal	draw_pixel
	addi	$a0,	$a0,	-1
	jal	draw_pixel
	addi	$a0,	$a0,	-1
	jal	draw_pixel
	addi	$a0,	$a0,	-1
	jal	draw_pixel
	addi	$a0,	$a0,	-1
	jal	draw_pixel
	addi	$a0,	$a0,	-1
	jal	draw_pixel
	addi	$a0,	$a0,	-1
	jal	draw_pixel
	addi	$a0,	$a0,	-1
	addi	$a0,	$a0,	8
	
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	addi	$a1,	$a1,	-1
	jal	draw_pixel
	
	jal	draw_pixel
	addi	$a0,	$a0,	-1
	jal	draw_pixel
	addi	$a0,	$a0,	-1
	jal	draw_pixel
	addi	$a0,	$a0,	-1
	jal	draw_pixel
	addi	$a0,	$a0,	-1
	jal	draw_pixel
	
	lw	$ra,	($sp)
	addi	$sp,	$sp,	4
	jr	$ra
	
#################################If the person wins, then put winning screen####################
isw:
	la	$a0,	msg
	li	$v0,	4
	syscall
	j	exit
	
pause:	
	addi	$sp,	$sp,	-8
	sw	$ra,	($sp)
	sw	$a0,	4($sp)
	
	li	$v0,	32
	lw	$a0,	delay		#the delay amount is in the .data section
	syscall
	
	lw	$ra,	($sp)
	lw	$a0,	4($sp)
	addi	$sp,	$sp,	8
	jr	$ra
	
spause:	
	addi	$sp,	$sp,	-8
	sw	$ra,	($sp)
	sw	$a0,	4($sp)
	
	li	$v0,	32
	lw	$a0,	sdelay		#the delay amount is in the .data section
	syscall
	
	lw	$ra,	($sp)
	lw	$a0,	4($sp)
	addi	$sp,	$sp,	8
	jr	$ra

