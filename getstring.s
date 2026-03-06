// ---------------------------------------------------------------------
// getstring.s
// ---------------------------------------------------------------------
// 	PURPOSE:
// Will read a string of characters up to a specified length from the 
// console and save it in a specified buffer as a C-String (i.e. null
// terminated).
// ---------------------------------------------------------------------
//	VARAIBLES:
//  X0: Points to the first byte of the buffer to receive the string. This must
//      be preserved (i.e. X0 should still point to the buffer when this function
//      returns).
//  X1: The maximum length of the buffer pointed to by X0 (note this length
//      should account for the null termination of the read string (i.e. C-String)
//  LR: Must contain the return address (automatic when BL
//      is used for the call)
//  All AAPCS mandated registers are preserved.
// ---------------------------------------------------------------------
// 	PSUEDOCODE:
// LOREM
// ---------------------------------------------------------------------
.global getstring	// Provide program starting address 

getstring: 
	.EQU STDIN,		0	// starndard input
	.EQU STDOUT,	1	// standard output
	.EQU SYS_read,	63	// Linux read()
	.EQU SYS_write, 64	// Linux write()
	.EQU SYS_exit,  93	// exit() supervisor call code 

	.text  // code section 
	// -----------------------------------------------------------------
	// SAVE VARIABLES FROM MAIN
	//	X3: X0, string
	//	X4: X1, MAX_LENGTH
	// -----------------------------------------------------------------
	MOV X3, X0			// X3 = X0, variable to store string
	MOV X4, X1			// X4 = X1,    n MAX_LENGTH

	// -----------------------------------------------------------------
	// READ KEYBOARD
	// -----------------------------------------------------------------
	MOV X0, STDIN  		// file descriptor for stdin (keyboard) 
	MOV X1, X3			// read() needs buffer pointer in X1 
	MOV X2, X4		 	// max amount of characters to read
	MOV X8, SYS_read 	// Linux read() system call number 
	SVC 0				// call Linux to execute commands

	// If input not valid exit (overflow)
	CMP  X0, XZR
	B.LT done

	// -----------------------------------------------------------------
	// PROCESS INPUT
	//	X3: string
	//	X4: MAX_LENGTH
	//	X5: counter
	//  X6: current character
	//  X7: MAX_LENGTH - 1
	// -----------------------------------------------------------------
	// INITALIZATIONS
	MOV X5, #0			// counter = 0
            
forEachChar:
	// -----------------------------------------------------------------
	// CHECK IF CHARACTER == NULL
	// -----------------------------------------------------------------
	LDR  X6, [X3, X5] 	// X6 = string[counter]
	CMP  X6, #'0'		// X6 == '\n', exit
	B.EQ output

	// -----------------------------------------------------------------
	// CHECK IF COUNTER == MAX_LENGTH - 1
	// -----------------------------------------------------------------
	SUB  X7, X4, #1
	CMP  X5, X7			// X5 == MAX_LENGHT - 1
	B.EQ output

	// -----------------------------------------------------------------
	// LOOP AGAIN
	// -----------------------------------------------------------------
	ADD X5, X5, #1	// X5++
	B forEachChar

	// -----------------------------------------------------------------
	// OUTPUT INPUT
	//	X3: X0, string
	//	X4: X1, MAX_LENGTH
	//	X5: counter
	// -----------------------------------------------------------------
output: 
	STRB WZR, [X3, X5]  // X0[counter] = \0

	MOV X0, STDOUT		// tells program we will output
	MOV X1, X3			// string to output
	MOV X2, X4			// number of characters to output
	MOV X8, SYS_write	// Linux write() sys call
	SVC 0				// call Linux to execute commands

    // terminate program
done:
	RET     // return to main

.end	// end of program, optional but good practice 
