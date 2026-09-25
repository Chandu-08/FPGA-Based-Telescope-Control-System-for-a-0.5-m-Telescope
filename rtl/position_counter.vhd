library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity position_counter is
    generic (
        COUNTS_PER_REVOLUTION : positive := 14400
    );
    port (
        clk             : in  std_logic;
        reset           : in  std_logic;
        step            : in  std_logic;
        direction       : in  std_logic;
        position_count  : out unsigned(31 downto 0);
        revolution_done : out std_logic
    );
end entity;

architecture rtl of position_counter is
    signal count : unsigned(31 downto 0) := (others => '0');
    constant CPR : unsigned(31 downto 0) :=
        to_unsigned(COUNTS_PER_REVOLUTION, 32);
begin

    process(clk)
        variable next_count : unsigned(31 downto 0);
    begin
        if rising_edge(clk) then
            revolution_done <= '0';

            if reset = '1' then
                count <= (others => '0');

            elsif step = '1' then

                if direction = '1' then
                    if count = CPR - 1 then
                        next_count := (others => '0');
                        revolution_done <= '1';
                    else
                        next_count := count + 1;
                    end if;
                else
                    if count = 0 then
                        next_count := CPR - 1;
                        revolution_done <= '1';
                    else
                        next_count := count - 1;
                    end if;
                end if;

                count <= next_count;
            end if;
        end if;
    end process;

    position_count <= count;

end architecture;
