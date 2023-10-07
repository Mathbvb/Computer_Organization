.data
    
    vet_a: .word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
    var_i: .space 4
    var_j: .space 4
    var_k: .space 4

.text

    # endereços

    la $s0, vet_a
    la $s1, var_i
    la $s2, var_j
    la $s3, var_k


  main:
  
    addiu $t0, $zero, 1			# t0 = 1
    sw, $t0, ($s1)			# var_i = t0
    
    j abc
    
    addiu $t0, $zero, 123		# t0 = 123
    sw, $t0, 16($s0)			# a[4] = t0
    addiu $t0, $zero, 900		# t0 = 900
    sw, $t0, 20($s0)			# a[5] = t0
    
  abc:
  
    lw, $t0, ($s1)			# t0 = var_i
    sw $t0, ($s0)			# a[0] = t0
    
    lw $t0, ($s0)			# t0 = a[0]
    sw $t0, ($s2)			# var_j = t0
    
    lw $t0, ($s1)			# t0 = var_i
    addiu $t1, $t0, 3000		# t0 = var_i + 3000
    sw $t1, ($s3)			# var_k = t0
    
    lw $t1, ($s2)			# t1 = var_j
    bne $t0, $t1, if1_false		# se var_i != var_j, vá para if1_false
    
      lw $t0, ($s3)			# t0 = var_k
      lw $t1, 36($s0)			# t1 = a[9]
      sub $t0, $t0, $t1			# t0 = var_k - a[9]
      sw $t0, 8($s0)			# a[2] = t0
    
      j fim_if1				# goto fim_if1
    
    if1_false:
    
      lw $t0, 16($s0)			# t0 = a[4]
      sw $t0, 8($s0)			# a[2] = t0
    
    fim_if1:
    
    # if ((k < i) && (i < 600))
    lw $t0, ($s1)			# t0 = var_i
    lw $t1, ($s3)			# t1 = var_k
    
    slt $t2, $t1, $t0			# se k<i t2 = 1, se k>i t2 = 0
    slti $t3, $t0, 600			# se i<600 t3 = 1, se i>600 t3 = 0
    
    and $t0, $t2, $t3			# t0 = t2 && t3
    
    bne $t0, 1, if2_false		# se t0 != 1, vá para if2_false
    
      # if ((k == 6) || (j >= i))
      lw $t0, ($s1)			# t0 = var_i
      lw $t1, ($s2)			# t1 = var_j
      lw $t2, ($s3)			# t1 = var_k
      
      seq $t3, $t2, 6			# t3 = var_k == 6
      sle $t4, $t0, $t2			# t4 = var_i <= var_j
      
      or $t5, $t3, $t4			# t5 == t3 || t4
      
      bne $t5, 1, if3_false		# se t5 != 1, goto if3_false
      
      addiu $t0, $zero, 400		# t0 = 0 + 400
      sw $t0, 36($s0)			# a[9] = t0
      
      j if3_fim				# va pro fim do if3
      
      if3_false:
      
      addiu $t0, $zero, 500		# t0 = 0 + 500
      sw $t0, 32($s0)			# a[8] = t0
      
      if3_fim:
      
      j if2_fim				# va pro fim do if2
      
    if2_false:
    
    j if2_fim				# va pro fim do if2
    
    if2_fim:    
    
    # switch(a[j * 2 + 1])
    
    lw $t0, ($s2)			# t0 = var_j
    sll $t0, $t0, 1			# t0 = t0 * 2`1
    addiu $t0, $t0, 1			# t0 = t0 + 1
    sll $t0, $t0, 2			# t0 = t0 * 2^2
    add $t0, $t0, $s0			# t0 = t0 + endereço de vet_A (vet_A[t0])
    
    lw $t1, ($t0)			# t1 = a[t0]
    
    beq $t1, 1, switch1_case1		# se t1 = 1, goto case1
    beq $t1, 3, switch1_case3		# se t1 = 1, goto case3
    beq $t1, 5, switch1_case5		# se t1 = 1, goto case5
    
    j fim_switch1
    
    switch1_case1:
    
    addiu $t0, $zero, 4000		# t0 = 0 + 4000
    sw $t0, 4($s0)			# a[1] = t0
    
    j fim_switch1
    
    switch1_case3:
    
    lw $t0, 16($s0)
    
    beq $t0, 3, switch2_case3
    beq $t0, 4, switch2_case4
    beq $t0, 5, switch2_case5
    
    j fim_switch2
    
      switch2_case3:
      
      addiu $t0, $zero, 50000		# t0 = 0 + 50000
      sw $t0, 20($s0)			# a[5] = t0
      
      j fim_switch2
      
      switch2_case4:
      
      addiu $t0, $zero, 50000		# t0 = 0 + 50000
      sw $t0, 24($s0)			# a[6] = t0
      
      j fim_switch2
      
      switch2_case5:
      
      addiu $t0, $zero, 70000		# t0 = 0 + 50000
      sw $t0, 28($s0)			# a[7] = t0
      
      fim_switch2:
    
    addiu $t0, $zero, 50000		# t0 = 0 + 50000
    sw $t0, 12($s0)			# a[3] = t0
    
    j fim_switch1
    
    switch1_case5:
    
    addiu $t0, $zero, 6000		# t0 = 0 + 6000
    sw $t0, 20($s0)			# a[5] = t0
    
    fim_switch1:
    
    lw $t0, ($s0)
    lw $t1, 4($s0)
    lw $t2, 8($s0)
    lw $t3, 12($s0)
    lw $t4, 16($s0)
    lw $t5, 20($s0)
    lw $t6, 24($s0)
    lw $t7, 28($s0)
    lw $t8, 32($s0)
    lw $t9, 36($s0)
    
    lw $a1, ($s1)
    lw $a2, ($s2)
    lw $a3, ($s3)
    
    
    
    
    