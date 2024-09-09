.text
	.globl main

main:		xor	$s2, $s2, $s2		#zera $s2 (i)

		la	$t3, vetA		#carrega o endereco de a
		la	$t4, vetB		#carrega o endereco de b
		la	$t5, vetC		#carrega o endereco de c
	
		la	$t6, mediaA		#carrega o endereco de mediaA
		la	$t7, mediaB		#carrega o endereco de mediaB
		la	$t8, mediaC		#carrega o endereco de mediaC
	
		la	$s0, n			#carrega o endereco n
		lw	$s0, 0($s0)		#poe n (6) em $s0
	
calculo:	lw	$s3, 0($t3)		#a[i] em $s3
		lw	$s4, 0($t4)		#b[i] em $s4
		lw	$s5, 0($t5)		#c[i] em $s5
		
		#calculo A
		lw	$t6, 0($t6)		#$t6 = mediaA
		add	$s7, $t6, $s3		#adiciona media A com $s3 em $s7
		la	$t6, mediaA		#$t6 = &mediaA
		sw	$s7, 0($t6)		#coloca soma total no conteudo de $t6
		
		#calculo B
		lw	$t7, 0($t7)		#$t7 = mediaB
		add	$s7, $t7, $s4
		la	$t7, mediaB		#$t7 = &mediaB
		sw	$s7, 0($t7)
		
		#calculo C
		lw	$t8, 0($t8)		#$t8 = mediaC
		add	$s7, $t8, $s5
		la	$t8, mediaC		#$t8 = &mediaC
		sw	$s7, 0($t8)
		
		#loop
		addi	$s2, $s2, 1		#i++
		addi	$t3, $t3, 4		#a[i++]
		addi	$t4, $t4, 4		#b[i++]
		addi	$t5, $t5, 4		#c[i++]
		bne	$s2, $s0, calculo	#i != n
		
		#divide A
		lw	$t6, 0($t6)
		add	$s1, $t6, $zero
		la	$t6, mediaA
		
		jal	divider

		sw	$v1, 0($t6)
		
		#divide B
		lw	$t7, 0($t7)
		add	$s1, $t7, $zero
		la	$t7, mediaB
		
		jal	divider

		sw	$v1, 0($t7)
		
		#divide C
		lw	$t8, 0($t8)
		add	$s1, $t8, $zero
		la	$t8, mediaC
		
		jal	divider

		sw	$v1, 0($t8)
		
defineVM:	xor	$t1, $t1, $t1
		addi	$t1, $t1, 1		#$t1 = 1
		
testaA:		lw	$t6, 0($t6)		#media A
		lw	$t7, 0($t7)		#media B
		lw	$t8, 0($t8)		#media C
		slt	$t0, $t6, $t7		#media A < media B, $t0 = 1, caso contrario $t0 = 0
		bne	$t0, $t1, testaB	#se media A >= media B, pula pra testaB
		slt	$t0, $t6, $t7		#media A < media C, $t0 = 1, caso contrario $t0 = 0
		bne	$t0, $t1, testaC	#se media A >= media C, pula pra testaC
		la	$t0, vm
		sw	$t6, 0($t0)		#media A foi a menor media, coloca em vm
		j	vetorD

testaB:		slt	$t0, $t7, $t8		#media B < media C, $t0 = 1, caso contrario $t0 = 0
		bne	$t0, $t1, testaC
		la	$t0, vm
		sw	$t7, 0($t0)		#media B foi a menor media, coloca em vm
		j	vetorD
		
testaC:		slt	$t0, $t8, $t6		#media C < media A, $t0 = 1, caso contrario $t0 = 0
		bne	$t0, $t1, end		#deu erro (nenhuma media foi a menor)
		la	$t0, vm					
		sw	$t8, 0($t0)		#media C foi a menor media, coloca em vm
		
vetorD:		xor	$s2, $s2, $s2		#zera $s2 (i)
		xor	$t2, $t2, $t2		#zera $t2 (flag booleano)
		la	$t6, vetD		#carrega end. d
		la	$t7, k			#carrega end. k
		lw	$t7, 0($t7)		#carrega valor de k
		xor 	$t7, $t7, $t7
		lw	$t0, 0($t0)		#carrega valor de vm
		la	$t3, vetA 
		la	$t4, vetB
		la	$t5, vetC
		
loopD:		lw	$s3, 0($t3)		#a[i]
		lw	$s4, 0($t4)		#b[i]
		lw	$s5, 0($t5)		#c[i]
			
		
comparaA:	slt	$t2, $t0, $s3		#a[i] > vm?
		bne	$t2, $t1, comparaB	#nao, prox comparacao
		add	$t8, $s3, $zero 	#else $t8 = a[i]
		jal	adiciona
		
comparaB:	slt	$t2, $t0, $s4		#b[i] > vm?
		bne	$t2, $t1, comparaC	#nao, prox comparacao
		add	$t8, $s4, $zero		#else $t8 = b[i]
		jal 	adiciona
		
comparaC:	slt	$t2, $t0, $s5		#c[i] > vm?
		bne	$t2, $t1, incrementa	#nao, incrementa vars
		add	$t8, $s5, $zero		#else $t8 = c[i]
		jal	adiciona 

incrementa:	addi	$s2, $s2, 1		#i++
		addi	$t3, $t3, 4		#a[i++]
		addi	$t4, $t4, 4		#b[i++]
		addi	$t5, $t5, 4		#c[i++]
		bne	$s2, $s0, loopD

end:		j end
		
		
adiciona:	sw	$t8, 0($t6)		#guarda o conteudo de $t8 (elemento a ser adicionado em D) em d[k]		
		addi 	$t7, $t7, 1		#k++
		addi	$t6, $t6, 4		#d[k++]
		jr	$ra			#retorna
		
	
	
###############################################################################################
### Divisão serial $s1/ $s0 --> $v0--> resto $v1 --> divisão
###############################################################################################
divider:	lui $t0, 0x8000 # máscara para isolar bit mais significativo
 		li $t1, 32 # contador de iterações
 		xor $v0, $v0, $v0 # registrador P($v0)-A($v1) com 0 e o dividendo ($s1)
 		add $v1, $s1, $0

dloop: 		and $t2, $v1, $t0 # isola em t2 o bit mais significativo do registador 'A' ($v1)
 		sll $v0, $v0, 1 # desloca para a esquerda o registrado P-A
 		sll $v1, $v1, 1
 		beq $t2, $0, di1
 		ori $v0, $v0, 1 # coloca 1 no bit menos significativo do registador 'P'($v0)

di1: 		sub $t2, $v0, $s0 # subtrai 'P'($v0) do divisor ($s0)
		blt $t2, $0, di2
 		add $v0, $t2, $0 # se a subtração deu positiva, 'P'($v0) recebe o valor da subtração
 		ori $v1, $v1, 1 # e 'A'($v1) recebe 1 no bit menos significativo

di2: 		addi $t1, $t1, -1 # decrementa o número de iterações
 		bne $t1, $0, dloop
 		jr $ra 

.data
n:	.word 6
vetA:	.word 111 222 333 444 555 666
vetB:	.word 543 431 332 54 0 1
vetC:	.word 53 340 193 12 4 999

vm:	.word 0				#valor médio minimo
vetD:	.word				#vetor de tamanho indefinido com valores de a, b, c que são maiores que vm
k:	.word 0				#numero de elementos de d

mediaA:	.word 0
mediaB:	.word 0
mediaC:	.word 0

divi:	.word 0
resto:	.word 0
