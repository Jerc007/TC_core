--------------------------------------------------------------------------------
--                       Normalizer_ZO_30_30_30_F0_uid6
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin, (2007-2020)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X OZb
-- Output signals: Count R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity Normalizer_ZO_30_30_30_F0_uid6 is
    port (X : in  std_logic_vector(29 downto 0);
          OZb : in  std_logic;
          Count : out  std_logic_vector(4 downto 0);
          R : out  std_logic_vector(29 downto 0)   );
end entity;

architecture arch of Normalizer_ZO_30_30_30_F0_uid6 is
signal level5 :  std_logic_vector(29 downto 0);
signal sozb :  std_logic;
signal count4 :  std_logic;
signal level4 :  std_logic_vector(29 downto 0);
signal count3 :  std_logic;
signal level3 :  std_logic_vector(29 downto 0);
signal count2 :  std_logic;
signal level2 :  std_logic_vector(29 downto 0);
signal count1 :  std_logic;
signal level1 :  std_logic_vector(29 downto 0);
signal count0 :  std_logic;
signal level0 :  std_logic_vector(29 downto 0);
signal sCount :  std_logic_vector(4 downto 0);
begin
   level5 <= X ;
   sozb<= OZb;
   count4<= '1' when level5(29 downto 14) = (29 downto 14=>sozb) else '0';
   level4<= level5(29 downto 0) when count4='0' else level5(13 downto 0) & (15 downto 0 => '0');

   count3<= '1' when level4(29 downto 22) = (29 downto 22=>sozb) else '0';
   level3<= level4(29 downto 0) when count3='0' else level4(21 downto 0) & (7 downto 0 => '0');

   count2<= '1' when level3(29 downto 26) = (29 downto 26=>sozb) else '0';
   level2<= level3(29 downto 0) when count2='0' else level3(25 downto 0) & (3 downto 0 => '0');

   count1<= '1' when level2(29 downto 28) = (29 downto 28=>sozb) else '0';
   level1<= level2(29 downto 0) when count1='0' else level2(27 downto 0) & (1 downto 0 => '0');

   count0<= '1' when level1(29 downto 29) = (29 downto 29=>sozb) else '0';
   level0<= level1(29 downto 0) when count0='0' else level1(28 downto 0) & (0 downto 0 => '0');

   R <= level0;
   sCount <= count4 & count3 & count2 & count1 & count0;
   Count <= sCount;
end architecture;

--------------------------------------------------------------------------------
--                       PositFastDecoder_32_2_F0_uid4
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Raul Murillo (2021)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X
-- Output signals: Sign SF Frac NZN

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity PositFastDecoder_32_2_F0_uid4 is
    port (X : in  std_logic_vector(31 downto 0);
          Sign : out  std_logic;
          SF : out  std_logic_vector(7 downto 0);
          Frac : out  std_logic_vector(26 downto 0);
          NZN : out  std_logic   );
end entity;

architecture arch of PositFastDecoder_32_2_F0_uid4 is
   component Normalizer_ZO_30_30_30_F0_uid6 is
      port ( X : in  std_logic_vector(29 downto 0);
             OZb : in  std_logic;
             Count : out  std_logic_vector(4 downto 0);
             R : out  std_logic_vector(29 downto 0)   );
   end component;

signal sgn :  std_logic;
signal pNZN :  std_logic;
signal rc :  std_logic;
signal regPosit :  std_logic_vector(29 downto 0);
signal regLength :  std_logic_vector(4 downto 0);
signal shiftedPosit :  std_logic_vector(29 downto 0);
signal k :  std_logic_vector(5 downto 0);
signal sgnVect :  std_logic_vector(1 downto 0);
signal exp :  std_logic_vector(1 downto 0);
signal pSF :  std_logic_vector(7 downto 0);
signal pFrac :  std_logic_vector(26 downto 0);
begin
--------------------------- Start of vhdl generation ---------------------------
--------------------------- Sign bit & special cases ---------------------------
   sgn <= X(31);
   pNZN <= '0' when (X(30 downto 0) = "0000000000000000000000000000000") else '1';
