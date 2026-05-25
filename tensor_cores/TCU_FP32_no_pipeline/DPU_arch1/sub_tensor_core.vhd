----------------------------------------------------------------------------
-- Company:         	Politecnico di Torino
-- Engineer:          	Josie E. Rodriguez Condia
--
-- Create Date:     		23/10/2022
-- Module Name:   	Sub-tensor Unit
-- Project Name:   	Open TCU
-- Target Devices:		
-- Tool versions:    	ModelSim
-- Description:
--
----------------------------------------------------------------------------
-- Revisions:
--  REV:        Date:          			Description:
--  1.0.a       	23/10/2022      	 	Created Top level file
----------------------------------------------------------------------------

-- The sub_tensor_core_unit process the vectorial 4X4 matrix multiplication
--



Library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.def_package.all;

entity sub_tensor_core is
	
	generic(
				size: natural:= 2;			-- I think it must be 2..
				long : natural := 32
				);

	port(
			-- original ones:
--				A_0X: in  operand_array(2**size - 1 downto 0)(long - 1 downto 0);			-- A_0X <= (0 => bus0, 1 => bus1, 2 => bus2, 3 => bus3);
--				A_1X: in  operand_array(2**size - 1 downto 0)(long - 1 downto 0);
--				A_2X: in  operand_array(2**size - 1 downto 0)(long - 1 downto 0);
--				A_3X: in  operand_array(2**size - 1 downto 0)(long - 1 downto 0);
--				B_0X: in  operand_array(2**size - 1 downto 0)(long - 1 downto 0);
--				B_1X: in  operand_array(2**size - 1 downto 0)(long - 1 downto 0);
--				B_2X: in  operand_array(2**size - 1 downto 0)(long - 1 downto 0);
--				B_3X: in  operand_array(2**size - 1 downto 0)(long - 1 downto 0);
--				C_0X: in  operand_array(2**size - 1 downto 0)(long - 1 downto 0);
--				C_1X: in  operand_array(2**size - 1 downto 0)(long - 1 downto 0);
--				C_2X: in  operand_array(2**size - 1 downto 0)(long - 1 downto 0);
--				C_3X: in operand_array(2**size - 1 downto 0)(long - 1 downto 0);
--				W_0X3: out operand_array(2**size - 1 downto 0)(long - 1 downto 0);
--				W_1X3: out operand_array(2**size - 1 downto 0)(long - 1 downto 0);
--				W_2X3: out operand_array(2**size - 1 downto 0)(long - 1 downto 0);
--				W_3X3: out operand_array(2**size - 1 downto 0)(long - 1 downto 0);

				-- modified for the synth version...(currently working the synthesis)

				A_0X: in  operand_array(2**size - 1 downto 0);					-- A_0X <= (0 => bus0, 1 => bus1, 2 => bus2, 3 => bus3);
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
				W_3X3: out operand_array(2**size - 1 downto 0);
			underflow, overflow :out std_logic
	);
end sub_tensor_core;


architecture ar of sub_tensor_core is

	-- Signals for the interconnection of the cores:

	signal underflow_0 :std_logic;
	signal underflow_1 :std_logic;
	signal underflow_2 :std_logic;
	signal underflow_3 :std_logic;
	signal underflow_4 :std_logic;
	signal underflow_5 :std_logic;
	signal underflow_6 :std_logic;
	signal underflow_7 :std_logic;
	signal underflow_8 :std_logic;
	signal underflow_9 :std_logic;
	signal underflow_10 :std_logic;
	signal underflow_11 :std_logic;
	signal underflow_12 :std_logic;
	signal underflow_13 :std_logic;
	signal underflow_14 :std_logic;
	signal underflow_15 :std_logic;
		
	signal overflow_0 :std_logic;
	signal overflow_1 :std_logic;
	signal overflow_2 :std_logic;
	signal overflow_3 :std_logic;
	signal overflow_4 :std_logic;
	signal overflow_5 :std_logic;
	signal overflow_6 :std_logic;
	signal overflow_7 :std_logic;
	signal overflow_8 :std_logic;
	signal overflow_9 :std_logic;
	signal overflow_10 :std_logic;
	signal overflow_11 :std_logic;
	signal overflow_12 :std_logic;
	signal overflow_13 :std_logic;
	signal overflow_14 :std_logic;
	signal overflow_15 :std_logic;

