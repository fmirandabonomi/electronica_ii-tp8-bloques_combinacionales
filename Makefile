all: force cod_8_3 decod_2_4 mux_8_1 rom_16x7 bcd_7seg teclado
cod_8_3: force 
	ghdl -m --std=08 cod_8_3_tb
	ghdl -r --std=08 cod_8_3_tb
decod_2_4: force
	ghdl -m --std=08 decod_2_4_tb
	ghdl -r --std=08 decod_2_4_tb
mux_8_1: force
	ghdl -m --std=08 mux_8_1_tb
	ghdl -r --std=08 mux_8_1_tb
rom_16x7: force
	ghdl -m --std=08 rom_16x7_tb
	ghdl -r --std=08 rom_16x7_tb
bcd_7seg: force
	ghdl -m --std=08 bcd_7seg_tb
	ghdl -r --std=08 bcd_7seg_tb
teclado: force
	ghdl -m --std=08 teclado_tb
	ghdl -r --std=08 teclado_tb
force: work-obj08.cf

entrega: all entrega.tar
entrega.tar:  
	tar -cf entrega.tar cod_8_3.vhd decod_2_4.vhd mux_8_1.vhd rom_16x7.vhd bcd_7seg.vhd teclado.vhd

clean:
	ghdl clean
work-obj08.cf: *.vhd
	ghdl -i --std=08 *.vhd
