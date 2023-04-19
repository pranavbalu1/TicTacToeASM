.data
	str1: 			.asciiz "\nYour Turn: Enter the board position of your move (1-9): "
	input_board_str1:  	.asciiz "\n 1 | 2 | 3 \n"
	input_board_str2:  	.asciiz "---+---+---\n"
	input_board_str3:  	.asciiz " 4 | 5 | 6 \n"
	input_board_str4:  	.asciiz "---+---+---\n"
	input_board_str5:  	.asciiz " 7 | 8 | 9 \n"
	output_board_str1: 	.asciiz " "
	output_board_str2: 	.asciiz " | "
	output_board_str3: 	.asciiz "---+---+---\n"
	newline:	   	.asciiz "\n"
	input_X_or_O:	   	.asciiz "\nInput whether you would like to play as X or O: "
	error_message_X0:  	.asciiz "\nError: You may only enter 'X' or 'O' (Capitalized)."
	error_message_1_9: 	.asciiz "\nError: You may not enter a number below 1 or above 9."
	error_message_space:	.asciiz "\nError: You may only choose a board position that is not already taken."
	tie_message:	   	.asciiz "\nTie Game"
	enterToContinue: 	.asciiz "Press 1 for the computer to go: "
	header_1: 		.asciiz "  _____     _                      _____                            _____                  \n"
	header_2: 		.asciiz " |_   _|   (_)     __       o O O |_   _|  __ _     __       o O O |_   _|   ___     ___   \n"
	header_3: 		.asciiz "   | |     | |    / _|     o        | |   / _` |   / _|     o        | |    / _ \\   / -_)  \n"
	header_4: 		.asciiz "  _|_|_   _|_|_   \\__|_   TS__[O]  _|_|_  \\__,_|   \\__|_   TS__[O]  _|_|_   \\___/   \\___|  \n"
	header_5: 		.asciiz "_|\"\"\"\"\"|_|\"\"\"\"\"|_|\"\"\"\"\"| {======|_|\"\"\"\"\"|_|\"\"\"\"\"|_|\"\"\"\"\"| {======|_|\"\"\"\"\"|_|\"\"\"\"\"|_|\"\"\"\"\"| \n"
	header_6: 		.asciiz "\"`-0-0-'\"`-0-0-'\"`-0-0-'./o--000'\"`-0-0-'\"`-0-0-'\"`-0-0-'./o--000'\"`-0-0-'\"`-0-0-'\"`-0-0-' "
	userWinMessage:    	.asciiz "User win!!!" 
	userLoseMessage:   	.asciiz "User lost!!!" 
	numOfBoardSpaces:  	.word 9
	true:		   	.word 1
	false:		   	.word 0
	myArray: 	   	.byte ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '
	input:			.byte '-'

	 
.text
main:
	li $s7, 0			# $s2 = numOfMovesMade = 0
	lw $s3, false			# $s3 = isTiePresent (true or false) set that to false(0)
	lw $s4, numOfBoardSpaces	# $s4 = maxBoardMoves = 9
	lw $s5, true			# $s5 = true = 1 
	
	jal displayHeader
	j userXorO			# Ask the user whether they rather play as X or O
	
	whileLoopX:
		jal userInput		#
		addi $s7, $s7, 1	# numOfMovesMade = numOfMovesMade + 1
		jal printBoard		#
		jal isWinYet
		
		beq $s7, $s4, exitWhileLoop
		
		jal getComputerMove
      		addi $s7, $s7, 1	# numOfMovesMade = numOfMovesMade + 1
      		jal printBoard 
      	 jal isWinYet      
      		
		j whileLoopX		#  Jump back to the whileLoopX label
	whileLoopO:
		jal getComputerMove
      		addi $s7, $s7, 1	# numOfMovesMade = numOfMovesMade + 1
      		jal printBoard 
      		jal isWinYet   
      		
      		beq $s7, $s4, exitWhileLoop
      		
      		jal userInput		#
		addi $s7, $s7, 1	# numOfMovesMade = numOfMovesMade + 1
		jal printBoard		#
	    	jal isWinYet
	
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
	add $s0, $v0, $zero		# $s0 = user's choice between X and O
# Validate the user's input.
	beq $s0, 88, input_valid_XO	# 88 is the ASCII code for 'X'
    	beq $s0, 79, input_valid_XO	# 79 is the ASCII code for 'O'
# Print an error message.
	la $a0, error_message_X0
	li $v0, 4
	syscall
# Call the function again.
	j userXorO
# Continue on as user input is confirmed valid.
	input_valid_XO:
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
	#li $v0, 5
	#syscall
	# Read in as string
	li $v0, 8
	li $a1, 2
	la $a0, input
	syscall
	# -48 to get numeric value and continue as normal
	# Invalid if value is less than 48 or greater than 57
	lb $t0, ($a0)
	add $t0, $t0, -48
	#add $t0, $v0, $zero	# $t0 = user's move position
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
	subi $t5, $t0, 1         	# $t0 = $t0 - 1 to convert the user's input into zero-based index.
	add $t1, $t1, $t5        	# $t1 = $t1 + $t0 for array address to access = base address + offset
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
	jr $ra			# return back to function call

