----------------------------------------------------------------------------
-- Company:         	Politecnico di Torino
-- Engineer:          	Josie E. Rodriguez Condia
--
-- Create Date:     		27/06/2023
-- Module Name:   			Dot Product Unit 16 bits inputs.
-- Project Name:   			Open TCU
-- Target Devices:		
-- Tool versions:    		ModelSim
-- Description:
--
----------------------------------------------------------------------------
-- Revisions:
--  REV:        Date:          			Description:
--  1.0.a       	23/10/2022      	Created Top level file
--  1.2.a           17/11/2022          Functional verification OK 
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

entity dot_unit_core is
	port(
				a_X0 : in std_logic_vector(15 downto 0);
				a_X1 : in std_logic_vector(15 downto 0);
				a_X2 : in std_logic_vector(15 downto 0);
				a_X3 : in std_logic_vector(15 downto 0);
				b_X0  : in std_logic_vector(15 downto 0);
				b_X1  : in std_logic_vector(15 downto 0);
				b_X2  : in std_logic_vector(15 downto 0);
				b_X3  : in std_logic_vector(15 downto 0);		
				c_X0: in std_logic_vector(31 downto 0);					-- Check the size of this one
				w_XX3: out std_logic_vector(31 downto 0)
	);
end dot_unit_core;

architecture ar of dot_unit_core is

	-- Signals for the interconnection of the cores:
	signal a_X0_b_X0_s :std_logic_vector(15 downto 0);
	signal a_X1_b_X1_s :std_logic_vector(15 downto 0);
	signal a_X2_b_X2_s :std_logic_vector(15 downto 0);
	signal a_X3_b_X3_s :std_logic_vector(15 downto 0);
	signal c_XX_s :std_logic_vector(31 downto 0);

	signal a_X0_b_X0_plus_a_X1_b_X1_unsigned_s: unsigned(31 downto 0);
	signal a_X2_b_X2_plus_a_X3_b_X3_unsigned_s: unsigned(31 downto 0);
	signal a_plus_b_unsigned_s: unsigned(31 downto 0);
	signal w_XX3_unsigned_s: unsigned(31 downto 0);


	constant EXP_WIDTH_c : natural := 5;	
	constant MANT_WIDTH_c : natural := 10;
	
	
	-- remember to include the generic port to allow the size definition...
	component FP_16				-- this version is having 16 bits inputs and 32 bits output and cames from chatGPT engines
		generic (
			EXP_WIDTH : natural := 5;  -- Exponent width
			MANT_WIDTH : natural := 10  -- Mantissa width
		);
		port (
			A : in std_logic_vector((EXP_WIDTH + MANT_WIDTH) - 1 downto 0);
			B : in std_logic_vector((EXP_WIDTH + MANT_WIDTH) - 1 downto 0);
			Result : out std_logic_vector((2 * (EXP_WIDTH + MANT_WIDTH)) - 1 downto 0)
		);
	end component;

	component adder_FP
		generic(
			long : natural := 32
		);
		port(
			operando1, operando2: in unsigned(long-1 downto 0);
			operacion: in unsigned(3 downto 0);
			resultado: out unsigned(long-1 downto 0)
		);
	end component;
	
begin

	c_XX_s <= c_X0;
	
	FMUL0: FP_16 generic map(							-- this version is having 16 bits inputs and 32 bits output and cames from chatGPT engines
							EXP_WIDTH => EXP_WIDTH_c,
							MANT_WIDTH => MANT_WIDTH_c
							)
					port map(
							A  => a_X0,
							B  => b_X0,
							Result a_X0_b_X0_s
							);

	FMUL1: FP_16 generic map(							-- this version is having 16 bits inputs and 32 bits output and cames from chatGPT engines
							EXP_WIDTH => EXP_WIDTH_c,
							MANT_WIDTH => MANT_WIDTH_c
							)
					port map(
							A  => a_X1,
							B  => b_X1,
							Result a_X1_b_X1_s
							);

	FMUL2: FP_16 generic map(							-- this version is having 16 bits inputs and 32 bits output and cames from chatGPT engines
							EXP_WIDTH => EXP_WIDTH_c,
							MANT_WIDTH => MANT_WIDTH_c
							)
					port map(
							A  => a_X2,
							B  => b_X2,
							Result a_X2_b_X2_s
							);

	FMUL3: FP_16 generic map(							-- this version is having 16 bits inputs and 32 bits output and cames from chatGPT engines
							EXP_WIDTH => EXP_WIDTH_c,
							MANT_WIDTH => MANT_WIDTH_c
							)
					port map(
							A  => a_X3,
							B  => b_X3,
							Result a_X3_b_X3_s
							);

-- adder (FADD) stage:

	ADDER0: adder_FP generic map(
														long =>long
														)
									 port map(
														operando1 => unsigned(a_X0_b_X0_s),
														operando2 => unsigned(a_X1_b_X1_s),
														operacion => to_unsigned(1, 4),
														resultado  => a_X0_b_X0_plus_a_X1_b_X1_unsigned_s
									 );

	ADDER1: adder_FP generic map(
														long =>long
														)
									 port map(
														operando1 => unsigned(a_X2_b_X2_s),
														operando2 => unsigned(a_X3_b_X3_s),
														operacion => to_unsigned(1, 4),
														resultado =>  a_X2_b_X2_plus_a_X3_b_X3_unsigned_s
									 );


	ADDER2: adder_FP generic map(
														long =>long
														)
									 port map(
														operando1 => a_X0_b_X0_plus_a_X1_b_X1_unsigned_s ,
														operando2 => a_X2_b_X2_plus_a_X3_b_X3_unsigned_s,
														operacion => to_unsigned(1, 4),
														resultado => a_plus_b_unsigned_s
									 );

	ADDER3: adder_FP generic map(
														long =>long
														)
									 port map(
														operando1 => a_plus_b_unsigned_s,
														operando2 => unsigned(c_XX_s),
														operacion => to_unsigned(1, 4),
														resultado => w_XX3_unsigned_s
									 );
									 
	w_XX3 <= std_logic_vector(w_XX3_unsigned_s);


end ar;
