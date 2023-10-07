# int a[10] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
# int i, j, k;
#
# int main(void)
#{
#	i = 1;
#	j = 3;
#	k = 4;
#	a[0] = 5;
#	a[2] = a[0] + 20;
#	a[3] = a[4] + 200000;
#	a[4] = 10000;
#	a[5] = a[6] + a[7] - a[8];
#	a[6] = a[7] - 1;
#	a[7] = a[8] - a[j]
#	a[j] = a[a + k] - i + j;
#	a[k] = a[a[i]];
#	return 0;
#}

.data
    a: .word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 
    i: .space 4
    j: .space 4
    k: .space 4

.text

main:
    # i = 1    
    addiu $t0, $zero, 1		# t0 = 0 + 1
    sw $t0, i			# i = t0
    
    # j = 3    
    addiu $t0, $zero, 3		# t0 = 0 + 3
    sw $t0, j			# j = t0
    
    # k = 4    
    addiu $t0, $zero, 4		# t0 = 0 + 4
    sw $t0, k			# k = t0
    
    # a[0] = 5 
    addiu $t0, $zero, 5		# t0 = 0 + 5
    sw $t0, a			# a = t0
    
    # a[2] = a[0] + 20
    lw $t0, a			# t0 = a[0]
    addiu $t0, $t0, 20		# t0 = t0 + 20
    sw $t0, a+8			# a2 = t0; a+8 pois a posiçãoa[2] está 8 bytes acima da posição de a[0]
    
    # a[3] = a[4] + 200000
    lw $t0, a+16		# t0 = a[4]
    addiu $t0, $t0, 200000	# t0 = t0 + 200000
    sw $t0, a+12		# a[12] = t0
    
    # a[4] = 10000
    addiu $t0, $t0, 10000	# t0 = 0 + 10000
    sw $t0, a+16		# a[16] = t0
    
    # a[5] = a[6] + a[6] - a[7]
    lw $t0, a+24		# t0 = a[6]
    lw $t1, a+28		# t1 = a[7]
    lw $t2, a+32		# t2 = a[8]
    add $t0, $t0, $t1		# t0 = t0 + t1
    sub $t0, $t0, $t2		# t0 = t0 - t2
    sw $t0, a+20		# a[5] = t0
    
    # a[6] = a[7] - i
    lw $t0, a+28		# t0 = a[7]
    lw $t1, i			# t1 = i
    sub $t0, $t0, $t1		# t0 = t0 - i
    sw $t0, a+24		# a[6] = t0
    
    # a[7] = a[8] - a[j]
    lw $t0, j			# t0 = j
    sll $t0, $t0, 2		# t0 = t0*2^2
    la $t2, a			# t2 = *a
    addu $t0, $t0, $t2		# t0 = a[j]
    lw $t1, a+32		# t1 = a[8]
    sub $t0, $t0, $t1		# t0 = t0 - t1
    sw $t0, a+28		# a[7] = t0
    
    # a[j] = a[i+k] - i + j
    lw $t0, j			# t0 = j
    sll $t1, $t0, 2		# t1 = t0*2^2
    la $t4, a			# t4 = *a
    addu $t1, $t1, $t4		# t1 = a[j]
    lw $t2, i			# t2 = i
    lw $t3, k			# t3 = k
    add $t3, $t3, $t2		# t3 = t3 + t2 (t3 = k + i)
    sll $t3, $t3, 2		# t3 = t3*2^2
    addu $t3, $t3, $t4		# t3 = a[i+k]
    sub $t3, $t3, $t2		# t3 = t3 - i
    add $t3, $t3, $t0		# t3 = t3 + j
    sw $t3, ($t1)		# a[j] = t3
    
    # a[k] = a[a[i]]
    lw $t0, k			# t0 = k
    sll $t0, $t0, 2		# t0 = k*2^2
    la $t1, a			# t1 = *a
    addu $t0, $t0, $t1		# t0 = a[k]
    
    lw $t2, i			# t2 = i
    sll $t2, $t2, 2		# t2 = i*2^2
    addu $t2, $t2, $t1		# t2 = a[i]
    
    lw $t2, ($t2)		# t2 = a[í]
    sll $t2, $t2, 2		# t2 = a[i]*2^2
    addu $t2, $t2, $t1 		# t2 = a[t2]
    
    lw $t2, ($t2)		# t2 = a[t2]
    
    sw $t2, ($t0)		# a[k] = a[t2]
    
    lw $s0, a
    lw $s1, a+4
    lw $s2, a+8
    lw $s3, a+12
    lw $s4, a+16
    lw $s5, a+20
    lw $s6, a+24
    lw $s7, a+28
    lw $t8, a+32
    lw $t9, a+36
    
