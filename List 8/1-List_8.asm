.data
	g1: .space 4

.text 
	
	
	j main				# va para a main


	# int p3(int i, int y)
	p3:
	
	# mapa da pilha #
	# i = sp
	# y = sp + 4
	# c = sp + 8
	# ra = sp + 12
	
	addiu $sp, $sp, -16		# ajusta a pilha para (4 * sizeof(int))
	
	sw $ra, 12($sp)			# guarda o valor de retorno
	sw $a0, ($sp)			# guarda o valor de i
	sw $a1, 4($sp)			# guarda o valor de y
	
	lw $t0, ($sp)			# t0 = i
	lw $t1, 4($sp)			# t1 = y
	
	and $v0, $t0, $t1		# v0 = t0 and t1 
	sw $v0, 8($sp)
	
	lw $ra, 12($sp)			# restora o valor de retorno
	addiu $sp, $sp, 16		# destroi a pilha
	jr $ra				# retorna
	
	
	# int p2(int y)
	p2:
	
	# mapa da pilha #
	# b[10] = sp
	# i = sp + 40
	# acumuluador = sp + 44
	# y = sp + 48
	# ra = sp + 52
	
	addiu $sp, $sp, -56		# ajusta a pilha para (13 * sizeof(int))
	
	sw $ra, 52($sp)			# guarda o valor de retorno
	sw $a0, 48($sp)			# guarda o valor de y
	
	addiu $t0, $zero, 0		# t0 = 0 + 0
	sw $t0, 44($sp)			# acumulador = t0
	
	addiu $t0, $zero, 0		# t0 = 0 + 0
	sw $t0, 40($sp)			# i = t0
	
	j checa_for
	
	for:
		
		lw $t2, 40($sp)		# t2 = i
		sll $t2, $t2, 2		# t2 = i * 2 ^2
		add $t2, $t2, $sp	# t2 + sp (endereço para o vetor b[i])
		
		lw $a0, 40($sp)		# a0 = i
		lw $a1, 48($sp)		# a1 = y
		
		jal p3			# v0 guarda o retorno de p3
		
		add $t3, $v0, $a1	# t3 = p3(i, y) + y
		sw $t3, ($t2)		# b[i] = t3
		
		lw $t4, 44($sp)		# t4 = acumulador
		add $t4, $t4, $t3	# t4 = acumulador + b[i]
		
		sw $t4, 44($sp)		# guarda o acumulador no endereço
		
		addiu $t0, $t0, 1	# i++
		sw $t0, 40($sp)		# guarda i
	
	checa_for:
		
		slti $t1, $t0, 10	# t1 = t0 < 10
		bne $t1, $zero, for	# t1 != 0, goto for
	
	lw $v0, 44($sp)			# v0 = acumulador, para o return
	lw $a0, 48($sp)			# a0 restora y
	
	lw $ra, 52($sp)			# restora o valor de retorno
	addiu $sp, $sp, 56		# destroi a pilha
	jr $ra				# retorna
	
	
	# int p1(int x)
	p1:
	
	# mapa da pilha #
	# a1 = sp
	# a2 = sp + 4
	# x = sp + 8
	# ra = sp + 12
	
	addiu $sp, $sp, -16		# ajusta a pilha sp para (4 * sizeof(int))
	
	sw $ra, 12($sp)			# guarda o endereço de retorno
	sw $a0, 8($sp)			# guarda x em sp
	
	# a0 ja esta com o valor de x para p2(x)
	jal p2				# retorno de p2 esta em v0
	
	sw $v0, ($sp)			# a1 = p2(x)
	add $t0, $a0, $v0		# a2 = x + a1
	sw $t0, 4($sp)			# guarda o valor de a2
	
	lw $v0, 4($sp)			# v0 = a2
	lw $a0, 8($sp)			# restora x
	
	lw $ra, 12($sp)			# restora o valor de retorno
	addiu $sp, $sp, 16		# destroi a pilha
	jr $ra				# retorna
	
	
	main:
	
	# mapa da pilha #
	# $ra = $sp + 4
	# resultado = $sp
	
	addiu $sp, $sp, -8		# ajusta a pilha sp para (2 * sizeof(int))
	
	sw $ra, 4($sp)			# guarda o endereço de retorno caso alguma função chame a main
	
	la $s0, g1			# s0 recebe o endereço de g1
	addiu $t0, $zero, 10		# t0 = 10
	sw $t0, ($sp)			# s0 = t0
	
	lw $a0, 0($sp)			# a0 = g1, (x0 = x) de p1
	jal p1				# o valor do retorno de pq está salvo no registrador v0
	sw $v0, ($sp)			# armazena o valor de retorno na variavel resultado
	
	li $v0, 1			# v0 = 1, imprime inteiro
	lw $a0, ($sp)			# a0 = resultado
	syscall
	
	addiu $v0, $zero, 0		# return 0
	lw $ra, 4($sp)			# ra recebe o valor de retorno
	addiu $sp, $sp, 8		# destroi a pilha

	
	addiu $v0, $zero, 17
	syscall				# fecha o programa
	
	
	
	