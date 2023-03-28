.data
	myArray: .byte ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '
.text

diagonalWinCheck:
# Check if there exists a matching character from top-left to bottom-right.
	lb $t0, myArray   	  	# Load the 0th element in myArray representing the top-left spot.
	lb $t1, myArray+4 	  	# Load the 4th element in myArray representing the middle-middle spot.
	lb $t2, myArray+8 	  	# Load the 8th element in myArray representing the bottom-right spot.
	beq $t0, ' ', diagonalWinCheck2 # Branch if top-left spot is empty.
	beq $t1, ' ', diagonalWinCheck2 # Branch if middle-middle spot is empty.
	beq $t2, ' ', diagonalWinCheck2 # Branch if bottom-right spot is empty.
	bne $t0, $t1, diagonalWinCheck2 # Branch if top-left spot != middle-middle spot.
	bne $t0, $t2, diagonalWinCheck2 # Branch if middle-middle spot != bottom-right spot.
	# If code gets to this line then somebody won diagonally
	
diagonalWinCheck2:
# Check if there exists a matching character from top-right to bottom-left.
	lb $t0, myArray+2 		# Load the 2th element in myArray representing the top-right spot.
	lb $t1, myArray+4 		# Load the 4th element in myArray representing the middle-middle spot.
	lb $t2, myArray+6 		# Load the 6th element in myArray representing the top-left spot.
	beq $t0, ' ', exit 		# Branch if top-right spot is empty.
	beq $t1, ' ', exit 		# Branch if middle-middle spot is empty.
	beq $t2, ' ', exit 		# Branch if bottom-left spot is empty.
	bne $t0, $t1, exit		# Branch if top-right spot != middle-middle spot.
	bne $t0, $t2, exit 		# Branch if middle-middle spot != bottom-left spot.
	# If code gets to this line then somebody won diagonally

# Exit is just where code where go, if niether diagonal line check comes up with a winner	
exit:
