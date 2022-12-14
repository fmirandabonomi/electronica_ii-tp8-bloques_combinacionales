library IEEE;
use IEEE.std_logic_1164.all;
package pkg_rom_16x7 is
    type Tabla16x7 is array (0 to 15) of std_logic_vector (6 downto 0);
end package;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.pkg_rom_16x7.all;

entity rom_16x7 is
    generic (
        constant contenido: Tabla16x7 := (others=>(others=>'0')));
    port(
        dir  : in std_logic_vector (3 downto 0);
        hab  : in std_logic;
        dato : out std_logic_vector (6 downto 0));
end rom_16x7;

architecture solucion of rom_16x7 is
begin
-- Escribe aquí tu solución.
end solucion;
