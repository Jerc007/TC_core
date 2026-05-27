----------------------------------------------------------------------------
-- Company:         	Politecnico di Torino
-- Engineer:          	Josie E. Rodriguez Condia
--
-- Create Date:     		25/05/2026
-- Module Name:   	INT Dot Product Unit TB
-- Project Name:   	Open TCU
-- Target Devices:		
-- Tool versions:    	ModelSim
-- Description:
--
----------------------------------------------------------------------------
-- Revisions:
--  REV:        Date:          			Description:
--  1.0.a       	23/10/2022      	 	Created Top level file
--  1.2.a       	17/11/2022      	 	Functional verification
--  1.3.a       	02/05/2023      	 	synth version handling
----------------------------------------------------------------------------


-- The dot unit is the basic operation inside a tensor core unit and process the scalar product in a 4X4 matrix multiplication
--
--    a_X0   b_X0                 a_X1    b_X1                a_X2         b_X2            a_X3      b_X3		       c_X0
--  ____|______|____		   ____|_______|____	         ____|_________|____    	____|_________|____             |
--	|	 FMUL0      |		  |		FMUL1			|			FMUL2	|								|			FMUL3 |								|               |
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



entity TC_core_TB is

end TC_core_TB;

architecture ar of TC_core_TB is
	
	-- Size of the dot product unit comes from def_package
	
	-- Signals for the interconnection of the cores:
	
	signal A_00_s: std_logic_vector(15 downto 0);
	signal A_01_s: std_logic_vector(15 downto 0);
	signal A_02_s: std_logic_vector(15 downto 0);
	signal A_03_s: std_logic_vector(15 downto 0);
	signal A_10_s: std_logic_vector(15 downto 0);
	signal A_11_s: std_logic_vector(15 downto 0);
	signal A_12_s: std_logic_vector(15 downto 0);
	signal A_13_s: std_logic_vector(15 downto 0);
	signal A_20_s: std_logic_vector(15 downto 0);
	signal A_21_s: std_logic_vector(15 downto 0);
	signal A_22_s: std_logic_vector(15 downto 0);
	signal A_23_s: std_logic_vector(15 downto 0);
	signal A_30_s: std_logic_vector(15 downto 0);
	signal A_31_s: std_logic_vector(15 downto 0);
	signal A_32_s: std_logic_vector(15 downto 0);
	signal A_33_s: std_logic_vector(15 downto 0);

	signal B_00_s: std_logic_vector(15 downto 0);
	signal B_01_s: std_logic_vector(15 downto 0);
	signal B_02_s: std_logic_vector(15 downto 0);
	signal B_03_s: std_logic_vector(15 downto 0);
	signal B_10_s: std_logic_vector(15 downto 0);
	signal B_11_s: std_logic_vector(15 downto 0);
	signal B_12_s: std_logic_vector(15 downto 0);
	signal B_13_s: std_logic_vector(15 downto 0);
	signal B_20_s: std_logic_vector(15 downto 0);
	signal B_21_s: std_logic_vector(15 downto 0);
	signal B_22_s: std_logic_vector(15 downto 0);
	signal B_23_s: std_logic_vector(15 downto 0);
	signal B_30_s: std_logic_vector(15 downto 0);
	signal B_31_s: std_logic_vector(15 downto 0);
	signal B_32_s: std_logic_vector(15 downto 0);
	signal B_33_s: std_logic_vector(15 downto 0);

	signal C_00_s: std_logic_vector(31 downto 0);
	signal C_01_s: std_logic_vector(31 downto 0);
	signal C_02_s: std_logic_vector(31 downto 0);
	signal C_03_s: std_logic_vector(31 downto 0);
	signal C_10_s: std_logic_vector(31 downto 0);
	signal C_11_s: std_logic_vector(31 downto 0);
	signal C_12_s: std_logic_vector(31 downto 0);
	signal C_13_s: std_logic_vector(31 downto 0);
	signal C_20_s: std_logic_vector(31 downto 0);
	signal C_21_s: std_logic_vector(31 downto 0);
	signal C_22_s: std_logic_vector(31 downto 0);
	signal C_23_s: std_logic_vector(31 downto 0);
	signal C_30_s: std_logic_vector(31 downto 0);
	signal C_31_s: std_logic_vector(31 downto 0);
	signal C_32_s: std_logic_vector(31 downto 0);
	signal C_33_s: std_logic_vector(31 downto 0);

	signal W_003_s: std_logic_vector(31 downto 0);
	signal W_013_s: std_logic_vector(31 downto 0);
	signal W_023_s: std_logic_vector(31 downto 0);
	signal W_033_s: std_logic_vector(31 downto 0);
	signal W_103_s: std_logic_vector(31 downto 0);
	signal W_113_s: std_logic_vector(31 downto 0);
	signal W_123_s: std_logic_vector(31 downto 0);
	signal W_133_s: std_logic_vector(31 downto 0);
	signal W_203_s: std_logic_vector(31 downto 0);
	signal W_213_s: std_logic_vector(31 downto 0);
	signal W_223_s: std_logic_vector(31 downto 0);
	signal W_233_s: std_logic_vector(31 downto 0);
	signal W_303_s: std_logic_vector(31 downto 0);
	signal W_313_s: std_logic_vector(31 downto 0);
	signal W_323_s: std_logic_vector(31 downto 0);
	signal W_333_s: std_logic_vector(31 downto 0);

	signal W_003_golden_s: std_logic_vector(31 downto 0);
	signal W_013_golden_s: std_logic_vector(31 downto 0);
	signal W_023_golden_s: std_logic_vector(31 downto 0);
	signal W_033_golden_s: std_logic_vector(31 downto 0);
	signal W_103_golden_s: std_logic_vector(31 downto 0);
	signal W_113_golden_s: std_logic_vector(31 downto 0);
	signal W_123_golden_s: std_logic_vector(31 downto 0);
	signal W_133_golden_s: std_logic_vector(31 downto 0);
	signal W_203_golden_s: std_logic_vector(31 downto 0);
	signal W_213_golden_s: std_logic_vector(31 downto 0);
	signal W_223_golden_s: std_logic_vector(31 downto 0);
	signal W_233_golden_s: std_logic_vector(31 downto 0);
	signal W_303_golden_s: std_logic_vector(31 downto 0);
	signal W_313_golden_s: std_logic_vector(31 downto 0);
	signal W_323_golden_s: std_logic_vector(31 downto 0);
	signal W_333_golden_s: std_logic_vector(31 downto 0);

	signal underflow_s : std_logic;
	signal overflow_s : std_logic;
	signal clk_s: std_logic := '1';
	signal rst_s: std_logic := '1';
	signal valid_in_s: std_logic;
	signal valid_out_s: std_logic;


	component TC_INT is		-- signed version
	generic(
				long : natural := 16
			);
	port(
			    clk  : in std_logic;
			    rst  : in std_logic;
				valid_in : in std_logic;
				A_00 : in std_logic_vector(long-1 downto 0);
				A_01 : in std_logic_vector(long-1 downto 0);
				A_02 : in std_logic_vector(long-1 downto 0);
				A_03 : in std_logic_vector(long-1 downto 0);
				A_10 : in std_logic_vector(long-1 downto 0);
				A_11 : in std_logic_vector(long-1 downto 0);
				A_12 : in std_logic_vector(long-1 downto 0);
				A_13 : in std_logic_vector(long-1 downto 0);
				A_20 : in std_logic_vector(long-1 downto 0);
				A_21 : in std_logic_vector(long-1 downto 0);
				A_22 : in std_logic_vector(long-1 downto 0);
				A_23 : in std_logic_vector(long-1 downto 0);
				A_30 : in std_logic_vector(long-1 downto 0);
				A_31 : in std_logic_vector(long-1 downto 0);
				A_32 : in std_logic_vector(long-1 downto 0);
				A_33 : in std_logic_vector(long-1 downto 0);
				B_00 : in std_logic_vector(long-1 downto 0);
				B_01 : in std_logic_vector(long-1 downto 0);
				B_02 : in std_logic_vector(long-1 downto 0);
				B_03 : in std_logic_vector(long-1 downto 0);
				B_10 : in std_logic_vector(long-1 downto 0);
				B_11 : in std_logic_vector(long-1 downto 0);
				B_12 : in std_logic_vector(long-1 downto 0);
				B_13 : in std_logic_vector(long-1 downto 0);
				B_20 : in std_logic_vector(long-1 downto 0);
				B_21 : in std_logic_vector(long-1 downto 0);
				B_22 : in std_logic_vector(long-1 downto 0);
				B_23 : in std_logic_vector(long-1 downto 0);
				B_30 : in std_logic_vector(long-1 downto 0);
				B_31 : in std_logic_vector(long-1 downto 0);
				B_32 : in std_logic_vector(long-1 downto 0);
				B_33 : in std_logic_vector(long-1 downto 0);
				C_00: in std_logic_vector((2*long)-1 downto 0);
				C_01: in std_logic_vector((2*long)-1 downto 0);
				C_02: in std_logic_vector((2*long)-1 downto 0);
				C_03: in std_logic_vector((2*long)-1 downto 0);
				C_10: in std_logic_vector((2*long)-1 downto 0);
				C_11: in std_logic_vector((2*long)-1 downto 0);
				C_12: in std_logic_vector((2*long)-1 downto 0);
				C_13: in std_logic_vector((2*long)-1 downto 0);
				C_20: in std_logic_vector((2*long)-1 downto 0);
				C_21: in std_logic_vector((2*long)-1 downto 0);
				C_22: in std_logic_vector((2*long)-1 downto 0);
				C_23: in std_logic_vector((2*long)-1 downto 0);
				C_30: in std_logic_vector((2*long)-1 downto 0);
				C_31: in std_logic_vector((2*long)-1 downto 0);
				C_32: in std_logic_vector((2*long)-1 downto 0);
				C_33: in std_logic_vector((2*long)-1 downto 0);
				w_003: out std_logic_vector((2*long)-1 downto 0);
				w_013: out std_logic_vector((2*long)-1 downto 0);
				w_023: out std_logic_vector((2*long)-1 downto 0);
				w_033: out std_logic_vector((2*long)-1 downto 0);
				w_103: out std_logic_vector((2*long)-1 downto 0);
				w_113: out std_logic_vector((2*long)-1 downto 0);
				w_123: out std_logic_vector((2*long)-1 downto 0);
				w_133: out std_logic_vector((2*long)-1 downto 0);
				w_203: out std_logic_vector((2*long)-1 downto 0);
				w_213: out std_logic_vector((2*long)-1 downto 0);
				w_223: out std_logic_vector((2*long)-1 downto 0);
				w_233: out std_logic_vector((2*long)-1 downto 0);
				w_303: out std_logic_vector((2*long)-1 downto 0);
				w_313: out std_logic_vector((2*long)-1 downto 0);
				w_323: out std_logic_vector((2*long)-1 downto 0);
				w_333: out std_logic_vector((2*long)-1 downto 0);
				valid_out: out std_logic
	);
