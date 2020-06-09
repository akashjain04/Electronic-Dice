# Electronic Dice
****

Electronic dice is an Assembly program written to simulate the behaviour of the dice. It can generate random numbers between 1 and 6. This is designed specifically for 8086 Microprocessor.

## We have two types

  - Software Program
  - Hardware Program


### Software Program
****
The software program has two options. One is to roll the dice and another is to stop the simulation. The software program just displays the result on the screen. 

#### Output:-
![software Output](https://github.com/akashjain04/Electronic-Dice/blob/master/SoftwareOutput.png?raw=true)


### Hardware Program
****
The Hardware program uses the 7 segment display to display the result. We need to have this hardware to execute the program. The program displays the result on the seven segment display.

#### Output:-

![Hardware Output](https://github.com/akashjain04/Electronic-Dice/blob/master/HardwareOutput.png?raw=true)

## Execution
****
We need to have MASM installed in the System.

First we compile to assembly file,
```
    masm programName.asm
```
Next we link the object file
```
    link programName.obj
```
Next we run the .exe file
```
    programName.exe
```

For executing hardware programs you need to assign permissions and then execute the program similar to software program.



