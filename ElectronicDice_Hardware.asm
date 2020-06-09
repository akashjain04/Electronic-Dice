ASSUME CS:CODE,DS:DATA
DATA SEGMENT
	PA EQU 40A0H
	PB EQU PA+1
	PC EQU PB+1
	CR EQU PC+1
	CHOICE DB 0
    RINT DB 0
	SSTABLE DB 0C0H,0F9H,0A4H,0B0H,99H,92H,83H,0F8H,80H,98H ; To store the seven segment code values
    SSCODE DB 0C0H,0C0H,0C0H,0C0H ; To display 0 in seven segment code along with the dice number
	MSG1 DB 10,13,"ENTER 1-ROLL THE DICE 0 -TO STOP$"
	MSG2 DB 10,13,"ENTER YOUR CHOICE$"
	MSG3 DB 10,13,"RANDOM NUMBER GENERATED IS $"
	MSG4 DB 10,13,"-------EXIT !!!!------$"
DATA ENDS
CODE SEGMENT
START:
    MOV AX,DATA
	MOV DS,AX ; Intialize the data segment
    MOV DX,CR
	MOV AL,80H
	OUT DX,AL ; Intialize the hardware interface 8255
 UP:
	LEA DX,MSG1 ;To display message MSG1
	MOV AH,09H
	INT 21H
	LEA DX,MSG2 ;To display message MSG2
	MOV AH,09H
	INT 21H	
	MOV AH,01H ;To read the choice
	INT 21H
    MOV CHOICE,AL ; To Store the value of choice
	LEA DX,MSG3 ; To display message MSG3
	MOV AH,09H
	INT 21H
    CMP CHOICE,'0' ; Compare the entered choice with ASCII value of 0
	JE EXIT ; If equal to 0 then Exit ( Terminate the program )
	MOV AH,2CH
	INT 21H ; Interrupt used to get the system time 
	MOV AX,DX 
	MOV DX,0
	MOV CX,6
	DIV CX ; Divide the value of AX with 6 in order to get remainder between 0 to 5

    MOV RINT,DL ; Store remainder in RINT which will be in the range of 0 to 5
    INC RINT ; To increment value of RINT 0 to 5 to display in the range of 1 to 6 to simulate a dice
    ADD DL,'0' ; Add ascii value of 0 to print the value;
    ADD DL,1 ; Incrementing the value to display between 1 to 6
    MOV AH,02H
    INT 21H ; Interrupt to print the random number generated.
    LEA SI,RINT ; Make SI point to RINT (source)
	LEA DI,SSCODE ; Make DI point to SSCODE which is used to store seven segment code of random number
	LEA BX,SSTABLE ; Load BX with address of SSTABLE which contains the table of values
    MOV AL,[SI] ; Move contents of memory location pointed to by SI to AL
	XLAT ; Transalte the value stored in AL with seven segment code
    MOV [DI],AL ; Store the Seven segment code to location pointed by DI
	LEA SI,SSCODE ; Make SI point to SSCODE
	CALL DISPLAY ; Call the DISPLAY procedure to display the random number on seven segment display
    
	JMP UP ; Continue till the user enters 0
EXIT:
	LEA DX,MSG4 ; To display the exit message
	MOV AH,09H
	INT 21H
	MOV AH,4CH ; To Terminate the program
	INT 21H

DISPLAY PROC
    MOV CX,04 ; Since we display four characters we store CX with 4
NXT_CHR:
    MOV AL,[SI] ; Load AL with value stored at memory location pointed by SI
	MOV BL,08H ; Since we have 8 bits per number to display
NXT_BIT:
	ROL AL,01H ; Rotate the contents of AL by one position
	MOV DX,PB
	OUT DX,AL ; Send one bit 
	PUSH AX ; To save the contents of AX such that its value will not be overwritten.
	MOV AL,00H
	MOV DX,PC
	OUT DX,AL; Send a low clock signal
	MOV AL,01H
	OUT DX,AL ; Send a high clock signal
	POP AX ; To get back the value stored in AX
	DEC BL ; decrement the count 
	JNZ NXT_BIT ; Display the bits one by one
    INC SI ; Increment SI to point to next number
    LOOP NXT_CHR ; Display all four characters on seven segment display
RET ; To return to main program;
DISPLAY ENDP
	
CODE ENDS
END START
