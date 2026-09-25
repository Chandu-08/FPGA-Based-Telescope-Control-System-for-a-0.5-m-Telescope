library ieee;
use ieee.std_logic_1164.all;

entity quadrature_decoder is
    port (
        clk       : in  std_logic;
        reset     : in  std_logic;
        enc_a     : in  std_logic;
        enc_b     : in  std_logic;
        step      : out std_logic;
        direction : out std_logic
    );
end entity;

architecture rtl of quadrature_decoder is
    signal previous_state : std_logic_vector(1 downto 0) := "00";
    signal current_state  : std_logic_vector(1 downto 0);
begin

    current_state <= enc_a & enc_b;

    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                previous_state <= "00";
                step           <= '0';
                direction      <= '0';
            else
                step <= '0';

                case previous_state & current_state is

                    -- Forward sequence:
                    -- 00 -> 01 -> 11 -> 10 -> 00
                    when "0001" | "0111" | "1110" | "1000" =>
                        step      <= '1';
                        direction <= '1';

                    -- Reverse sequence:
                    -- 00 -> 10 -> 11 -> 01 -> 00
                    when "0010" | "1011" | "1101" | "0100" =>
                        step      <= '1';
                        direction <= '0';

                    when others =>
                        null;

                end case;

                previous_state <= current_state;
            end if;
        end if;
    end process;

end architecture;
