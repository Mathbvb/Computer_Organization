.data
    matriz_A: .word 0:5
	      .word 0:5
	      .word 0:5
	      .word 0:5
	      .word 0:5		# declarando matriz 5x5 com zeros

    message: .asciiz "Digite um número inteiro. \0"

.text

  main:
    
    # endereços para as variáveis
    la $s0, matriz_A

    # recebendo o valor para matriz_A[1][3]
    # imprimindo a mensagem
    li, $v0, 4			# informa que deve ser impresso uma string
    la, $a0, message		# carrega o endereço da string
    syscall			# imprime a string
    
    # recebendo o valor
    li, $v0, 5			# informando que deve receber um input de inteiro do teclado
    syscall			
    sw, $v0, 12($s0)		# guarda o valor digitado na posição [1][3] da matriz
    
    # recebendo o valor para matriz_A[2][2]
    # imprimindo a mensagem
    li, $v0, 4			# informa que deve ser impresso uma string
    la, $a0, message		# carrega o endereço da string
    syscall			# imprime a string
    
    # recebendo o valor
    li, $v0, 5			# informando que deve receber um input de inteiro do teclado
    syscall			
    sw, $v0, 28($s0)		# guarda o valor digitado na posição [2][2] da matriz
    
    # somando as posições [1][3] e [2][2]
    lw $t1, 12($s0)		# guarda o valor de A[1][3] em t1
    lw $t2, 28($s0)		# guarda o valor de A[2][2] em t1
    
    add $t0, $t1, $t2		# t0 = t1 + t2 
    sw $t0, 36($s0)		# a[2][4] = t0
    
