library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity telescope_encoder_tb is
end entity;

architecture sim of telescope_encoder_tb is

    constant CLK_PERIOD : time := 10 ns;

    signal clk       : std_logic := '0';
    signal reset     : std_logic := '1';
    signal encoder_a : std_logic := '0';
    signal encoder_b : std_logic := '0';

    signal led       : std_logic;
    signal position  : unsigned(31 downto 0);
    signal direction : std_logic;

    procedure encoder_step(
        signal a : out std_logic;
        signal b : out std_logic;
        constant state : in integer
    ) is
    begin
        case state is
            when 0 =>
                a <= '0';
                b <= '0';
            when 1 =>
                a <= '0';
                b <= '1';
            when 2 =>
                a <= '1';
                b <= '1';
            when 3 =>
                a <= '1';
                b <= '0';
            when others =>
                a <= '0';
                b <= '0';
        end case;

        wait for 100 ns;
    end procedure;

begin

    clk <= not clk after CLK_PERIOD / 2;

    dut : entity work.telescope_encoder
        generic map (
            PULSES_PER_REVOLUTION => 4,
            -- Small value for simulation.
            LED_ON_CYCLES => 20
        )
        port map (
            clk       => clk,
            reset     => reset,
            encoder_a => encoder_a,
            encoder_b => encoder_b,
            led       => led,
            position  => position,
            direction => direction
        );

    stimulus : process
    begin

        reset <= '1';
        wait for 100 ns;
        reset <= '0';

        -- Four forward quadrature cycles.
        -- This drives enough transitions to demonstrate the counter.
        for i in 1 to 4 loop
            encoder_step(encoder_a, encoder_b, 1);
            encoder_step(encoder_a, encoder_b, 2);
            encoder_step(encoder_a, encoder_b, 3);
            encoder_step(encoder_a, encoder_b, 0);
        end loop;

        wait for 500 ns;

        -- Reverse direction test.
        for i in 1 to 2 loop
            encoder_step(encoder_a, encoder_b, 3);
            encoder_step(encoder_a, encoder_b, 2);
            encoder_step(encoder_a, encoder_b, 1);
            encoder_step(encoder_a, encoder_b, 0);
        end loop;

        wait for 500 ns;

        report "Simulation completed." severity note;
        wait;

    end process;

end architecture;
