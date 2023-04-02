.data
	str1: 			.asciiz "Your Turn: Enter the board position of your move (1-9):"
	error_message_1_9:	.asciiz "\nError: You may not enter a number below 1 or above 9.\n"
	error_message_space:	.asciiz "\nError: You may only choose a board position that is not already taken.\n"
	myArray: 		.byte 'X', 'X', 'O', ' ', ' ', ' ', ' ', ' ', 'O'
.text

li $s0, 88

userInput:
# Print the prompt asking for the row of the user's move.
	la $a0, str1
	li $v0, 4
	syscall
# Read the board position inputed by the user.
	li $v0, 5
	syscall
	add $t0, $v0, $zero	# $t0 = user's move position
# Validate that the user's input is a integer between 1 and 9.
	beq $t0, 1, input_valid_1_9	# 
	beq $t0, 2, input_valid_1_9	# 
	beq $t0, 3, input_valid_1_9	# 
	beq $t0, 4, input_valid_1_9	# 
	beq $t0, 5, input_valid_1_9	# 
	beq $t0, 6, input_valid_1_9	# 
	beq $t0, 7, input_valid_1_9	# 
	beq $t0, 8, input_valid_1_9	# 
	beq $t0, 9, input_valid_1_9	# 
# Display error message.
	la $a0, error_message_1_9
	li $v0, 4
	syscall
# Call the userInput function again.
	j userInput
# Continue on as user input is confirmed a valid character between '1' through '9'.
	input_valid_1_9:
# Validate that the corresponding element in myArray holds ' '.
	la $t1, myArray          	# Load the base address of myArray into $t1.
	subi $t0, $t0, 1         	# $t0 = $t0 - 1 to convert the user's input into zero-based index.
	add $t1, $t1, $t0        	# $t1 = $t1 + $t0 for array address to access = base address + offset
	lb $t2, ($t1)            	# Load the character at the array address into $t2.
	li $t3, 32               	# The ASCII code for ' ' is 32.
	beq $t2, $t3, input_valid_space # Branch to input_valid_space
# Display an error message.
	la $a0, error_message_space
	li $v0, 4
	syscall
# Call the userInput function again.
	j userInput
# Continue on as user input is confirmed to be corresponding to a free board position.
	input_valid_space:
# Save user's input into myArray.
	la $t1, myArray	      	#
	subi $t0, $t0, 1	# $t0 = $t0 - 1
	add $t1, $t1, $t0	# $t1 = $t1 + $t0
	sb $s0, ($t1)		# Store the character into the array address