printBoard:
# Print the tic-tac-toe board with 'X', 'O', or ' '
	addi $sp, $sp, -4	#
	sw $ra, 0($sp)		#
	li $t0, 3		# loop counter = 3
	la $t1, myArray		# $t1 = base address of myArray
	li $t2, 0 		# $t2 = offset
	
	la $a0, newline
	li $v0, 4
	syscall
	
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
	
getComputerMove:
# Getting random number 1-9 and storing it in t0
	add $t0 $zero, 0 
	li $a1,  9
	li $v0,  42
	syscall
	addi $t0, $a0, 0
		
	# Checking to see if the number that was randomly rolled is already in use, if not, go to "input_valid_spaceX" if so, jump back to start of RandomNumberX
	la $t1, myArray          		# Load the base address of myArray into $t1.
	add $t1, $t1, $t0        		# $t1 = $t1 + $t0 for array address to access = base address + offset
	lb $t2, ($t1)            		# Load the character at the array address into $t2.
	li $t3, 32               		# The ASCII code for ' ' is 32.
	beq $t2, $t3, input_valid_spaceX 	# Branch to input_valid_space
	j getComputerMove
		
	# Since the random number is valid, input it onto the board
	input_valid_spaceX:
	addi $s2, $s2, 1	# numOfMovesMade = numOfMovesMade + 1
	la $t1, myArray	      	
	add $t1, $t1, $t0	# $t1 = $t1 + $t0
	sb $s1, ($t1)
	
	li $v0, 4		# Print new line
	la $a0, newline
	syscall
		
	li $v0, 4		# Give the user a buffer to continue the program to not overwhelm them
	la $a0, enterToContinue
	syscall
	li $v0, 5
	syscall
		
	li $v0, 4		# Print new line
	la $a0, newline
	syscall
	
	jr $ra
	
isWinYet:
#diagonalWinCheck2
# Check if there exists a matching character from top-left to bottom-right.
	lb $t0, myArray   	  	# Load the 0th element in myArray representing the top-left spot.
	lb $t1, myArray+4 	  	# Load the 4th element in myArray representing the middle-middle spot.
	lb $t2, myArray+8 	  	# Load the 8th element in myArray representing the bottom-right spot.
	beq $t0, ' ', diagonalWinCheck2 # Branch if top-left spot is empty.
	beq $t1, ' ', diagonalWinCheck2 # Branch if middle-middle spot is empty.
	beq $t2, ' ', diagonalWinCheck2 # Branch if bottom-right spot is empty.
	bne $t0, $t1, diagonalWinCheck2 # Branch if top-left spot != middle-middle spot.
	bne $t0, $t2, diagonalWinCheck2 # Branch if top-left spot != bottom-right spot.
	# If code gets to this line then somebody won digonally
	bne $t0, $s0, printuserlost
	j printuserWin
 

diagonalWinCheck2:
# Check if there exists a matching character from top-right to bottom-left.
	lb $t0, myArray+2 				# Load the 2nd element in myArray representing the top-right spot.
	lb $t1, myArray+4 				# Load the 4th element in myArray representing the middle-middle spot.
	lb $t2, myArray+6 				# Load the 6th element in myArray representing the top-left spot.
	beq $t0, ' ', horizontalWinCheck1 		# Branch if top-right spot is empty.
	beq $t1, ' ', horizontalWinCheck1 		# Branch if middle-middle spot is empty.
	beq $t2, ' ', horizontalWinCheck1 		# Branch if bottom-left spot is empty.
	bne $t0, $t1, horizontalWinCheck1		# Branch if top-right spot != middle-middle spot.
	bne $t0, $t2, horizontalWinCheck1 		# Branch if middle-middle spot != bottom-left spot.
	# If code gets to this line then somebody won digonally
	bne $t0, $s0, printuserlost
	j printuserWin

horizontalWinCheck1:
#Check if there exists a matching of all characters in row 1.
    	lb $t0, myArray         			#Load the 0th element in myArray representing the top-left spot.
    	lb $t1, myArray+1       			#Load the 1st element in myArray representing the top-middle spot.
    	lb $t2, myArray+2       			#Load the 2nd element in myArray representing the top-right spot.
    	beq $t0, ' ', horizontalWinCheck2 		# Branch if top-left spot is empty.
	beq $t1, ' ', horizontalWinCheck2 		# Branch if top-middle is empty.
	beq $t2, ' ', horizontalWinCheck2 		# Branch if top-right spot is empty.
	bne $t0, $t1, horizontalWinCheck2		# Branch if top-left spot != top-middle spot.
	bne $t0, $t2, horizontalWinCheck2 		# Branch if top-left spot != top-right spot.
	# If code gets to this line then somebody won horizontaly
	bne $t0, $s0, printuserlost
	j printuserWin

