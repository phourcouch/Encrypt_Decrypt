.data 

prompt: .asciiz "Please enter the massage to be sent:\n"

output_Enc: .asciiz "\nYour encrypted message is:\n"

output_Dec: .asciiz "\nYour decrypted message is:\n"

charArray: .byte 0,0,0,0,0,0,0,0,0,0

gap1: .asciiz  " "

EncArray: .byte 0,0,0,0,0,0,0,0,0,0

gap2: .asciiz  " "

DecArray: .byte 0,0,0,0,0,0,0,0,0,0

gap3: .asciiz  " "

.text 

li $s0, 10 #loop 
li $s1, 10 #key  

li $v0,4
la $a0,prompt
syscall 


li $v0,8
la $a0, charArray #collect user's input & store into charArray 
li $a1, 10
syscall 

la $s2, charArray
la $s3,	EncArray

encArray: beq $s0,$0,next
lb $t0, 0($s2) #load a byte from user's input array
xor $t3,$t0,$s1 #char3 = char + 10
sb $t3, 0($s3) #store encrypted byte to EncArray

li $t0,0
li $t3,0

addi $s0,$s0,-1
addi $s2,$s2,1
addi $s3,$s3,1

j encArray

next:
li $v0,4
la $a0,output_Enc
syscall 

la $a0,	EncArray #point to top of array

li $v0, 4
syscall


li $s0, 10 #loop 
li $s7, 10 #key  
la $s4,	DecArray
la $s3,	EncArray

decArray: beq $s0,$0,next2
lb $t0, 0($s3) #load a byte from user's input array
xor $t3,$t0,$s7 #char3 = char + 10
sb $t3, 0($s4) #store encrypted byte to DecArray

li $t0,0
li $t3,0

addi $s0,$s0,-1
addi $s4,$s4,1
addi $s3,$s3,1

j decArray
 
next2:

li $v0,4
la $a0,output_Dec
syscall 

la $a0,	DecArray #point to top of array

li $v0, 4
syscall

li $v0, 10
syscall #close program

