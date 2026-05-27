-- The dot unit is the basic operation inside a tensor core unit and process the scalar product in a 4X4 matrix multiplication
--
--                         a_X0         b_X0                 a_X1        b_X1                 a_X2       b_X2           	 a_X3      b_X3		   c_X0
--	   					____|_________|____					____|_________|____				____|_________|____			  ____|_________|____     |
--			FMUL0	    |				  |			FMUL1	|		    	  |		FMUL2	|				  |		FMUL3 |					|     |
--						|		*         |					|		*   	  |				|		*	      |			  |		*		    |     |
--						|_________________|					|_________________|				|_________________|			  |_________________|     |
--	   					_________|______________________________|________________________________|______________________________|_________________|______
--			FADD	    |																															   |
--						|																+				                                               |
--						|______________________________________________________________________________________________________________________________|
--                                                                                                                                  |
--																																w_XX3

Library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TC_LNS is		-- signed version
	port(
			 	clk  : in std_logic;
			  	rst  : in std_logic;
				valid_in : in std_logic;
				A_00 : in std_logic_vector(15 downto 0);
				A_01 : in std_logic_vector(15 downto 0);
				A_02 : in std_logic_vector(15 downto 0);
				A_03 : in std_logic_vector(15 downto 0);
				A_10 : in std_logic_vector(15 downto 0);
				A_11 : in std_logic_vector(15 downto 0);
				A_12 : in std_logic_vector(15 downto 0);
				A_13 : in std_logic_vector(15 downto 0);
				A_20 : in std_logic_vector(15 downto 0);
				A_21 : in std_logic_vector(15 downto 0);
				A_22 : in std_logic_vector(15 downto 0);
				A_23 : in std_logic_vector(15 downto 0);
				A_30 : in std_logic_vector(15 downto 0);
				A_31 : in std_logic_vector(15 downto 0);
				A_32 : in std_logic_vector(15 downto 0);
				A_33 : in std_logic_vector(15 downto 0);
				B_00 : in std_logic_vector(15 downto 0);
				B_01 : in std_logic_vector(15 downto 0);
				B_02 : in std_logic_vector(15 downto 0);
				B_03 : in std_logic_vector(15 downto 0);
				B_10 : in std_logic_vector(15 downto 0);
				B_11 : in std_logic_vector(15 downto 0);
				B_12 : in std_logic_vector(15 downto 0);
				B_13 : in std_logic_vector(15 downto 0);
				B_20 : in std_logic_vector(15 downto 0);
				B_21 : in std_logic_vector(15 downto 0);
				B_22 : in std_logic_vector(15 downto 0);
				B_23 : in std_logic_vector(15 downto 0);
				B_30 : in std_logic_vector(15 downto 0);
				B_31 : in std_logic_vector(15 downto 0);
				B_32 : in std_logic_vector(15 downto 0);
				B_33 : in std_logic_vector(15 downto 0);
				C_00: in std_logic_vector(15 downto 0);
				C_01: in std_logic_vector(15 downto 0);
				C_02: in std_logic_vector(15 downto 0);
				C_03: in std_logic_vector(15 downto 0);
				C_10: in std_logic_vector(15 downto 0);
				C_11: in std_logic_vector(15 downto 0);
				C_12: in std_logic_vector(15 downto 0);
				C_13: in std_logic_vector(15 downto 0);
				C_20: in std_logic_vector(15 downto 0);
				C_21: in std_logic_vector(15 downto 0);
				C_22: in std_logic_vector(15 downto 0);
				C_23: in std_logic_vector(15 downto 0);
				C_30: in std_logic_vector(15 downto 0);
				C_31: in std_logic_vector(15 downto 0);
				C_32: in std_logic_vector(15 downto 0);
				C_33: in std_logic_vector(15 downto 0);
				w_003: out std_logic_vector(15 downto 0);
				w_013: out std_logic_vector(15 downto 0);
				w_023: out std_logic_vector(15 downto 0);
				w_033: out std_logic_vector(15 downto 0);
				w_103: out std_logic_vector(15 downto 0);
				w_113: out std_logic_vector(15 downto 0);
				w_123: out std_logic_vector(15 downto 0);
				w_133: out std_logic_vector(15 downto 0);
				w_203: out std_logic_vector(15 downto 0);
				w_213: out std_logic_vector(15 downto 0);
				w_223: out std_logic_vector(15 downto 0);
				w_233: out std_logic_vector(15 downto 0);
				w_303: out std_logic_vector(15 downto 0);
				w_313: out std_logic_vector(15 downto 0);
				w_323: out std_logic_vector(15 downto 0);
				w_333: out std_logic_vector(15 downto 0);
				valid_out: out std_logic
	);
end TC_LNS;