end component;


	-- convert `std_logic_vector' to `string'
	function to_string(value : std_logic_vector) return string is
	variable l : line;
	begin
	write(l, to_bitVector(value), right, 0);
	return l.all;
	end to_string;



	constant CLK_PERIOD : time := 5 ns;  -- 200 MHz

	begin



	-- Clock generator
	clk_proc : process
	begin
		clk_s <= '1';
		wait for CLK_PERIOD/2;
		clk_s <= '0';
		wait for CLK_PERIOD/2;
	end process clk_proc;
		

	TCU0: TC_INT 
					generic map(
						long => long
					)
					port map(
						clk => clk_s,
						rst => rst_s,
						valid_in => valid_in_s,
						A_00 => A_00_s,
						A_01 => A_01_s,
						A_02 => A_02_s,
						A_03 => A_03_s,
						A_10 => A_10_s,
						A_11 => A_11_s,
						A_12 => A_12_s,
						A_13 => A_13_s,
						A_20 => A_20_s,
						A_21 => A_21_s,
						A_22 => A_22_s,
						A_23 => A_23_s,
						A_30 => A_30_s,
						A_31 => A_31_s,
						A_32 => A_32_s,
						A_33 => A_33_s,
						B_00 => B_00_s,
						B_01 => B_01_s,
						B_02 => B_02_s,
						B_03 => B_03_s,
						B_10 => B_10_s,
						B_11 => B_11_s,
						B_12 => B_12_s,
						B_13 => B_13_s,
						B_20 => B_20_s,
						B_21 => B_21_s,
						B_22 => B_22_s,
						B_23 => B_23_s,
						B_30 => B_30_s,
						B_31 => B_31_s,
						B_32 => B_32_s,
						B_33 => B_33_s,
						C_00 => C_00_s,
						C_01 => C_01_s,
						C_02 => C_02_s,
						C_03 => C_03_s,
						C_10 => C_10_s,
						C_11 => C_11_s,
						C_12 => C_12_s,
						C_13 => C_13_s,
						C_20 => C_20_s,
						C_21 => C_21_s,
						C_22 => C_22_s,
						C_23 => C_23_s,
						C_30 => C_30_s,
						C_31 => C_31_s,
						C_32 => C_32_s,
						C_33 => C_33_s,
						W_003 => W_003_s,
						W_013 => W_013_s,
						W_023 => W_023_s,
						W_033 => W_033_s,
						W_103 => W_103_s,
						W_113 => W_113_s,
						W_123 => W_123_s,
						W_133 => W_133_s,
						W_203 => W_203_s,
						W_213 => W_213_s,
						W_223 => W_223_s,
						W_233 => W_233_s,
						W_303 => W_303_s,
						W_313 => W_313_s,
						W_323 => W_323_s,
						W_333 => W_333_s,
						valid_out => valid_out_s
					);
					
					
