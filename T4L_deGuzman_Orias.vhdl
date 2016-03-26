library IEEE; use IEEE.std_logic_1164.all;
entity alarm_pa is
	port (i0, i1, i2, o0, o1, o2: in std_logic; result : out std_logic);
end alarm_pa;

architecture alarm of alarm_pa is
begin
	result <= ((i0 or i1) or i2) and ((o0 or o1) or o2);
end architecture alarm;