architecture ar of TC_LNS is

	-- Signals for the interconnection of the cores:
	signal a_X0_b_X0_s :std_logic_vector( 15 downto 0);
	signal a_X1_b_X1_s :std_logic_vector( 15 downto 0);
	signal a_X2_b_X2_s :std_logic_vector( 15 downto 0);
	signal a_X3_b_X3_s :std_logic_vector( 15 downto 0);
	signal c_XX_s :std_logic_vector(15 downto 0);

	signal a_X0_b_X0_plus_a_X1_b_X1_unsigned_s: std_logic_vector(15 downto 0);
	signal a_X2_b_X2_plus_a_X3_b_X3_unsigned_s: std_logic_vector(15 downto 0);
	signal a_plus_b_unsigned_s: std_logic_vector(15 downto 0);
	signal w_XX3_unsigned_s: std_logic_vector(15 downto 0);

	signal clk_s : std_logic;
	signal rst_s : std_logic;
	

component dot_unit_core_LNS is port(
									clk  : in  STD_LOGIC;
									rst  : in  std_logic;
									a_X0 : in  std_logic_vector(15 downto 0);
									a_X1 : in  std_logic_vector(15 downto 0);
									a_X2 : in  std_logic_vector(15 downto 0);
									a_X3 : in  std_logic_vector(15 downto 0);
									b_X0 : in  std_logic_vector(15 downto 0);
									b_X1 : in  std_logic_vector(15 downto 0);
									b_X2 : in  std_logic_vector(15 downto 0);
									b_X3 : in  std_logic_vector(15 downto 0);		
									c_X0 : in  std_logic_vector(15 downto 0);
									w_XX3: out std_logic_vector(15 downto 0)
								);
end component;


constant PIPE_DEPTH : integer := 13;
signal valid_pipe : std_logic_vector(PIPE_DEPTH-1 downto 0);