-- state machine loading the patterns and applying to the DUT: (Dot Product Unit) DPU

	test_bench : process
	
		file text_file : TEXT open READ_MODE is "TC_INT_patterns.txt";

		variable text_line : line;
		variable ok : boolean;
		variable char : character;

		variable A0_hex_a0_text : std_logic_vector(15 downto 0);
		variable A0_hex_a1_text : std_logic_vector(15 downto 0);
		variable A0_hex_a2_text : std_logic_vector(15 downto 0);
		variable A0_hex_a3_text : std_logic_vector(15 downto 0);

		variable A1_hex_a0_text : std_logic_vector(15 downto 0);
		variable A1_hex_a1_text : std_logic_vector(15 downto 0);
		variable A1_hex_a2_text : std_logic_vector(15 downto 0);
		variable A1_hex_a3_text : std_logic_vector(15 downto 0);

		variable A2_hex_a0_text : std_logic_vector(15 downto 0);
		variable A2_hex_a1_text : std_logic_vector(15 downto 0);
		variable A2_hex_a2_text : std_logic_vector(15 downto 0);
		variable A2_hex_a3_text : std_logic_vector(15 downto 0);

		variable A3_hex_a0_text : std_logic_vector(15 downto 0);
		variable A3_hex_a1_text : std_logic_vector(15 downto 0);
		variable A3_hex_a2_text : std_logic_vector(15 downto 0);
		variable A3_hex_a3_text : std_logic_vector(15 downto 0);

		variable B0_hex_b0_text : std_logic_vector(15 downto 0);
		variable B0_hex_b1_text : std_logic_vector(15 downto 0);
		variable B0_hex_b2_text : std_logic_vector(15 downto 0);
		variable B0_hex_b3_text : std_logic_vector(15 downto 0);

		variable B1_hex_b0_text : std_logic_vector(15 downto 0);
		variable B1_hex_b1_text : std_logic_vector(15 downto 0);
		variable B1_hex_b2_text : std_logic_vector(15 downto 0);
		variable B1_hex_b3_text : std_logic_vector(15 downto 0);

		variable B2_hex_b0_text : std_logic_vector(15 downto 0);
		variable B2_hex_b1_text : std_logic_vector(15 downto 0);
		variable B2_hex_b2_text : std_logic_vector(15 downto 0);
		variable B2_hex_b3_text : std_logic_vector(15 downto 0);

		variable B3_hex_b0_text : std_logic_vector(15 downto 0);
		variable B3_hex_b1_text : std_logic_vector(15 downto 0);
		variable B3_hex_b2_text : std_logic_vector(15 downto 0);
		variable B3_hex_b3_text : std_logic_vector(15 downto 0);

		variable C0_hex_c0_text : std_logic_vector(31 downto 0);
		variable C0_hex_c1_text : std_logic_vector(31 downto 0);
		variable C0_hex_c2_text : std_logic_vector(31 downto 0);
		variable C0_hex_c3_text : std_logic_vector(31 downto 0);

		variable C1_hex_c0_text : std_logic_vector(31 downto 0);
		variable C1_hex_c1_text : std_logic_vector(31 downto 0);
		variable C1_hex_c2_text : std_logic_vector(31 downto 0);
		variable C1_hex_c3_text : std_logic_vector(31 downto 0);

		variable C2_hex_c0_text : std_logic_vector(31 downto 0);
		variable C2_hex_c1_text : std_logic_vector(31 downto 0);
		variable C2_hex_c2_text : std_logic_vector(31 downto 0);
		variable C2_hex_c3_text : std_logic_vector(31 downto 0);

		variable C3_hex_c0_text : std_logic_vector(31 downto 0);
		variable C3_hex_c1_text : std_logic_vector(31 downto 0);
		variable C3_hex_c2_text : std_logic_vector(31 downto 0);
		variable C3_hex_c3_text : std_logic_vector(31 downto 0);

		variable D0_hex_d0_text	: std_logic_vector(31 downto 0);
		variable D0_hex_d1_text	: std_logic_vector(31 downto 0);
		variable D0_hex_d2_text	: std_logic_vector(31 downto 0);
		variable D0_hex_d3_text	: std_logic_vector(31 downto 0);

		variable D1_hex_d0_text	: std_logic_vector(31 downto 0);
		variable D1_hex_d1_text	: std_logic_vector(31 downto 0);
		variable D1_hex_d2_text	: std_logic_vector(31 downto 0);
		variable D1_hex_d3_text	: std_logic_vector(31 downto 0);

		variable D2_hex_d0_text	: std_logic_vector(31 downto 0);
		variable D2_hex_d1_text	: std_logic_vector(31 downto 0);
		variable D2_hex_d2_text	: std_logic_vector(31 downto 0);
		variable D2_hex_d3_text	: std_logic_vector(31 downto 0);

		variable D3_hex_d0_text	: std_logic_vector(31 downto 0);
		variable D3_hex_d1_text	: std_logic_vector(31 downto 0);
		variable D3_hex_d2_text	: std_logic_vector(31 downto 0);
		variable D3_hex_d3_text	: std_logic_vector(31 downto 0);

		variable dummy_temp	: unsigned(31 downto 0);
		variable temp1 : unsigned(31 downto 0);
		variable temp2 : unsigned(31 downto 0);

		variable index_x : integer range 0 to 4;
		variable index_y : integer range 0 to 4;

		begin	

		rst_s <= '1';		

		wait for 100 ns;

		rst_s <= '0';

		wait for 1 ns;

			while not endfile(text_file) loop
				-- reading the line for the file and storing into the line.
				readline(text_file, text_line);

				-- Skip empty lines and single-line comments
				if text_line.all'length = 0 or text_line.all(1) = '#' then
					next;
				end if;

				-- Collecting values for the input A:
		
				hread(text_line, A0_hex_a0_text, ok);
				assert ok
					report "Read 'A0_hex_a0_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, A0_hex_a1_text, ok);
				assert ok
					report "Read 'A0_hex_a1_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, A0_hex_a2_text, ok);
				assert ok
					report "Read 'A0_hex_a2_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, A0_hex_a3_text, ok);
				assert ok
					report "Read 'A0_hex_a3_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, A1_hex_a0_text, ok);
				assert ok
					report "Read 'A1_hex_a0_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, A1_hex_a1_text, ok);
				assert ok
					report "Read 'A1_hex_a1_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, A1_hex_a2_text, ok);
				assert ok
					report "Read 'A1_hex_a2_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, A1_hex_a3_text, ok);
				assert ok
					report "Read 'A1_hex_a3_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, A2_hex_a0_text, ok);
				assert ok
					report "Read 'A2_hex_a0_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, A2_hex_a1_text, ok);
				assert ok
					report "Read 'A2_hex_a1_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, A2_hex_a2_text, ok);
				assert ok
					report "Read 'A2_hex_a2_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, A2_hex_a3_text, ok);
				assert ok
					report "Read 'A2_hex_a3_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, A3_hex_a0_text, ok);
				assert ok
					report "Read 'A3_hex_a0_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, A3_hex_a1_text, ok);
				assert ok
					report "Read 'A3_hex_a1_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, A3_hex_a2_text, ok);
				assert ok
					report "Read 'A3_hex_a2_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, A3_hex_a3_text, ok);
				assert ok
					report "Read 'A3_hex_a3_text' failed for line: " & text_line.all
					severity failure;

				-- Collecting values for the input B:

				hread(text_line, B0_hex_b0_text, ok);
				assert ok
					report "Read 'B0_hex_b0_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, B0_hex_b1_text, ok);
				assert ok
					report "Read 'B0_hex_b1_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, B0_hex_b2_text, ok);
				assert ok
					report "Read 'B0_hex_b2_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, B0_hex_b3_text, ok);
				assert ok
					report "Read 'B0_hex_b3_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, B1_hex_b0_text, ok);
				assert ok
					report "Read 'B1_hex_b0_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, B1_hex_b1_text, ok);
				assert ok
					report "Read 'B1_hex_b1_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, B1_hex_b2_text, ok);
				assert ok
					report "Read 'B1_hex_b2_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, B1_hex_b3_text, ok);
				assert ok
					report "Read 'B1_hex_b3_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, B2_hex_b0_text, ok);
				assert ok
					report "Read 'B2_hex_b0_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, B2_hex_b1_text, ok);
				assert ok
					report "Read 'B2_hex_b1_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, B2_hex_b2_text, ok);
				assert ok
					report "Read 'B2_hex_b2_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, B2_hex_b3_text, ok);
				assert ok
					report "Read 'B2_hex_b3_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, B3_hex_b0_text, ok);
				assert ok
					report "Read 'B3_hex_b0_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, B3_hex_b1_text, ok);
				assert ok
					report "Read 'B3_hex_b1_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, B3_hex_b2_text, ok);
				assert ok
					report "Read 'B3_hex_b2_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, B3_hex_b3_text, ok);
				assert ok
					report "Read 'B3_hex_b3_text' failed for line: " & text_line.all
					severity failure;

				-- loading parameters for input C:

				hread(text_line, C0_hex_c0_text, ok);
				assert ok
					report "Read 'C0_hex_c0_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, C0_hex_c1_text, ok);
				assert ok
					report "Read 'C0_hex_c1_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, C0_hex_c2_text, ok);
				assert ok
					report "Read 'C0_hex_c2_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, C0_hex_c3_text, ok);
				assert ok
					report "Read 'C0_hex_c3_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, C1_hex_c0_text, ok);
				assert ok
					report "Read 'C1_hex_c0_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, C1_hex_c1_text, ok);
				assert ok
					report "Read 'C1_hex_c1_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, C1_hex_c2_text, ok);
				assert ok
					report "Read 'C1_hex_c2_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, C1_hex_c3_text, ok);
				assert ok
					report "Read 'C1_hex_c3_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, C2_hex_c0_text, ok);
				assert ok
					report "Read 'C2_hex_c0_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, C2_hex_c1_text, ok);
				assert ok
					report "Read 'C2_hex_c1_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, C2_hex_c2_text, ok);
				assert ok
					report "Read 'C2_hex_c2_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, C2_hex_c3_text, ok);
				assert ok
					report "Read 'C2_hex_c3_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, C3_hex_c0_text, ok);
				assert ok
					report "Read 'C3_hex_c0_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, C3_hex_c1_text, ok);
				assert ok
					report "Read 'C3_hex_c1_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, C3_hex_c2_text, ok);
				assert ok
					report "Read 'C3_hex_c2_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, C3_hex_c3_text, ok);
				assert ok
					report "Read 'C3_hex_c3_text' failed for line: " & text_line.all
					severity failure;

				-- loading the parameters for the golden output

				hread(text_line, D0_hex_d0_text, ok);
				assert ok
					report "Read 'D0_hex_d0_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, D0_hex_d1_text, ok);
				assert ok
					report "Read 'D0_hex_d1_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, D0_hex_d2_text, ok);
				assert ok
					report "Read 'D0_hex_d2_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, D0_hex_d3_text, ok);
				assert ok
					report "Read 'D0_hex_d3_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, D1_hex_d0_text, ok);
				assert ok
					report "Read 'D1_hex_d0_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, D1_hex_d1_text, ok);
				assert ok
					report "Read 'D1_hex_d1_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, D1_hex_d2_text, ok);
				assert ok
					report "Read 'D1_hex_d2_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, D1_hex_d3_text, ok);
				assert ok
					report "Read 'D1_hex_d3_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, D2_hex_d0_text, ok);
				assert ok
					report "Read 'D2_hex_d0_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, D2_hex_d1_text, ok);
				assert ok
					report "Read 'D2_hex_d1_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, D2_hex_d2_text, ok);
				assert ok
					report "Read 'D2_hex_d2_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, D2_hex_d3_text, ok);
				assert ok
					report "Read 'D2_hex_d3_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, D3_hex_d0_text, ok);
				assert ok
					report "Read 'D3_hex_d0_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, D3_hex_d1_text, ok);
				assert ok
					report "Read 'D3_hex_d1_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, D3_hex_d2_text, ok);
				assert ok
					report "Read 'D3_hex_d2_text' failed for line: " & text_line.all
					severity failure;

				hread(text_line, D3_hex_d3_text, ok);
				assert ok
					report "Read 'D3_hex_d3_text' failed for line: " & text_line.all
					severity failure;

				--Assigning the collected values as inputs for the design...



				A_00_s <= A0_hex_a0_text;
				A_01_s <= A0_hex_a1_text;
				A_02_s <= A0_hex_a2_text;
				A_03_s <= A0_hex_a3_text;
				A_10_s <= A1_hex_a0_text;
				A_11_s <= A1_hex_a1_text;
				A_12_s <= A1_hex_a2_text;
				A_13_s <= A1_hex_a3_text;
				A_20_s <= A2_hex_a0_text;
				A_21_s <= A2_hex_a1_text;
				A_22_s <= A2_hex_a2_text;
				A_23_s <= A2_hex_a3_text;
				A_30_s <= A3_hex_a0_text;
				A_31_s <= A3_hex_a1_text;
				A_32_s <= A3_hex_a2_text;
				A_33_s <= A3_hex_a3_text;

				B_00_s <= B0_hex_b0_text;
				B_01_s <= B0_hex_b1_text;
				B_02_s <= B0_hex_b2_text;
				B_03_s <= B0_hex_b3_text;
				B_10_s <= B1_hex_b0_text;
				B_11_s <= B1_hex_b1_text;
				B_12_s <= B1_hex_b2_text;
				B_13_s <= B1_hex_b3_text;
				B_20_s <= B2_hex_b0_text;
				B_21_s <= B2_hex_b1_text;
				B_22_s <= B2_hex_b2_text;
				B_23_s <= B2_hex_b3_text;
				B_30_s <= B3_hex_b0_text;
				B_31_s <= B3_hex_b1_text;
				B_32_s <= B3_hex_b2_text;
				B_33_s <= B3_hex_b3_text;

				C_00_s <= C0_hex_c0_text;
				C_01_s <= C0_hex_c1_text;
				C_02_s <= C0_hex_c2_text;
				C_03_s <= C0_hex_c3_text;
				C_10_s <= C1_hex_c0_text;
				C_11_s <= C1_hex_c1_text;
				C_12_s <= C1_hex_c2_text;
				C_13_s <= C1_hex_c3_text;
				C_20_s <= C2_hex_c0_text;
				C_21_s <= C2_hex_c1_text;
				C_22_s <= C2_hex_c2_text;
				C_23_s <= C2_hex_c3_text;
				C_30_s <= C3_hex_c0_text;
				C_31_s <= C3_hex_c1_text;
				C_32_s <= C3_hex_c2_text;
				C_33_s <= C3_hex_c3_text;


				W_003_golden_s <= D0_hex_d0_text;
				W_013_golden_s <= D0_hex_d1_text;
				W_023_golden_s <= D0_hex_d2_text;
				W_033_golden_s <= D0_hex_d3_text;

				W_103_golden_s <= D1_hex_d0_text;
				W_113_golden_s <= D1_hex_d1_text;
				W_123_golden_s <= D1_hex_d2_text;
				W_133_golden_s <= D1_hex_d3_text;

				W_203_golden_s <= D2_hex_d0_text;
				W_213_golden_s <= D2_hex_d1_text;
				W_223_golden_s <= D2_hex_d2_text;
				W_233_golden_s <= D2_hex_d3_text;

				W_303_golden_s <= D3_hex_d0_text;
				W_313_golden_s <= D3_hex_d1_text;
				W_323_golden_s <= D3_hex_d2_text;
				W_333_golden_s <= D3_hex_d3_text;


