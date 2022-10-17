library IEEE;
use IEEE.std_logic_1164.all;
use work.tp8.all;

entity bcd_7seg is
    port (
        bcd       : in std_logic_vector (3 downto 0);
        hab       : in std_logic;
        segmentos : out std_logic_vector (6 downto 0));
end bcd_7seg;

architecture solucion of bcd_7seg is
begin
-- Escribe aquí tu solución.
end solucion;