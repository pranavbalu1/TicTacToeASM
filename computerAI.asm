#This program so far prints out a tictactoe board 1-9 and gives the user to enter the position they want to play 
#USER IS '50' IN THE PROGRAM
#COMPUTER IS '30' IN THE PROGRAM

#Max Lichter
#4/2/23

.data 
	#allocating space for the 9 number array (9*4)
	Numbers:	.space 36
	newSpace: .asciiz "  "
	newLine: .asciiz "\n"
	promptUser: .asciiz "\nEnter the value of the number correlating to the board: "
	enter: .asciiz "\nType 100 to continue: "
	computerPrompt: .asciiz "The computer selected its position"

.text


	#initializing 2 temp registers to zero
	main:
	addi $t0, $t0, 0
	addi $t1, $t1, 1
	
	#Making our registers zero. I use this chunk of code frequently throughout the program
	MakingRegistersZero:
		add $t1, $zero, 0
		add $t4, $zero, 0
		add $t6, $zero, 0
		add $t7, $zero, 0
		add $a0, $zero, 0
		add $s0, $zero, 0
		jr $ra
			
	#This chunk of code populates our array (our tictactoe board with the 9 numbers)
	fillingArray:
		sw $t1, Numbers($t0)
		addi $t0, $t0, 4
		addi $t1, $t1, 1
		beq $t1, 10, backToZero
		
		j fillingArray
		
	#Making our temp registers back to zero
	backToZero:
		add $t0, $zero, 0
		add $t1, $zero, 0
		
		
	#Print out initial array
	printingArray:
	
		#Putting the number at current index into t6 then adding the index by 4
		lw $t6, Numbers($t0)
		addi $t0, $t0, 4
			
		#Every third and sixth number, a new line is made (like a tictactoe board)
		jal thirdLine
		jal sixthLine
			
		#once this counter gets to 10 aka, when t7 = 10 (not on our board) we go to the user input
		addi $t1, $t1, 1
		beq $t1, 10, userInput
			
			
		#Print Current numbers 1-9.
		li $v0, 1
		move $a0, $t6
		syscall
		
		#print a new space between numbers
		li $v0, 4
		la $a0, newSpace
		syscall
		
		#repeat until full array is printed
		j printingArray
	
	
	#every third and sixth number, a new line is made
	thirdLine: 
		beq $t1, 3, third
		bne $t1, 3, goBackthird
		third:
			li $v0, 4
			la $a0, newLine
			syscall			
		goBackthird:
			jr $ra
			
	sixthLine: 
		beq $t1, 6, sixth
		bne $t1, 6, goBacksixth
		sixth:
			li $v0, 4
			la $a0, newLine
			syscall			
		goBacksixth:
			jr $ra

	

	#Getting the number from the user corresponding to the board
	userInput:
	
		#print a new line
		li $v0, 4
		la $a0, newLine
		syscall
			
		#prompting the user for the value of X (users number).
		li $v0, 4
		la $a0, promptUser
		syscall
			
		#Getting the users number X
		li $v0, 5
		syscall
			
		#Storing X into temp register
		move $t3, $v0
		add $t0, $zero, 0
		j usersFill
			
	
	#Filling the array at the corresponding number with 50
	usersFill:
		#these two lines for example... if the user enters 5, sll would to 5 * 4 = 20 and at position 20 in the array, 5 is the number. so 20 the location of X
		sub $t3, $t3, 1
		sll $t0, $t3, 2
		
		#Putting '50' into the position where the number was at
		add $t1, $zero, 50
		sw $t1 Numbers($t0)
		
		jal MakingRegistersZero #making my registers zero
		j printingNewUsersArray
		
		
	#Printing out the new array after users input
	printingNewUsersArray:
	
		#Putting the number at current index into t6 then adding the index by 4
		lw $t6, Numbers($s0)
		addi $s0, $s0, 4
			
		#Every third and sixth number, a new line is made (like a tictactoe board)
		jal thirdLine
		jal sixthLine
			
		#once the array gets  filled, go to buffer
		addi $t1, $t1, 1
		beq $s0, 40, buffer
		
		#Print Current numbers.
		li $v0, 1
		move  $a0, $t6
		syscall
		
		#print a new space
		li $v0, 4
		la $a0, newSpace
		syscall
		
		j printingNewUsersArray	
		
	
	#This section is so the user doesn't get overwhelmed and has to input something to continue	
	buffer:
		li $v0, 4
		la $a0, enter
		syscall
		li $v0, 5
		syscall
	
	
	#This is the computers turn to place a piece on the board	
	computersTurn:
			
		#printing a new line
		li $v0, 4
		la $a0, newLine
		syscall
		
		#printing a new line
		li $v0, 4
		la $a0, newLine
		syscall
		
		#printing a statement telling the user what's happening
		li $v0, 4
		la $a0, computerPrompt
		syscall
		
		#printing a new line
		li $v0, 4
		la $a0, newLine
		syscall
			
		jal MakingRegistersZero #making my registers zero
		
		
		#Gets a random number and stores it in t4
		li $a1,  9
		li $v0,  42
		syscall
		add $t4, $zero $a0
		add $t0, $zero, 0
		sll $t0, $t4, 2 	#getting the address of the number in the array that we are going to change

		#Putting '30' into the position where the number was at
		add $t1, $zero, 30
		sw $t1 Numbers($t0)
		
		jal MakingRegistersZero #making my registers zero
		j printingNewComputerArray
	
	
	#printing the new array with the input from the computer
	printingNewComputerArray:
	
		#Putting the number at current index into t6 then adding the index by 4
		lw $t6, Numbers($s0)
		addi $s0, $s0, 4

		#Every third and sixth number, a new line is made (like a tictactoe board)
		jal thirdLine
		jal sixthLine
			
		#when the array is fully printed, go back and get the next number the user will input
		addi $t1, $t1, 1
		beq $s0, 40, userInput
		
		#Print Current numbers.
		li $v0, 1
		move  $a0, $t6
		syscall
		
		#print a new space
		li $v0, 4
		la $a0, newSpace
		syscall
		
		j printingNewComputerArray	
	
	exit:
		#Tell system this is end of program
		li $v0, 10
		syscall
		
