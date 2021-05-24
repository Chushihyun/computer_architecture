.data
str1:		.asciiz "input a: "
str2:		.asciiz "input b: "
str3:		.asciiz "input c: "
str4:		.asciiz "result = "
Pnewline: 	.asciiz "\n"
.text

_Start:
	# Prompt the user to enter a
	la $a0, str1
	li $v0, 4
	syscall
	
	# Get the a and store in $s0
  	li $v0, 5
	syscall
	move $s0 $v0
	
	# Prompt the user to enter b
	la $a0, str2
	li $v0, 4
	syscall
	
	# Get the a and store in $s1
  	li $v0, 5
	syscall
	move $s1,$v0
	
	# Prompt the user to enter c
	la $a0, str3
	li $v0, 4
	syscall
	
	# Get the a and store in $s2
  	li $v0, 5
	syscall
	move $s2,$v0
###input over	

### do madd(a,c)
	move $a0,$s0
	move $a1,$s2
	jal _madd
	move $s4,$v0
	
### do abs_sub(b,x)
	move $a0,$s1
	move $a1,$s4
	jal _abs_sub
	move $s3,$v0
	
	j _exit

####################
### function	
_madd:
	addi $sp,$sp,-8
	sw $s0,0($sp)
	sw $s2,4($sp)
	
	bge $a0,$a1,label1
	move $t1,$a0
	move $t0,$a1
	j label2
	
    label1:
	move $t0,$a0
	move $t1,$a1	

    label2:	
	move $t2,$zero
	
    loop1:
	blt $t0,$t1,return1
	add $t2,$t2,$t1
	addi $t0,$t0,-1
	j loop1				
	
    return1:	
	move $v0,$t2
	
	lw $s0,0($sp)
	lw $s2,4($sp)
	addi $sp,$sp,8
	jr $ra

_abs_sub:

	addi $sp,$sp,-8
	sw $s1,0($sp)
	sw $s4,4($sp)
	
	bge $a0,$a1,label3
	move $t1,$a0
	move $t0,$a1
	j label4
	
    label3:
	move $t0,$a0
	move $t1,$a1	

    label4:	
	
	sub $v0,$t0,$t1
	
	lw $s1,0($sp)
	lw $s4,4($sp)
	addi $sp,$sp,8
	jr $ra


#Stop the program
_exit:
	la $a0, str4
	li $v0, 4
	syscall
	move $a0, $s3
	li $v0, 1
	syscall
	#print out result
	
