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

entity dot_unit_coreINT is
	
	generic(
				long : natural := 16
				);

	port(
				a_X0 : in std_logic_vector(long-1 downto 0);
				a_X1 : in std_logic_vector(long-1 downto 0);
				a_X2 : in std_logic_vector(long-1 downto 0);
				a_X3 : in std_logic_vector(long-1 downto 0);
				b_X0 : in std_logic_vector(long-1 downto 0);
				b_X1 : in std_logic_vector(long-1 downto 0);
				b_X2 : in std_logic_vector(long-1 downto 0);
				b_X3 : in std_logic_vector(long-1 downto 0);		
				c_X0: in std_logic_vector((2*long)-1 downto 0);
				w_XX3: out std_logic_vector((2*long)-1 downto 0)
	);
end dot_unit_coreINT;

architecture ar of dot_unit_coreINT is

	-- Signals for the interconnection of the cores:
	signal a_X0_b_X0_s :std_logic_vector( (2*long)-1 downto 0);
	signal a_X1_b_X1_s :std_logic_vector( (2*long)-1 downto 0);
	signal a_X2_b_X2_s :std_logic_vector( (2*long)-1 downto 0);
	signal a_X3_b_X3_s :std_logic_vector( (2*long)-1 downto 0);
	signal c_XX_s :std_logic_vector((2*long)-1 downto 0);

	signal a_X0_b_X0_plus_a_X1_b_X1_unsigned_s: std_logic_vector((2*long)-1 downto 0);
	signal a_X2_b_X2_plus_a_X3_b_X3_unsigned_s: std_logic_vector((2*long)-1 downto 0);
	signal a_plus_b_unsigned_s: std_logic_vector((2*long)-1 downto 0);
	signal w_XX3_unsigned_s: std_logic_vector((2*long)-1 downto 0);

	--signal underflow_0 :std_logic;
	--signal underflow_1 :std_logic;
	--signal underflow_2 :std_logic;
	--signal underflow_3 :std_logic;
	--signal overflow_0 :std_logic;
	--signal overflow_1 :std_logic;
	--signal overflow_2 :std_logic;
	--signal overflow_3 :std_logic;
	
	-- remember to include the generic port to allow the size definition...
	component Multiplier
		port(
			A, B: in std_logic_vector( long-1 downto 0);
			P: out std_logic_vector( (2*long)-1  downto 0)
			);
	end component;

	component Adder
		generic(
			N : integer := 32
		);
		port(
			A, B: in std_logic_vector(N-1 downto 0);
			SUM: out std_logic_vector(N-1 downto 0)
		);
	end component;
	
begin

	c_XX_s <= c_X0;
	
	FMUL0: Multiplier port map(
														A => a_X0,
														B => b_X0,
														P => a_X0_b_X0_s);

	FMUL1: Multiplier port map(
														A => a_X1,
														B => b_X1,
														P => a_X1_b_X1_s);
	
	FMUL2: Multiplier port map(
														A => a_X2,
														B => b_X2,
														P => a_X2_b_X2_s);

	FMUL3: Multiplier port map(
														A => a_X3,
														B => b_X3,
														P => a_X3_b_X3_s);

-- adder (FADD) stage:

	ADDER0: Adder generic map(
														N =>2*long
														)
									 port map(
														A => a_X0_b_X0_s,
														B => a_X1_b_X1_s,
														SUM  => a_X0_b_X0_plus_a_X1_b_X1_unsigned_s 
									) ; 

	ADDER1: Adder generic map(
														N =>2*long
														)
									 port map(
														A => a_X2_b_X2_s,
														B => a_X3_b_X3_s,
														SUM =>  a_X2_b_X2_plus_a_X3_b_X3_unsigned_s
									);


	ADDER2: Adder generic map(
														N =>2*long
														)
									 port map(
														A => a_X0_b_X0_plus_a_X1_b_X1_unsigned_s ,
														B => a_X2_b_X2_plus_a_X3_b_X3_unsigned_s,
														SUM => a_plus_b_unsigned_s
									); 

	ADDER3: Adder generic map(
														N =>2*long
														)
									 port map(
														A => a_plus_b_unsigned_s,
														B => c_XX_s,
														SUM => w_XX3_unsigned_s
									 );
									 
	w_XX3 <= w_XX3_unsigned_s;

end ar;