--				A_0X_s <= (0 => A0_hex_a0_text, 1 => A0_hex_a1_text, 2 => A0_hex_a2_text, 3 => A0_hex_a3_text);
--				A_1X_s <= (0 => A1_hex_a0_text, 1 => A1_hex_a1_text, 2 => A1_hex_a2_text, 3 => A1_hex_a3_text);
--				A_2X_s <= (0 => A2_hex_a0_text, 1 => A2_hex_a1_text, 2 => A2_hex_a2_text, 3 => A2_hex_a3_text);
--				A_3X_s <= (0 => A3_hex_a0_text, 1 => A3_hex_a1_text, 2 => A3_hex_a2_text, 3 => A3_hex_a3_text);

--				B_0X_s <= (0 => B0_hex_b0_text, 1 => B0_hex_b1_text, 2 => B0_hex_b2_text, 3 => B0_hex_b3_text);
--				B_1X_s <= (0 => B1_hex_b0_text, 1 => B1_hex_b1_text, 2 => B1_hex_b2_text, 3 => B1_hex_b3_text);
--				B_2X_s <= (0 => B2_hex_b0_text, 1 => B2_hex_b1_text, 2 => B2_hex_b2_text, 3 => B2_hex_b3_text);
--				B_3X_s <= (0 => B3_hex_b0_text, 1 => B3_hex_b1_text, 2 => B3_hex_b2_text, 3 => B3_hex_b3_text);

