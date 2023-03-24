.data
    output_board_str1: .asciiz " "
    output_board_str2: .asciiz " | "
    output_board_str3: .asciiz "---+---+---\n"
    newline:       .asciiz "\n"
    myArray: .byte ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '
.text
# jal printBoard

# printBoard:
# Print board with the user and computer's moves.
    li $t0, 3        # loop counter = 3
    la $t1, myArray        # $t1 = base address of myArray
    li $t2, 0         # $t2 = offset
    
    # Print the parts of the board that don't contain the user or computer's moves
    forLoop1:
        beq $t0, $zero, exitForLoop1    # exit out forLoop1 when branch counter == 0
        la $a0, output_board_str1
        li $v0, 4
        syscall
        jal accessArray        # Print move on board position 1
        la $a0, output_board_str2
        li $v0, 4
        syscall
        jal accessArray        # Print move on board position 2
        la $a0, output_board_str2
        li $v0, 4
        syscall
        jal accessArray        # Print move on board position 3
        la $a0, output_board_str1
        li $v0, 4
        syscall
        la $a0, newline
        li $v0, 4
        syscall
        la $a0, output_board_str3
        li $v0, 4
        syscall
        subi $t0, $t0, 1    # loop counter = loop counter - 1
        j forLoop1        # Jump to loop1
    accessArray:
        # Print the user's and computer's moves
        add $t3, $t1, $t2    # $t3 = current array address = base address + offset
        lb  $t4, ($t3)             # $t4 = byte at current array address
        la $a0, ($t4)        # Load character
        li $v0, 11        # Print character
        syscall
        addi $t2, $t2, 1    # $t2 = $t2 + 1
        jr $ra
    exitForLoop1:
    # jr $ra
    
# Exit the program.
    li $v0, 10
    syscall