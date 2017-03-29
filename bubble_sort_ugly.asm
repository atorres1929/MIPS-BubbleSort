      .data
nums: .word   0 : 12        # "array" of 12 words to contain values
size: .word  12             # size of "array" 
      .text
      la $s0, nums
      la $s5, size        # load address of size variable
      lw $s5, 0($s5)	    # load value of size
      
      # Populate with twelve values
      addi $t1, $zero, 55
      sw $t1, 0($s0)
      addi $t1, $zero, 88
      sw $t1, 4($s0)
      addi $t1, $zero, 0
      sw $t1, 8($s0)
      addi $t1, $zero, 22
      sw $t1, 12($s0)
      addi $t1, $zero, 77
      sw $t1, 16($s0)
      addi $t1, $zero, 44
      sw $t1, 20($s0)
      addi $t1, $zero, 99
      sw $t1, 24($s0)
      addi $t1, $zero, 33
      sw $t1, 28($s0)
      addi $t1, $zero, 110
      sw $t1, 32($s0)
      addi $t1, $zero, 66
      sw $t1, 36($s0)
      addi $t1, $zero, 121
      sw $t1, 40($s0)
      addi $t1, $zero, 11
      sw $t1, 44($s0)

      ##################################################################
      # AT THIS POINT: $s0 is the address of the start of the array
      #                $s5 is the size (= 12)
      #################################################################
      
      ##################################################################
      # PUT CODE HERE FOR CALL
      ##############################
      # SAVE $a registers and $ra
      ##############################
      addi $sp, $sp, -12
      sw $a0, 0($sp)
      sw $a1, 4($sp)
      sw $ra, 8($sp)
      ##############################
      # Change $a registers
      ##############################
      # 
      ##############################
      # jal
      ##############################
      jal bubblesort
      ##############################
      # RELOAD $a registers and $ra
      ##############################
      reload:
        lw $a0, 0($sp)
        lw $a1, 4($sp)
        lw $ra, 8($sp)
        addi $sp, $sp, 12 
      ##################################################################

                         
      ##################################################################
      # DO NOT MODIFY
      la   $a0, nums        # first argument for print (array)
      add  $a1, $s5, $zero      # second argument for print (size)
      jal  print            # call print routine. 
      li   $v0, 10          # system call for exit
      syscall               # we are out of here.
      ##################################################################


########################################################################
# PUT CODE HERE FOR FUNCTION
bubblesort:

      ##################################################################
      # SAVE S REGISTERS
      ##################################################################
	addi $sp, $sp, -8
	sw $s0, 0($sp)
	sw $s5, 4($sp)
      ##################################################################
      # IF STATEMENT
      startsort:
        add $t7, $s5, $zero  # setting t7 to n (size of the array)
        beq $t7, 1, endsort # if n == 1 then goto over
      ############################
      # RETURN FROM FUNCTION
      ############################
      ##################################################################
      
      ##################################################################
      # FOR LOOP
      ##################################################################
      	add $s1, $zero, $zero 	# j = 0
        add $t0, $zero, $zero 	# target
       
        addi $s2, $t7, -1  	# n - 1
      while:			# while
      	slt $t0, $s1, $s2	# j < n-1
      	bne $t0, 1, done	# if j < n - 1 THEN continue, else GOTO done
      	
      	# Need arr[j] -> index = j * 4 so IF j = 4 THEN index = 16 (remember word size is 4)
      	add $t6, $s1, $s1	# t6 = j + j
      	add $t6, $t6, $t6	# t6 = j + j (j is now mulitplied by 4)
      	add $t6, $s0, $t6	# t6 = index 0 + index j
      	lw $t1, 0($t6)		# load word at t6 which is arr[j]
      	
      	# Need arr[j+1] -> index = (j+1) * 4 so IF j = 4 THEN index = 20 (4+1=5 -> 5*4=20)
      	addi $t5, $s1, 1	# t5 = j + 1
      	add $t5, $t5, $t5	# t5 = (j+1) + (j+1)
      	add $t5, $t5, $t5	# t5 = (j+1) + (j+1) (j+1 is now multiplied by 4)
      	add $t5, $s0, $t5	# t5 = index 0 + index j + 1
      	lw $t2, 0($t5)		# load word at t5 which is arr[j+1]
      	
      	add $t3, $zero, $zero   # target
      	slt $t3, $t2, $t1	# arr[j+1] < arr[j]
      	bne $t3, 1, endif	# if slt NOT true, end of if
      	sw $t1, 0($t5)		# swap j and j+1 -> j goes into j + 1 (address location)
      	sw $t2, 0($t6)		# swap j+1 and j -> j + 1 goes into j (address location)
      endif:
      	addi $s1, $s1, 1	# increment j
      	j while
      ##################################################################
      # RECURSIVE CALL
      done:
      	addi $s5, $s5, -1	# decrement the size of the array to search from 12, 11, 10 etc. 
      	j startsort     	# call bubblesort again
      endsort:
        lw $s0, 0($sp)		
      	lw $s5, 4($sp)
      	addi $sp, $sp, 8
      	j reload
      ######################################
      # SAVE $a registers, $ra
      ######################################
      #
      ######################################
      # CHANGE $a registers
      ######################################
      #
      ######################################
      # jal
      ######################################
      #	
      ######################################
      # RELOAD $a registers, $ra
      ######################################
      ################################################################## 
      
      ##################################################################
      # RETURN FROM FUNCTION
      ##################################################################
      
########################################################################


########################################################################
#########  routine to print the numbers on one line. 
#########  don't touch anything below this line!!!!

      .data
space:.asciiz  " "          # space to insert between numbers
head: .asciiz  "Sorted array:\n"
      .text
print:add  $s0, $zero, $a0  # starting address of array
      add  $t1, $zero, $a1  # initialize loop counter to array size
      la   $a0, head        # load address of print heading
      li   $v0, 4           # specify Print String service
      syscall               # print heading
out:  lw   $a0, 0($s0)      # load number for syscall
      li   $v0, 1           # specify Print Integer service
      syscall               # print number
      la   $a0, space       # load address of spacer for syscall
      li   $v0, 4           # specify Print String service
      syscall               # output string
      addi $s0, $s0, 4      # increment address
      addi $t1, $t1, -1     # decrement loop counter
      bgtz $t1, out         # repeat if not finished
      jr   $ra              # return
########################################################################
	
