----------------------------------------------------------------------------
-- Company:         	Politecnico di Torino
-- Engineer:          	Josie E. Rodriguez Condia
--
-- Create Date:     	14/01/2026
-- Module Name:   		Tensor Core Unit (Posit Version)
-- Project Name:   		Open TCU
-- Target Devices:		
-- Tool versions:    	ModelSim
-- Description:
--
----------------------------------------------------------------------------
-- Revisions:
--  REV:        Date:          			Description:
--  1.0.a       	14/01/2026      	Created Top level file
--  1.2.a           14/01/2026          Functional verification OK 
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

entity tensor_core_unit is
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
end tensor_core_unit;

architecture ar of tensor_core_unit is


	component dot_unit_core
		port(
				a_X0 : in std_logic_vector(31 downto 0);
				a_X1 : in std_logic_vector(31 downto 0);
				a_X2 : in std_logic_vector(31 downto 0);
				a_X3 : in std_logic_vector(31 downto 0);
				b_X0  : in std_logic_vector(31 downto 0);
				b_X1  : in std_logic_vector(31 downto 0);
				b_X2  : in std_logic_vector(31 downto 0);
				b_X3  : in std_logic_vector(31 downto 0);		
				c_X0: in std_logic_vector(31 downto 0);
				w_XX3: out std_logic_vector(31 downto 0)
		);
	end component;
	
begin
	
	
	DPU00: dot_unit_core port map(
								a_X0 => a_00,
								a_X1 => a_01,
								a_X2 => a_02,
								a_X3 => a_03,
								b_X0 => b_00,
								b_X1 => b_10,
								b_X2 => b_20,
								b_X3 => b_30,
								c_X0 => c_00,
								w_XX3 => w_003
							 );


	DPU01: dot_unit_core port map(
								a_X0 => a_00,
								a_X1 => a_01,
								a_X2 => a_02,
								a_X3 => a_03,
								b_X0 => b_01,
								b_X1 => b_11,
								b_X2 => b_21,
								b_X3 => b_31,		
								c_X0 => c_01,
								w_XX3 => w_013
							 );


	DPU02: dot_unit_core port map(
								a_X0 => a_00,
								a_X1 => a_01,
								a_X2 => a_02,
								a_X3 => a_03,
								b_X0 => b_02,
								b_X1 => b_12,
								b_X2 => b_22,
								b_X3 => b_32,		
								c_X0 => c_02,
								w_XX3 => w_023
							 );


	DPU03: dot_unit_core port map(
								a_X0 => a_00,
								a_X1 => a_01,
								a_X2 => a_02,
								a_X3 => a_03,
								b_X0 => b_03,
								b_X1 => b_13,
								b_X2 => b_23,
								b_X3 => b_33,		
								c_X0 => c_03,
								w_XX3 => w_033
							 );


	DPU10: dot_unit_core port map(
								a_X0 => a_10,
								a_X1 => a_11,
								a_X2 => a_12,
								a_X3 => a_13,
								b_X0 => b_00,
								b_X1 => b_10,
								b_X2 => b_20,
								b_X3 => b_30,		
								c_X0 => c_10,
								w_XX3 => w_103
							 );

	DPU11: dot_unit_core port map(
								a_X0 => a_10,
								a_X1 => a_11,
								a_X2 => a_12,
								a_X3 => a_13,
								b_X0 => b_01,
								b_X1 => b_11,
								b_X2 => b_21,
								b_X3 => b_31,		
								c_X0 => c_11,
								w_XX3 => w_113
							 );

	DPU12: dot_unit_core port map(
								a_X0 => a_10,
								a_X1 => a_11,
								a_X2 => a_12,
								a_X3 => a_13,
								b_X0 => b_02,
								b_X1 => b_12,
								b_X2 => b_22,
								b_X3 => b_32,		
								c_X0 => c_12,
								w_XX3 => w_123
							 );


	DPU13: dot_unit_core port map(
								a_X0 => a_10,
								a_X1 => a_11,
								a_X2 => a_12,
								a_X3 => a_13,
								b_X0 => b_03,
								b_X1 => b_13,
								b_X2 => b_23,
								b_X3 => b_33,		
								c_X0 => c_13,
								w_XX3 => w_133
							 );


	DPU20: dot_unit_core port map(
								a_X0 => a_20,
								a_X1 => a_21,
								a_X2 => a_22,
								a_X3 => a_23,
								b_X0 => b_00,
								b_X1 => b_10,
								b_X2 => b_20,
								b_X3 => b_30,		
								c_X0 => c_20,
								w_XX3 => w_203
							 );

	DPU21: dot_unit_core port map(
								a_X0 => a_20,
								a_X1 => a_21,
								a_X2 => a_22,
								a_X3 => a_23,
								b_X0 => b_01,
								b_X1 => b_11,
								b_X2 => b_21,
								b_X3 => b_31,		
								c_X0 => c_21,
								w_XX3 => w_213
							 );


	DPU22: dot_unit_core port map(
								a_X0 => a_20,
								a_X1 => a_21,
								a_X2 => a_22,
								a_X3 => a_23,
								b_X0 => b_02,
								b_X1 => b_12,
								b_X2 => b_22,
								b_X3 => b_32,		
								c_X0 => c_22,
								w_XX3 => w_223
							 );


	DPU23: dot_unit_core port map(
								a_X0 => a_20,
								a_X1 => a_21,
								a_X2 => a_22,
								a_X3 => a_23,
								b_X0 => b_03,
								b_X1 => b_13,
								b_X2 => b_23,
								b_X3 => b_33,		
								c_X0 => c_23,
								w_XX3 => w_233
							 );


	DPU30: dot_unit_core port map(
								a_X0 => a_30,
								a_X1 => a_31,
								a_X2 => a_32,
								a_X3 => a_33,
								b_X0 => b_00,
								b_X1 => b_10,
								b_X2 => b_20,
								b_X3 => b_30,
								c_X0 => c_30,
								w_XX3 => w_303
							 );


	DPU31: dot_unit_core port map(
								a_X0 => a_30,
								a_X1 => a_31,
								a_X2 => a_32,
								a_X3 => a_33,
								b_X0 => b_01,
								b_X1 => b_11,
								b_X2 => b_21,
								b_X3 => b_31,
								c_X0 => c_31,
								w_XX3 => w_313
							 );


	DPU32: dot_unit_core port map(
								a_X0 => a_30,
								a_X1 => a_31,
								a_X2 => a_32,
								a_X3 => a_33,
								b_X0 => b_02,
								b_X1 => b_12,
								b_X2 => b_22,
								b_X3 => b_32,
								c_X0 => c_32,
								w_XX3 => w_323
							 );

	DPU33: dot_unit_core port map(
								a_X0 => a_30,
								a_X1 => a_31,
								a_X2 => a_32,
								a_X3 => a_33,
								b_X0 => b_03,
								b_X1 => b_13,
								b_X2 => b_23,
								b_X3 => b_33,
								c_X0 => c_33,
								w_XX3 => w_333
							 );

end ar;
