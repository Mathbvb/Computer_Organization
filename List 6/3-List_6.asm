.data
    matriz_A: .word 0:250

    .eqv tam_data 4

    message: .asciiz "Digite um número inteiro. \0"

        
.text

  main:
    
    #endereços
    
    la $s0, matriz_A
    
    
    # recebe um valor para matriz_A[1][3][7]
    
    # imprime o message no terminal
    li $v0, 4			# informa que deve ser impresso uma string
    la $a0, message		# carrega o endereço da string
    syscall			# imprime a string
    li $v0, 5			# le um valor inteiro
    syscall			
    
    li $t0, 200			# t0 = 200 
    sll $t0, $t0, 2		# t0 = 7 * 4 (posição de A[0][0][7])
    addiu $t0, $t0, 32		# t0 = t0 + 32 (posição de A[1][3][7])
    add $t0, $t0, $s0		# + endereço da matriz
    
    sw $v0, ($t0)		# guarda o valor na posição A[1][3][7] 
    
    
    # recebe um valor para matriz_A[1][3][7]
    
    # imprime o message no terminal
    li $v0, 4			# informa que deve ser impresso uma string
    la $a0, message		# carrega o endereço da string
    syscall			# imprime a string
    li $v0, 5			# le um valor inteiro
    syscall			
    
    li $t1, 175			# t0 = 100 
    sll $t1, $t1, 2		# t0 = 3 * 4 (posição de A[0][0][3])
    addiu $t1, $t1, 72		# t0 = t0 + 48 (posição de A[2][2][7])
    add $t1, $t1, $s0		# + endereço da matriz
    
    sw $v0, ($t1)		# guarda o valor na posição A[2][2][7] 
    
    # soma A[1][3][7] e A[2][2][7]  e guarda em A[1][4][8]
    
    lw $t2, ($t0)		# t2 = A[1][3][7]
    lw $t3, ($t1)		# t3 = A[2][2][7] 
    
    add $t4, $t2, $t3		# t4 = A[1][3][7] + A[2][2][7]
    
    li $t5, 225			# t0 = 225 
    sll $t5, $t5, 2		# t0 = 8 * 4 (posição de A[0][0][8])
    addiu $t5, $t5, 36		# t0 = t0 + 48 (posição de A[1][4][8])
    add $t5, $t5, $s0		# + endereço da matriz
    
    sw $t4, ($t5)		# guarda t4 em A[1][4][8]
