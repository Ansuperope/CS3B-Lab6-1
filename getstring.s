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
	// READ KEYBOARD
	// -----------------------------------------------------------------
	MOV X2, X1 			// max amount of characters to read
	MOV X1, X0			// read() needs buffer pointer in X1
	MOV X0, STDIN  		// file descriptor for stdin (keyboard) 
	MOV X8, SYS_read 	// Linux read() system call number 
	SVC 0				// call Linux to exicute commands

	// If input not valid exit (overflow)
	CMP  X0, XZR
	B.LT done

	// -----------------------------------------------------------------
	// SEND VARAIBLES TO FUNCTION
	// -----------------------------------------------------------------
	

	// -----------------------------------------------------------------
	// OUTPUT INPUT
	// -----------------------------------------------------------------
	MOV X0, STDOUT		// tells program we will output
	MOV X1, X1	// string to output
	MOV X2, X2	// number of characters to output
	MOV X8, SYS_write	// Linux write() sys call
	SVC 0				// call Linux to execute commands

    // terminate program
done:
	RET     // return to main

.end	// end of program, optional but good practice 
