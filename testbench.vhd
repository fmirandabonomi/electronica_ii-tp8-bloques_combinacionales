library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cod_8_3_tb is
    -- empty
end cod_8_3_tb;

architecture tb of cod_8_3_tb is
    constant nombre : string := "cod_8_3";
    component cod_8_3 is
        port (
            entrada : in std_logic_vector (7 downto 0);
            valido  : out std_logic;
            salida  : out std_logic_vector (2 downto 0));
    end component;
    signal x_in       : std_logic_vector (7 downto 0);
    signal valido_out : std_logic;
    signal y_out      : std_logic_vector (2 downto 0);

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
begin
    DUT : cod_8_3 port map (entrada => x_in, 
                             valido => valido_out, 
                             salida => y_out);
    process
        variable pass       : boolean := true;
        variable all_pass   : boolean := true;
        variable y_esperado : std_logic_vector (2 downto 0);
        variable x          : std_logic_vector (7 downto 0);
    begin
        for i in 0 to 7 loop
            if not all_pass then
                exit;
            end if;
            x_in <= std_logic_vector(to_unsigned(2**i,8));
            y_esperado := std_logic_vector(to_unsigned(i,3));
            wait for 1 ns;
            assert valido_out = '1' report "Indica entrada no valida para "
                                            &to_string(x_in)&" valida"
                                    severity error;
            assert y_out = y_esperado report "Codigo incorrecto "&to_string(y_out)
                                             &" para entrada "&to_string(x_in)
                                      severity error;
            pass := valido_out = '1' and y_out = y_esperado;
            all_pass := pass and all_pass;
            x := std_logic_vector(to_unsigned(i*199621 mod 2**8,8));
            if num_unos(x) /= 1 then
                x_in <= x;
                wait for 1 ns;
                pass := valido_out = '0';
                all_pass := pass and all_pass;
                assert pass report "Indica entrada valida para "
                                   &to_string(x_in)&" no valida"
                            severity error;
            end if;
        end loop;
        if all_pass then
            report nombre&" [PASS]" severity note;
        else
            report nombre&" [FAIL]" severity failure;
        end if;
        wait;
    end process;
end tb;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity decod_2_4_tb is
    -- empty
end decod_2_4_tb;

architecture tb of decod_2_4_tb is
    constant nombre : string := "decod_2_4";
    component decod_2_4 is
        port (
            sel    : in std_logic_vector (1 downto 0);
            hab    : in std_logic;
            salida : out std_logic_vector (3 downto 0));
    end component;
    signal sel_in : std_logic_vector (1 downto 0);
    signal hab_in : std_logic;
    signal y_out  : std_logic_vector (3 downto 0);
begin
    DUT : decod_2_4 port map (sel => sel_in,hab => hab_in,salida => y_out);
    process
        variable pass       : boolean := true;
        variable all_pass   : boolean := true;
        variable y_esperado : std_logic_vector (3 downto 0);
    begin
        for i in 0 to 3 loop
            if not all_pass then
                exit;
            end if;
            sel_in <= std_logic_vector(to_unsigned(i,2));
            hab_in <= '0';
            y_esperado := (others=>'0');
            wait for 1 ns;
            pass := y_esperado = y_out;
            all_pass := pass and all_pass;
            assert pass report "Salida debe mantenerse en cero si inhabilitado"
            severity error;
            hab_in <= '1';
            y_esperado := std_logic_vector(to_unsigned(2**i,4));
            wait for 1 ns;
            pass := y_esperado = y_out;
            all_pass := pass and all_pass;
            assert pass report "Salida incorrecta para entrada "&to_string(sel_in)
                               &lf&"    esperado "&to_string(y_esperado)
                               &lf&"    obtenido "&to_string(y_out)
                        severity error;
        end loop;
        if all_pass then
            report nombre&" [PASS]" severity note;
        else
            report nombre&" [FAIL]" severity failure;
        end if;
        wait;
    end process;
end tb;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux_8_1_tb is
    -- empty
end mux_8_1_tb;

