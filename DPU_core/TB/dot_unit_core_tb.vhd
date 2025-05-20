----------------------------------------------------------------------------
-- Company:         	Politecnico di Torino
-- Engineer:          	Josie E. Rodriguez Condia
--
-- Create Date:     		23/10/2022
-- Module Name:   	Dot Product Unit TB
-- Project Name:   	Open TCU
-- Target Devices:		
-- Tool versions:    	ModelSim
-- Description:
--
----------------------------------------------------------------------------
-- Revisions:
--  REV:        Date:          			Description:
--  1.0.a       	23/10/2022      	 	Created Top level file
--  1.2.a			17/11/2022				Functional verification
----------------------------------------------------------------------------


-- The dot unit is the basic operation inside a tensor core unit and process the scalar product in a 4X4 matrix multiplication
--
--                         a_X0         b_X0                                 a_X1        b_X1                                a_X2         b_X2           			           a_X3           b_X3		         c_X0
--	   					____|_________|____						____|_________|____						____|_________|____						____|_________|____                |
--			FMUL0	|								|			FMUL1	|								|			FMUL2	|								|			FMUL3 |								|               |
--						|				*				|						|				*				|						|				*				|						|				*				|               |
--						|_________________|						|_________________|						|_________________|			  			|_________________|               |
--	   					_________|______________________________|________________________________|______________________________|_________________|______
--			FADD	|																																										 								                        	|
--						|																											+															 															|
--						|______________________________________________________________________________________________________________________________|
--                                                                                                                                  |
--																																w_XX3

Library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.def_package.all;

-- Library to load the patterns from a file.

library STD;
use STD.textio.all;
-- use IEEE.std_logic_textio.all;
-- use std.textio.all;
use IEEE.std_logic_textio.all;



entity dot_unit_core_TB is

end dot_unit_core_TB;

architecture ar of dot_unit_core_TB is
	
	-- Size of the dot product unit comes from def_package
	
	-- Signals for the interconnection of the cores:

	signal a_X0_s :std_logic_vector(long-1 downto 0);
	signal a_X1_s :std_logic_vector(long-1 downto 0);
	signal a_X2_s :std_logic_vector(long-1 downto 0);
	signal a_X3_s :std_logic_vector(long-1 downto 0);
	signal b_X0_s :std_logic_vector(long-1 downto 0);
	signal b_X1_s :std_logic_vector(long-1 downto 0);
	signal b_X2_s :std_logic_vector(long-1 downto 0);
	signal b_X3_s :std_logic_vector(long-1 downto 0);
	signal c_X0_s :std_logic_vector(long-1 downto 0);
	signal w_XX3_s :std_logic_vector(long-1 downto 0);
	signal underflow_s :std_logic;
	signal overflow_s :std_logic;
	signal golden_w_XX3_s: std_logic_vector(long-1 downto 0);

	component dot_unit_core is
				generic(
							long : natural := 32
							);
				port(
							a_X0 : in std_logic_vector(long-1 downto 0);
							a_X1 : in std_logic_vector(long-1 downto 0);
							a_X2 : in std_logic_vector(long-1 downto 0);
							a_X3 : in std_logic_vector(long-1 downto 0);
							b_X0  : in std_logic_vector(long-1 downto 0);
							b_X1  : in std_logic_vector(long-1 downto 0);
							b_X2  : in std_logic_vector(long-1 downto 0);
							b_X3  : in std_logic_vector(long-1 downto 0);		
							c_X0: in std_logic_vector(long-1 downto 0);
							w_XX3: out std_logic_vector(long-1 downto 0);
							underflow, overflow :out std_logic
					);
	end component;
	
	begin

	DUT0: dot_unit_core generic map(
														long =>long
													)
									 port map(
														a_X0 => a_X0_s,		
														a_X1 => a_X1_s,
														a_X2 => a_X2_s,
														a_X3 => a_X3_s,
														b_X0 => b_X0_s,
														b_X1 => b_X1_s,
														b_X2 => b_X2_s,
														b_X3 => b_X3_s,	
														c_X0 => c_X0_s,
														w_XX3 => w_XX3_s,
														underflow => underflow_s,
														overflow => overflow_s
													);
													
													
									
-- state machine loading the patterns and applying to the DUT: (Dot Product Unit) DPU
	
	test_bench : process
	
		file text_file : TEXT open READ_MODE is "values_dot_product.txt";
		
		variable text_line : line;
		variable ok : boolean;
		variable char : character;

		variable A_hex_0_text : std_logic_vector(long-1 downto 0);
		variable A_hex_1_text : std_logic_vector(long-1 downto 0);
		variable A_hex_2_text : std_logic_vector(long-1 downto 0);
		variable A_hex_3_text : std_logic_vector(long-1 downto 0);
		variable B_hex_0_text : std_logic_vector(long-1 downto 0);
		variable B_hex_1_text : std_logic_vector(long-1 downto 0);
		variable B_hex_2_text : std_logic_vector(long-1 downto 0);
		variable B_hex_3_text : std_logic_vector(long-1 downto 0);
		variable c_hex_text : std_logic_vector(long-1 downto 0);
		variable d_hex_text	: std_logic_vector(long-1 downto 0);


		begin
		
			while not endfile(text_file) loop
				-- reading the line for the file and storing into the line.
				readline(text_file, text_line);

				-- Skip empty lines and single-line comments
				if text_line.all'length = 0 or text_line.all(1) = '#' then
					next;
				end if;
		
				hread(text_line, A_hex_0_text, ok);
				assert ok
					report "Read 'sel' failed for line: " & text_line.all
					severity failure;

				hread(text_line, A_hex_1_text, ok);
				assert ok
					report "Read 'din_0' failed for line: " & text_line.all
					severity failure;


				hread(text_line, A_hex_2_text, ok);
				assert ok
					report "Read 'din_1' failed for line: " & text_line.all
					severity failure;


				hread(text_line, A_hex_3_text, ok);
				assert ok
					report "Read 'din_2' failed for line: " & text_line.all
					severity failure;


				hread(text_line, B_hex_0_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;

				hread(text_line, B_hex_1_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;

				hread(text_line, B_hex_2_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;

				hread(text_line, B_hex_3_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;

				hread(text_line, c_hex_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;

				hread(text_line, d_hex_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;

				a_X0_s <= A_hex_0_text;
				a_X1_s <= A_hex_1_text;
				a_X2_s <= A_hex_2_text;
				a_X3_s <= A_hex_3_text;
				b_X0_s <= B_hex_0_text;
				b_X1_s <= B_hex_1_text;
				b_X2_s <= B_hex_2_text;
				b_X3_s <= B_hex_3_text;
				c_X0_s <= c_hex_text;
				golden_w_XX3_s <= d_hex_text;

				wait for 50ns;

			end loop;
		wait;
end process;
		
		


end ar;
