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
      #
      ##############################
      # SAVE $a registers and $ra
      ##############################
      # 
      ##############################
      # Change $a registers
      ##############################
      # 
      ##############################
      # jal
      ##############################
      # 
      ##############################
      # RELOAD $a registers and $ra
      ##############################
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
	
      ##################################################################
      # IF STATEMENT
      #
      ############################
      # RETURN FROM FUNCTION
      ############################
      ##################################################################
      addi $t0, $zero, 1 # n
      bne $a1, $t0, over # if n == 1 then goto over

      ##################################################################
      # FOR LOOP
      ##################################################################
      
      											# add $s1, $zero, $zero # j = 0
      add $t1, $zero, $zero # target
      addi $s2, $a1, -1  # n - 1
      while:
      	slt $t1, $s1, $s2	# j < n-1
      	bne $t1, 1, endOfwhile	# if j < n - 1 THEN continue, else GOTO over
      	add $s5, $a0, $a0
      	add $s5, $s5, $s5 
      	lw $t2, 0($s5)	# load arr[j]
      	addi $s3, $s1, 4	# s3 = j + 1
      	lw $t4, 4($s5)	# t4 = arr[j+1]
      	add $t5, $zero, $zero   # target for if (arr[j] > arr[j+1])
      	slt $t5, $t4, $t2	# if (arr[j] > arr[j+1])
      	bne $t5, 1, endOfIf     # if the if is true, then GOTO end of if
      	add $s4, $t2, $zero     # $s4 = arr[j]
      	sw $t2, 
    	endOfIf:
    	# call bubblesort again
      endOfwhile:     
      
      ##################################################################
      # RECURSIVE CALL
      #
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
	
