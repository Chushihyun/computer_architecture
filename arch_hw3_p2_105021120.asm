.data
str1:		.asciiz "input a: "
str2:		.asciiz "input b: "
str4:		.asciiz "ans: "
Pnewline: 	.asciiz "\n"
.text

main:
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
	
###input over


### do re(a) and place c
	move $a0,$s0
	jal  re
	move $s2,$v0
	
### do fn(b,c) and place d
	move $a0,$s1
	move $a1,$s2
	jal fn
	move $s3,$v0
	
	j _exit
	
### end
#########################
### function	
re:
	addi $sp,$sp,-12
	sw $a0,0($sp)
	sw $ra,4($sp)
	
	bge $a0,2,label1
	beq $a0,1,label2
	move $v0,$zero	
	addi $sp,$sp,12
	jr $ra
	
    label2:
    	addi $v0,$zero,1
    	addi $sp,$sp,12
	jr $ra
	
    label1:
	addi $a0,$a0,-1
	jal re
	lw $a0,0($sp)
	move $t0,$v0
	sw $t0,8($sp)
	addi $a0,$a0,-2
	jal re
	move $t1,$v0
	
	lw $a0,0($sp)
	lw $ra,4($sp)
	lw $t0,8($sp)
	addi $sp,$sp,12
	
### prepare output
### t0=re(x-1), t1=re(x-2), t2=x-1, a0=x
	mul $t0,$t0,$a0
	addi $t2,$a0,-1
	mul $t1,$t1,$t2
	mul $v0,$a0,$a0
	add $v0,$v0,$t0
	add $v0,$v0,$t1
	
	jr $ra


#########################
##
fn:
	addi $sp,$sp,-24
	sw $a0,0($sp)
	sw $a1,4($sp)
	sw $ra,8($sp)
	
	ble $a0,0,label3
	ble $a1,0,label3
	bgt $a0,$a1,label4

### else case, to get t0,t1,t2	
### t0=fn(x-1,y) t1=fn(x,y-1) t2=fn(x-1,y-1)
	addi $a0,$a0,-1
	jal fn
	lw $a0,0($sp)
	lw $a1,4($sp)
	lw $ra,8($sp)
	move $t0,$v0
	sw $t0,12($sp)
	
	addi $a1,$a1,-1
	jal fn
	lw $a0,0($sp)
	lw $a1,4($sp)
	lw $ra,8($sp)
	lw $t0,12($sp)
	move $t1,$v0
	sw $t1,16($sp)
	
	addi $a0,$a0,-1
	addi $a1,$a1,-1
	jal fn
	lw $a0,0($sp)
	lw $a1,4($sp)
	move $t2,$v0
	sw $t2,20($sp)
	
	lw $ra,8($sp)
	lw $t0,12($sp)
	lw $t1,16($sp)
	lw $t2,20($sp)
	addi $sp,$sp,24
	
	j output
	
    label3:		## x or y <= 0 , return 0
    	move $v0,$zero
    	addi $sp,$sp,24
	jr $ra
	
    label4:             ## x > y , return 2
        addi $v0,$zero,2
    	addi $sp,$sp,24
	jr $ra
    
	
	
### prepare output
### t0=re(x-1), t1=re(x-2), t2=x-1, a0=x
    output:
	mul $t0,$t0,3
	mul $t1,$t1,2
	add $v0,$t0,$t1
	add $v0,$v0,$t2
	
	jr $ra

#Stop the program
_exit:
	la $a0, str4
	li $v0, 4
	syscall
	move $a0, $s2
	li $v0, 1
	syscall
	
	la $a0, str4
	li $v0, 4
	syscall
	move $a0, $s3
	li $v0, 1
	syscall
	
	#print out result
	