-------------- Count leading zeros/ones of regime & shift it out --------------
   rc <= X(30);
   regPosit <= X(29 downto 0);
   RegimeCounter: Normalizer_ZO_30_30_30_F0_uid6
      port map ( OZb => rc,
                 X => regPosit,
                 Count => regLength,
                 R => shiftedPosit);
----------------- Determine the scaling factor - regime & exp -----------------
   k <= "0" & regLength when rc /= sgn else "1" & NOT(regLength);
   sgnVect <= (others => sgn);
   exp <= shiftedPosit(28 downto 27) XOR sgnVect;
   pSF <= k & exp;
------------------------------- Extract fraction -------------------------------
   pFrac <= shiftedPosit(26 downto 0);
   Sign <= sgn;
   SF <= pSF;
   Frac <= pFrac;
   NZN <= pNZN;
---------------------------- End of vhdl generation ----------------------------
end architecture;

--------------------------------------------------------------------------------
--                      Normalizer_ZO_30_30_30_F0_uid10
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin, (2007-2020)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X OZb
-- Output signals: Count R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity Normalizer_ZO_30_30_30_F0_uid10 is
    port (X : in  std_logic_vector(29 downto 0);
          OZb : in  std_logic;
          Count : out  std_logic_vector(4 downto 0);
          R : out  std_logic_vector(29 downto 0)   );
end entity;

architecture arch of Normalizer_ZO_30_30_30_F0_uid10 is
signal level5 :  std_logic_vector(29 downto 0);
signal sozb :  std_logic;
signal count4 :  std_logic;
signal level4 :  std_logic_vector(29 downto 0);
signal count3 :  std_logic;
signal level3 :  std_logic_vector(29 downto 0);
signal count2 :  std_logic;
signal level2 :  std_logic_vector(29 downto 0);
signal count1 :  std_logic;
signal level1 :  std_logic_vector(29 downto 0);
signal count0 :  std_logic;
signal level0 :  std_logic_vector(29 downto 0);
signal sCount :  std_logic_vector(4 downto 0);
begin
   level5 <= X ;
   sozb<= OZb;
   count4<= '1' when level5(29 downto 14) = (29 downto 14=>sozb) else '0';
   level4<= level5(29 downto 0) when count4='0' else level5(13 downto 0) & (15 downto 0 => '0');

   count3<= '1' when level4(29 downto 22) = (29 downto 22=>sozb) else '0';
   level3<= level4(29 downto 0) when count3='0' else level4(21 downto 0) & (7 downto 0 => '0');

   count2<= '1' when level3(29 downto 26) = (29 downto 26=>sozb) else '0';
   level2<= level3(29 downto 0) when count2='0' else level3(25 downto 0) & (3 downto 0 => '0');

   count1<= '1' when level2(29 downto 28) = (29 downto 28=>sozb) else '0';
   level1<= level2(29 downto 0) when count1='0' else level2(27 downto 0) & (1 downto 0 => '0');

   count0<= '1' when level1(29 downto 29) = (29 downto 29=>sozb) else '0';
   level0<= level1(29 downto 0) when count0='0' else level1(28 downto 0) & (0 downto 0 => '0');

   R <= level0;
   sCount <= count4 & count3 & count2 & count1 & count0;
   Count <= sCount;
end architecture;

--------------------------------------------------------------------------------
--                       PositFastDecoder_32_2_F0_uid8
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Raul Murillo (2021)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X
-- Output signals: Sign SF Frac NZN

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity PositFastDecoder_32_2_F0_uid8 is
    port (X : in  std_logic_vector(31 downto 0);
          Sign : out  std_logic;
          SF : out  std_logic_vector(7 downto 0);
          Frac : out  std_logic_vector(26 downto 0);
          NZN : out  std_logic   );
end entity;