begin

	clk_s <= clk;
	rst_s <= rst;


	-- dummy pipe ack (might cause issues in high speed clks for real deployments)

	process(clk_s)
	begin
	  if rising_edge(clk_s) then
		if rst_s = '1' then
		  valid_pipe <= (others => '0');
		else
		  valid_pipe(0) <= valid_in;
		  for i in 1 to PIPE_DEPTH-1 loop
		    valid_pipe(i) <= valid_pipe(i-1);
		  end loop;
		end if;
	  end if;
	end process;

	valid_out <= valid_pipe(PIPE_DEPTH-1);



	-- description of the (4x4 array) 16 cores...


	-- A00, B00, c00
	D_UNIT0: dot_unit_core_LNS port map(
									clk  	=> clk_s,
									rst  	=> rst_s,
									a_X0 	=> A_00,
									a_X1	=> A_01,
									a_X2 	=> A_02,
									a_X3 	=> A_03,
									b_X0 	=> B_00,
									b_X1 	=> B_10,
									b_X2 	=> B_20,
									b_X3 	=> B_30,
									c_X0 	=> C_00,
									w_XX3	=> W_003
								);

	-- A00, B01, c10
	D_UNIT1: dot_unit_core_LNS port map(
									clk => clk_s,
									rst => rst_s,
									a_X0 => A_00,
									a_X1 => A_01,
									a_X2 => A_02,
									a_X3 => A_03,
									b_X0 => B_01,
									b_X1 => B_11,
									b_X2 => B_21,
									b_X3 => B_31,
									c_X0 => C_10,
									w_XX3 =>W_013
								);

	-- A00, B02, c20
	D_UNIT2: dot_unit_core_LNS port map(
									clk => clk_s,
									rst => rst_s,
									a_X0 => A_00,
									a_X1 => A_01,
									a_X2 => A_02,
									a_X3 => A_03,
									b_X0 => B_02,
									b_X1 => B_12,
									b_X2 => B_22,
									b_X3 => B_32,
									c_X0 => C_20,
									w_XX3 =>W_023
								);

	-- A00, B03, c30
	D_UNIT3: dot_unit_core_LNS port map(
									clk => clk_s,
									rst => rst_s,
									a_X0 => A_00,
									a_X1 => A_01,
									a_X2 => A_02,
									a_X3 => A_03,
									b_X0 => B_03,
									b_X1 => B_13,
									b_X2 => B_23,
									b_X3 => B_33,
									c_X0 => C_30,
									w_XX3 =>W_033
								);
	
	-- A10, B00, c01
	D_UNIT4: dot_unit_core_LNS port map(
									clk => clk_s,
									rst => rst_s,
									a_X0 => A_10,
									a_X1 => A_11,
									a_X2 => A_12,
									a_X3 => A_13,
									b_X0 => B_00,
									b_X1 => B_10,
									b_X2 => B_20,
									b_X3 => B_30,
									c_X0 => C_01,
									w_XX3 =>W_103
								);
	
	-- A10, B01, c11
	D_UNIT5: dot_unit_core_LNS port map(
									clk => clk_s,
									rst => rst_s,
									a_X0 => A_10,
									a_X1 => A_11,
									a_X2 => A_12,
									a_X3 => A_13,
									b_X0 => B_01,
									b_X1 => B_11,
									b_X2 => B_21,
									b_X3 => B_31,
									c_X0 => C_11,
									w_XX3 =>W_113
								);

	-- A10, B02, c21
	D_UNIT6: dot_unit_core_LNS port map(
									clk => clk_s,
									rst => rst_s,
									a_X0 => A_10,
									a_X1 => A_11,
									a_X2 => A_12,
									a_X3 => A_13,
									b_X0 => B_02,
									b_X1 => B_12,
									b_X2 => B_22,
									b_X3 => B_32,
									c_X0 => C_21,
									w_XX3 =>W_123
								);

	-- A10, B03, c31
	D_UNIT7: dot_unit_core_LNS port map(
									clk => clk_s,
									rst => rst_s,
									a_X0 => A_10,
									a_X1 => A_11,
									a_X2 => A_12,
									a_X3 => A_13,
									b_X0 => B_03,
									b_X1 => B_13,
									b_X2 => B_23,
									b_X3 => B_33,
									c_X0 => C_31,
									w_XX3 =>W_133
								);

	-- A20, B00, c02
	D_UNIT8: dot_unit_core_LNS port map(
									clk => clk_s,
									rst => rst_s,
									a_X0 => A_20,
									a_X1 => A_21,
									a_X2 => A_22,
									a_X3 => A_23,
									b_X0 => B_00,
									b_X1 => B_10,
									b_X2 => B_20,
									b_X3 => B_30,
									c_X0 => C_02,
									w_XX3 =>W_203
								);

	-- A20, B01, c12
	D_UNIT9: dot_unit_core_LNS port map(
									clk => clk_s,
									rst => rst_s,
									a_X0 => A_20,
									a_X1 => A_21,
									a_X2 => A_22,
									a_X3 => A_23,
									b_X0 => B_01,
									b_X1 => B_11,
									b_X2 => B_21,
									b_X3 => B_31,
									c_X0 => C_12,
									w_XX3 =>W_213
								);

	-- A20, B02, c22
	D_UNIT10: dot_unit_core_LNS port map(
									clk => clk_s,
									rst => rst_s,
									a_X0 => A_20,
									a_X1 => A_21,
									a_X2 => A_22,
									a_X3 => A_23,
									b_X0 => B_02,
									b_X1 => B_12,
									b_X2 => B_22,
									b_X3 => B_32,
									c_X0 => C_22,
									w_XX3 =>W_223
								);

	-- A20, B03, c32
	D_UNIT11: dot_unit_core_LNS port map(
									clk => clk_s,
									rst => rst_s,
									a_X0 => A_20,
									a_X1 => A_21,
									a_X2 => A_22,
									a_X3 => A_23,
									b_X0 => B_03,
									b_X1 => B_13,
									b_X2 => B_23,
									b_X3 => B_33,
									c_X0 => C_32,
									w_XX3 =>W_233
								);

	-- A30, B00, c03
	D_UNIT12: dot_unit_core_LNS port map(
									clk => clk_s,
									rst => rst_s,
									a_X0 => A_30,
									a_X1 => A_31,
									a_X2 => A_32,
									a_X3 => A_33,
									b_X0 => B_00,
									b_X1 => B_10,
									b_X2 => B_20,
									b_X3 => B_30,
									c_X0 => C_03,
									w_XX3 =>W_303
								);

	-- A30, B01, c13
	D_UNIT13: dot_unit_core_LNS port map(
									clk => clk_s,
									rst => rst_s,
									a_X0 => A_30,
									a_X1 => A_31,
									a_X2 => A_32,
									a_X3 => A_33,
									b_X0 => B_01,
									b_X1 => B_11,
									b_X2 => B_21,
									b_X3 => B_31,
									c_X0 => C_13,
									w_XX3 =>W_313
								);

	-- A30, B02, c23
	D_UNIT14: dot_unit_core_LNS port map(
									clk => clk_s,
									rst => rst_s,
									a_X0 => A_30,
									a_X1 => A_31,
									a_X2 => A_32,
									a_X3 => A_33,
									b_X0 => B_02,
									b_X1 => B_12,
									b_X2 => B_22,
									b_X3 => B_32,
									c_X0 => C_23,
									w_XX3 =>W_323
								);

	-- A30, B03, c32
	D_UNIT15: dot_unit_core_LNS port map(
									clk => clk_s,
									rst => rst_s,
									a_X0 => A_30,
									a_X1 => A_31,
									a_X2 => A_32,
									a_X3 => A_33,
									b_X0 => B_03,
									b_X1 => B_13,
									b_X2 => B_23,
									b_X3 => B_33,
									c_X0 => C_33,
									w_XX3 =>W_333
								);

end ar;
