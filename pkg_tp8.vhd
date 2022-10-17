library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

package TP8 is
    type Tabla16x7 is array (0 to 15) of bit_vector (6 downto 0);
    function num_unos (a : std_logic_vector) return natural;
end package;

package body TP8 is
    function num_unos (a : std_logic_vector) return natural is
        variable w : unsigned(a'range);
        variable d : natural :=0;
        begin
            w := unsigned(a);
            while to_integer(w) /= 0 loop
                w := w and (w - 1);
                d := d + 1;
            end loop;
            return d;
        end function;
end package body;