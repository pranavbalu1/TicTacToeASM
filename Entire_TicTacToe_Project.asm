.data
	str1: .asciiz "Your Turn: Enter the board position of your move (1-9):"
	input_board_str1:  .asciiz " 1 | 2 | 3 \n"
	input_board_str2:  .asciiz "---+---+---\n"
	input_board_str3:  .asciiz " 4 | 5 | 6 \n"
	input_board_str4:  .asciiz "---+---+---\n"
	input_board_str5:  .asciiz " 7 | 8 | 9 \n"
	output_board_str1: .asciiz " "
	output_board_str2: .asciiz " | "
	output_board_str3: .asciiz "---+---+---\n"
	newline:	   .asciiz "\n"
	input_X_or_O:	   .asciiz "Would you rather play as X or O?"
	tie_message:	   .asciiz "Tie Game"
	header_1: .asciiz "  _____     _                      _____                            _____                  \n"
	header_2: .asciiz " |_   _|   (_)     __       o O O |_   _|  __ _     __       o O O |_   _|   ___     ___   \n"
	header_3: .asciiz "   | |     | |    / _|     o        | |   / _` |   / _|     o        | |    / _ \\   / -_)  \n"
	header_4: .asciiz "  _|_|_   _|_|_   \\__|_   TS__[O]  _|_|_  \\__,_|   \\__|_   TS__[O]  _|_|_   \\___/   \\___|  \n"
	header_5: .asciiz "_|\"\"\"\"\"|_|\"\"\"\"\"|_|\"\"\"\"\"| {======|_|\"\"\"\"\"|_|\"\"\"\"\"|_|\"\"\"\"\"| {======|_|\"\"\"\"\"|_|\"\"\"\"\"|_|\"\"\"\"\"| \n"
	header_6: .asciiz "\"`-0-0-'\"`-0-0-'\"`-0-0-'./o--000'\"`-0-0-'\"`-0-0-'\"`-0-0-'./o--000'\"`-0-0-'\"`-0-0-'\"`-0-0-' \n"
	myArray: 	   .byte ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '
	numOfBoardSpaces:  .word 9
	true:		   .word 1
	false:		   .word 0
	
	 
.text
main:
	li $s2, 0			# $s2 = numOfMovesMade = 0
	lw $s3, false			# $s3 = isTiePresent (true or false) set that to false(0)
	lw $s4, numOfBoardSpaces	# $s4 = maxBoardMoves = 9
	lw $s5, true			# $s5 = true = 1 
	
	jal displayHeader
	j userXorO			# Ask the user whether they rather play as X or O
	
	whileLoopX:
		jal userInput		#
		addi $s2, $s2, 1	# numOfMovesMade = numOfMovesMade + 1
		jal printBoard		#
		# isWinYet
		
		beq $s2, $s4, exitWhileLoop
		
		# getComputerMove
      		addi $s2, $s2, 1	# numOfMovesMade = numOfMovesMade + 1
      		# jal printBoard 
      		# isWinYet      
      		
		j whileLoopX		#  Jump back to the whileLoopX label
	whileLoopO:
		# getComputerMove
      		# addi $s2, $s2, 1	# numOfMovesMade = numOfMovesMade + 1
      		# jal printBoard 
      		# isWinYet   
      		
      		beq $s2, $s4, exitWhileLoop
      		
      		jal userInput		#
		addi $s2, $s2, 1	# numOfMovesMade = numOfMovesMade + 1
		jal printBoard		#
		# isWinYet
	
		j whileLoopO		# Jump back to the whileLoopO label
	exitWhileLoop:
		li $s3,  1		# $s3 = isTiePresent (true or false) = 1 (true)
		
		beq $s3, $s5, tieMessage	# If isTiePresent == true then branch to tieMessage
		j skipTieMessage		# Jump to the skipTieMessage label
		
	tieMessage:
		la $a0, tie_message		# Display the tie message
		li $v0, 4
		syscall
	skipTieMessage:
	
	# Exit the program.
	li $v0, 10
	syscall

