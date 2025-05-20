----------------------------------------------------------------------------
-- Company:         	Politecnico di Torino
-- Engineer:          	Josie E. Rodriguez Condia
--
-- Create Date:     	23/10/2022
-- Module Name:   		Dot Product Unit TB
-- Project Name:   		Open TCU
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



entity sub_tensor_core_TB is

end sub_tensor_core_TB;

architecture ar of sub_tensor_core_TB is
	
	-- Size of the dot product unit comes from def_package
	
	-- Signals for the interconnection of the cores:

	signal A_0X_s: operand_array(2**size_sub_tensor - 1 downto 0);
	signal A_1X_s: operand_array(2**size_sub_tensor - 1 downto 0);
	signal A_2X_s: operand_array(2**size_sub_tensor - 1 downto 0);
	signal A_3X_s: operand_array(2**size_sub_tensor - 1 downto 0);
	signal B_0X_s: operand_array(2**size_sub_tensor - 1 downto 0);
	signal B_1X_s: operand_array(2**size_sub_tensor - 1 downto 0);
	signal B_2X_s: operand_array(2**size_sub_tensor - 1 downto 0);
	signal B_3X_s: operand_array(2**size_sub_tensor - 1 downto 0);
	signal C_0X_s: operand_array(2**size_sub_tensor - 1 downto 0);
	signal C_1X_s: operand_array(2**size_sub_tensor - 1 downto 0);
	signal C_2X_s: operand_array(2**size_sub_tensor - 1 downto 0);
	signal C_3X_s: operand_array(2**size_sub_tensor - 1 downto 0);
	signal W_0X3_s: operand_array(2**size_sub_tensor - 1 downto 0);
	signal W_1X3_s: operand_array(2**size_sub_tensor - 1 downto 0);
	signal W_2X3_s: operand_array(2**size_sub_tensor - 1 downto 0);
	signal W_3X3_s: operand_array(2**size_sub_tensor - 1 downto 0);

	signal W_0X3_golden_s: operand_array(2**size_sub_tensor - 1 downto 0);
	signal W_1X3_golden_s: operand_array(2**size_sub_tensor - 1 downto 0);
	signal W_2X3_golden_s: operand_array(2**size_sub_tensor - 1 downto 0);
	signal W_3X3_golden_s: operand_array(2**size_sub_tensor - 1 downto 0);

	signal underflow_s : std_logic;
	signal overflow_s : std_logic;
	signal clk_s: std_logic := '0';
	signal rst_s: std_logic;

	component sub_tensor_core is
		generic(
				size: natural:= 2;
				long : natural := 32
				);
		port(
				-- A_0X <= (0 => bus0, 1 => bus1, 2 => bus2, 3 => bus3);
				clk : in std_logic;
				rst : in std_logic;
				A_0X: in  operand_array(2**size - 1 downto 0);
				A_1X: in  operand_array(2**size - 1 downto 0);
				A_2X: in  operand_array(2**size - 1 downto 0);
				A_3X: in  operand_array(2**size - 1 downto 0);
				B_0X: in  operand_array(2**size - 1 downto 0);
				B_1X: in  operand_array(2**size - 1 downto 0);
				B_2X: in  operand_array(2**size - 1 downto 0);
				B_3X: in  operand_array(2**size - 1 downto 0);
				C_0X: in  operand_array(2**size - 1 downto 0);
				C_1X: in  operand_array(2**size - 1 downto 0);
				C_2X: in  operand_array(2**size - 1 downto 0);
				C_3X: in operand_array(2**size - 1 downto 0);
				W_0X3: out operand_array(2**size - 1 downto 0);
				W_1X3: out operand_array(2**size - 1 downto 0);
				W_2X3: out operand_array(2**size - 1 downto 0);
				W_3X3: out operand_array(2**size - 1 downto 0)
	);
	end component;

	-- convert `std_logic_vector' to `string'
	function to_string(value : std_logic_vector) return string is
	variable l : line;
	begin
	write(l, to_bitVector(value), right, 0);
	return l.all;
	end to_string;


	begin

	

	clk_s <= not clk_s after 1ns;

	rst_s <= '0';
	
	DUT0: sub_tensor_core generic map(
						size  => size_sub_tensor,  -- Defined in the general package
						long  =>long
					 )
			 	 port map(
						clk => clk_s,
						rst => rst_s,
						A_0X => A_0X_s,
						A_1X => A_1X_s,
						A_2X => A_2X_s,
						A_3X => A_3X_s,
						B_0X => B_0X_s,
						B_1X => B_1X_s,
						B_2X => B_2X_s,
						B_3X => B_3X_s,
						C_0X => C_0X_s,
						C_1X => C_1X_s,
						C_2X => C_2X_s,
						C_3X => C_3X_s,
						W_0X3 => W_0X3_s,
						W_1X3 => W_1X3_s,
						W_2X3 => W_2X3_s,
						W_3X3 => W_3X3_s
					);
		
