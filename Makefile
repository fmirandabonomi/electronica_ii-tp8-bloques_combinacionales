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

wav_cod_8_3: force cod_8_3.ghw 
	gtkwave -f cod_8_3.ghw

wav_decod_2_4: force decod_2_4.ghw
	gtkwave -f decod_2_4.ghw

wav_mux_8_1: force mux_8_1.ghw
	gtkwave -f mux_8_1.ghw

wav_rom_16x7: force rom_16x7.ghw
	gtkwave -f rom_16x7.ghw
	
wav_bcd_7seg: force bcd_7seg.ghw
	gtkwave -f bcd_7seg.ghw

wav_teclado: force teclado.ghw
	gtkwave -f teclado.ghw

cod_8_3.ghw: cod_8_3.vhd
	ghdl -m --std=08 cod_8_3_tb
	ghdl -r --std=08 cod_8_3_tb --wave=cod_8_3.ghw
decod_2_4.ghw: decod_2_4.vhd
	ghdl -m --std=08 decod_2_4_tb
	ghdl -r --std=08 decod_2_4_tb --wave=decod_2_4.ghw
mux_8_1.ghw: mux_8_1.vhd
	ghdl -m --std=08 mux_8_1_tb
	ghdl -r --std=08 mux_8_1_tb --wave=mux_8_1.ghw
rom_16x7.ghw: rom_16x7.vhd
	ghdl -m --std=08 rom_16x7_tb
	ghdl -r --std=08 rom_16x7_tb --wave=rom_16x7.ghw
bcd_7seg.ghw: bcd_7seg.vhd
	ghdl -m --std=08 bcd_7seg_tb
	ghdl -r --std=08 bcd_7seg_tb --wave=bcd_7seg.ghw
teclado.ghw: teclado.vhd
	ghdl -m --std=08 teclado_tb
	ghdl -r --std=08 teclado_tb --wave=teclado.ghw


force: work-obj08.cf

corrige: recupera all

reset:
	git checkout -f

recupera:
	tar -xf entrega.tar

entrega: all entrega.tar
entrega.tar:  
	tar -cf entrega.tar cod_8_3.vhd decod_2_4.vhd mux_8_1.vhd rom_16x7.vhd bcd_7seg.vhd teclado.vhd

clean:
	ghdl clean
work-obj08.cf: *.vhd
	ghdl -i --std=08 *.vhd