architecture tb of mux_8_1_tb is
    constant nombre : string := "mux_8_1";
    component mux_8_1 is
        port(
            din  : in std_logic_vector (7 downto 0); 
            sel  : in std_logic_vector (2 downto 0);
            hab  : in std_logic;
            dout : out std_logic);
    end component;
    signal x_in   : std_logic_vector (7 downto 0);
    signal sel_in : std_logic_vector (2 downto 0);
    signal hab_in : std_logic;
    signal y_out  : std_logic;
begin
    DUT : mux_8_1 port map (din => x_in, 
                             sel => sel_in,
                             hab => hab_in,
                             dout => y_out);
    process
        variable pass     : boolean := true;
        variable all_pass : boolean := true;
    begin
        for i in 0 to 7 loop
            if not all_pass then
                exit;
            end if;
            x_in    <= std_logic_vector(to_unsigned(2**i,8));
            sel_in  <= std_logic_vector(to_unsigned(i,3));
            hab_in  <= '0';
            wait for 1 ns;
            pass := y_out = 'Z';
            all_pass := pass and all_pass;
            assert pass report "Salida debe ser de alta impedancia cuando no habilitado"
            severity error;
            hab_in <= '1';
            wait for 1 ns;
            pass := y_out = '1';
            all_pass := pass and all_pass;
            assert pass report "Salida debe ser '1' porque la entrada seleccionada "
                                &to_string(sel_in)&" lo es"
                        severity error;
            x_in <= not x_in;
            wait for 1 ns;
            pass := y_out = '0';
            all_pass := pass and all_pass;
            assert pass report "Salida debe ser '0' porque la entrada seleccionada "
                                &to_string(sel_in)&" lo es"
                        severity error;
        end loop;
        if all_pass then
            x_in   <= "01010101";
            hab_in <= '1';
            wait for 1 ns;
            for i in 0 to 7 loop
                sel_in <= std_logic_vector(to_unsigned(i,3));
                wait for 1 ns;
                pass := y_out = x_in(i);
                if not pass then
                    all_pass := false;
                    report "Datos "&to_string(x_in)&" selector "&to_string(sel_in)
                            &lf&"  Salida esperada "&std_logic'image(x_in(i))
                            &lf&"  Salida obtenida "&std_logic'image(y_out)
                         severity error;
                    exit;
                end if;
            end loop;
        end if;
        if all_pass then
            report nombre&" [PASS]" severity note;
        else
            report nombre&" [FAIL]" severity failure;
        end if;
        wait;
    end process;
end tb;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.pkg_rom_16x7.all;

entity rom_16x7_tb is
    -- empty
end rom_16x7_tb;

