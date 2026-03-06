// ---------------------------------------------------------------------
// Aspen Cristobal
// CS3b - lab-6-1
// 3/10/2026
// ---------------------------------------------------------------------
// 	PURPOSE:
// LOREM
// ---------------------------------------------------------------------
//	VARAIBLES:
// LOREM
// ---------------------------------------------------------------------
// 	PSUEDOCODE:
// LOREM
// ---------------------------------------------------------------------
.global _start	// Provide program starting address 

// functions
.extern getstring

_start: 
	.EQU SYS_exit,  93	// exit() supervisor call code 

	// CONSTANTS
	.EQU MAX_BYTES,	10	// max bytes to read

	.text  // code section 

	// -----------------------------------------------------------------
	// SEND VARAIBLES TO FUNCTION
	// -----------------------------------------------------------------
	// INTIALIZE VARAIBLES
	LDR X0, =szBuffer	// X0 = szBuffer,   string
	MOV X1, MAX_BYTES	// X1 = MAX_LENGTH, max length to output
	
	// SEND TO FUNCITON
	BL  getstring

	// -----------------------------------------------------------------
	// TERMINATE PROGRAM
	// -----------------------------------------------------------------
	MOV X0, #0			// set return code to 0, all good 
	MOV X8, SYS_exit	// set exit() supervisor call code 
	SVC 0				// call Linux to exit 

	.data	// data section
szBuffer:	.skip	MAX_BYTES	// string with size

.end	// end of program, optional but good practice 