--				C_0X_s <= (0 => C0_hex_c0_text, 1 => C0_hex_c1_text, 2 => C0_hex_c2_text, 3 => C0_hex_c3_text);
--				C_1X_s <= (0 => C1_hex_c0_text, 1 => C1_hex_c1_text, 2 => C1_hex_c2_text, 3 => C1_hex_c3_text);
--				C_2X_s <= (0 => C2_hex_c0_text, 1 => C2_hex_c1_text, 2 => C2_hex_c2_text, 3 => C2_hex_c3_text);
--				C_3X_s <= (0 => C3_hex_c0_text, 1 => C3_hex_c1_text, 2 => C3_hex_c2_text, 3 => C3_hex_c3_text);

--				W_0X3_golden_s <= (0 => D0_hex_d0_text, 1 => D0_hex_d1_text, 2 => D0_hex_d2_text, 3 => D0_hex_d3_text);
--				W_1X3_golden_s <= (0 => D1_hex_d0_text, 1 => D1_hex_d1_text, 2 => D1_hex_d2_text, 3 => D1_hex_d3_text);
--				W_2X3_golden_s <= (0 => D2_hex_d0_text, 1 => D2_hex_d1_text, 2 => D2_hex_d2_text, 3 => D2_hex_d3_text);
--				W_3X3_golden_s <= (0 => D3_hex_d0_text, 1 => D3_hex_d1_text, 2 => D3_hex_d2_text, 3 => D3_hex_d3_text);

				valid_in_s <= '1';

				wait for 10ns;

				valid_in_s <= '0';

				wait for 100ns;


				--	 Missing the comparison between the obtained results and the golden from file

				-- setting indices
