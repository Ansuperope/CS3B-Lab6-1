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
    
	.text  // code section 

	// terminate the program 
	MOV X0, #0			// set return code to 0, all good 
	MOV X8, #SYS_exit	// set exit() supervisor call code 
	SVC 0				// call Linux to exit 

	.data	// data section

.end	// end of program, optional but good practice 