-- state machine loading the patterns and applying to the DUT: (Dot Product Unit) DPU

	test_bench : process
	
		file text_file : TEXT open READ_MODE is "values_sub_tensor.txt";

		variable text_line : line;
		variable ok : boolean;
		variable char : character;

		variable A0_hex_a0_text : std_logic_vector(long-1 downto 0);
		variable A0_hex_a1_text : std_logic_vector(long-1 downto 0);
		variable A0_hex_a2_text : std_logic_vector(long-1 downto 0);
		variable A0_hex_a3_text : std_logic_vector(long-1 downto 0);

		variable A1_hex_a0_text : std_logic_vector(long-1 downto 0);
		variable A1_hex_a1_text : std_logic_vector(long-1 downto 0);
		variable A1_hex_a2_text : std_logic_vector(long-1 downto 0);
		variable A1_hex_a3_text : std_logic_vector(long-1 downto 0);

		variable A2_hex_a0_text : std_logic_vector(long-1 downto 0);
		variable A2_hex_a1_text : std_logic_vector(long-1 downto 0);
		variable A2_hex_a2_text : std_logic_vector(long-1 downto 0);
		variable A2_hex_a3_text : std_logic_vector(long-1 downto 0);

		variable A3_hex_a0_text : std_logic_vector(long-1 downto 0);
		variable A3_hex_a1_text : std_logic_vector(long-1 downto 0);
		variable A3_hex_a2_text : std_logic_vector(long-1 downto 0);
		variable A3_hex_a3_text : std_logic_vector(long-1 downto 0);

		variable B0_hex_b0_text : std_logic_vector(long-1 downto 0);
		variable B0_hex_b1_text : std_logic_vector(long-1 downto 0);
		variable B0_hex_b2_text : std_logic_vector(long-1 downto 0);
		variable B0_hex_b3_text : std_logic_vector(long-1 downto 0);

		variable B1_hex_b0_text : std_logic_vector(long-1 downto 0);
		variable B1_hex_b1_text : std_logic_vector(long-1 downto 0);
		variable B1_hex_b2_text : std_logic_vector(long-1 downto 0);
		variable B1_hex_b3_text : std_logic_vector(long-1 downto 0);

		variable B2_hex_b0_text : std_logic_vector(long-1 downto 0);
		variable B2_hex_b1_text : std_logic_vector(long-1 downto 0);
		variable B2_hex_b2_text : std_logic_vector(long-1 downto 0);
		variable B2_hex_b3_text : std_logic_vector(long-1 downto 0);

		variable B3_hex_b0_text : std_logic_vector(long-1 downto 0);
		variable B3_hex_b1_text : std_logic_vector(long-1 downto 0);
		variable B3_hex_b2_text : std_logic_vector(long-1 downto 0);
		variable B3_hex_b3_text : std_logic_vector(long-1 downto 0);

		variable C0_hex_c0_text : std_logic_vector(long-1 downto 0);
		variable C0_hex_c1_text : std_logic_vector(long-1 downto 0);
		variable C0_hex_c2_text : std_logic_vector(long-1 downto 0);
		variable C0_hex_c3_text : std_logic_vector(long-1 downto 0);

		variable C1_hex_c0_text : std_logic_vector(long-1 downto 0);
		variable C1_hex_c1_text : std_logic_vector(long-1 downto 0);
		variable C1_hex_c2_text : std_logic_vector(long-1 downto 0);
		variable C1_hex_c3_text : std_logic_vector(long-1 downto 0);

		variable C2_hex_c0_text : std_logic_vector(long-1 downto 0);
		variable C2_hex_c1_text : std_logic_vector(long-1 downto 0);
		variable C2_hex_c2_text : std_logic_vector(long-1 downto 0);
		variable C2_hex_c3_text : std_logic_vector(long-1 downto 0);

		variable C3_hex_c0_text : std_logic_vector(long-1 downto 0);
		variable C3_hex_c1_text : std_logic_vector(long-1 downto 0);
		variable C3_hex_c2_text : std_logic_vector(long-1 downto 0);
		variable C3_hex_c3_text : std_logic_vector(long-1 downto 0);

		variable D0_hex_d0_text	: std_logic_vector(long-1 downto 0);
		variable D0_hex_d1_text	: std_logic_vector(long-1 downto 0);
		variable D0_hex_d2_text	: std_logic_vector(long-1 downto 0);
		variable D0_hex_d3_text	: std_logic_vector(long-1 downto 0);

		variable D1_hex_d0_text	: std_logic_vector(long-1 downto 0);
		variable D1_hex_d1_text	: std_logic_vector(long-1 downto 0);
		variable D1_hex_d2_text	: std_logic_vector(long-1 downto 0);
		variable D1_hex_d3_text	: std_logic_vector(long-1 downto 0);

		variable D2_hex_d0_text	: std_logic_vector(long-1 downto 0);
		variable D2_hex_d1_text	: std_logic_vector(long-1 downto 0);
		variable D2_hex_d2_text	: std_logic_vector(long-1 downto 0);
		variable D2_hex_d3_text	: std_logic_vector(long-1 downto 0);

		variable D3_hex_d0_text	: std_logic_vector(long-1 downto 0);
		variable D3_hex_d1_text	: std_logic_vector(long-1 downto 0);
		variable D3_hex_d2_text	: std_logic_vector(long-1 downto 0);
		variable D3_hex_d3_text	: std_logic_vector(long-1 downto 0);

		variable dummy_temp	: unsigned(long-1 downto 0);
		variable temp1 : unsigned(long-1 downto 0);
		variable temp2 : unsigned(long-1 downto 0);

		variable index_x : integer range 0 to 4;
		variable index_y : integer range 0 to 4;

		begin
		
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

				A_0X_s <= (0 => A0_hex_a0_text, 1 => A0_hex_a1_text, 2 => A0_hex_a2_text, 3 => A0_hex_a3_text);
				A_1X_s <= (0 => A1_hex_a0_text, 1 => A1_hex_a1_text, 2 => A1_hex_a2_text, 3 => A1_hex_a3_text);
				A_2X_s <= (0 => A2_hex_a0_text, 1 => A2_hex_a1_text, 2 => A2_hex_a2_text, 3 => A2_hex_a3_text);
				A_3X_s <= (0 => A3_hex_a0_text, 1 => A3_hex_a1_text, 2 => A3_hex_a2_text, 3 => A3_hex_a3_text);

				B_0X_s <= (0 => B0_hex_b0_text, 1 => B0_hex_b1_text, 2 => B0_hex_b2_text, 3 => B0_hex_b3_text);
				B_1X_s <= (0 => B1_hex_b0_text, 1 => B1_hex_b1_text, 2 => B1_hex_b2_text, 3 => B1_hex_b3_text);
				B_2X_s <= (0 => B2_hex_b0_text, 1 => B2_hex_b1_text, 2 => B2_hex_b2_text, 3 => B2_hex_b3_text);
				B_3X_s <= (0 => B3_hex_b0_text, 1 => B3_hex_b1_text, 2 => B3_hex_b2_text, 3 => B3_hex_b3_text);

				C_0X_s <= (0 => C0_hex_c0_text, 1 => C0_hex_c1_text, 2 => C0_hex_c2_text, 3 => C0_hex_c3_text);
				C_1X_s <= (0 => C1_hex_c0_text, 1 => C1_hex_c1_text, 2 => C1_hex_c2_text, 3 => C1_hex_c3_text);
				C_2X_s <= (0 => C2_hex_c0_text, 1 => C2_hex_c1_text, 2 => C2_hex_c2_text, 3 => C2_hex_c3_text);
				C_3X_s <= (0 => C3_hex_c0_text, 1 => C3_hex_c1_text, 2 => C3_hex_c2_text, 3 => C3_hex_c3_text);

				W_0X3_golden_s <= (0 => D0_hex_d0_text, 1 => D0_hex_d1_text, 2 => D0_hex_d2_text, 3 => D0_hex_d3_text);
				W_1X3_golden_s <= (0 => D1_hex_d0_text, 1 => D1_hex_d1_text, 2 => D1_hex_d2_text, 3 => D1_hex_d3_text);
				W_2X3_golden_s <= (0 => D2_hex_d0_text, 1 => D2_hex_d1_text, 2 => D2_hex_d2_text, 3 => D2_hex_d3_text);
				W_3X3_golden_s <= (0 => D3_hex_d0_text, 1 => D3_hex_d1_text, 2 => D3_hex_d2_text, 3 => D3_hex_d3_text);

				wait for 100 ns;

				--	 Missing the comparison between the obtained results and the golden from file

				-- setting indices
				index_x := 0;		-- Wxy The results are organized in this order (row , colunm)
				index_y := 0;		-- Wxy


				-- Comparing results:

				temp1 := unsigned(W_0X3_s(0));
				temp2 := unsigned(W_0X3_golden_s(0));
				dummy_temp := (temp1 xor temp2);
