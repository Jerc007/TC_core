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

entity dot_unit_core_LNS is port(
									clk  : in STD_LOGIC;
									rst  : in std_logic;
									a_X0 : in std_logic_vector(15 downto 0);
									a_X1 : in std_logic_vector(15 downto 0);
									a_X2 : in std_logic_vector(15 downto 0);
									a_X3 : in std_logic_vector(15 downto 0);
									b_X0 : in std_logic_vector(15 downto 0);
									b_X1 : in std_logic_vector(15 downto 0);
									b_X2 : in std_logic_vector(15 downto 0);
									b_X3 : in std_logic_vector(15 downto 0);		
									c_X0 : in std_logic_vector(15 downto 0);
									w_XX3: out std_logic_vector(15 downto 0)
								);
end dot_unit_core_LNS;

architecture ar of dot_unit_core_LNS is

	-- Signals for the interconnection of the cores:
	signal a_X0_b_X0_s :std_logic_vector(15 downto 0);
	signal a_X1_b_X1_s :std_logic_vector(15 downto 0);
	signal a_X2_b_X2_s :std_logic_vector(15 downto 0);
	signal a_X3_b_X3_s :std_logic_vector(15 downto 0);
	signal c_XX_s :std_logic_vector(15 downto 0);

	signal a_X0_b_X0_plus_a_X1_b_X1_unsigned_s: std_logic_vector(15 downto 0);
	signal a_X2_b_X2_plus_a_X3_b_X3_unsigned_s: std_logic_vector(15 downto 0);
	signal a_plus_b_unsigned_s: std_logic_vector(15 downto 0);
	signal w_XX3_unsigned_s: std_logic_vector(15 downto 0);


	-- remember to include the generic port to allow the size definition...
	component LNSAddSub_4_9 is
  		port( 
				clk_p	: in  std_logic;
				rst_p	: in  std_logic;
				nA 		: in  std_logic_vector(15 downto 0);
		    	nB 		: in  std_logic_vector(15 downto 0);
		    	nR 		: out  std_logic_vector(15 downto 0)
			);
	end component;

	component LNSMul_4_9 is
   		port(
				clk 	: in std_logic;
				rst 	: in std_logic;
		      	nA  	: in  std_logic_vector(15 downto 0);
		      	nB  	: in  std_logic_vector(15 downto 0);
		      	nR  	: out  std_logic_vector(15 downto 0)
			);
		end component;
	
begin

    process(clk)
    begin
        if rising_edge(clk) then
        	if rst = '1' then
				w_XX3 <= (others => '0');
    		else
				w_XX3 <= w_XX3_unsigned_s;
			end if;
        end if;
    end process;

	c_XX_s <= c_X0;


	FMUL0: LNSMul_4_9 port map(
								clk => clk,
								rst => rst,
							  	nA  => a_X0,
							  	nB  => b_X0,
							  	nR  => a_X0_b_X0_s
							  );

	FMUL1: LNSMul_4_9 port map(
								clk => clk,
								rst => rst,
							  	nA  => a_X1,
							  	nB  => b_X1,
							  	nR  => a_X1_b_X1_s
							  );

	FMUL2: LNSMul_4_9 port map(
								clk => clk,
								rst => rst,
							  	nA  => a_X2,
							  	nB  => b_X2,
							  	nR  => a_X2_b_X2_s
							  );

	FMUL3: LNSMul_4_9 port map(
								clk => clk,
								rst => rst,
							  	nA  => a_X3,
							  	nB  => b_X3,
							  	nR  => a_X3_b_X3_s
							  );


-- adder (FADD) stage:

	ADDER0: LNSAddSub_4_9 port map( 
									clk_p => clk,
									rst_p => rst,
									nA 	  => a_X0_b_X0_s,
									nB 	  => a_X1_b_X1_s,
									nR 	  => a_X0_b_X0_plus_a_X1_b_X1_unsigned_s
								  );

	ADDER1: LNSAddSub_4_9 port map( 
									clk_p => clk,
									rst_p => rst,
									nA 	  => a_X2_b_X2_s,
									nB 	  => a_X3_b_X3_s,
									nR 	  => a_X2_b_X2_plus_a_X3_b_X3_unsigned_s
								  );

	ADDER2: LNSAddSub_4_9 port map( 
									clk_p => clk,
									rst_p => rst,
									nA 	  => a_X0_b_X0_plus_a_X1_b_X1_unsigned_s,
									nB 	  => a_X2_b_X2_plus_a_X3_b_X3_unsigned_s,
									nR 	  => a_plus_b_unsigned_s
								  );

	ADDER3: LNSAddSub_4_9 port map( 
									clk_p => clk,
									rst_p => rst,
									nA 	  => a_plus_b_unsigned_s,
									nB 	  => c_XX_s,
									nR 	  => w_XX3_unsigned_s
								  );

end ar;
