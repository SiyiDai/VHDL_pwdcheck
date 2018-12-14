# VHDL_pwdcheck

VHDL project for SS17 Circuit Design

The project is, the customer said: “I want to have an ASIC (FPGA), which opens a door. A 
code lock. The input of the FPGA is a data stream from an existing, programmed micro 
controller. The data stream are ASCII characters. The protocol (or is it the algorithm; 
please explain it to me) is UART (or is it RS232; please explain). The transmission is 9600 
baud, 8 bit, parity (correct parity should be indicated by a LED), 1 stop bit. Once, the ASIC 
received the characters, they will be compared to pre-stored characters. If there is a 
match, the door opens (a LED will be switched on). There should be four different sets of 
characters choosable. The actual character set should be selected by switches. By the 
way, I heard something about OSI layers, please explain your implementations with 
respect to the OSI layers (in the final specification). I want to understand, what those OSI 
layers are.“ 