--				assert (dummy_temp = x"00000000") report "mismatch in results: golden: " & to_string(W_0X3_golden_s(0) ) & " Sim:" & to_string( W_0X3_s(0) ) & "  " & to_string(dummy_temp);
				assert (dummy_temp = x"00000000") report "mismatch in results:" & to_string(dummy_temp) & " W33 index: [" & integer'image(index_x) & "][" & integer'image(index_y) & "]";
				index_y := index_y + 1;

				temp1 := unsigned(W_0X3_s(1));
				temp2 := unsigned(W_0X3_golden_s(1));
				dummy_temp := (temp1 xor temp2);
				assert (dummy_temp = x"00000000") report "mismatch in results:" & to_string(dummy_temp) & " W33 index: [" & integer'image(index_x) & "][" & integer'image(index_y) & "]";
				index_y := index_y + 1;

				temp1 := unsigned(W_0X3_s(2));
				temp2 := unsigned(W_0X3_golden_s(2));
				dummy_temp := (temp1 xor temp2);
				assert (dummy_temp = x"00000000") report "mismatch in results:" & to_string(dummy_temp) & " W33 index: [" & integer'image(index_x) & "][" & integer'image(index_y) & "]";
				index_y := index_y + 1;

				temp1 := unsigned(W_0X3_s(3));
				temp2 := unsigned(W_0X3_golden_s(3));
				dummy_temp := (temp1 xor temp2);
				assert (dummy_temp = x"00000000") report "mismatch in results:" & to_string(dummy_temp) & " W33 index: [" & integer'image(index_x) & "][" & integer'image(index_y) & "]";
				index_y := 0;
				index_x := index_x + 1;

				temp1 := unsigned(W_1X3_s(0));
				temp2 := unsigned(W_1X3_golden_s(0));
				dummy_temp := (temp1 xor temp2);
				assert (dummy_temp = x"00000000") report "mismatch in results:" & to_string(dummy_temp) & " W33 index: [" & integer'image(index_x) & "][" & integer'image(index_y) & "]";

				index_y := index_y + 1;

				temp1 := unsigned(W_1X3_s(1));
				temp2 := unsigned(W_1X3_golden_s(1));
				dummy_temp := (temp1 xor temp2);
				assert (dummy_temp = x"00000000") report "mismatch in results:" & to_string(dummy_temp) & " W33 index: [" & integer'image(index_x) & "][" & integer'image(index_y) & "]";
				index_y := index_y + 1;

				temp1 := unsigned(W_1X3_s(2));
				temp2 := unsigned(W_1X3_golden_s(2));
				dummy_temp := (temp1 xor temp2);
				assert (dummy_temp = x"00000000") report "mismatch in results:" & to_string(dummy_temp) & " W33 index: [" & integer'image(index_x) & "][" & integer'image(index_y) & "]";
				index_y := index_y + 1;

				temp1 := unsigned(W_1X3_s(3));
				temp2 := unsigned(W_1X3_golden_s(3));
				dummy_temp := (temp1 xor temp2);
				assert (dummy_temp = x"00000000") report "mismatch in results:" & to_string(dummy_temp) & " W33 index: [" & integer'image(index_x) & "][" & integer'image(index_y) & "]";
				index_y := 0;
				index_x := index_x + 1;

				temp1 := unsigned(W_2X3_s(0));
				temp2 := unsigned(W_2X3_golden_s(0));
				dummy_temp := (temp1 xor temp2);
				assert (dummy_temp = x"00000000") report "mismatch in results:" & to_string(dummy_temp) & " W33 index: [" & integer'image(index_x) & "][" & integer'image(index_y) & "]";
				index_y := index_y + 1;


				temp1 := unsigned(W_2X3_s(1));
				temp2 := unsigned(W_2X3_golden_s(1));
				dummy_temp := (temp1 xor temp2);
				assert (dummy_temp = x"00000000") report "mismatch in results:" & to_string(dummy_temp) & " W33 index: [" & integer'image(index_x) & "][" & integer'image(index_y) & "]";
				index_y := index_y + 1;

				temp1 := unsigned(W_2X3_s(2));
				temp2 := unsigned(W_2X3_golden_s(2));
				dummy_temp := (temp1 xor temp2);
				assert (dummy_temp = x"00000000") report "mismatch in results:" & to_string(dummy_temp) & " W33 index: [" & integer'image(index_x) & "][" & integer'image(index_y) & "]";
				index_y := index_y + 1;

				temp1 := unsigned(W_2X3_s(3));
				temp2 := unsigned(W_2X3_golden_s(3));
				dummy_temp := (temp1 xor temp2);
				assert (dummy_temp = x"00000000") report "mismatch in results:" & to_string(dummy_temp) & " W33 index: [" & integer'image(index_x) & "][" & integer'image(index_y) & "]";
				index_y := 0;
				index_x := index_x + 1;

				temp1 := unsigned(W_3X3_s(0));
				temp2 := unsigned(W_3X3_golden_s(0));
				dummy_temp := (temp1 xor temp2);
				assert (dummy_temp = x"00000000") report "mismatch in results:" & to_string(dummy_temp) & " W33 index: [" & integer'image(index_x) & "][" & integer'image(index_y) & "]";
				index_y := index_y + 1;

				temp1 := unsigned(W_3X3_s(1));
				temp2 := unsigned(W_3X3_golden_s(1));
				dummy_temp := (temp1 xor temp2);
				assert (dummy_temp = x"00000000") report "mismatch in results:" & to_string(dummy_temp) & " W33 index: [" & integer'image(index_x) & "][" & integer'image(index_y) & "]";
				index_y := index_y + 1;

				temp1 := unsigned(W_3X3_s(2));
				temp2 := unsigned(W_3X3_golden_s(2));
				dummy_temp := (temp1 xor temp2);
				assert (dummy_temp = x"00000000") report "mismatch in results:" & to_string(dummy_temp) & " W33 index: [" & integer'image(index_x) & "][" & integer'image(index_y) & "]";
				index_y := index_y + 1;

				temp1 := unsigned(W_3X3_s(3));
				temp2 := unsigned(W_3X3_golden_s(3));
				dummy_temp := (temp1 xor temp2);
				assert (dummy_temp = x"00000000") report "mismatch in results:" & to_string(dummy_temp) & " W33 index: [" & integer'image(index_x) & "][" & integer'image(index_y) & "]";

			end loop;
		wait;
end process;
		
		


end ar;
