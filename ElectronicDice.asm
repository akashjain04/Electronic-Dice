
ASSUME CS:CODE,DS:DATA

DATA SEGMENT
	COUNT DB 0
	CHOICE DB ?
    RINT DB ?
	MSG1 DB 10,13,"ENTER 1-ROLL THE DICE 0 -TO STOP$"
	MSG2 DB 10,13,"ENTER YOUR CHOICE$"
	MSG3 DB 10,13,"RANDOM NUMBER GENERATED IS $"
	MSG4 DB 10,13,"-------EXIT !!!!------$"
	MSG5 DB 10,13,"BINGO$"
	REC DB 100 DUP(0)
DATA ENDS
CODE SEGMENT
START:
    MOV AX,DATA
	MOV DS,AX
	LEA SI,REC
	INC SI
	INC SI
	INC SI
    UP:
	LEA DX,MSG1        ;To display message MSG1
	MOV AH,09H
	INT 21H
	LEA DX,MSG2        ;To display message MSG2
	MOV AH,09H
	INT 21H	
	MOV AH,01H         ;To read the choice
	INT 21H
	MOV CHOICE,AL      ; To Store the value of choice
	CMP AL,'0'         ; Compare the entered choice with ASCII value of 0
	JE EXIT            ; If equal to 0 then Exit ( Terminate the program )
	LEA DX,MSG3        ; To display message MSG3
	MOV AH,09H
	INT 21H
	MOV AH,2CH
	INT 21H            ; Interrupt used to get the system time 
	MOV AX,DX 
	MOV DX,0
	MOV CX,6
	DIV CX             ; Divide the value of AX with 6 in order to get remainder between 0 to 5
	ADD DL,'0'         ; Add the ASCII value 30 to convert value to ASCII
	ADD DL,1 			; Since obtained random integer is between 0 to 5 add 1 to make it display between 1 to 6 to simulate rolling of dice.
	;MOV RINT,DL
	MOV [SI],DL
	INC SI
	MOV AH,02H         ;To display the Random value generated
	INT 21H

    CMP DL,'6'
	JNE NEXT1
	INC COUNT;
NEXT1:
	MOV BL,[SI]
	CMP BL,[SI-1]
	JNE EX
	CMP BL,[SI-2]
	JE NEXT
	EX:
	CMP COUNT,3
	;JE NEXT
	JMP UP             ; Continue till the user enters 0
	
NEXT:
	LEA DX,MSG5
	MOV AH,09H
	INT 21H
	JMP EXIT
EXIT:
	LEA DX,MSG4       ; To display message MSG1
	MOV AH,09H
	INT 21H
	MOV AH,4CH
	INT 21H

CODE ENDS
END START
	
        