--	signal A_0X_s: operand_array(2**size - 1 downto 0);		-- temp definition for the analysis of the missing connections.

	
	-- remember to include the generic port to allow the size definition...

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

	-- description of the 16 cores...

	-- A00, B00, c00
	D_UNIT0: dot_unit_core generic map(
											long => long
											)
										port map(
											a_X0 => A_0X(0), 
											a_X1 => A_0X(1),
											a_X2 => A_0X(2),
											a_X3 => A_0X(3),
											b_X0  => B_0X(0),
											b_X1  => B_1X(0),
											b_X2  => B_2X(0),
											b_X3  => B_3X(0) ,
											c_X0 => C_0X(0),
											w_XX3 => W_0X3(0),
											underflow => underflow_0, 
											overflow => overflow_0
										);

	-- A00, B01, c10
	D_UNIT1: dot_unit_core generic map(
											long => long
											)
										port map(
											a_X0 => A_0X(0), 
											a_X1 => A_0X(1),
											a_X2 => A_0X(2),
											a_X3 => A_0X(3),
											b_X0  => B_0X(1),
											b_X1  => B_1X(1),
											b_X2  => B_2X(1),
											b_X3  => B_3X(1) ,
											c_X0 => C_1X(0),
											w_XX3 => W_0X3(1),
											underflow => underflow_1, 
											overflow => overflow_1
										);

	-- A00, B02, c20
	D_UNIT2: dot_unit_core generic map(
											long => long
											)
										port map(
											a_X0 => A_0X(0), 
											a_X1 => A_0X(1),
											a_X2 => A_0X(2),
											a_X3 => A_0X(3),
											b_X0  => B_0X(2),
											b_X1  => B_1X(2),
											b_X2  => B_2X(2),
											b_X3  => B_3X(2) ,
											c_X0 => C_2X(0),
											w_XX3 => W_0X3(2),
											underflow => underflow_2,
											overflow => overflow_2
										);


	-- A00, B03, c30
	D_UNIT3: dot_unit_core generic map(
											long => long
											)
										port map(
											a_X0 => A_0X(0), 
											a_X1 => A_0X(1),
											a_X2 => A_0X(2),
											a_X3 => A_0X(3),
											b_X0  => B_0X(3),
											b_X1  => B_1X(3),
											b_X2  => B_2X(3),
											b_X3  => B_3X(3) ,
											c_X0 => C_3X(0),
											w_XX3 => W_0X3(3),
											underflow => underflow_3,
											overflow => overflow_3
										);



	-- A10, B00, c01
	D_UNIT4: dot_unit_core generic map(
											long => long
											)
										port map(
											a_X0 => A_1X(0), 
											a_X1 => A_1X(1),
											a_X2 => A_1X(2),
											a_X3 => A_1X(3),
											b_X0  => B_0X(0),
											b_X1  => B_1X(0),
											b_X2  => B_2X(0),
											b_X3  => B_3X(0) ,
											c_X0 => C_0X(1),
											w_XX3 => W_1X3(0),
											underflow => underflow_4,
											overflow => overflow_4
										);



	-- A10, B01, c11
	D_UNIT5: dot_unit_core generic map(
											long => long
											)
										port map(
											a_X0 => A_1X(0), 
											a_X1 => A_1X(1),
											a_X2 => A_1X(2),
											a_X3 => A_1X(3),
											b_X0  => B_0X(1),
											b_X1  => B_1X(1),
											b_X2  => B_2X(1),
											b_X3  => B_3X(1) ,
											c_X0 => C_1X(1),
											w_XX3 => W_1X3(1),
											underflow => underflow_5,
											overflow => overflow_5
										);


	-- A10, B02, c21
	D_UNIT6: dot_unit_core generic map(
											long => long
											)
										port map(
											a_X0 => A_1X(0), 
											a_X1 => A_1X(1),
											a_X2 => A_1X(2),
											a_X3 => A_1X(3),
											b_X0  => B_0X(2),
											b_X1  => B_1X(2),
											b_X2  => B_2X(2),
											b_X3  => B_3X(2) ,
											c_X0 => C_2X(1),
											w_XX3 => W_1X3(2),
											underflow => underflow_6,
											overflow => overflow_6
										);


	-- A10, B03, c31
	D_UNIT7: dot_unit_core generic map(
											long => long
											)
										port map(
											a_X0 => A_1X(0), 
											a_X1 => A_1X(1),
											a_X2 => A_1X(2),
											a_X3 => A_1X(3),
											b_X0  => B_0X(3),
											b_X1  => B_1X(3),
											b_X2  => B_2X(3),
											b_X3  => B_3X(3) ,
											c_X0 => C_3X(1),
											w_XX3 => W_1X3(3), 
											underflow => underflow_7,
											overflow => overflow_7
										);



	-- A20, B00, c02
	D_UNIT8: dot_unit_core generic map(
											long => long
											)
										port map(
											a_X0 => A_2X(0), 
											a_X1 => A_2X(1),
											a_X2 => A_2X(2),
											a_X3 => A_2X(3),
											b_X0  => B_0X(0),
											b_X1  => B_1X(0),
											b_X2  => B_2X(0),
											b_X3  => B_3X(0) ,
											c_X0 => C_0X(2),
											w_XX3 => W_2X3(0),
											underflow => underflow_8,
											overflow => overflow_8
										);


	-- A20, B01, c12
	D_UNIT9: dot_unit_core generic map(
											long => long
											)
										port map(
											a_X0 => A_2X(0), 
											a_X1 => A_2X(1),
											a_X2 => A_2X(2),
											a_X3 => A_2X(3),
											b_X0  => B_0X(1),
											b_X1  => B_1X(1),
											b_X2  => B_2X(1),
											b_X3  => B_3X(1) ,
											c_X0 => C_1X(2),
											w_XX3 => W_2X3(1),
											underflow => underflow_9,
											overflow => overflow_9
										);


	-- A20, B02, c22
	D_UNIT10: dot_unit_core generic map(
											long => long
											)
										port map(
											a_X0 => A_2X(0), 
											a_X1 => A_2X(1),
											a_X2 => A_2X(2),
											a_X3 => A_2X(3),
											b_X0  => B_0X(2),
											b_X1  => B_1X(2),
											b_X2  => B_2X(2),
											b_X3  => B_3X(2) ,
											c_X0 => C_2X(2),
											w_XX3 => W_2X3(2),
											underflow => underflow_10,
											overflow => overflow_10
										);


	-- A20, B03, c32
	D_UNIT11: dot_unit_core generic map(
											long => long
											)
										port map(
											a_X0 => A_2X(0), 
											a_X1 => A_2X(1),
											a_X2 => A_2X(2),
											a_X3 => A_2X(3),
											b_X0  => B_0X(3),
											b_X1  => B_1X(3),
											b_X2  => B_2X(3),
											b_X3  => B_3X(3) ,
											c_X0 => C_3X(2),
											w_XX3 => W_2X3(3),
											underflow => underflow_11,
											overflow => overflow_11
										);



	-- A30, B00, c03
	D_UNIT12: dot_unit_core generic map(
											long => long
											)
										port map(
											a_X0 => A_3X(0), 
											a_X1 => A_3X(1),
											a_X2 => A_3X(2),
											a_X3 => A_3X(3),
											b_X0  => B_0X(0),
											b_X1  => B_1X(0),
											b_X2  => B_2X(0),
											b_X3  => B_3X(0) ,
											c_X0 => C_0X(3),
											w_XX3 => W_3X3(0),
											underflow => underflow_12,
											overflow => overflow_12
										);


	-- A30, B01, c13
	D_UNIT13: dot_unit_core generic map(
											long => long
											)
										port map(
											a_X0 => A_3X(0), 
											a_X1 => A_3X(1),
											a_X2 => A_3X(2),
											a_X3 => A_3X(3),
											b_X0  => B_0X(1),
											b_X1  => B_1X(1),
											b_X2  => B_2X(1),
											b_X3  => B_3X(1) ,
											c_X0 => C_1X(3),
											w_XX3 => W_3X3(1),
											underflow => underflow_13,
											overflow => overflow_13
										);


	-- A30, B02, c23
	D_UNIT14: dot_unit_core generic map(
											long => long
											)
										port map(
											a_X0 => A_3X(0), 
											a_X1 => A_3X(1),
											a_X2 => A_3X(2),
											a_X3 => A_3X(3),
											b_X0  => B_0X(2),
											b_X1  => B_1X(2),
											b_X2  => B_2X(2),
											b_X3  => B_3X(2) ,
											c_X0 => C_2X(3),
											w_XX3 => W_3X3(2), 
											underflow => underflow_14,
											overflow => overflow_14
										);

	-- A30, B03, c32
	D_UNIT15: dot_unit_core generic map(
											long => long
											)
										port map(
											a_X0 => A_3X(0), 
											a_X1 => A_3X(1),
											a_X2 => A_3X(2),
											a_X3 => A_3X(3),
											b_X0  => B_0X(3),
											b_X1  => B_1X(3),
											b_X2  => B_2X(3),
											b_X3  => B_3X(3) ,
											c_X0 => C_3X(3),
											w_XX3 => W_3X3(3),
											underflow => underflow_15,
											overflow => overflow_15
										);


	underflow <= ( (underflow_0 or underflow_1) or (underflow_2 or underflow_3) )  or ( ( ( (underflow_4 or underflow_5) or (underflow_6 or underflow_7) ) or ( (underflow_8 or underflow_9) or (underflow_10 or underflow_11) ) )  or ( (underflow_12 or underflow_13) or (underflow_14 or underflow_15) ) );
	overflow <= ( (overflow_0 or underflow_1) or (overflow_2 or overflow_3) )  or ( ( ( (overflow_4 or overflow_5) or (overflow_6 or overflow_7) ) or ( (overflow_8 or overflow_9) or (overflow_10 or overflow_11) ) )  or ( (overflow_12 or overflow_13) or (overflow_14 or overflow_15) ) );

end ar;
