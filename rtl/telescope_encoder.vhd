library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity telescope_encoder is
    generic (
        PULSES_PER_REVOLUTION : positive := 3600;
        LED_ON_CYCLES         : positive := 200000000
    );
    port (
        clk        : in  std_logic;
        reset      : in  std_logic;
        encoder_a  : in  std_logic;
        encoder_b  : in  std_logic;
        led        : out std_logic;
        position   : out unsigned(31 downto 0);
        direction  : out std_logic
    );
end entity;

architecture rtl of telescope_encoder is

    constant COUNTS_PER_REVOLUTION : positive :=
        PULSES_PER_REVOLUTION * 4;

    signal enc_a_sync : std_logic;
    signal enc_b_sync : std_logic;

    signal step_sig       : std_logic;
    signal direction_sig  : std_logic;
    signal revolution_sig : std_logic;

    signal position_sig : unsigned(31 downto 0);

    signal led_counter : unsigned(31 downto 0) := (others => '0');
    signal led_active  : std_logic := '0';

begin

    sync_inst : entity work.encoder_sync
        port map (
            clk     => clk,
            reset   => reset,
            enc_a_i => encoder_a,
            enc_b_i => encoder_b,
            enc_a_o => enc_a_sync,
            enc_b_o => enc_b_sync
        );

    decoder_inst : entity work.quadrature_decoder
        port map (
            clk       => clk,
            reset     => reset,
            enc_a     => enc_a_sync,
            enc_b     => enc_b_sync,
            step      => step_sig,
            direction => direction_sig
        );

    counter_inst : entity work.position_counter
        generic map (
            COUNTS_PER_REVOLUTION => COUNTS_PER_REVOLUTION
        )
        port map (
            clk             => clk,
            reset           => reset,
            step            => step_sig,
            direction       => direction_sig,
            position_count  => position_sig,
            revolution_done => revolution_sig
        );

    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                led_counter <= (others => '0');
                led_active  <= '0';

            else
                if revolution_sig = '1' then
                    led_active  <= '1';
                    led_counter <= to_unsigned(LED_ON_CYCLES - 1, 32);

                elsif led_active = '1' then
                    if led_counter = 0 then
                        led_active <= '0';
                    else
                        led_counter <= led_counter - 1;
                    end if;
                end if;
            end if;
        end if;
    end process;

    position  <= position_sig;
    direction <= direction_sig;
    led       <= led_active;

end architecture;