--				index_x := 0;		-- Wxy The results are organized in this order (row , colunm)
--				index_y := 0;		-- Wxy


				-- Comparing results:

--				temp1 := unsigned(W_0X3_s(0));
--				temp2 := unsigned(W_0X3_golden_s(0));
--				dummy_temp := (temp1 xor temp2);
----				assert (dummy_temp = x"00000000") report "mismatch in results: golden: " & to_string(W_0X3_golden_s(0) ) & " Sim:" & to_string( W_0X3_s(0) ) & "  " & to_string(dummy_temp);
--				assert (dummy_temp = x"00000000") report "mismatch in results:" & to_string(dummy_temp) & " W33 index: [" & integer'image(index_x) & "][" & integer'image(index_y) & "]";
--				index_y := index_y + 1;

--				temp1 := unsigned(W_0X3_s(1));
--				temp2 := unsigned(W_0X3_golden_s(1));
--				dummy_temp := (temp1 xor temp2);
--				assert (dummy_temp = x"00000000") report "mismatch in results:" & to_string(dummy_temp) & " W33 index: [" & integer'image(index_x) & "][" & integer'image(index_y) & "]";
--				index_y := index_y + 1;

--				temp1 := unsigned(W_0X3_s(2));
--				temp2 := unsigned(W_0X3_golden_s(2));
--				dummy_temp := (temp1 xor temp2);
--				assert (dummy_temp = x"00000000") report "mismatch in results:" & to_string(dummy_temp) & " W33 index: [" & integer'image(index_x) & "][" & integer'image(index_y) & "]";
--				index_y := index_y + 1;

