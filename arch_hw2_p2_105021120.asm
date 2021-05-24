# student_id:105021120
.data
str1:		.asciiz "Please select an integer number A from (0~10): "
str2:		.asciiz "A * 2 = "
str3:		.asciiz "******"
str4:		.asciiz "THE END"
Pnewline: 	.asciiz "\n"
.text

_Start:
	# Prompt the user to enter int
	
	la $a0, str1
	li $v0, 4
	syscall
	
	# Get the int and store in $t0
	
  	li $v0, 5
	syscall
	move $t0 $v0
  	
  	#if input = 0, goto _Exit
  	
  	beq $t0, $zero, _Exit
  	
  	# If $t0 < 0 || $t0 > 10, goto _OutofRange
  	
  	blt $t0, $zero, _Start
  	bgt $t0, 10, _Start
  	
  	#If input =7, compute input * 2, and print out the answer.
	
	bne  $t0, 7, _function_others    
	       
	#Print 7 case
	
	la $a0, str2
	li $v0, 4
	syscall
	li $a0, 14
	li $v0, 1
	syscall	
	la $a0, Pnewline
	li $v0, 4
	syscall
	
  	#After print out, go back to wait the user to enter number.
  	j _Start
  	
  	
_function_others:
	#setup counter i
	li $t1, 0
	 
	#Write a Loop for print ******
	Loop:
	
	#Chech the input and the counter
		beq $t1, $t0, _Start
	
	#End the loop and wait the user to enter number.
	

	# print out ******
		la $a0, str3
		li $v0, 4
		syscall
	
	#print out the counter number
	        move $a0, $t1
		li $v0, 1
		syscall	    
	 
	# print out ******
	        la $a0, str3
		li $v0, 4
		syscall     
	
	# print out \n (����)	
		la $a0, Pnewline
		li $v0, 4
		syscall
		
	#counter ++
		addi $t1, $t1, 1
	
	#go back to the Loop
	j Loop                

#Stop the program
_Exit:
	la $a0, str4
	li $v0, 4
	syscall
	#print out THE END
	