architecture arch of PositFastDecoder_32_2_F0_uid8 is
   component Normalizer_ZO_30_30_30_F0_uid10 is
      port ( X : in  std_logic_vector(29 downto 0);
             OZb : in  std_logic;
             Count : out  std_logic_vector(4 downto 0);
             R : out  std_logic_vector(29 downto 0)   );
   end component;

signal sgn :  std_logic;
signal pNZN :  std_logic;
signal rc :  std_logic;
signal regPosit :  std_logic_vector(29 downto 0);
signal regLength :  std_logic_vector(4 downto 0);
signal shiftedPosit :  std_logic_vector(29 downto 0);
signal k :  std_logic_vector(5 downto 0);
signal sgnVect :  std_logic_vector(1 downto 0);
signal exp :  std_logic_vector(1 downto 0);
signal pSF :  std_logic_vector(7 downto 0);
signal pFrac :  std_logic_vector(26 downto 0);
begin
--------------------------- Start of vhdl generation ---------------------------
--------------------------- Sign bit & special cases ---------------------------
   sgn <= X(31);
   pNZN <= '0' when (X(30 downto 0) = "0000000000000000000000000000000") else '1';
-------------- Count leading zeros/ones of regime & shift it out --------------
   rc <= X(30);
   regPosit <= X(29 downto 0);
   RegimeCounter: Normalizer_ZO_30_30_30_F0_uid10
      port map ( OZb => rc,
                 X => regPosit,
                 Count => regLength,
                 R => shiftedPosit);
----------------- Determine the scaling factor - regime & exp -----------------
   k <= "0" & regLength when rc /= sgn else "1" & NOT(regLength);
   sgnVect <= (others => sgn);
   exp <= shiftedPosit(28 downto 27) XOR sgnVect;
   pSF <= k & exp;
------------------------------- Extract fraction -------------------------------
   pFrac <= shiftedPosit(26 downto 0);
   Sign <= sgn;
   SF <= pSF;
   Frac <= pFrac;
   NZN <= pNZN;
---------------------------- End of vhdl generation ----------------------------
end architecture;

--------------------------------------------------------------------------------
--                           IntMultiplier_F0_uid12
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Martin Kumm, Florent de Dinechin, Kinga Illyes, Bogdan Popa, Bogdan Pasca, 2012
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library std;
use std.textio.all;
library work;

entity IntMultiplier_F0_uid12 is
    port (X : in  std_logic_vector(28 downto 0);
          Y : in  std_logic_vector(28 downto 0);
          R : out  std_logic_vector(57 downto 0)   );
end entity;

architecture arch of IntMultiplier_F0_uid12 is
signal XX_m13 :  std_logic_vector(28 downto 0);
signal YY_m13 :  std_logic_vector(28 downto 0);
signal XX :  signed(-1+29 downto 0);
signal YY :  signed(-1+29 downto 0);
signal RR :  signed(-1+58 downto 0);
begin
   XX_m13 <= X ;
   YY_m13 <= Y ;
   XX <= signed(X);
   YY <= signed(Y);
   RR <= XX*YY;
   R <= std_logic_vector(RR(57 downto 0));
end architecture;

--------------------------------------------------------------------------------
--                  RightShifterSticky31_by_max_31_F0_uid17
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca (2008-2011), Florent de Dinechin (2008-2019)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X S padBit
-- Output signals: R Sticky

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity RightShifterSticky31_by_max_31_F0_uid17 is
    port (X : in  std_logic_vector(30 downto 0);
          S : in  std_logic_vector(4 downto 0);
          padBit : in  std_logic;
          R : out  std_logic_vector(30 downto 0);
          Sticky : out  std_logic   );
end entity;

