library IEEE ;
use IEEE.std_logic_1164.all ;
use IEEE.numeric_std.all ;

-- Entity Definition
entity alarm_pa_tb is
  constant combinations: integer := 64;
  constant delay: time := 10 ns;
end entity;

architecture tb of alarm_pa_tb is
	signal i0, i1, i2, o0, o1, o2: std_logic;
	signal result : std_logic;

	component alarm_pa is
		port (
			i0, i1, i2, o0, o1, o2 : in std_logic;
			result : out std_logic
		);
	end component;
begin
	UUT: component alarm_pa port map(i0, i1, i2, o0, o1, o2, result);

    main: process is
		variable temp: unsigned(5 downto 0);
		variable expected_output: std_logic;
		variable error_count: integer := 0;

	begin
		report "Start simulation.";

		for count in 0 to 63 loop
			temp := TO_UNSIGNED(count, 6);
			i0 <= std_logic(temp(5));
			i1 <= std_logic(temp(4));
			i2 <= std_logic(temp(3));
			o0 <= std_logic(temp(2));
			o1 <= std_logic(temp(1));
			o2 <= std_logic(temp(0));

			if (count=0) then
				expected_output := '0';
			else
				if(((temp(0) = '1') or (temp(1) = '1') or (temp(2) = '1')) and ((temp(3) = '1') or (temp(4) = '1') or (temp(5) = '1'))) then
					expected_output := '1';
				
				else
					expected_output := '0';
				end if;
			
			end if;
			wait for DELAY;

			assert (expected_output = result)
				report "ERROR: Expected output" &
					std_logic'image(expected_output) &
					" at time " & time'image(now);

			if (expected_output/=result)
				then error_count := error_count + 1;		
			end if;
		end loop;

		wait for DELAY;

		assert (error_count=0)
			report "ERROR: There were " & integer'image(error_count) & " errors!";

		if (error_count=0) then
			report "Simulation completed with NO errors.";
		end if;

		wait;
	end process;
end architecture ;
