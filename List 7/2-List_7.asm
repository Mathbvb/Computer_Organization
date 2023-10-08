.data

	vet_a: .word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
	var_i: .space 0
	var_j: .space 0
	var_k: .space 0
	acc: .word 0

.text

    # endereços
    la $s0, vet_a
    la $s1, var_i
    la $s2, var_j
    la $s3, var_k
    la $s4, acc
    
main:
    
    addiu $t0, $zero, 1	
    sw $t0, ($s1)			# var_i = 1
    
    addiu $t0, $zero, 2	
    sw $t0, ($s2)			# var_j = 2
    
    addiu $t0, $zero, 4	
    sw $t0, ($s3)			# var_k = 4
    
    
     # for(i = 1; i < 10; i++)

     for1:
      
      lw $t0, ($s1)
      
      sll $t1, $t0, 2			# t1 = t0 * 2^2 
      add $t1, $t1, $s0
      
      subu $t2, $t0, 1			# t2 = t0 - 1
      sll $t2, $t2, 2
      add $t2, $t2, $s0
      
      lw $t3, ($t2)
      addiu $t3, $t3, 19		# t3 = a[i-1] + 19
      
      sw $t3, ($t1)			# a[i] = t3
      
      lw $t0, ($s1) 			# t0 = var_i
      addiu $t0, $t0, 1			# i++
      sw $t0, ($s1)			# guarda t0 em var_i
      blt $t0, 10, for1		# se $t0 < 10 goto for1
    
      # fim for1
    
    
      # for(i = 0; i < 10; i++)
    
     addiu $t0, $zero, 0
     sw $t0, ($s1)			# var_i = 0
    
     for2:
    
       lw $t0, ($s1)
       sw $t0, ($s2)			# var_j = var_i
    
     for3:
       
       lw $t0, ($s2)
       sll $t0, $t0, 2			
       add $t0, $t0, $s0
       
       lw $t1, ($t0)
       lw $t2, ($s4)
       
       add $t1, $t1, $t2
       sw $t1, ($s4)       
       
       lw $t0, ($s2) 			# t0 = var_j
       addiu $t0, $t0, 1		# i++
       sw $t0, ($s2)			# guarda t0 em var_i
       blt $t0, 10, for3		# se $t0 < 10 goto for1
       
     # fim for3
    
    
     lw $t0, ($s1) 			# t0 = var_i
     addiu $t0, $t0, 1			# i++
     sw $t0, ($s1)			# guarda t0 em var_i
     blt $t0, 10, for2			# se $t0 < 10 goto for1
     
     # fim for2
     
     
     # a[6] = acc
     
     lw $t0, ($s4)
     sw $t0, 24($s0)
     
     
     # while(a[k] < acc)
     
     while:
     
       lw $t0, ($s3)			# t0 = var_k
       sll $t0, $t0, 2			# t0 = t0 * 4
       add $t0, $t0, $s0
       lw $t1, ($t0)			# t1 = a[t0] 
       
       lw $t2, ($s4)			# t0 = acc
       
       blt $t2, $t1, fim_while
       
       addiu $t1, $t1, 10
       sw $t1, ($t0)
       
       j while
       
     fim_while:
     
     
     # do{ }while(a[7] < a[8])
     
     do:
     
       lw $t0, ($s3)			# t0 = var_k
       sll $t0, $t0, 2
       add $t0, $t0, $s0
       lw $t0, ($t0)
       addiu $t0, $t0, 10
       sw $t0, 28($s0)
       
     
       lw $t0, 28($s0)
       lw $t1, 32($s0)
       
       blt $t0, $t1, do			# se a[7] < a[8] goto do
     
     
     
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

     lw $a0, ($s1)
     lw $a1, ($s2)
     lw $a2, ($s3)
     lw $a3, ($s4)
     