architecture arch of RightShifterSticky31_by_max_31_F0_uid17 is
signal ps :  std_logic_vector(4 downto 0);
signal Xpadded :  std_logic_vector(30 downto 0);
signal level5 :  std_logic_vector(30 downto 0);
signal stk4 :  std_logic;
signal level4 :  std_logic_vector(30 downto 0);
signal stk3 :  std_logic;
signal level3 :  std_logic_vector(30 downto 0);
signal stk2 :  std_logic;
signal level2 :  std_logic_vector(30 downto 0);
signal stk1 :  std_logic;
signal level1 :  std_logic_vector(30 downto 0);
signal stk0 :  std_logic;
signal level0 :  std_logic_vector(30 downto 0);
begin
   ps<= S;
   Xpadded <= X;
   level5<= Xpadded;
   stk4 <= '1' when (level5(15 downto 0)/="0000000000000000" and ps(4)='1')   else '0';
   level4 <=  level5 when  ps(4)='0'    else (15 downto 0 => padBit) & level5(30 downto 16);
   stk3 <= '1' when (level4(7 downto 0)/="00000000" and ps(3)='1') or stk4 ='1'   else '0';
   level3 <=  level4 when  ps(3)='0'    else (7 downto 0 => padBit) & level4(30 downto 8);
   stk2 <= '1' when (level3(3 downto 0)/="0000" and ps(2)='1') or stk3 ='1'   else '0';
   level2 <=  level3 when  ps(2)='0'    else (3 downto 0 => padBit) & level3(30 downto 4);
   stk1 <= '1' when (level2(1 downto 0)/="00" and ps(1)='1') or stk2 ='1'   else '0';
   level1 <=  level2 when  ps(1)='0'    else (1 downto 0 => padBit) & level2(30 downto 2);
   stk0 <= '1' when (level1(0 downto 0)/="0" and ps(0)='1') or stk1 ='1'   else '0';
   level0 <=  level1 when  ps(0)='0'    else (0 downto 0 => padBit) & level1(30 downto 1);
   R <= level0;
   Sticky <= stk0;
end architecture;

--------------------------------------------------------------------------------
--                       PositFastEncoder_32_2_F0_uid15
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Raul Murillo (2021)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: Sign SF Frac Guard Sticky NZN
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity PositFastEncoder_32_2_F0_uid15 is
    port (Sign : in  std_logic;
          SF : in  std_logic_vector(8 downto 0);
          Frac : in  std_logic_vector(26 downto 0);
          Guard : in  std_logic;
          Sticky : in  std_logic;
          NZN : in  std_logic;
          R : out  std_logic_vector(31 downto 0)   );
end entity;

architecture arch of PositFastEncoder_32_2_F0_uid15 is
   component RightShifterSticky31_by_max_31_F0_uid17 is
      port ( X : in  std_logic_vector(30 downto 0);
             S : in  std_logic_vector(4 downto 0);
             padBit : in  std_logic;
             R : out  std_logic_vector(30 downto 0);
             Sticky : out  std_logic   );
   end component;

