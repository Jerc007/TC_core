----------------------------------------------------------------------------
-- Company:         	Politecnico di Torino
-- Engineer:          	Josie E. Rodriguez Condia
--
-- Create Date:     		13/01/2026
-- Module Name:   		TCU TB (Posit version)
-- Project Name:   		Open TCU
-- Target Devices:		
-- Tool versions:    	ModelSim
-- Description:
--
----------------------------------------------------------------------------
-- Revisions:
--  REV:        Date:          			Description:
--  1.0.a       	13/01/2026      	 	Created Top level file
--  1.2.a			13/01/2026				Functional verification
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
-- use work.def_package.all;

-- Library to load the patterns from a file.

library STD;
use STD.textio.all;
-- use IEEE.std_logic_textio.all;
-- use std.textio.all;
use IEEE.std_logic_textio.all;



entity TC_core_TB is

end TC_core_TB;

architecture ar of TC_core_TB is
	
	-- Size of the dot product unit comes from def_package
	
	-- Signals for the interconnection of the cores:

	signal golden_w_003_s:  std_logic_vector(31 downto 0);
	signal golden_w_013_s:  std_logic_vector(31 downto 0);
	signal golden_w_023_s:  std_logic_vector(31 downto 0);
	signal golden_w_033_s:  std_logic_vector(31 downto 0);

	signal golden_w_103_s:  std_logic_vector(31 downto 0);
	signal golden_w_113_s:  std_logic_vector(31 downto 0);
	signal golden_w_123_s:  std_logic_vector(31 downto 0);
	signal golden_w_133_s:  std_logic_vector(31 downto 0);

	signal golden_w_203_s:  std_logic_vector(31 downto 0);
	signal golden_w_213_s:  std_logic_vector(31 downto 0);
	signal golden_w_223_s:  std_logic_vector(31 downto 0);
	signal golden_w_233_s:  std_logic_vector(31 downto 0);

	signal golden_w_303_s:  std_logic_vector(31 downto 0);
	signal golden_w_313_s:  std_logic_vector(31 downto 0);
	signal golden_w_323_s:  std_logic_vector(31 downto 0);
	signal golden_w_333_s:  std_logic_vector(31 downto 0);

	signal a_00_s : std_logic_vector(31 downto 0);
	signal a_01_s : std_logic_vector(31 downto 0);
	signal a_02_s : std_logic_vector(31 downto 0);
	signal a_03_s : std_logic_vector(31 downto 0);
	signal a_10_s : std_logic_vector(31 downto 0);
	signal a_11_s : std_logic_vector(31 downto 0);
	signal a_12_s : std_logic_vector(31 downto 0);
	signal a_13_s : std_logic_vector(31 downto 0);
	signal a_20_s : std_logic_vector(31 downto 0);
	signal a_21_s : std_logic_vector(31 downto 0);
	signal a_22_s : std_logic_vector(31 downto 0);
	signal a_23_s : std_logic_vector(31 downto 0);
	signal a_30_s : std_logic_vector(31 downto 0);
	signal a_31_s : std_logic_vector(31 downto 0);
	signal a_32_s : std_logic_vector(31 downto 0);
	signal a_33_s : std_logic_vector(31 downto 0);
	signal b_00_s  : std_logic_vector(31 downto 0);
	signal b_01_s  : std_logic_vector(31 downto 0);
	signal b_02_s  : std_logic_vector(31 downto 0);
	signal b_03_s  : std_logic_vector(31 downto 0);		
	signal b_10_s  : std_logic_vector(31 downto 0);
	signal b_11_s  : std_logic_vector(31 downto 0);
	signal b_12_s  : std_logic_vector(31 downto 0);
	signal b_13_s  : std_logic_vector(31 downto 0);
	signal b_20_s  : std_logic_vector(31 downto 0);
	signal b_21_s  : std_logic_vector(31 downto 0);
	signal b_22_s  : std_logic_vector(31 downto 0);
	signal b_23_s  : std_logic_vector(31 downto 0);		
	signal b_30_s  : std_logic_vector(31 downto 0);
	signal b_31_s  : std_logic_vector(31 downto 0);
	signal b_32_s  : std_logic_vector(31 downto 0);
	signal b_33_s  : std_logic_vector(31 downto 0);
	signal c_00_s: std_logic_vector(31 downto 0);
	signal c_01_s: std_logic_vector(31 downto 0);
	signal c_02_s: std_logic_vector(31 downto 0);
	signal c_03_s: std_logic_vector(31 downto 0);
	signal c_10_s: std_logic_vector(31 downto 0);
	signal c_11_s: std_logic_vector(31 downto 0);
	signal c_12_s: std_logic_vector(31 downto 0);
	signal c_13_s: std_logic_vector(31 downto 0);
	signal c_20_s: std_logic_vector(31 downto 0);
	signal c_21_s: std_logic_vector(31 downto 0);
	signal c_22_s: std_logic_vector(31 downto 0);
	signal c_23_s: std_logic_vector(31 downto 0);
	signal c_30_s: std_logic_vector(31 downto 0);
	signal c_31_s: std_logic_vector(31 downto 0);
	signal c_32_s: std_logic_vector(31 downto 0);
	signal c_33_s: std_logic_vector(31 downto 0);
	signal w_003_s: std_logic_vector(31 downto 0);
	signal w_013_s: std_logic_vector(31 downto 0);
	signal w_023_s: std_logic_vector(31 downto 0);
	signal w_033_s: std_logic_vector(31 downto 0);
	signal w_103_s: std_logic_vector(31 downto 0);
	signal w_113_s: std_logic_vector(31 downto 0);
	signal w_123_s: std_logic_vector(31 downto 0);
	signal w_133_s: std_logic_vector(31 downto 0);
	signal w_203_s: std_logic_vector(31 downto 0);
	signal w_213_s: std_logic_vector(31 downto 0);
	signal w_223_s: std_logic_vector(31 downto 0);
	signal w_233_s: std_logic_vector(31 downto 0);
	signal w_303_s: std_logic_vector(31 downto 0);
	signal w_313_s: std_logic_vector(31 downto 0);
	signal w_323_s: std_logic_vector(31 downto 0);
	signal w_333_s: std_logic_vector(31 downto 0);


	component tensor_core_unit is
		port(
				a_00 : in std_logic_vector(31 downto 0);
				a_01 : in std_logic_vector(31 downto 0);
				a_02 : in std_logic_vector(31 downto 0);
				a_03 : in std_logic_vector(31 downto 0);
				a_10 : in std_logic_vector(31 downto 0);
				a_11 : in std_logic_vector(31 downto 0);
				a_12 : in std_logic_vector(31 downto 0);
				a_13 : in std_logic_vector(31 downto 0);
				a_20 : in std_logic_vector(31 downto 0);
				a_21 : in std_logic_vector(31 downto 0);
				a_22 : in std_logic_vector(31 downto 0);
				a_23 : in std_logic_vector(31 downto 0);
				a_30 : in std_logic_vector(31 downto 0);
				a_31 : in std_logic_vector(31 downto 0);
				a_32 : in std_logic_vector(31 downto 0);
				a_33 : in std_logic_vector(31 downto 0);
				b_00  : in std_logic_vector(31 downto 0);
				b_01  : in std_logic_vector(31 downto 0);
				b_02  : in std_logic_vector(31 downto 0);
				b_03  : in std_logic_vector(31 downto 0);		
				b_10  : in std_logic_vector(31 downto 0);
				b_11  : in std_logic_vector(31 downto 0);
				b_12  : in std_logic_vector(31 downto 0);
				b_13  : in std_logic_vector(31 downto 0);
				b_20  : in std_logic_vector(31 downto 0);
				b_21  : in std_logic_vector(31 downto 0);
				b_22  : in std_logic_vector(31 downto 0);
				b_23  : in std_logic_vector(31 downto 0);		
				b_30  : in std_logic_vector(31 downto 0);
				b_31  : in std_logic_vector(31 downto 0);
				b_32  : in std_logic_vector(31 downto 0);
				b_33  : in std_logic_vector(31 downto 0);
				c_00: in std_logic_vector(31 downto 0);
				c_01: in std_logic_vector(31 downto 0);
				c_02: in std_logic_vector(31 downto 0);
				c_03: in std_logic_vector(31 downto 0);
				c_10: in std_logic_vector(31 downto 0);
				c_11: in std_logic_vector(31 downto 0);
				c_12: in std_logic_vector(31 downto 0);
				c_13: in std_logic_vector(31 downto 0);
				c_20: in std_logic_vector(31 downto 0);
				c_21: in std_logic_vector(31 downto 0);
				c_22: in std_logic_vector(31 downto 0);
				c_23: in std_logic_vector(31 downto 0);
				c_30: in std_logic_vector(31 downto 0);
				c_31: in std_logic_vector(31 downto 0);
				c_32: in std_logic_vector(31 downto 0);
				c_33: in std_logic_vector(31 downto 0);
				w_003: out std_logic_vector(31 downto 0);
				w_013: out std_logic_vector(31 downto 0);
				w_023: out std_logic_vector(31 downto 0);
				w_033: out std_logic_vector(31 downto 0);
				w_103: out std_logic_vector(31 downto 0);
				w_113: out std_logic_vector(31 downto 0);
				w_123: out std_logic_vector(31 downto 0);
				w_133: out std_logic_vector(31 downto 0);
				w_203: out std_logic_vector(31 downto 0);
				w_213: out std_logic_vector(31 downto 0);
				w_223: out std_logic_vector(31 downto 0);
				w_233: out std_logic_vector(31 downto 0);
				w_303: out std_logic_vector(31 downto 0);
				w_313: out std_logic_vector(31 downto 0);
				w_323: out std_logic_vector(31 downto 0);
				w_333: out std_logic_vector(31 downto 0)
	);
	end component;


	begin
	
		TCU0: tensor_core_unit port map(
						a_00 => a_00_s,
						a_01 => a_01_s,
						a_02 => a_02_s,
						a_03 => a_03_s,
						a_10 => a_10_s,
						a_11 => a_11_s,
						a_12 => a_12_s,
						a_13 => a_13_s,
						a_20 => a_20_s,
						a_21 => a_21_s,
						a_22 => a_22_s,
						a_23 => a_23_s,
						a_30 => a_30_s,
						a_31 => a_31_s,
						a_32 => a_32_s,
						a_33 => a_33_s,
						b_00 => b_00_s,
						b_01 => b_01_s,
						b_02 => b_02_s,
						b_03 => b_03_s,		
						b_10 => b_10_s,
						b_11 => b_11_s,
						b_12 => b_12_s,
						b_13 => b_13_s,
						b_20 => b_20_s,
						b_21 => b_21_s,
						b_22 => b_22_s,
						b_23 => b_23_s,		
						b_30 => b_30_s,
						b_31 => b_31_s,
						b_32 => b_32_s,
						b_33 => b_33_s,
						c_00 => c_00_s,
						c_01 => c_01_s,
						c_02 => c_02_s,
						c_03 => c_03_s,
						c_10 => c_10_s,
						c_11 => c_11_s,
						c_12 => c_12_s,
						c_13 => c_13_s,
						c_20 => c_20_s,
						c_21 => c_21_s,
						c_22 => c_22_s,
						c_23 => c_23_s,
						c_30 => c_30_s,
						c_31 => c_31_s,
						c_32 => c_32_s,
						c_33 => c_33_s,
						w_003 => w_003_s,
						w_013 => w_013_s,
						w_023 => w_023_s,
						w_033 => w_033_s,
						w_103 => w_103_s,
						w_113 => w_113_s,
						w_123 => w_123_s,
						w_133 => w_133_s,
						w_203 => w_203_s,
						w_213 => w_213_s,
						w_223 => w_223_s,
						w_233 => w_233_s,
						w_303 => w_303_s,
						w_313 => w_313_s,
						w_323 => w_323_s,
						w_333 => w_333_s
					);