architecture tb of rom_16x7_tb is
    constant nombre : string := "rom_16x7";
    component rom_16x7 is
        generic (
            constant contenido: Tabla16x7 := (others=>(others=>'0')));
        port(
            dir  : in std_logic_vector (3 downto 0);
            hab  : in std_logic;
            dato : out std_logic_vector (6 downto 0));    
    end component;
    signal dir_in : std_logic_vector (3 downto 0);
    signal hab_in : std_logic;
    signal y_out  : std_logic_vector (6 downto 0);
    constant contenido: Tabla16x7 := (
        16#0# => "0000000",
        16#1# => "0000001",
        16#2# => "0000011",
        16#3# => "0000110",
        16#4# => "0001100",
        16#5# => "0011000",
        16#6# => "0110000",
        16#7# => "1100000",
        16#8# => "1000000",
        16#9# => "1000001",
        16#A# => "0100010",
        16#B# => "0010100",
        16#C# => "0001000",
        16#D# => "0011100",
        16#E# => "0101010",
        16#F# => "1001001");
begin
    DUT : rom_16x7 generic map (contenido => contenido)
                   port map (dir => dir_in, 
                             hab => hab_in,
                             dato => y_out);
    process
        variable pass     : boolean := true;
        variable all_pass : boolean := true;
        variable esperado : std_logic_vector (6 downto 0);
    begin
        for i in 0 to 15 loop
            if not all_pass then
                exit;
            end if;
            dir_in <= std_logic_vector(to_unsigned(i,4));
            hab_in <= '0';
            wait for 1 ns;
            esperado := (others => 'Z');
            pass := y_out = esperado;
            all_pass := pass and all_pass;
            assert pass report "La salida debe mantenerse en alta impedancia cuando hab es '0'"
                               &lf&"    Esperado: "&to_string(esperado)
                               &lf&"    Obtenido: "&to_string(y_out)
                        severity error;
            hab_in <= '1';
            wait for 1 ns;
            esperado := to_std_logic_vector(contenido(i));
            pass := y_out = esperado;
            all_pass := pass and all_pass;
            assert pass report "El contenido de dir "&integer'image(i)&" es incorrecto."
                               &lf&"    Esperado: "&to_string(esperado)
                               &lf&"    Obtenido: "&to_string(y_out)
                        severity error;
        end loop;
        if all_pass then
            report nombre&" [PASS]" severity note;
        else
            report nombre&" [FAIL]" severity failure;
        end if;
        wait;
    end process;
end tb;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity bcd_7seg_tb is
    -- empty
end bcd_7seg_tb;

architecture tb of bcd_7seg_tb is
    constant nombre : string := "bcd_7seg";
    component bcd_7seg is
        port (
            bcd       : in std_logic_vector (3 downto 0);
            hab       : in std_logic;
            segmentos : out std_logic_vector (6 downto 0));    
    end component;
    signal x_in   : std_logic_vector (3 downto 0);
    signal hab_in : std_logic;
    signal y_out  : std_logic_vector (6 downto 0);
begin
    DUT : bcd_7seg port map (bcd => x_in,hab => hab_in,segmentos => y_out);
    process
        variable pass     : boolean := true;
        variable all_pass : boolean := true;
    begin
        -- Deshabilitado
        hab_in <= '0';
        x_in <= x"-";
        wait for 1 ns;
        pass := y_out = (6 downto 0 => 'Z');
        all_pass := pass and all_pass;
        assert pass report "Si no esta habilitado las salidas deben mantenerse en 0"
        severity error;
        -- Habilitado
        hab_in <= '1';
        x_in   <= x"0";
        wait for 1 ns;
        pass := y_out = "1111110";
        all_pass := pass and all_pass;
        assert pass report "Patron incorrecto para numero 0"
                    severity error;
        x_in   <= x"1";
        wait for 1 ns;
        pass := y_out = "0110000";
        all_pass := pass and all_pass;
        assert pass report "Patron incorrecto para numero 1"
                    severity error;
        x_in   <= x"2";
        wait for 1 ns;
        pass := y_out = "1101101";
        all_pass := pass and all_pass;
        assert pass report "Patron incorrecto para numero 2"
                    severity error;
        x_in   <= x"3";
        wait for 1 ns;
        pass := y_out = "1111001";
        all_pass := pass and all_pass;
        assert pass report "Patron incorrecto para numero 3"
                    severity error;
        x_in   <= x"4";
        wait for 1 ns;
        pass := y_out = "0110011";
        all_pass := pass and all_pass;
        assert pass report "Patron incorrecto para numero 4"
                    severity error;
        x_in   <= x"5";
        wait for 1 ns;
        pass := y_out = "1011011";
        all_pass := pass and all_pass;
        assert pass report "Patron incorrecto para numero 5"
                    severity error;
        x_in   <= x"6";
        wait for 1 ns;
        pass := y_out = "1011111";
        all_pass := pass and all_pass;
        assert pass report "Patron incorrecto para numero 6"
                    severity error;
        x_in   <= x"7";
        wait for 1 ns;
        pass := y_out = "1110010";
        all_pass := pass and all_pass;
        assert pass report "Patron incorrecto para numero 7"
                    severity error;
        x_in   <= x"8";
        wait for 1 ns;
        pass := y_out = "1111111";
        all_pass := pass and all_pass;
        assert pass report "Patron incorrecto para numero 8"
                    severity error;
        x_in   <= x"9";
        wait for 1 ns;
        pass := y_out = "1111011";
        all_pass := pass and all_pass;
        assert pass report "Patron incorrecto para numero 9"
                    severity error;
    
        if all_pass then
            report nombre&" [PASS]" severity note;
        else
            report nombre&" [FAIL]" severity failure;
        end if;
        wait;
    end process;
end tb;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity teclado_tb is
    -- empty
end teclado_tb;

architecture tb of teclado_tb is
    constant nombre : string := "teclado";
    component teclado is
        port (
            sel        : in std_logic_vector (1 downto 0);
            hab        : in std_logic;
            drv_fila   : out std_logic_vector (3 downto 0);
            buf_col    : in std_logic_vector (3 downto 0);
            estado_col : out std_logic_vector (3 downto 0));    
    end component;
    signal sel_in : std_logic_vector (1 downto 0);
    signal hab_in : std_logic;
    signal f_out_x: std_logic_vector (3 downto 0);
    signal f_out  : std_logic_vector (3 downto 0);
    signal c_in   : std_logic_vector (3 downto 0);
    signal c_out  : std_logic_vector (3 downto 0);
    function open_drain (x: std_logic_vector ) return std_logic_vector is
        variable result : std_logic_vector (x'range);
    begin
        for i in x'range loop
            case to_x01(x(i)) is
                when '0' => result(i) := '0';
                when '1' => result(i) := 'Z';
                when others => result(i) := 'U';
            end case;
        end loop;
        return result;
    end function;

begin
    DUT : teclado port map (sel        => sel_in,
                            hab        => hab_in,
                            drv_fila   => f_out_x,
                            buf_col    => c_in,
                            estado_col => c_out);
    f_out <= open_drain(f_out_x);
    process
        variable pass     : boolean := true;
        variable all_pass : boolean := true;
        variable f_out_esperado : std_logic_vector(3 downto 0);
        variable c_out_esperado : std_logic_vector(3 downto 0);
    begin
        sel_in <= "--";
        hab_in <= '0';
        c_in <= "----";
        wait for 1 ns;
        f_out_esperado := (3 downto 0 => 'Z' );
        c_out_esperado := (3 downto 0 => 'Z' );
        pass := f_out = f_out_esperado and c_out = c_out_esperado;
        assert pass 
            report "Cuando el circuito esta deshabilitado debe mantener sus salidas en alta impedancia"
            &lf&" f_out: "&to_string(f_out)
            &lf&" c_out: "&to_string(c_out)
            severity error;
        all_pass := pass and all_pass;
        hab_in <= '1';
        c_in <= (others=>'H');
        wait for 1 ns;
        c_out_esperado := (3 downto 0 => '0'); 
        pass := c_out = c_out_esperado;
        all_pass := pass and all_pass;
        assert pass
            report "Las salidas de columna correspondiente a entradas distintas de '0' deben ser '0'"
            severity error; 
        for k in 0 to 3 loop
            if not all_pass then
                exit;
            end if;
            sel_in <= std_logic_vector(to_unsigned(k,2));
            wait for 1 ns;
            f_out_esperado := (3 downto 0 => 'Z');
            f_out_esperado(k) := '0'; 
            pass := f_out = f_out_esperado;
            all_pass := pass and all_pass;
            assert pass
                report "Salidas de seleccion incorrectas para selector "&integer'image(k)
                severity error;
        end loop;
        for k in 0 to 3 loop
            if not all_pass then
                exit;
            end if;
            c_in <= (others=>'H');
            c_in(k) <= '0';
            wait for 1 ns;
            c_out_esperado := (others => '0');
            c_out_esperado(k) := '1';
            pass := c_out = c_out_esperado;
            all_pass := pass and all_pass;
            assert pass
                report "Las salidas de columna correspondiente a entradas distintas de '0' deben ser '0' y para entradas '1' deben ser '1'"
                severity error;
        end loop;
        if all_pass then
            report nombre&" [PASS]" severity note;
        else
            report nombre&" [FAIL]" severity failure;
        end if;
        wait;
    end process;
end tb;