signal rc :  std_logic;
signal rcVect :  std_logic_vector(5 downto 0);
signal k :  std_logic_vector(5 downto 0);
signal sgnVect :  std_logic_vector(1 downto 0);
signal exp :  std_logic_vector(1 downto 0);
signal ovf :  std_logic;
signal regValue :  std_logic_vector(4 downto 0);
signal regNeg :  std_logic;
signal padBit :  std_logic;
signal inputShifter :  std_logic_vector(30 downto 0);
signal shiftedPosit :  std_logic_vector(30 downto 0);
signal stkBit :  std_logic;
signal unroundedPosit :  std_logic_vector(30 downto 0);
signal lsb :  std_logic;
signal rnd :  std_logic;
signal stk :  std_logic;
signal round :  std_logic;
signal roundedPosit :  std_logic_vector(30 downto 0);
signal unsignedPosit :  std_logic_vector(30 downto 0);
begin
--------------------------- Start of vhdl generation ---------------------------
----------------------------- Get value of regime -----------------------------
   rc <= SF(SF'high);
   rcVect <= (others => rc);
   k <= SF(7 downto 2) XOR rcVect;
   sgnVect <= (others => Sign);
   exp <= SF(1 downto 0) XOR sgnVect;
   -- Check for regime overflow
   ovf <= '1' when (k > "011101") else '0';
   regValue <= k(4 downto 0) when ovf = '0' else "11110";
-------------- Generate regime - shift out exponent and fraction --------------
   regNeg <= Sign XOR rc;
   padBit <= NOT(regNeg);
   inputShifter <= regNeg & exp & Frac & Guard;
   RegimeGenerator: RightShifterSticky31_by_max_31_F0_uid17
      port map ( S => regValue,
                 X => inputShifter,
                 padBit => padBit,
                 R => shiftedPosit,
                 Sticky => stkBit);
   unroundedPosit <= padBit & shiftedPosit(30 downto 1);
---------------------------- Round to nearest even ----------------------------
   lsb <= shiftedPosit(1);
   rnd <= shiftedPosit(0);
   stk <= stkBit OR Sticky;
   round <= rnd AND (lsb OR stk OR ovf);
   roundedPosit <= unroundedPosit + round;
-------------------------- Check sign & Special Cases --------------------------
   unsignedPosit <= roundedPosit when NZN = '1' else (others => '0');
   R <= Sign & unsignedPosit;
---------------------------- End of vhdl generation ----------------------------
end architecture;





--------------------------------------------------------------------------------
--                                 Stage Decode
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;


entity stage_decode is
    port (
			clk_in: 	in std_logic;
			reset: 		in std_logic;
			X : 		in std_logic_vector(31 downto 0);
			Y : 		in std_logic_vector(31 downto 0);
			X_sf : 		out std_logic_vector(7 downto 0);
			X_f : 		out std_logic_vector(26 downto 0);
			X_sgn : 	out std_logic;
			X_nzn: 		out std_logic;
			Y_sf : 		out std_logic_vector(7 downto 0);
			Y_f : 		out std_logic_vector(26 downto 0);
			Y_sgn : 	out std_logic;
			Y_nzn: 		out std_logic );
end entity;


architecture arch of stage_decode is


   component PositFastDecoder_32_2_F0_uid4 is
      port ( X : in  std_logic_vector(31 downto 0);
             Sign : out  std_logic;
             SF : out  std_logic_vector(7 downto 0);
             Frac : out  std_logic_vector(26 downto 0);
             NZN : out  std_logic   );
   end component;

   component PositFastDecoder_32_2_F0_uid8 is
      port ( X : in  std_logic_vector(31 downto 0);
             Sign : out  std_logic;
             SF : out  std_logic_vector(7 downto 0);
             Frac : out  std_logic_vector(26 downto 0);
             NZN : out  std_logic   );
   end component;


	signal X_f_s: std_logic_vector(26 downto 0);
	signal X_nzn_s: std_logic;
	signal X_sf_s: std_logic_vector(7 downto 0);
	signal X_sgn_s: std_logic;

	signal Y_f_s: std_logic_vector(26 downto 0);
	signal Y_nzn_s: std_logic;
	signal Y_sf_s: std_logic_vector(7 downto 0);
	signal Y_sgn_s: std_logic;

begin



--------------------------- Start of vhdl generation ---------------------------
---------------------------- Decode X & Y operands -----------------------------

	process(clk_in)
	begin
	if rising_edge(clk_in) then
		if reset = '1' then
			X_sgn 		<= '0';
			X_sf  		<= (others => '0');
			X_f   		<= (others => '0');
			X_nzn 		<= '0';
			Y_sgn		<= '0';
			Y_sf  		<= (others => '0');
			Y_f			<= (others => '0');
			Y_nzn	 	<= '0';
		else
			X_sgn 		<= X_sgn_s;
			X_sf  		<= X_sf_s;
			X_f   		<= X_f_s;
			X_nzn	 	<= X_nzn_s;
			Y_sgn		<= Y_sgn_s;
			Y_sf  		<= Y_sf_s;
			Y_f			<= Y_f_s;
			Y_nzn		<= Y_nzn_s;
		end if;
	  end if;
	end process;


   X_decoder: PositFastDecoder_32_2_F0_uid4
      port map ( X => X,
                 Frac => X_f_s,
                 NZN => X_nzn_s,
                 SF => X_sf_s,
                 Sign => X_sgn_s);

   Y_decoder: PositFastDecoder_32_2_F0_uid8
      port map ( X => Y,
                 Frac => Y_f_s,
                 NZN => Y_nzn_s,
                 SF => Y_sf_s,
                 Sign => Y_sgn_s);

end architecture;


--------------------------------------------------------------------------------
-- 							Multiply pipeline stage
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- use ieee.std_logic_arith.all;
-- use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;



entity stage_multiply is
    port (
			clk_in: 	in std_logic;
			reset: 		in std_logic;
			X_f: 		in std_logic_vector(26 downto 0);
			X_sgn: 		in std_logic;
			Y_f: 		in std_logic_vector(26 downto 0);
			Y_sgn: 		in std_logic;
			X_sf : 		in std_logic_vector(7 downto 0);
			Y_sf : 		in std_logic_vector(7 downto 0);
			XY_sgn: 	out std_logic;
			XY_sf: 		out std_logic_vector(8 downto 0);
			XY_normF:  	out std_logic_vector(54 downto 0)  );
end entity;


architecture arch of stage_multiply is

  component IntMultiplier_F0_uid12 is
      port ( X : in  std_logic_vector(28 downto 0);
             Y : in  std_logic_vector(28 downto 0);
             R : out  std_logic_vector(57 downto 0)   );
   end component;


signal XY_ovfExtra :  std_logic;
signal XY_ovf :  std_logic;
signal XY_normF_s :  std_logic_vector(54 downto 0);
signal XY_ovfBits :  std_logic_vector(1 downto 0);
signal XY_sgn_s: std_logic;
signal XY_sf_s :  std_logic_vector(8 downto 0);


signal XX_f :  std_logic_vector(28 downto 0);
signal YY_f :  std_logic_vector(28 downto 0);
signal XY_f :  std_logic_vector(57 downto 0);

begin



--------------------------- Start of vhdl generation ---------------------------
---------------------------- Decode X & Y operands -----------------------------


	process(clk_in)
	begin
	if rising_edge(clk_in) then
		if reset = '1' then
			XY_sgn		<= '0';
			XY_sf 		<= (others => '0');
			XY_normF  	<= (others => '0');
		else
			XY_sgn		<= XY_sgn_s;
			XY_sf 		<= XY_sf_s;
			XY_normF  	<= XY_normF_s;
		end if;
	  end if;
	end process;


   -- Multiply the fractions (using FloPoCo IntMultiplier)
   XX_f <= X_sgn & NOT(X_sgn) & X_f;
   YY_f <= Y_sgn & NOT(Y_sgn) & Y_f;
   FracMultiplier: IntMultiplier_F0_uid12
      port map ( X => XX_f,
                 Y => YY_f,
                 R => XY_f); 
   XY_sgn_s <= XY_f(57);
   XY_ovfExtra <= NOT(XY_f(57)) AND XY_f(56);
   XY_ovf <=  (XY_f(57) XOR XY_f(55));
   XY_normF_s <= XY_f(54 downto 0) when (XY_ovfExtra OR XY_ovf) = '1' else (XY_f(53 downto 0) & '0');
   -- Add the exponent values
   XY_ovfBits <= XY_ovfExtra & XY_ovf;
   XY_sf_s <= std_logic_vector( unsigned(X_sf(X_sf'high) & X_sf) + 
              unsigned(Y_sf(Y_sf'high) & Y_sf) + unsigned(XY_ovfBits) );
   
   

end architecture;




--------------------------------------------------------------------------------
-- 						    	Assemble stage
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;


entity stage_assemble is
    port (
			clk_in: 	in std_logic;
			reset: 		in std_logic;
			X_nzn: 		in std_logic;
			X_sgn: 		in std_logic;
			Y_nzn: 		in std_logic;
			Y_sgn: 		in std_logic;			
			XY_sf: 		in std_logic_vector(8 downto 0);
			XY_sgn: 	in std_logic;
			XY_normF:   in std_logic_vector(54 downto 0);
			R: 			out std_logic_vector(31 downto 0)  );
end entity;


architecture arch of stage_assemble is

   component PositFastEncoder_32_2_F0_uid15 is
      port ( Sign : in  std_logic;
             SF : in  std_logic_vector(8 downto 0);
             Frac : in  std_logic_vector(26 downto 0);
             Guard : in  std_logic;
             Sticky : in  std_logic;
             NZN : in  std_logic;
             R : out  std_logic_vector(31 downto 0)   );
   end component;
	
signal XY_finalSgn :  std_logic;
signal XY_frac :  std_logic_vector(26 downto 0);
signal grd :  std_logic;
signal stk :  std_logic;

signal XY_nzn :  std_logic;
signal X_nar :  std_logic;
signal Y_nar :  std_logic;
signal R_s : std_logic_vector(31 downto 0);


begin


--------------------------- Start of vhdl generation ---------------------------
---------------------------- Decode X & Y operands -----------------------------

	process(clk_in)
	begin
	if rising_edge(clk_in) then

		if reset = '1' then
			R 	<= (others => '0') ;
		else			
			R <= R_s;
			
		end if;
	  end if;
	end process;   
   
----------------------------- Generate final posit -----------------------------
   -- Sign and Special Cases Computation
   XY_nzn <= X_nzn AND Y_nzn;
   X_nar <= X_sgn AND NOT(X_nzn);
   Y_nar <= Y_sgn AND NOT(Y_nzn);

   XY_finalSgn <= XY_sgn when XY_nzn = '1' else (X_nar OR Y_nar);
   XY_frac <= XY_normF(54 downto 28);
   grd <= XY_normF(27);
   stk <= '0' when (XY_normF(26 downto 0) = "000000000000000000000000000") else '1';
   PositEncoder: PositFastEncoder_32_2_F0_uid15
      port map ( Frac => XY_frac,
                 Guard => grd,
                 NZN => XY_nzn,
                 SF => XY_sf,
                 Sign => XY_finalSgn,
                 Sticky => stk,
                 R => R_s);
---------------------------- End of vhdl generation ----------------------------
end architecture;






--------------------------------------------------------------------------------
--                           PositMult_32_2_F0_uid2
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Raul Murillo (2021)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library std;
use std.textio.all;
library work;

entity PositMult is
    port (
		  clk_in: 	in std_logic;
		  reset: 		in std_logic;
		  valid_in: in std_logic;
		  X : in  std_logic_vector(31 downto 0);
          Y : in  std_logic_vector(31 downto 0);
          R : out  std_logic_vector(31 downto 0);
		  valid_out: out std_logic );
end entity;


architecture arch of PositMult is


	component stage_decode is
		port (
				clk_in: 	in std_logic;
				reset: 		in std_logic;
				X : 		in std_logic_vector(31 downto 0);
				Y : 		in std_logic_vector(31 downto 0);
				X_sf : 		out std_logic_vector(7 downto 0);
				X_f : 		out std_logic_vector(26 downto 0);
				X_sgn : 	out std_logic;
				X_nzn: 		out std_logic;
				Y_sf : 		out std_logic_vector(7 downto 0);
				Y_f : 		out std_logic_vector(26 downto 0);
				Y_sgn : 	out std_logic;
				Y_nzn: 		out std_logic );
	end component;


	component stage_multiply is
		port (
				clk_in: 	in std_logic;
				reset: 		in std_logic;
				X_f: 		in std_logic_vector(26 downto 0);
				X_sgn: 		in std_logic;
				Y_f: 		in std_logic_vector(26 downto 0);
				Y_sgn: 		in std_logic;
				X_sf : 		in std_logic_vector(7 downto 0);
				Y_sf : 		in std_logic_vector(7 downto 0);
				XY_sgn: 	out std_logic;
				XY_sf: 		out std_logic_vector(8 downto 0);
				XY_normF:  	out std_logic_vector(54 downto 0)  );
	end component;
	
	
	component stage_assemble is
		port (
				clk_in: 	in std_logic;
				reset: 		in std_logic;
				X_nzn: 		in std_logic;
				X_sgn: 		in std_logic;
				Y_nzn: 		in std_logic;
				Y_sgn: 		in std_logic;			
				XY_sf: 		in std_logic_vector(8 downto 0);
				XY_sgn: 	in std_logic;
				XY_normF:   in std_logic_vector(54 downto 0);
				R: 			out std_logic_vector(31 downto 0)  );
	end component;	
	

signal X_sgn :  std_logic;
signal X_sf :  std_logic_vector(7 downto 0);
signal X_f :  std_logic_vector(26 downto 0);
signal X_nzn :  std_logic;
signal Y_sgn :  std_logic;
signal Y_sf :  std_logic_vector(7 downto 0);
signal Y_f :  std_logic_vector(26 downto 0);
signal Y_nzn :  std_logic;
signal XY_nzn :  std_logic;
signal X_nar :  std_logic;
signal Y_nar :  std_logic;
signal XX_f :  std_logic_vector(28 downto 0);
signal YY_f :  std_logic_vector(28 downto 0);
signal XY_f :  std_logic_vector(57 downto 0);
signal XY_sgn :  std_logic;
signal XY_ovfExtra :  std_logic;
signal XY_ovf :  std_logic;
signal XY_normF :  std_logic_vector(54 downto 0);
signal XY_ovfBits :  std_logic_vector(1 downto 0);
signal XY_sf :  std_logic_vector(8 downto 0);
signal XY_finalSgn :  std_logic;
signal XY_frac :  std_logic_vector(26 downto 0);
signal grd :  std_logic;
signal stk :  std_logic;


constant PIPE_DEPTH : integer := 3;
signal valid_pipe : std_logic_vector(PIPE_DEPTH-1 downto 0);

begin
--------------------------- Start of vhdl generation ---------------------------


process(clk_in)
begin
  if rising_edge(clk_in) then
    if reset = '1' then
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



	DECODE:  stage_decode port map(
				clk_in 	=> clk_in,
				reset 	=> reset,
				X 		=> X,
				Y 		=> Y,
				X_sf 	=> X_sf,
				X_f 	=> X_f,
				X_sgn 	=> X_sgn,
				X_nzn 	=> X_nzn,
				Y_sf 	=> Y_sf,
				Y_f 	=> Y_f,
				Y_sgn 	=> Y_sgn,
				Y_nzn 	=> Y_nzn );


-------------------------------- Multiply X & Y --------------------------------
	MULTIPLY: stage_multiply port map(
				clk_in 		=> clk_in,
				reset 		=> reset,
				X_f			=> X_f,
				X_sgn		=> X_sgn,
				Y_f			=> Y_f,
				Y_sgn		=> Y_sgn,
				X_sf		=> X_sf,
				Y_sf		=> Y_sf,
				XY_sgn 		=> XY_sgn,
				XY_sf		=> XY_sf,
				XY_normF	=> XY_normF );


	ASSEMBLE : stage_assemble port map(
				clk_in 		=> clk_in,
				reset 		=> reset,
				X_nzn 		=> X_nzn,
				X_sgn 		=> X_sgn,
				Y_nzn 		=> Y_nzn,
				Y_sgn 		=> Y_sgn,
				XY_sf 		=> XY_sf,
				XY_sgn 		=> XY_sgn,
				XY_normF 	=> XY_normF,
				R 			=> R);

	

end architecture;


