library IEEE;
use IEEE.std_logic_1164.all;

entity teclado is
    port (
        sel        : in std_logic_vector (1 downto 0);
        hab        : in std_logic;
        drv_fila   : out std_logic_vector (3 downto 0);
        buf_col    : in std_logic_vector (3 downto 0);
        estado_col : out std_logic_vector (3 downto 0));
end teclado;

architecture solucion of teclado is
begin
-- Escribe aquí tu solución.
end solucion;