horizontalWinCheck2:
#Check if there exists a matching of all characters in row 2.
    	lb $t0, myArray+3       			#Load the 3rd element in myArray representing the middle-left spot.
    	lb $t1, myArray+4       			#Load the 4th element in myArray representing the middle-middle spot.
    	lb $t2, myArray+5       			#Load the 5th element in myArray representing the middle-right.
    	beq $t0, ' ', horizontalWinCheck3 		# Branch if middle-left spot is empty.
	beq $t1, ' ', horizontalWinCheck3 		# Branch if middle-middle spot is empty.
	beq $t2, ' ', horizontalWinCheck3 		# Branch if middle-right spot is empty.
	bne $t0, $t1, horizontalWinCheck3		# Branch if middle-left spot != middle-middle spot.
	bne $t0, $t2, horizontalWinCheck3 		# Branch if middle-left spot != middle-right spot.
	# If code gets to this line then somebody won horizontaly
    	bne $t0, $s0, printuserlost
	j printuserWin

horizontalWinCheck3:
#Check if there exists a matching of all characters in row 2.
    	lb $t0, myArray+6       			#Load the 6th element in myArray representing the bottom-left spot.
    	lb $t1, myArray+7       			#Load the 7th element in myArray representing the bottom-middled row.
    	lb $t2, myArray+8       			#Load the 8th element in myArray representing the bottom-right spot.
    	beq $t0, ' ', VerticalWinCheck1 		# Branch if bottom-left spot is empty.
	beq $t1, ' ', VerticalWinCheck1 		# Branch if bottom-middle spot is empty.
	beq $t2, ' ', VerticalWinCheck1 		# Branch if bottom-right spot is empty.
	bne $t0, $t1, VerticalWinCheck1		    	# Branch if bottom-left spot != bottom-middle spot.
	bne $t0, $t2, VerticalWinCheck1 		# Branch if bottom-left spot != bottom-right spot.
	# If code gets to this line then somebody won horizontaly
  	bne $t0, $s0, printuserlost
	j printuserWin

VerticalWinCheck1:
# Check if there exists a matching character for the column 1.
	lb $t0, myArray		    			# Load the 0th element in myArray representing the top-left spot.
	lb $t1, myArray+3 	    			# Load the 3rd element in myArray representing the middle-left spot.
	lb $t2, myArray+6				# Load the 6th element in myArray representing the bottom-left spot.
	beq $t0, ' ', VerticalWinCheck2			# Branch if top-left spot is empty.
	beq $t1, ' ', VerticalWinCheck2 		# Branch if middle-left spot is empty.
	beq $t2, ' ', VerticalWinCheck2	    		# Branch if bottom-left spot is empty.
	bne $t0, $t1, VerticalWinCheck2			# Branch if top-lfet spot != middle-left spot.
	bne $t0, $t2, VerticalWinCheck2	    		# Branch if middle-left spot != bottom-left spot.
	# If code gets to this line then somebody won vertically
	bne $t0, $s0, printuserlost
	j printuserWin

   
VerticalWinCheck2:
# Check if there exists a matching character for the column 2.
	lb $t0, myArray+1	    			# Load the 1st element in myArray representing the top-middle spot.
	lb $t1, myArray+4 	    			# Load the 4th element in myArray representing the middle-middle spot.
	lb $t2, myArray+7				# Load the 6th element in myArray representing the bottom-middle spot.
	beq $t0, ' ', VerticalWinCheck3 		# Branch if top-middle spot is empty.
	beq $t1, ' ', VerticalWinCheck3 		# Branch if middle-middle spot is empty.
	beq $t2, ' ', VerticalWinCheck3		    	# Branch if bottom-middle  spot is empty.
	bne $t0, $t1, VerticalWinCheck3	        	# Branch if top-middle  spot != middle-middle spot.
	bne $t0, $t2, VerticalWinCheck3  	    	# Branch if top-middle spot != bottom-middle spot.
	# If code gets to this line then somebody won vertically
   	bne $t0, $s0, printuserlost
	j printuserWin
    
VerticalWinCheck3:
# Check if there exists a matching character for the column 3.
	lb $t0, myArray+2	    			# Load the 2nd element in myArray representing the top-right spot.
	lb $t1, myArray+5	    			# Load the 5th element in myArray representing the middle-right spot.
	lb $t2, myArray+8				# Load the 8th element in myArray representing the bottom-right spot.
	beq $t0, ' ', end1				# Branch if top-right spot is empty.
	beq $t1, ' ', end1				# Branch if middle-right spot is empty.
	beq $t2, ' ', end1				# Branch if bottom-right spot is empty.
	bne $t0, $t1, end1				# Branch if top-right spot != middle-right spot.
	bne $t0, $t2, end1	    			# Branch if top-right spot != bottom-right spot.
	# If code gets to this line then somebody won vertically
	bne $t0, $s0, printuserlost
	j printuserWin
	
printuserWin:
	la $a0, userWinMessage     # Display user win message 
	li $v0, 4
    	syscall
    	j skipTieMessage
printuserlost:
	la $a0, userLoseMessage    # Display user lost message 
	li $v0, 4
    	syscall  
    	j skipTieMessage
end1: 
    	jr $ra 