-- state machine loading the patterns and applying to the DUT: (Dot Product Unit) DPU
	

	test_bench : process
	
		file text_file : TEXT open READ_MODE is "TC_hex_patterns.txt";  -- check this address during importing
		
		variable text_line : line;
		variable ok : boolean;
		variable char : character;

		variable A_hex_00_text : std_logic_vector(31 downto 0);
		variable A_hex_01_text : std_logic_vector(31 downto 0);
		variable A_hex_02_text : std_logic_vector(31 downto 0);
		variable A_hex_03_text : std_logic_vector(31 downto 0);
		variable A_hex_10_text : std_logic_vector(31 downto 0);
		variable A_hex_11_text : std_logic_vector(31 downto 0);
		variable A_hex_12_text : std_logic_vector(31 downto 0);
		variable A_hex_13_text : std_logic_vector(31 downto 0);
		variable A_hex_20_text : std_logic_vector(31 downto 0);
		variable A_hex_21_text : std_logic_vector(31 downto 0);
		variable A_hex_22_text : std_logic_vector(31 downto 0);
		variable A_hex_23_text : std_logic_vector(31 downto 0);
		variable A_hex_30_text : std_logic_vector(31 downto 0);
		variable A_hex_31_text : std_logic_vector(31 downto 0);
		variable A_hex_32_text : std_logic_vector(31 downto 0);
		variable A_hex_33_text : std_logic_vector(31 downto 0);
		
		variable B_hex_00_text : std_logic_vector(31 downto 0);
		variable B_hex_01_text : std_logic_vector(31 downto 0);
		variable B_hex_02_text : std_logic_vector(31 downto 0);
		variable B_hex_03_text : std_logic_vector(31 downto 0);
		variable B_hex_10_text : std_logic_vector(31 downto 0);
		variable B_hex_11_text : std_logic_vector(31 downto 0);
		variable B_hex_12_text : std_logic_vector(31 downto 0);
		variable B_hex_13_text : std_logic_vector(31 downto 0);
		variable B_hex_20_text : std_logic_vector(31 downto 0);
		variable B_hex_21_text : std_logic_vector(31 downto 0);
		variable B_hex_22_text : std_logic_vector(31 downto 0);
		variable B_hex_23_text : std_logic_vector(31 downto 0);
		variable B_hex_30_text : std_logic_vector(31 downto 0);
		variable B_hex_31_text : std_logic_vector(31 downto 0);
		variable B_hex_32_text : std_logic_vector(31 downto 0);
		variable B_hex_33_text : std_logic_vector(31 downto 0);
		
		variable C_hex_00_text : std_logic_vector(31 downto 0);
		variable C_hex_01_text : std_logic_vector(31 downto 0);
		variable C_hex_02_text : std_logic_vector(31 downto 0);
		variable C_hex_03_text : std_logic_vector(31 downto 0);
		variable C_hex_10_text : std_logic_vector(31 downto 0);
		variable C_hex_11_text : std_logic_vector(31 downto 0);
		variable C_hex_12_text : std_logic_vector(31 downto 0);
		variable C_hex_13_text : std_logic_vector(31 downto 0);
		variable C_hex_20_text : std_logic_vector(31 downto 0);
		variable C_hex_21_text : std_logic_vector(31 downto 0);
		variable C_hex_22_text : std_logic_vector(31 downto 0);
		variable C_hex_23_text : std_logic_vector(31 downto 0);
		variable C_hex_30_text : std_logic_vector(31 downto 0);
		variable C_hex_31_text : std_logic_vector(31 downto 0);
		variable C_hex_32_text : std_logic_vector(31 downto 0);
		variable C_hex_33_text : std_logic_vector(31 downto 0);
		
		variable D_hex_00_text	: std_logic_vector(31 downto 0);
		variable D_hex_01_text	: std_logic_vector(31 downto 0);
		variable D_hex_02_text	: std_logic_vector(31 downto 0);
		variable D_hex_03_text	: std_logic_vector(31 downto 0);
		variable D_hex_10_text	: std_logic_vector(31 downto 0);
		variable D_hex_11_text	: std_logic_vector(31 downto 0);
		variable D_hex_12_text	: std_logic_vector(31 downto 0);
		variable D_hex_13_text	: std_logic_vector(31 downto 0);
		variable D_hex_20_text	: std_logic_vector(31 downto 0);
		variable D_hex_21_text	: std_logic_vector(31 downto 0);
		variable D_hex_22_text	: std_logic_vector(31 downto 0);
		variable D_hex_23_text	: std_logic_vector(31 downto 0);
		variable D_hex_30_text	: std_logic_vector(31 downto 0);
		variable D_hex_31_text	: std_logic_vector(31 downto 0);
		variable D_hex_32_text	: std_logic_vector(31 downto 0);
		variable D_hex_33_text	: std_logic_vector(31 downto 0);
		
		begin
		
			report "The evaluation of the DPU unit FP has started...";
		
			while not endfile(text_file) loop
				-- reading the line for the file and storing into the line.
				readline(text_file, text_line);
				report "line was read...";

				-- Skip empty lines and single-line comments
				if text_line.all'length = 0 or text_line.all(1) = '#' then
					next;
				end if;
				
				report "conversion of lines...";

				hread(text_line, A_hex_00_text, ok);
				assert ok
					report "Read 'sel' failed for line: " & text_line.all
					severity failure;

				hread(text_line, A_hex_01_text, ok);
				assert ok
					report "Read 'din_0' failed for line: " & text_line.all
					severity failure;


				hread(text_line, A_hex_02_text, ok);
				assert ok
					report "Read 'din_1' failed for line: " & text_line.all
					severity failure;


				hread(text_line, A_hex_03_text, ok);
				assert ok
					report "Read 'din_2' failed for line: " & text_line.all
					severity failure;


				hread(text_line, A_hex_10_text, ok);
				assert ok
					report "Read 'din_2' failed for line: " & text_line.all
					severity failure;


				hread(text_line, A_hex_11_text, ok);
				assert ok
					report "Read 'din_2' failed for line: " & text_line.all
					severity failure;


				hread(text_line, A_hex_12_text, ok);
				assert ok
					report "Read 'din_2' failed for line: " & text_line.all
					severity failure;


				hread(text_line, A_hex_13_text, ok);
				assert ok
					report "Read 'din_2' failed for line: " & text_line.all
					severity failure;


				hread(text_line, A_hex_20_text, ok);
				assert ok
					report "Read 'din_2' failed for line: " & text_line.all
					severity failure;


				hread(text_line, A_hex_21_text, ok);
				assert ok
					report "Read 'din_2' failed for line: " & text_line.all
					severity failure;


				hread(text_line, A_hex_22_text, ok);
				assert ok
					report "Read 'din_2' failed for line: " & text_line.all
					severity failure;


				hread(text_line, A_hex_23_text, ok);
				assert ok
					report "Read 'din_2' failed for line: " & text_line.all
					severity failure;


				hread(text_line, A_hex_30_text, ok);
				assert ok
					report "Read 'din_2' failed for line: " & text_line.all
					severity failure;


				hread(text_line, A_hex_31_text, ok);
				assert ok
					report "Read 'din_2' failed for line: " & text_line.all
					severity failure;


				hread(text_line, A_hex_32_text, ok);
				assert ok
					report "Read 'din_2' failed for line: " & text_line.all
					severity failure;


				hread(text_line, A_hex_33_text, ok);
				assert ok
					report "Read 'din_2' failed for line: " & text_line.all
					severity failure;



				hread(text_line, B_hex_00_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;

				hread(text_line, B_hex_01_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;

				hread(text_line, B_hex_02_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;

				hread(text_line, B_hex_03_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;

				hread(text_line, B_hex_10_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;

				hread(text_line, B_hex_11_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;

				hread(text_line, B_hex_12_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;

				hread(text_line, B_hex_13_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;


				hread(text_line, B_hex_20_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;

				hread(text_line, B_hex_21_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;

				hread(text_line, B_hex_22_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;

				hread(text_line, B_hex_23_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;

				hread(text_line, B_hex_30_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;

				hread(text_line, B_hex_31_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;

				hread(text_line, B_hex_32_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;

				hread(text_line, B_hex_33_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;


				hread(text_line, C_hex_00_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;

				hread(text_line, C_hex_01_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;

				hread(text_line, C_hex_02_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;

				hread(text_line, C_hex_03_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;


				hread(text_line, C_hex_10_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;

				hread(text_line, C_hex_11_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;

				hread(text_line, C_hex_12_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;

				hread(text_line, C_hex_13_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;


				hread(text_line, C_hex_20_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;

				hread(text_line, C_hex_21_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;

				hread(text_line, C_hex_22_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;

				hread(text_line, C_hex_23_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;


				hread(text_line, C_hex_30_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;

				hread(text_line, C_hex_31_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;

				hread(text_line, C_hex_32_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;

				hread(text_line, C_hex_33_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;


				hread(text_line, D_hex_00_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;

				hread(text_line, D_hex_01_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;

				hread(text_line, D_hex_02_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;

				hread(text_line, D_hex_03_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;


				hread(text_line, D_hex_10_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;

				hread(text_line, D_hex_11_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;

				hread(text_line, D_hex_12_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;

				hread(text_line, D_hex_13_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;


				hread(text_line, D_hex_20_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;

				hread(text_line, D_hex_21_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;

				hread(text_line, D_hex_22_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;

				hread(text_line, D_hex_23_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;

				hread(text_line, D_hex_30_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;

				hread(text_line, D_hex_31_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;

				hread(text_line, D_hex_32_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;

				hread(text_line, D_hex_33_text, ok);
				assert ok
					report "Read 'din_3' failed for line: " & text_line.all
					severity failure;

				a_00_s <= A_hex_00_text;
				a_01_s <= A_hex_01_text;
				a_02_s <= A_hex_02_text;
				a_03_s <= A_hex_03_text;
				a_10_s <= A_hex_10_text;
				a_11_s <= A_hex_11_text;
				a_12_s <= A_hex_12_text;
				a_13_s <= A_hex_13_text;
				a_20_s <= A_hex_20_text;
				a_21_s <= A_hex_21_text;
				a_22_s <= A_hex_22_text;
				a_23_s <= A_hex_23_text;
				a_30_s <= A_hex_30_text;
				a_31_s <= A_hex_31_text;
				a_32_s <= A_hex_32_text;
				a_33_s <= A_hex_33_text;

				b_00_s <= B_hex_00_text;
				b_01_s <= B_hex_01_text;
				b_02_s <= B_hex_02_text;
				b_03_s <= B_hex_03_text;
				b_10_s <= B_hex_10_text;
				b_11_s <= B_hex_11_text;
				b_12_s <= B_hex_12_text;
				b_13_s <= B_hex_13_text;
				b_20_s <= B_hex_20_text;
				b_21_s <= B_hex_21_text;
				b_22_s <= B_hex_22_text;
				b_23_s <= B_hex_23_text;
				b_30_s <= B_hex_30_text;
				b_31_s <= B_hex_31_text;
				b_32_s <= B_hex_32_text;
				b_33_s <= B_hex_33_text;

				c_00_s <= C_hex_00_text;
				c_01_s <= C_hex_01_text;
				c_02_s <= C_hex_02_text;
				c_03_s <= C_hex_03_text;
				c_10_s <= C_hex_10_text;
				c_11_s <= C_hex_11_text;
				c_12_s <= C_hex_12_text;
				c_13_s <= C_hex_13_text;
				c_20_s <= C_hex_20_text;
				c_21_s <= C_hex_21_text;
				c_22_s <= C_hex_22_text;
				c_23_s <= C_hex_23_text;
				c_30_s <= C_hex_30_text;
				c_31_s <= C_hex_31_text;
				c_32_s <= C_hex_32_text;
				c_33_s <= C_hex_33_text;

				golden_w_003_s <= D_hex_00_text;
				golden_w_013_s <= D_hex_01_text;
				golden_w_023_s <= D_hex_02_text;
				golden_w_033_s <= D_hex_03_text;

				golden_w_103_s <= D_hex_10_text;
				golden_w_113_s <= D_hex_11_text;
				golden_w_123_s <= D_hex_12_text;
				golden_w_133_s <= D_hex_13_text;

				golden_w_203_s <= D_hex_20_text;
				golden_w_213_s <= D_hex_21_text;
				golden_w_223_s <= D_hex_22_text;
				golden_w_233_s <= D_hex_23_text;

				golden_w_303_s <= D_hex_30_text;
				golden_w_313_s <= D_hex_31_text;
				golden_w_323_s <= D_hex_32_text;
				golden_w_333_s <= D_hex_33_text;



				wait for 10ns;

			end loop;

			report "The evaluation of the DPU unit FP has finished."	severity failure;

		wait;
end process;


end ar;
