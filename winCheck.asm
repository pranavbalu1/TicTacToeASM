# Type "jal isWinCheck" where the comments say winCheck in the whileLoopX and whileLoopO functions when finished


isWinYet:
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
	beq $t0, $s0 printuserWin #Find out if the winner is the user
 j printuserlost
 

diagonalWinCheck2:
# Check if there exists a matching character from top-right to bottom-left.
	lb $t0, myArray+2 		# Load the 2nd element in myArray representing the top-right spot.
	lb $t1, myArray+4 		# Load the 4th element in myArray representing the middle-middle spot.
	lb $t2, myArray+6 		# Load the 6th element in myArray representing the top-left spot.
	beq $t0, ' ', horizontalWinCheck1 		# Branch if top-right spot is empty.
	beq $t1, ' ', horizontalWinCheck1 		# Branch if middle-middle spot is empty.
	beq $t2, ' ', horizontalWinCheck1 		# Branch if bottom-left spot is empty.
	bne $t0, $t1, horizontalWinCheck1		# Branch if top-right spot != middle-middle spot.
	bne $t0, $t2, horizontalWinCheck1 		# Branch if middle-middle spot != bottom-left spot.
	# If code gets to this line then somebody won digonally
	beq $t0, $s0 printuserWin # Find out if the winner is the user
j printuserlost

horizontalWinCheck1:
#Check if there exists a matching of all characters in row 1.
    lb $t0, myArray         #Load the 0th element in myArray representing the top-left spot.
    lb $t1, myArray+1       #Load the 1st element in myArray representing the top-middle spot.
    lb $t2, myArray+2       #Load the 2nd element in myArray representing the top-right spot.
    beq $t0, ' ', horizontalWinCheck2 		# Branch if top-left spot is empty.
	beq $t1, ' ', horizontalWinCheck2 		# Branch if top-middle is empty.
	beq $t2, ' ', horizontalWinCheck2 		# Branch if top-right spot is empty.
	bne $t0, $t1, horizontalWinCheck2		# Branch if top-left spot != top-middle spot.
	bne $t0, $t2, horizontalWinCheck2 		# Branch if top-left spot != top-right spot.
	# If code gets to this line then somebody won horizontaly
	beq $t0, $s0 printuserWin #find out if the winer is the user
j printuserlost

horizontalWinCheck2:
#Check if there exists a matching of all characters in row 2.
    lb $t0, myArray+3       #Load the 3rd element in myArray representing the middle-left spot.
    lb $t1, myArray+4       #Load the 4th element in myArray representing the middle-middle spot.
    lb $t2, myArray+5       #Load the 5th element in myArray representing the middle-right.
    beq $t0, ' ', horizontalWinCheck3 		# Branch if middle-left spot is empty.
	beq $t1, ' ', horizontalWinCheck3 		# Branch if middle-middle spot is empty.
	beq $t2, ' ', horizontalWinCheck3 		# Branch if middle-right spot is empty.
	bne $t0, $t1, horizontalWinCheck3		# Branch if middle-left spot != middle-middle spot.
	bne $t0, $t2, horizontalWinCheck3 		# Branch if middle-left spot != middle-right spot.
	# If code gets to this line then somebody won horizontaly
    beq $t0, $s0 printuserWin #find out if the winer is the user
j printuserlost

horizontalWinCheck3:
#Check if there exists a matching of all characters in row 2.
    lb $t0, myArray+6       #Load the 6th element in myArray representing the bottom-left spot.
    lb $t1, myArray+7       #Load the 7th element in myArray representing the bottom-middled row.
    lb $t2, myArray+8       #Load the 8th element in myArray representing the bottom-right spot.
    beq $t0, ' ', VerticalWinCheck1 		# Branch if bottom-left spot is empty.
	beq $t1, ' ', VerticalWinCheck1 		# Branch if bottom-middle spot is empty.
	beq $t2, ' ', VerticalWinCheck1 		# Branch if bottom-right spot is empty.
	bne $t0, $t1, VerticalWinCheck1		    # Branch if bottom-left spot != bottom-middle spot.
	bne $t0, $t2, VerticalWinCheck1 		# Branch if bottom-left spot != bottom-right spot.
	# If code gets to this line then somebody won horizontaly
    beq $t0, $s0 printuserWin #find out if the winer is the user
j printuserlost

VerticalWinCheck1:
# Check if there exists a matching character for the column 1.
	lb $t0, myArray		    # Load the 0th element in myArray representing the top-left spot.
	lb $t1, myArray+3 	    # Load the 3rd element in myArray representing the middle-left spot.
	lb $t2, myArray+6		# Load the 6th element in myArray representing the bottom-left spot.
	beq $t0, ' ', VerticalWinCheck2		# Branch if top-left spot is empty.
	beq $t1, ' ', VerticalWinCheck2 	# Branch if middle-left spot is empty.
	beq $t2, ' ', VerticalWinCheck2	    # Branch if bottom-left spot is empty.
	bne $t0, $t1, VerticalWinCheck2		# Branch if top-lfet spot != middle-left spot.
	bne $t0, $t2, VerticalWinCheck2	    # Branch if middle-left spot != bottom-left spot.
	# If code gets to this line then somebody won vertically
	beq $t0, $s0  printuserWin           # Find if the user win
	j printuserlost

   
VerticalWinCheck2:
# Check if there exists a matching character for the column 2.
	lb $t0, myArray+1	    # Load the 1st element in myArray representing the top-middle spot.
	lb $t1, myArray+4 	    # Load the 4th element in myArray representing the middle-middle spot.
	lb $t2, myArray+7		# Load the 6th element in myArray representing the bottom-middle spot.
	beq $t0, ' ', VerticalWinCheck3 		# Branch if top-middle spot is empty.
	beq $t1, ' ', VerticalWinCheck3 		# Branch if middle-middle spot is empty.
	beq $t2, ' ', VerticalWinCheck3		    # Branch if bottom-middle  spot is empty.
	bne $t0, $t1, VerticalWinCheck3	        # Branch if top-middle  spot != middle-middle spot.
	bne $t0, $t2, VerticalWinCheck3  	    # Branch if top-middle spot != bottom-middle spot.
	# If code gets to this line then somebody won vertically
    beq $t0, $s0  printuserWin           # Find if the user win
	j printuserlost
    
VerticalWinCheck3:
# Check if there exists a matching character for the column 3.
	lb $t0, myArray+2	    # Load the 2nd element in myArray representing the top-right spot.
	lb $t1, myArray+5	    # Load the 5th element in myArray representing the middle-right spot.
	lb $t2, myArray+8		# Load the 8th element in myArray representing the bottom-right spot.
	beq $t0, ' ', end		# Branch if top-right spot is empty.
	beq $t1, ' ', end		# Branch if middle-right spot is empty.
	beq $t2, ' ', end		# Branch if bottom-right spot is empty.
	bne $t0, $t1, end		# Branch if top-right spot != middle-right spot.
	bne $t0, $t2, end	    # Branch if top-right spot != bottom-right spot.
	# If code gets to this line then somebody won vertically
	beq $t0, $s0  printuserWin           # Find if the user win
	j printuserlost
    
	printuserWin:
	la $a0, userWinMessage     # Display user win message 
	li $v0, 4
    	syscall
    printuserlost:
	la $a0, userLoseMessage    # Display user lost message 
	li $v0, 4
    	syscall  
    end: 
    jr $ra
