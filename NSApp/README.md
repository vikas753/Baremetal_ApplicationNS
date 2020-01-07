Non secure world application written specifically for LTZvisor Hypervisor but can be run standalone too

Compilation : 
make BOARD=ZEDBOARD . 

1. Power-on your board;

2. Run any terminal and setup the serial port for 115200 bps (baud rate);

3. Stop the autoboot by hitting any key;

4. Type the following sequence of commands:

	- ZedBoard Zynq-7000 ARM/FPGA SoC Development Board:
 
		`mmcinfo`
		
		`fatload mmc 0 0x100000 NSApp.bin`
		
		`go 0x100000` 

Application shall print
"Hello World" messages. 

References
------------

 1. Sandro Pinto, Jorge Pereira, Tiago Gomes, Adriano Tavares, and Jorge Cabral. 
 "LTZVisor: TrustZone is the Key." In LIPIcs-Leibniz International Proceedings 
 in Informatics, vol. 76. Schloss Dagstuhl-Leibniz-Zentrum fuer Informatik, 2017.
 
 2. Sandro Pinto, Daniel Oliveira, Jorge Pereira, Nuno Cardoso, Mongkol 
 Ekpanyapong, Jorge Cabral, and Adriano Tavares. "Towards a lightweight embedded 
 virtualization architecture exploiting ARM TrustZone." In Emerging Technology 
 and Factory Automation (ETFA), IEEE, pp. 1-4., 2014.