--				temp1 := unsigned(W_0X3_s(3));
--				temp2 := unsigned(W_0X3_golden_s(3));
--				dummy_temp := (temp1 xor temp2);
--				assert (dummy_temp = x"00000000") report "mismatch in results:" & to_string(dummy_temp) & " W33 index: [" & integer'image(index_x) & "][" & integer'image(index_y) & "]";
--				index_y := 0;
--				index_x := index_x + 1;

--				temp1 := unsigned(W_1X3_s(0));
--				temp2 := unsigned(W_1X3_golden_s(0));
--				dummy_temp := (temp1 xor temp2);
--				assert (dummy_temp = x"00000000") report "mismatch in results:" & to_string(dummy_temp) & " W33 index: [" & integer'image(index_x) & "][" & integer'image(index_y) & "]";

--				index_y := index_y + 1;

--				temp1 := unsigned(W_1X3_s(1));
--				temp2 := unsigned(W_1X3_golden_s(1));
--				dummy_temp := (temp1 xor temp2);
--				assert (dummy_temp = x"00000000") report "mismatch in results:" & to_string(dummy_temp) & " W33 index: [" & integer'image(index_x) & "][" & integer'image(index_y) & "]";
--				index_y := index_y + 1;

--				temp1 := unsigned(W_1X3_s(2));
--				temp2 := unsigned(W_1X3_golden_s(2));
--				dummy_temp := (temp1 xor temp2);
--				assert (dummy_temp = x"00000000") report "mismatch in results:" & to_string(dummy_temp) & " W33 index: [" & integer'image(index_x) & "][" & integer'image(index_y) & "]";
--				index_y := index_y + 1;

