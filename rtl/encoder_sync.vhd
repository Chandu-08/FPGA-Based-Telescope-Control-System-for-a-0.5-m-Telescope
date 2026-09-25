library ieee;
use ieee.std_logic_1164.all;

entity encoder_sync is
    port (
        clk     : in  std_logic;
        reset   : in  std_logic;
        enc_a_i : in  std_logic;
        enc_b_i : in  std_logic;
        enc_a_o : out std_logic;
        enc_b_o : out std_logic
    );
end entity;

architecture rtl of encoder_sync is
    signal a_meta, a_sync : std_logic := '0';
    signal b_meta, b_sync : std_logic := '0';
begin

    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                a_meta <= '0';
                a_sync <= '0';
                b_meta <= '0';
                b_sync <= '0';
            else
                a_meta <= enc_a_i;
                a_sync <= a_meta;

                b_meta <= enc_b_i;
                b_sync <= b_meta;
            end if;
        end if;
    end process;

    enc_a_o <= a_sync;
    enc_b_o <= b_sync;

end architecture;
