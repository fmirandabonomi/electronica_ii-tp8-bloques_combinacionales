library IEEE;
use IEEE.std_logic_1164.all;
use work.tp8.all;

entity mux_8_1 is
    port (
        din  : in std_logic_vector (7 downto 0); 
        sel  : in std_logic_vector (2 downto 0);
        hab  : in std_logic;
        dout : out std_logic);
end mux_8_1;

architecture solucion of mux_8_1 is
begin
-- Escribe aquí tu solución.
end solucion;