--				temp1 := unsigned(W_1X3_s(3));
--				temp2 := unsigned(W_1X3_golden_s(3));
--				dummy_temp := (temp1 xor temp2);
--				assert (dummy_temp = x"00000000") report "mismatch in results:" & to_string(dummy_temp) & " W33 index: [" & integer'image(index_x) & "][" & integer'image(index_y) & "]";
--				index_y := 0;
--				index_x := index_x + 1;

--				temp1 := unsigned(W_2X3_s(0));
--				temp2 := unsigned(W_2X3_golden_s(0));
--				dummy_temp := (temp1 xor temp2);
--				assert (dummy_temp = x"00000000") report "mismatch in results:" & to_string(dummy_temp) & " W33 index: [" & integer'image(index_x) & "][" & integer'image(index_y) & "]";
--				index_y := index_y + 1;


--				temp1 := unsigned(W_2X3_s(1));
--				temp2 := unsigned(W_2X3_golden_s(1));
--				dummy_temp := (temp1 xor temp2);
--				assert (dummy_temp = x"00000000") report "mismatch in results:" & to_string(dummy_temp) & " W33 index: [" & integer'image(index_x) & "][" & integer'image(index_y) & "]";
--				index_y := index_y + 1;

--				temp1 := unsigned(W_2X3_s(2));
--				temp2 := unsigned(W_2X3_golden_s(2));
--				dummy_temp := (temp1 xor temp2);
--				assert (dummy_temp = x"00000000") report "mismatch in results:" & to_string(dummy_temp) & " W33 index: [" & integer'image(index_x) & "][" & integer'image(index_y) & "]";
--				index_y := index_y + 1;

--				temp1 := unsigned(W_2X3_s(3));
--				temp2 := unsigned(W_2X3_golden_s(3));
--				dummy_temp := (temp1 xor temp2);
--				assert (dummy_temp = x"00000000") report "mismatch in results:" & to_string(dummy_temp) & " W33 index: [" & integer'image(index_x) & "][" & integer'image(index_y) & "]";
--				index_y := 0;
--				index_x := index_x + 1;

--				temp1 := unsigned(W_3X3_s(0));
--				temp2 := unsigned(W_3X3_golden_s(0));
--				dummy_temp := (temp1 xor temp2);
--				assert (dummy_temp = x"00000000") report "mismatch in results:" & to_string(dummy_temp) & " W33 index: [" & integer'image(index_x) & "][" & integer'image(index_y) & "]";
--				index_y := index_y + 1;

--				temp1 := unsigned(W_3X3_s(1));
--				temp2 := unsigned(W_3X3_golden_s(1));
--				dummy_temp := (temp1 xor temp2);
--				assert (dummy_temp = x"00000000") report "mismatch in results:" & to_string(dummy_temp) & " W33 index: [" & integer'image(index_x) & "][" & integer'image(index_y) & "]";
--				index_y := index_y + 1;

--				temp1 := unsigned(W_3X3_s(2));
--				temp2 := unsigned(W_3X3_golden_s(2));
--				dummy_temp := (temp1 xor temp2);
--				assert (dummy_temp = x"00000000") report "mismatch in results:" & to_string(dummy_temp) & " W33 index: [" & integer'image(index_x) & "][" & integer'image(index_y) & "]";
--				index_y := index_y + 1;

--				temp1 := unsigned(W_3X3_s(3));
--				temp2 := unsigned(W_3X3_golden_s(3));
--				dummy_temp := (temp1 xor temp2);
--				assert (dummy_temp = x"00000000") report "mismatch in results:" & to_string(dummy_temp) & " W33 index: [" & integer'image(index_x) & "][" & integer'image(index_y) & "]";

			end loop;
		wait;
end process;
		
		


end ar;