############### END OF MAIN ###############

userXorO:
# Print the message asking whether the user rather play as X or O.
	la $a0, input_X_or_O
	li $v0, 4
	syscall
# Read the character (X or O) the user rather play as.
	li $v0, 12
	syscall
	add $s0, $v0, $zero	# $s0 = user's choice between X and O
# Determine whether the computer is X or O.
	beq $s0, 88, else	# If user's choice == X, then branch
	li $s1, 88		# $s1 = computer = X
	j end
	else:
	li $s1, 79		# $s1 = computer = O
	end:
# Determine where to branch based on the user's choice
	beq $s0, 88, whileLoopX	# if user's choice == 'X' then branch to whileLoopX
	beq $s0, 79, whileLoopO	# if user's choice == 'O' then branch to whileLoopO

userInput:
# Print the board with positions labeled.
	la $a0, newline
	li $v0, 4
	syscall
	la $a0, input_board_str1
	li $v0, 4
	syscall
	la $a0, input_board_str2
	li $v0, 4
	syscall
	la $a0, input_board_str3
	li $v0, 4
	syscall
	la $a0, input_board_str4
	li $v0, 4
	syscall
	la $a0, input_board_str5
	li $v0, 4
	syscall
# Print the prompt asking for the row of the user's move.
	la $a0, str1
	li $v0, 4
	syscall
# Read the board position inputed by the user.
	li $v0, 5
	syscall
	add $t0, $v0, $zero	# $t0 = user's move position
# Save user's input into myArray.
	la $t1, myArray	      	#
	subi $t0, $t0, 1	# $t0 = $t0 - 1
	add $t1, $t1, $t0	# $t1 = $t1 + $t0
	sb $s0, ($t1)		# Store the character into the array address
	jr $ra			# return back to function call

printBoard:
	addi $sp, $sp, -4	#
	sw $ra, 0($sp)		#
	
	li $t0, 3		# loop counter = 3
	la $t1, myArray		# $t1 = base address of myArray
	li $t2, 0 		# $t2 = offset
	
	# Print the parts of the board that don't contain the user or computer's moves
	forLoop1:
		beq $t0, $zero, exitForLoop1	# exit out forLoop1 when branch counter == 0
		la $a0, output_board_str1
		li $v0, 4
		syscall
		jal accessArray			# Print move on board col position 1
		la $a0, output_board_str2
		li $v0, 4
		syscall
		jal accessArray			# Print move on board col position 2
		la $a0, output_board_str2
		li $v0, 4
		syscall
		jal accessArray			# Print move on board col position 3
		la $a0, output_board_str1
		li $v0, 4
		syscall
		la $a0, newline
		li $v0, 4
		syscall
		
		li $t3, 1			# $t1 = 1
		beq $t0, $t3, exitForLoop1	# exit out forLoop1 when branch counter == 1
		
		la $a0, output_board_str3
		li $v0, 4
		syscall
		subi $t0, $t0, 1		# loop counter = loop counter - 1
		j forLoop1			# Jump to loop1
	accessArray:
		# Print the user's and computer's moves
		add $t3, $t1, $t2	# $t3 = current array address = base address + offset
		lb  $t4, ($t3)         	# $t4 = byte at current array address
		la $a0, ($t4)		# Load character
		li $v0, 11		# Print character
		syscall
		addi $t2, $t2, 1	# $t2 = $t2 + 1
		jr $ra
	exitForLoop1:
	lw $ra, 0($sp)			#
	addi $sp, $sp, 4		#
	jr $ra				#

displayHeader:
# Print the ascii art for the "Tic Tac Toe" header.
	la $a0, header_1
	li $v0, 4
	syscall
	la $a0, header_2
	li $v0, 4
	syscall
	la $a0, header_3
	li $v0, 4
	syscall
	la $a0, header_4
	li $v0, 4
	syscall
	la $a0, header_5
	li $v0, 4
	syscall
	la $a0, header_6
	li $v0, 4
	syscall
	la $a0, newline
	li $v0, 4
	syscall
	jr $ra
