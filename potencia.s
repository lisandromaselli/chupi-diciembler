.data

out1:	.asciiz "Ingresar cantidad de exponentes: "
out2:	.asciiz "Ingresar exponentes: "
coma:	.asciiz ", "


#Fibonacci

.text

main: 		jal entrada
			move $t2, $v0

loop0:		beq $t2, $0, salir
			lw $a0, 0($v1)
			li $a1, 2
			jal potencia
			move $a0, $v0
			li $v0, 1
			syscall
			li $v0, 4
			la $a0, coma
			syscall
			addi $v1, $v1, 4
			addi $t2, $t2, -1
			j loop0

		
# entradas: ninguna
# salidas: $v0 numero exponentes
#          $v1 direccion primer exponente
entrada:	li $v0, 4
			la $a0, out1
			syscall
			li $v0, 5
			syscall
			move $t0, $v0	# Total de exponentes en temporal para iterar en la lista
			move $t2, $v0	# Guardo el total de exponentes en otra variable segura
			li $a0, 4
			li $v0, 9
			syscall
			move $v1, $v0	# Copio la direccion del primero de la lista
			move $t1, $v0	# Direccion de la lista, variable usada para recorrerla y guardar los resultados

loop1:		beq $t0, $0, endloop1
			li $v0, 4
			la $a0, out2
			syscall
			li $v0, 5
			syscall			
			sw $v0, 0($t1)
			li $a0, 4
			li $v0, 9
			syscall
			move $t1, $v0
			addi $t0, $t0, -1
			j loop1
endloop1:	move $v0, $t2
			jr $ra

# $a0, $a1
potencia:	addi $sp, $sp, -8
			sw $a0, 4($sp)
			sw $ra, 0($sp)
			beq $a0, $0, casobase
            andi $t0, $a0, 0x1
            beq $t0, $0, espar
esimpar:    srl $a0, $a0, 1
         	jal potencia
         	mul $v0, $v0, $v0
         	mul $v0, $v0, $a1
         	j fin
espar:		srl $a0, $a0, 1
			jal potencia
			mul $v0, $v0, $v0
			j fin
casobase:	li $v0, 1
			j fin
fin:		lw $ra, 0($sp)
			addi $sp, $sp, 8
			jr $ra


salir:		li $v0, 10
			syscall