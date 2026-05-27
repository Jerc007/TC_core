--------------------------------------------------------------------------------
--                            CotranF1Table_4_9_6
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved
-- Authors: Florent de Dinechin (2007-2012)
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
entity CotranF1Table_4_9_6 is
   port ( X : in  std_logic_vector(6 downto 0);
          Y : out  std_logic_vector(13 downto 0)   );
end entity;

architecture arch of CotranF1Table_4_9_6 is
   -- Build a 2-D array type for the RoM
   subtype word_t is std_logic_vector(13 downto 0);
   type memory_t is array(0 to 127) of word_t;
   function init_rom
      return memory_t is
      variable tmp : memory_t := (
   "01001100111111",
   "01001011111111",
   "01001010111111",
   "01001001111111",
   "01001000111111",
   "01000111111111",
   "01000110111110",
   "01000101111110",
   "01000100111110",
   "01000011111110",
   "01000010111110",
   "01000001111110",
   "01000000111101",
   "00111111111101",
   "00111110111101",
   "00111101111101",
   "00111100111100",
   "00111011111100",
   "00111010111100",
   "00111001111011",
   "00111000111011",
   "00110111111010",
   "00110110111010",
   "00110101111001",
   "00110100111000",
   "00110011111000",
   "00110010110111",
   "00110001110110",
   "00110000110101",
   "00101111110100",
   "00101110110011",
   "00101101110010",
   "00101100110001",
   "00101011101111",
   "00101010101110",
   "00101001101100",
   "00101000101011",
   "00100111101001",
   "00100110100110",
   "00100101100100",
   "00100100100001",
   "00100011011111",
   "00100010011100",
   "00100001011000",
   "00100000010100",
   "00011111010000",
   "00011110001100",
   "00011101000111",
   "00011100000010",
   "00011010111100",
   "00011001110101",
   "00011000101110",
   "00010111100110",
   "00010110011101",
   "00010101010100",
   "00010100001001",
   "00010010111101",
   "00010001110000",
   "00010000100010",
   "00001111010010",
   "00001110000000",
   "00001100101100",
   "00001011010101",
   "00001001111011",
   "00001000011111",
   "00000110111110",
   "00000101011000",
   "00000011101101",
   "00000001111011",
   "00000000000000",
   "11111101111010",
   "11111011100101",
   "11111000111100",
   "11110101110101",
   "11110001111111",
   "11101100110010",
   "11100100010010",
      others => (others => '0'));
        begin
      return tmp;
      end init_rom;
        signal rom : memory_t := init_rom;
   signal Y0 :  std_logic_vector(13 downto 0);
begin
        Y0 <= rom(  TO_INTEGER(unsigned(X))  );
    Y <= Y0;
end architecture;

--------------------------------------------------------------------------------
--                             CotranF2Table_9_6
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved
-- Authors: Florent de Dinechin (2007-2012)
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
entity CotranF2Table_9_6 is
   port ( X : in  std_logic_vector(5 downto 0);
          Y : out  std_logic_vector(13 downto 0)   );
end entity;

architecture arch of CotranF2Table_9_6 is
begin
  with X select  Y <=
   "11100011010010" when "000000",
   "11100011000110" when "000001",
   "11100010111011" when "000010",
   "11100010110000" when "000011",
   "11100010100100" when "000100",
   "11100010011000" when "000101",
   "11100010001100" when "000110",
   "11100001111111" when "000111",
   "11100001110011" when "001000",
   "11100001100110" when "001001",
   "11100001011001" when "001010",
   "11100001001100" when "001011",
   "11100000111110" when "001100",
   "11100000110000" when "001101",
   "11100000100010" when "001110",
   "11100000010100" when "001111",
   "11100000000101" when "010000",
   "11011111110110" when "010001",
   "11011111100110" when "010010",
   "11011111010111" when "010011",
   "11011111000111" when "010100",
   "11011110110110" when "010101",
   "11011110100101" when "010110",
   "11011110010100" when "010111",
   "11011110000010" when "011000",
   "11011101110000" when "011001",
   "11011101011101" when "011010",
   "11011101001010" when "011011",
   "11011100110110" when "011100",
   "11011100100010" when "011101",
   "11011100001101" when "011110",
   "11011011111000" when "011111",
   "11011011100001" when "100000",
   "11011011001010" when "100001",
   "11011010110011" when "100010",
   "11011010011010" when "100011",
   "11011010000001" when "100100",
   "11011001100110" when "100101",
   "11011001001011" when "100110",
   "11011000101110" when "100111",
   "11011000010001" when "101000",
   "11010111110010" when "101001",
   "11010111010010" when "101010",
   "11010110110000" when "101011",
   "11010110001100" when "101100",
   "11010101100111" when "101101",
   "11010100111111" when "101110",
   "11010100010110" when "101111",
   "11010011101001" when "110000",
   "11010010111010" when "110001",
   "11010010001000" when "110010",
   "11010001010001" when "110011",
   "11010000010111" when "110100",
   "11001111010111" when "110101",
   "11001110010001" when "110110",
   "11001101000100" when "110111",
   "11001011101101" when "111000",
   "11001010001011" when "111001",
   "11001000011010" when "111010",
   "11000110010100" when "111011",
   "11000011101111" when "111100",
   "11000000011011" when "111101",
   "10111011110000" when "111110",
   "10110011110001" when "111111",
   "--------------" when others;
end architecture;

--------------------------------------------------------------------------------
--                             CotranF3Table_9_6
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved
-- Authors: Florent de Dinechin (2007-2012)
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
entity CotranF3Table_9_6 is
   port ( X : in  std_logic_vector(7 downto 0);
          Y : out  std_logic_vector(9 downto 0)   );
end entity;

architecture arch of CotranF3Table_9_6 is
   -- Build a 2-D array type for the RoM
   subtype word_t is std_logic_vector(9 downto 0);
   type memory_t is array(0 to 255) of word_t;
   function init_rom
      return memory_t is
      variable tmp : memory_t := (
   "1000100001",
   "1100111101",
   "1100111001",
   "1100110101",
   "1100110000",
   "1100101100",
   "1100101000",
      others => (others => '0'));
        begin
      return tmp;
      end init_rom;
        signal rom : memory_t := init_rom;
   signal Y0 :  std_logic_vector(9 downto 0);
begin
        Y0 <= rom(  TO_INTEGER(unsigned(X))  );
    Y <= Y0;
end architecture;

--------------------------------------------------------------------------------
--                            PolyCoeffTable_8_11
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved
-- Authors: Mioara Joldes (2010)
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
entity PolyCoeffTable_8_11 is
   port ( clk, rst : in std_logic;
          X : in  std_logic_vector(7 downto 0);
          Y : out  std_logic_vector(10 downto 0)   );
end entity;

architecture arch of PolyCoeffTable_8_11 is
   -- Build a 2-D array type for the RoM
   subtype word_t is std_logic_vector(10 downto 0);
   type memory_t is array(0 to 255) of word_t;
   function init_rom
      return memory_t is
      variable tmp : memory_t := (
   "00000000100",
   "00000000100",
   "00000000100",
   "00000000100",
   "00000000100",
   "00000000100",
   "00000000100",
   "00000000100",
   "00000000100",
   "00000000100",
   "00000000100",
   "00000000100",
   "00000000100",
   "00000000100",
   "00000000100",
   "00000000100",
   "00000000100",
   "00000000100",
   "00000000100",
   "00000000100",
   "00000000100",
   "00000000100",
   "00000000100",
   "00000000100",
   "00000000100",
   "00000000100",
   "00000000100",
   "00000000100",
   "00000000100",
   "00000000100",
   "00000000100",
   "00000000100",
   "00000000100",
   "00000000100",
   "00100000100",
   "00100000100",
   "00100000100",
   "00100000100",
   "00100000100",
   "00100000100",
   "00100000100",
   "00100000100",
   "00100000100",
   "00100000100",
   "00100000100",
   "00100000100",
   "00100000100",
   "00100000100",
   "00100000100",
   "00100000100",
   "00100000100",
   "00100000100",
   "00100000100",
   "00100000100",
   "00100000100",
   "00100000100",
   "00100000100",
   "00100000100",
   "00100000100",
   "00100000100",
   "00100000100",
   "00100000100",
   "00100000100",
   "00100000100",
   "00100000100",
   "00100000100",
   "00100000100",
   "00100000100",
   "00100000100",
   "00100000100",
   "00100000100",
   "00100000100",
   "00100000100",
   "00100000100",
   "00100000100",
   "00100000100",
   "00100000100",
   "00100000100",
   "00100000100",
   "00100000100",
   "11100000101",
   "11100000101",
   "11100000101",
   "11100000101",
   "11100000101",
   "11100000101",
   "11100000101",
   "11100000101",
   "11100000101",
   "11100000101",
   "11100000101",
   "11100000101",
   "11100000101",
   "11100000101",
   "11100000101",
   "11100000101",
   "11100000101",
   "11100000101",
   "11100000101",
   "11100000101",
   "11100000101",
   "00000000101",
   "00000000101",
   "00000000101",
   "00000000101",
   "00000000101",
   "00000000101",
   "00000000101",
   "00000000101",
   "00000000101",
   "00000000101",
   "00000000101",
   "00000000101",
   "00000000101",
   "00000000101",
   "00000000101",
   "00000000101",
   "00000000101",
   "00000000101",
   "00100000101",
   "00100000101",
   "00100000101",
   "00100000101",
   "00100000101",
   "00100000101",
   "00100000101",
   "00100000101",
   "00100000101",
   "00100000101",
   "00100000101",
   "11100000110",
   "11100000110",
   "11100000110",
   "11100000110",
   "11100000110",
   "11100000110",
   "11100000110",
   "11100000110",
   "00000000110",
   "00000000110",
   "00000000110",
   "00000000110",
   "00000000110",
   "00000000110",
   "00000000110",
   "00000000110",
   "00000000110",
   "00100000110",
   "00100000110",
   "00100000110",
   "00100000110",
   "00100000110",
   "00100000110",
   "00100000110",
   "11100000111",
   "11100000111",
   "11100000111",
   "11100000111",
   "11100000111",
   "00000000111",
   "00000000111",
   "00000000111",
   "00000000111",
   "00000000111",
   "00100000111",
   "00100000111",
   "00100000111",
   "00100000111",
   "00100000111",
   "11100001000",
   "11100001000",
   "11100001000",
   "11100001000",
   "00000001000",
   "00000001000",
   "00000001000",
   "00000001000",
   "00100001000",
   "00100001000",
   "00100001000",
   "00100001000",
   "11100001001",
   "11100001001",
   "00000001001",
   "00000001001",
   "00000001001",
   "00000001001",
   "00100001001",
   "00100001001",
   "00100001001",
   "11100001010",
   "11100001010",
   "00000001010",
   "00000001010",
   "00000001010",
   "00100001010",
   "00100001010",
   "00100001010",
   "11100001011",
   "00000001011",
   "00000001011",
   "00000001011",
   "00100001011",
   "00100001011",
   "01000001011",
   "11100001100",
   "00000001100",
   "00000001100",
   "00100001100",
   "00100001100",
   "11100001101",
   "00000001101",
   "00000001101",
   "00100001101",
   "00100001101",
   "01000001101",
   "00000001110",
   "00000001110",
   "00100001110",
   "00100001110",
   "11100001111",
   "00000001111",
   "00100001111",
   "00100001111",
   "11100010000",
   "00000010000",
   "00100010000",
   "00100010000",
   "11100010001",
   "00000010001",
   "00100010001",
   "01000010001",
   "00000010010",
   "00100010010",
   "00100010010",
   "00000010011",
   "00100010011",
   "00100010011",
   "00000010100",
   "00100010100",
   "01000010100",
   "00000010101",
   "00100010101",
   "01000010101",
   "00000010110",
   "00100010110",
   "00000010111",
   "00100010111",
   "01000010111",
   "00000011000",
   "01000011000",
   "00000011001",
   "00100011001",
   "00000011010",
   "00100011010",
   "00000011011",
      others => (others => '0'));
        begin
      return tmp;
      end init_rom;
        signal rom : memory_t := init_rom;
   signal Y0 :  std_logic_vector(10 downto 0);
begin
        process(clk)
   begin
   if(rising_edge(clk)) then
        Y0 <= rom(  TO_INTEGER(unsigned(X))  );
   end if;
   end process;
    Y <= Y0;
end architecture;

--------------------------------------------------------------------------------
--                 IntMultiplier_UsingDSP_5_5_3_signed_uid14
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved
-- Authors: Florent de Dinechin, Kinga Illyes, Bogdan Popa, Bogdan Pasca, 2012
--------------------------------------------------------------------------------
-- Pipeline depth: 1 cycles

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;
library std;
use std.textio.all;
library work;

entity IntMultiplier_UsingDSP_5_5_3_signed_uid14 is
   port ( clk, rst : in std_logic;
          X : in  std_logic_vector(4 downto 0);
          Y : in  std_logic_vector(4 downto 0);
          R : out  std_logic_vector(2 downto 0)   );
end entity;

architecture arch of IntMultiplier_UsingDSP_5_5_3_signed_uid14 is
signal XX_m15, XX_m15_d1 :  std_logic_vector(4 downto 0);
signal YY_m15, YY_m15_d1 :  std_logic_vector(4 downto 0);
signal DSP_mult_13 :  std_logic_vector(42 downto 0);
signal heap_bh16_w0_0 : std_logic;
signal heap_bh16_w1_0 : std_logic;
signal heap_bh16_w2_0 : std_logic;
signal heap_bh16_w3_0 : std_logic;
signal heap_bh16_w4_0 : std_logic;
signal heap_bh16_w5_0 : std_logic;
signal CompressionResult16 :  std_logic_vector(5 downto 0);
begin
   process(clk)
      begin
         if clk'event and clk = '1' then
            XX_m15_d1 <=  XX_m15;
            YY_m15_d1 <=  YY_m15;
         end if;
      end process;
   XX_m15 <= X ;
   YY_m15 <= Y ;
   ----------------Synchro barrier, entering cycle 1----------------
   DSP_mult_13 <= ((XX_m15_d1(4) & XX_m15_d1(4) & XX_m15_d1(4) & XX_m15_d1(4) & XX_m15_d1(4) & XX_m15_d1(4) & XX_m15_d1(4) & XX_m15_d1(4) & XX_m15_d1(4) & XX_m15_d1(4) & XX_m15_d1(4) & XX_m15_d1(4) & XX_m15_d1(4) & XX_m15_d1(4) & XX_m15_d1(4) & XX_m15_d1(4) & XX_m15_d1(4) & XX_m15_d1(4) & XX_m15_d1(4) & XX_m15_d1(4)) & XX_m15_d1) * ((YY_m15_d1(4) & YY_m15_d1(4) & YY_m15_d1(4) & YY_m15_d1(4) & YY_m15_d1(4) & YY_m15_d1(4) & YY_m15_d1(4) & YY_m15_d1(4) & YY_m15_d1(4) & YY_m15_d1(4) & YY_m15_d1(4) & YY_m15_d1(4) & YY_m15_d1(4)) & YY_m15_d1);
   heap_bh16_w0_0 <= DSP_mult_13(4); -- cycle= 1 cp= 2.387e-09
   heap_bh16_w1_0 <= DSP_mult_13(5); -- cycle= 1 cp= 2.387e-09
   heap_bh16_w2_0 <= DSP_mult_13(6); -- cycle= 1 cp= 2.387e-09
   heap_bh16_w3_0 <= DSP_mult_13(7); -- cycle= 1 cp= 2.387e-09
   heap_bh16_w4_0 <= DSP_mult_13(8); -- cycle= 1 cp= 2.387e-09
   heap_bh16_w5_0 <= DSP_mult_13(9); -- cycle= 1 cp= 2.387e-09

   -- Beginning of code generated by BitHeap::generateCompressorVHDL
   -- code generated by BitHeap::generateSupertileVHDL()
   ----------------Synchro barrier, entering cycle 0----------------

   -- Adding the constant bits

   ----------------Synchro barrier, entering cycle 1----------------
   CompressionResult16 <= heap_bh16_w5_0 & heap_bh16_w4_0 & heap_bh16_w3_0 & heap_bh16_w2_0 & heap_bh16_w1_0 & heap_bh16_w0_0;
   -- End of code generated by BitHeap::generateCompressorVHDL
   R <= CompressionResult16(5 downto 3);
end architecture;

--------------------------------------------------------------------------------
--                           IntAdder_7_f400_uid19
--                      (IntAdderClassical_7_f400_uid21)
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2010)
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_7_f400_uid19 is
   port ( clk, rst : in std_logic;
          X : in  std_logic_vector(6 downto 0);
          Y : in  std_logic_vector(6 downto 0);
          Cin : in std_logic;
          R : out  std_logic_vector(6 downto 0)   );
end entity;

architecture arch of IntAdder_7_f400_uid19 is
begin
   process(clk)
      begin
         if clk'event and clk = '1' then
         end if;
      end process;
   --Classical
    R <= X + Y + Cin;
end architecture;

--------------------------------------------------------------------------------
--                     PolynomialEvaluator_degree1_uid12
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved
-- Authors: Bogdan Pasca, Florent de Dinechin (2010-2012)
--------------------------------------------------------------------------------
-- Pipeline depth: 2 cycles

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity PolynomialEvaluator_degree1_uid12 is
   port ( clk, rst : in std_logic;
          Y : in  std_logic_vector(3 downto 0);
          a0 : in  std_logic_vector(5 downto 0);
          a1 : in  std_logic_vector(4 downto 0);
          R : out  std_logic_vector(6 downto 0)   );
end entity;

architecture arch of PolynomialEvaluator_degree1_uid12 is
   component IntAdder_7_f400_uid19 is
      port ( clk, rst : in std_logic;
             X : in  std_logic_vector(6 downto 0);
             Y : in  std_logic_vector(6 downto 0);
             Cin : in std_logic;
             R : out  std_logic_vector(6 downto 0)   );
   end component;

   component IntMultiplier_UsingDSP_5_5_3_signed_uid14 is
      port ( clk, rst : in std_logic;
             X : in  std_logic_vector(4 downto 0);
             Y : in  std_logic_vector(4 downto 0);
             R : out  std_logic_vector(2 downto 0)   );
   end component;

signal sigmaP0 :  std_logic_vector(4 downto 0);
signal yT1 :  std_logic_vector(4 downto 0);
signal piP1, piP1_d1 :  std_logic_vector(2 downto 0);
signal op1_1 :  std_logic_vector(6 downto 0);
signal op2_1 :  std_logic_vector(6 downto 0);
signal sigmaP1 :  std_logic_vector(6 downto 0);
signal a0_d1, a0_d2 :  std_logic_vector(5 downto 0);
begin
   process(clk)
      begin
         if clk'event and clk = '1' then
            piP1_d1 <=  piP1;
            a0_d1 <=  a0;
            a0_d2 <=  a0_d1;
         end if;
      end process;
   -- LSB weight of sigmaP0 is=4 size=5
   sigmaP0 <= a1;
   -- weight of yT1 is=-8 size=5
   yT1 <= "0" & Y(3 downto 0);
   -- weight of piP1 is=-4 size=10
   Product_1: IntMultiplier_UsingDSP_5_5_3_signed_uid14  -- pipelineDepth=1 maxInDelay=0
      port map ( clk  => clk,
                 rst  => rst,
                 R => piP1,
                 X => yT1,
                 Y => sigmaP0);
   ----------------Synchro barrier, entering cycle 1----------------
   ----------------Synchro barrier, entering cycle 2----------------
   -- the delay at the output of the multiplier is : 0
   op1_1 <= (4 downto 0 => piP1_d1(2)) & piP1_d1(1 downto 0);
   op2_1 <= (0 downto 0 => a0_d2(5)) & a0_d2;
   Sum1: IntAdder_7_f400_uid19  -- pipelineDepth=0 maxInDelay=4.4472e-10
      port map ( clk  => clk,
                 rst  => rst,
                 Cin => '1',
                 R => sigmaP1,
                 X => op1_1,
                 Y => op2_1);
   R <= sigmaP1(6 downto 0);
end architecture;

--------------------------------------------------------------------------------
--                            FunctionEvaluator_9
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved
-- Authors: Bogdan Pasca, Mioara Joldes, Florent de Dinechin (2010)
--------------------------------------------------------------------------------
-- Pipeline depth: 4 cycles

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity FunctionEvaluator_9 is
   port ( clk, rst : in std_logic;
          X : in  std_logic_vector(11 downto 0);
          R : out  std_logic_vector(3 downto 0)   
		);
end entity;

architecture arch of FunctionEvaluator_9 is
   component PolyCoeffTable_8_11 is
      port ( clk, rst : in std_logic;
             X : in  std_logic_vector(7 downto 0);
             Y : out  std_logic_vector(10 downto 0)   
		);
   end component;

   component PolynomialEvaluator_degree1_uid12 is
      port ( clk, rst : in std_logic;
             Y : in  std_logic_vector(3 downto 0);
             a0 : in  std_logic_vector(5 downto 0);
             a1 : in  std_logic_vector(4 downto 0);
             R : out  std_logic_vector(6 downto 0)   
		);
   end component;

	signal addr :  std_logic_vector(7 downto 0);
	signal Coef, Coef_d1 :  std_logic_vector(10 downto 0);
	signal y :  std_logic_vector(3 downto 0);
	signal a0 :  std_logic_vector(5 downto 0);
	signal a1 :  std_logic_vector(4 downto 0);
	signal Rpe :  std_logic_vector(6 downto 0);
	signal X_d1, X_d2 :  std_logic_vector(11 downto 0);

begin

   process(clk)
      begin
         if clk'event and clk = '1' then
            Coef_d1 <=  Coef;
            X_d1 <=  X;
            X_d2 <=  X_d1;
         end if;
      end process;
   addr <= X(11 downto 4);
   GeneratedTable: PolyCoeffTable_8_11  -- pipelineDepth=1 maxInDelay=0
      port map ( clk  => clk,
                 rst  => rst,
                 X => addr,
                 Y => Coef);
   ----------------Synchro barrier, entering cycle 1----------------
   ----------------Synchro barrier, entering cycle 2----------------
   y <= X_d2(3 downto 0);
   a0<= Coef_d1(5 downto 0);
   a1<= Coef_d1(10 downto 6);
   PolynomialEvaluator: PolynomialEvaluator_degree1_uid12  -- pipelineDepth=2 maxInDelay=0
      port map ( clk  => clk,
                 rst  => rst,
                 R => Rpe,
                 Y => y,
                 a0 => a0,
                 a1 => a1);
   ----------------Synchro barrier, entering cycle 4----------------
   -- weight of poly result is : 2
    R <= Rpe(6 downto 3);
end architecture;

--------------------------------------------------------------------------------
--                            PolyCoeffTable_8_15
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved
-- Authors: Mioara Joldes (2010)
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
entity PolyCoeffTable_8_15 is
   port ( clk, rst : in std_logic;
          X : in  std_logic_vector(7 downto 0);
          Y : out  std_logic_vector(14 downto 0)   );
end entity;

architecture arch of PolyCoeffTable_8_15 is
   -- Build a 2-D array type for the RoM
   subtype word_t is std_logic_vector(14 downto 0);
   type memory_t is array(0 to 255) of word_t;
   function init_rom
      return memory_t is
      variable tmp : memory_t := (
   "000010000011011",
   "000010000011011",
   "111110000011100",
   "000000000011100",
   "000010000011100",
   "000010000011100",
   "111110000011101",
   "000000000011101",
   "000010000011101",
   "000100000011101",
   "000000000011110",
   "000000000011110",
   "000010000011110",
   "111110000011111",
   "000000000011111",
   "000010000011111",
   "000100000011111",
   "000000000100000",
   "000010000100000",
   "000010000100000",
   "000000000100001",
   "000000000100001",
   "000010000100001",
   "111110000100010",
   "000000000100010",
   "000010000100010",
   "111110000100011",
   "000000000100011",
   "000010000100011",
   "111110000100100",
   "000000000100100",
   "000010000100100",
   "000000000100101",
   "000000000100101",
   "000010000100101",
   "000000000100110",
   "000010000100110",
   "000100000100110",
   "000000000100111",
   "000010000100111",
   "000100000100111",
   "000000000101000",
   "000010000101000",
   "000000000101001",
   "000010000101001",
   "000100000101001",
   "000000000101010",
   "000100000101010",
   "000000000101011",
   "000010000101011",
   "000000000101100",
   "000010000101100",
   "000100000101100",
   "000000000101101",
   "000100000101101",
   "000000000101110",
   "000010000101110",
   "000000000101111",
   "000010000101111",
   "000000000110000",
   "000010000110000",
   "000000000110001",
   "000010000110001",
   "000100000110001",
   "000010000110010",
   "000100000110010",
   "000010000110011",
   "000100000110011",
   "000010000110100",
   "000000000110101",
   "000010000110101",
   "000000000110110",
   "000010000110110",
   "000000000110111",
   "000100000110111",
   "000010000111000",
   "000100000111000",
   "000010000111001",
   "000100000111001",
   "000010000111010",
   "000000000111011",
   "000100000111011",
   "000010000111100",
   "000100000111100",
   "000010000111101",
   "000000000111110",
   "000100000111110",
   "000010000111111",
   "000000001000000",
   "000100001000000",
   "000010001000001",
   "000000001000010",
   "000100001000010",
   "000010001000011",
   "000000001000100",
   "000100001000100",
   "000010001000101",
   "000000001000110",
   "000100001000110",
   "000100001000111",
   "000010001001000",
   "000000001001001",
   "000100001001001",
   "000100001001010",
   "000010001001011",
   "000000001001100",
   "000100001001100",
   "000100001001101",
   "000010001001110",
   "000010001001111",
   "000110001001111",
   "000100001010000",
   "000100001010001",
   "000100001010010",
   "000010001010011",
   "000010001010100",
   "000000001010101",
   "000110001010101",
   "000110001010110",
   "000100001010111",
   "000100001011000",
   "000100001011001",
   "000100001011010",
   "000010001011011",
   "000010001011100",
   "000010001011101",
   "000010001011110",
   "000010001011111",
   "000010001100000",
   "000010001100001",
   "000010001100010",
   "000010001100011",
   "000010001100100",
   "000010001100101",
   "000010001100110",
   "000100001100111",
   "000100001101000",
   "000100001101001",
   "000100001101010",
   "000110001101011",
   "000110001101100",
   "000110001101101",
   "001000001101110",
   "000010001110000",
   "000100001110001",
   "000100001110010",
   "000110001110011",
   "000110001110100",
   "000010001110110",
   "000100001110111",
   "000110001111000",
   "000110001111001",
   "000010001111011",
   "000100001111100",
   "000110001111101",
   "001000001111110",
   "000100010000000",
   "000110010000001",
   "001000010000010",
   "000100010000100",
   "000110010000101",
   "000100010000111",
   "000110010001000",
   "001000010001001",
   "000100010001011",
   "001000010001100",
   "000100010001110",
   "001000010001111",
   "000100010010001",
   "001000010010010",
   "000100010010100",
   "001000010010101",
   "000110010010111",
   "001000010011000",
   "000110010011010",
   "000100010011100",
   "001000010011101",
   "000110010011111",
   "000100010100001",
   "001000010100010",
   "000110010100100",
   "000110010100110",
   "001010010100111",
   "001000010101001",
   "000110010101011",
   "000110010101101",
   "000100010101111",
   "001010010110000",
   "001000010110010",
   "001000010110100",
   "001000010110110",
   "001000010111000",
   "000110010111010",
   "000110010111100",
   "000110010111110",
   "000110011000000",
   "000110011000010",
   "001000011000100",
   "001000011000110",
   "001000011001000",
   "001000011001010",
   "001010011001100",
   "001010011001110",
   "001100011010000",
   "000110011010011",
   "001000011010101",
   "001010011010111",
   "001010011011001",
   "001000011011100",
   "001000011011110",
   "001010011100000",
   "001000011100011",
   "001010011100101",
   "001100011100111",
   "001000011101010",
   "001100011101100",
   "001000011101111",
   "001100011110001",
   "001010011110100",
   "001100011110110",
   "001010011111001",
   "001000011111100",
   "001100011111110",
   "001010100000001",
   "001000100000100",
   "001100100000110",
   "001100100001001",
   "001010100001100",
   "001010100001111",
   "001110100010001",
   "001110100010100",
   "001100100010111",
   "001100100011010",
   "001100100011101",
   "001100100100000",
   "001100100100011",
   "001110100100110",
   "001110100101001",
   "001110100101100",
   "001010100110000",
   "001100100110011",
   "001100100110110",
   "001110100111001",
   "010000100111100",
   "001100101000000",
   "001110101000011",
   "010000101000110",
   "001110101001010",
   "010000101001101",
   "001110101010001",
   "010000101010100",
   "001110101011000",
   "010010101011011",
   "010000101011111",
   "001110101100011",
   "010010101100110",
      others => (others => '0'));
        begin
      return tmp;
      end init_rom;
        signal rom : memory_t := init_rom;
   signal Y0 :  std_logic_vector(14 downto 0);
begin
        process(clk)
   begin
   if(rising_edge(clk)) then
        Y0 <= rom(  TO_INTEGER(unsigned(X))  );
   end if;
   end process;
    Y <= Y0;
end architecture;

--------------------------------------------------------------------------------
--                 IntMultiplier_UsingDSP_4_5_5_signed_uid34
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved
-- Authors: Florent de Dinechin, Kinga Illyes, Bogdan Popa, Bogdan Pasca, 2012
--------------------------------------------------------------------------------
-- Pipeline depth: 1 cycles

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;
library std;
use std.textio.all;
library work;

entity IntMultiplier_UsingDSP_4_5_5_signed_uid34 is
   port ( clk, rst : in std_logic;
          X : in  std_logic_vector(3 downto 0);
          Y : in  std_logic_vector(4 downto 0);
          R : out  std_logic_vector(4 downto 0)   );
end entity;

architecture arch of IntMultiplier_UsingDSP_4_5_5_signed_uid34 is
signal XX_m35, XX_m35_d1 :  std_logic_vector(4 downto 0);
signal YY_m35, YY_m35_d1 :  std_logic_vector(3 downto 0);
signal DSP_mult_33 :  std_logic_vector(42 downto 0);
signal heap_bh36_w0_0 : std_logic;
signal heap_bh36_w1_0 : std_logic;
signal heap_bh36_w2_0 : std_logic;
signal heap_bh36_w3_0 : std_logic;
signal heap_bh36_w4_0 : std_logic;
signal heap_bh36_w5_0 : std_logic;
signal heap_bh36_w6_0 : std_logic;
signal CompressionResult36 :  std_logic_vector(6 downto 0);
begin
   process(clk)
      begin
         if clk'event and clk = '1' then
            XX_m35_d1 <=  XX_m35;
            YY_m35_d1 <=  YY_m35;
         end if;
      end process;
   XX_m35 <= Y ;
   YY_m35 <= X ;
   ----------------Synchro barrier, entering cycle 1----------------
   DSP_mult_33 <= ((XX_m35_d1(4) & XX_m35_d1(4) & XX_m35_d1(4) & XX_m35_d1(4) & XX_m35_d1(4) & XX_m35_d1(4) & XX_m35_d1(4) & XX_m35_d1(4) & XX_m35_d1(4) & XX_m35_d1(4) & XX_m35_d1(4) & XX_m35_d1(4) & XX_m35_d1(4) & XX_m35_d1(4) & XX_m35_d1(4) & XX_m35_d1(4) & XX_m35_d1(4) & XX_m35_d1(4) & XX_m35_d1(4) & XX_m35_d1(4)) & XX_m35_d1) * ((YY_m35_d1(3) & YY_m35_d1(3) & YY_m35_d1(3) & YY_m35_d1(3) & YY_m35_d1(3) & YY_m35_d1(3) & YY_m35_d1(3) & YY_m35_d1(3) & YY_m35_d1(3) & YY_m35_d1(3) & YY_m35_d1(3) & YY_m35_d1(3) & YY_m35_d1(3) & YY_m35_d1(3)) & YY_m35_d1);
   heap_bh36_w0_0 <= DSP_mult_33(2); -- cycle= 1 cp= 2.387e-09
   heap_bh36_w1_0 <= DSP_mult_33(3); -- cycle= 1 cp= 2.387e-09
   heap_bh36_w2_0 <= DSP_mult_33(4); -- cycle= 1 cp= 2.387e-09
   heap_bh36_w3_0 <= DSP_mult_33(5); -- cycle= 1 cp= 2.387e-09
   heap_bh36_w4_0 <= DSP_mult_33(6); -- cycle= 1 cp= 2.387e-09
   heap_bh36_w5_0 <= DSP_mult_33(7); -- cycle= 1 cp= 2.387e-09
   heap_bh36_w6_0 <= DSP_mult_33(8); -- cycle= 1 cp= 2.387e-09

   -- Beginning of code generated by BitHeap::generateCompressorVHDL
   -- code generated by BitHeap::generateSupertileVHDL()
   ----------------Synchro barrier, entering cycle 0----------------

   -- Adding the constant bits

   ----------------Synchro barrier, entering cycle 1----------------
   CompressionResult36 <= heap_bh36_w6_0 & heap_bh36_w5_0 & heap_bh36_w4_0 & heap_bh36_w3_0 & heap_bh36_w2_0 & heap_bh36_w1_0 & heap_bh36_w0_0;
   -- End of code generated by BitHeap::generateCompressorVHDL
   R <= CompressionResult36(6 downto 2);
end architecture;

--------------------------------------------------------------------------------
--                           IntAdder_11_f400_uid39
--                     (IntAdderClassical_11_f400_uid41)
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2010)
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_11_f400_uid39 is
   port ( clk, rst : in std_logic;
          X : in  std_logic_vector(10 downto 0);
          Y : in  std_logic_vector(10 downto 0);
          Cin : in std_logic;
          R : out  std_logic_vector(10 downto 0)   );
end entity;

architecture arch of IntAdder_11_f400_uid39 is
begin
   process(clk)
      begin
         if clk'event and clk = '1' then
         end if;
      end process;
   --Classical
    R <= X + Y + Cin;
end architecture;

--------------------------------------------------------------------------------
--                     PolynomialEvaluator_degree1_uid32
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved
-- Authors: Bogdan Pasca, Florent de Dinechin (2010-2012)
--------------------------------------------------------------------------------
-- Pipeline depth: 2 cycles

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity PolynomialEvaluator_degree1_uid32 is
   port ( clk, rst : in std_logic;
          Y : in  std_logic_vector(2 downto 0);
          a0 : in  std_logic_vector(9 downto 0);
          a1 : in  std_logic_vector(4 downto 0);
          R : out  std_logic_vector(10 downto 0)   );
end entity;

architecture arch of PolynomialEvaluator_degree1_uid32 is
   component IntAdder_11_f400_uid39 is
      port ( clk, rst : in std_logic;
             X : in  std_logic_vector(10 downto 0);
             Y : in  std_logic_vector(10 downto 0);
             Cin : in std_logic;
             R : out  std_logic_vector(10 downto 0)   );
   end component;

   component IntMultiplier_UsingDSP_4_5_5_signed_uid34 is
      port ( clk, rst : in std_logic;
             X : in  std_logic_vector(3 downto 0);
             Y : in  std_logic_vector(4 downto 0);
             R : out  std_logic_vector(4 downto 0)   );
   end component;

signal sigmaP0 :  std_logic_vector(4 downto 0);
signal yT1 :  std_logic_vector(3 downto 0);
signal piP1, piP1_d1 :  std_logic_vector(4 downto 0);
signal op1_1 :  std_logic_vector(10 downto 0);
signal op2_1 :  std_logic_vector(10 downto 0);
signal sigmaP1 :  std_logic_vector(10 downto 0);
signal a0_d1, a0_d2 :  std_logic_vector(9 downto 0);
begin
   process(clk)
      begin
         if clk'event and clk = '1' then
            piP1_d1 <=  piP1;
            a0_d1 <=  a0;
            a0_d2 <=  a0_d1;
         end if;
      end process;
   -- LSB weight of sigmaP0 is=3 size=5
   sigmaP0 <= a1;
   -- weight of yT1 is=-8 size=4
   yT1 <= "0" & Y(2 downto 0);
   -- weight of piP1 is=-5 size=9
   Product_1: IntMultiplier_UsingDSP_4_5_5_signed_uid34  -- pipelineDepth=1 maxInDelay=0
      port map ( clk  => clk,
                 rst  => rst,
                 R => piP1,
                 X => yT1,
                 Y => sigmaP0);
   ----------------Synchro barrier, entering cycle 1----------------
   ----------------Synchro barrier, entering cycle 2----------------
   -- the delay at the output of the multiplier is : 0
   op1_1 <= (6 downto 0 => piP1_d1(4)) & piP1_d1(3 downto 0);
   op2_1 <= (0 downto 0 => a0_d2(9)) & a0_d2;
   Sum1: IntAdder_11_f400_uid39  -- pipelineDepth=0 maxInDelay=4.4472e-10
      port map ( clk  => clk,
                 rst  => rst,
                 Cin => '1',
                 R => sigmaP1,
                 X => op1_1,
                 Y => op2_1);
   R <= sigmaP1(10 downto 0);
end architecture;

--------------------------------------------------------------------------------
--                            FunctionEvaluator_29
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved
-- Authors: Bogdan Pasca, Mioara Joldes, Florent de Dinechin (2010)
--------------------------------------------------------------------------------
-- Pipeline depth: 4 cycles

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity FunctionEvaluator_29 is
   port ( clk, rst : in std_logic;
          X : in  std_logic_vector(10 downto 0);
          R : out  std_logic_vector(7 downto 0)   );
end entity;

architecture arch of FunctionEvaluator_29 is
   component PolyCoeffTable_8_15 is
      port ( clk, rst : in std_logic;
             X : in  std_logic_vector(7 downto 0);
             Y : out  std_logic_vector(14 downto 0)   );
   end component;

   component PolynomialEvaluator_degree1_uid32 is
      port ( clk, rst : in std_logic;
             Y : in  std_logic_vector(2 downto 0);
             a0 : in  std_logic_vector(9 downto 0);
             a1 : in  std_logic_vector(4 downto 0);
             R : out  std_logic_vector(10 downto 0)   );
   end component;

signal addr :  std_logic_vector(7 downto 0);
signal Coef, Coef_d1 :  std_logic_vector(14 downto 0);
signal y :  std_logic_vector(2 downto 0);
signal a0 :  std_logic_vector(9 downto 0);
signal a1 :  std_logic_vector(4 downto 0);
signal Rpe :  std_logic_vector(10 downto 0);
signal X_d1, X_d2 :  std_logic_vector(10 downto 0);
begin
   process(clk)
      begin
         if clk'event and clk = '1' then
            Coef_d1 <=  Coef;
            X_d1 <=  X;
            X_d2 <=  X_d1;
         end if;
      end process;
   addr <= X(10 downto 3);
   GeneratedTable: PolyCoeffTable_8_15  -- pipelineDepth=1 maxInDelay=0
      port map ( clk  => clk,
                 rst  => rst,
                 X => addr,
                 Y => Coef);
   ----------------Synchro barrier, entering cycle 1----------------
   ----------------Synchro barrier, entering cycle 2----------------
   y <= X_d2(2 downto 0);
   a0<= Coef_d1(9 downto 0);
   a1<= Coef_d1(14 downto 10);
   PolynomialEvaluator: PolynomialEvaluator_degree1_uid32  -- pipelineDepth=2 maxInDelay=0
      port map ( clk  => clk,
                 rst  => rst,
                 R => Rpe,
                 Y => y,
                 a0 => a0,
                 a1 => a1);
   ----------------Synchro barrier, entering cycle 4----------------
   -- weight of poly result is : 3
    R <= Rpe(10 downto 3);
end architecture;

--------------------------------------------------------------------------------
--                            PolyCoeffTable_8_21
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved
-- Authors: Mioara Joldes (2010)
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
entity PolyCoeffTable_8_21 is
   port ( clk, rst : in std_logic;
          X : in  std_logic_vector(7 downto 0);
          Y : out  std_logic_vector(20 downto 0)   );
end entity;

architecture arch of PolyCoeffTable_8_21 is
   -- Build a 2-D array type for the RoM
   subtype word_t is std_logic_vector(20 downto 0);
   type memory_t is array(0 to 255) of word_t;
   function init_rom
      return memory_t is
      variable tmp : memory_t := (
   "000010000000101101010",
   "000010000000101101110",
   "000001110000101110010",
   "000001110000101110110",
   "000001110000101111010",
   "000001110000101111110",
   "000001110000110000010",
   "000001110000110000110",
   "000001110000110001010",
   "000010000000110001110",
   "000010000000110010010",
   "000010010000110010110",
   "000010010000110011010",
   "000001110000110011111",
   "000010000000110100011",
   "000010010000110100111",
   "000010000000110101100",
   "000010010000110110000",
   "000010000000110110101",
   "000010100000110111001",
   "000010010000110111110",
   "000010100000111000010",
   "000010100000111000111",
   "000010010000111001100",
   "000010000000111010001",
   "000010110000111010101",
   "000010100000111011010",
   "000010100000111011111",
   "000010100000111100100",
   "000010110000111101001",
   "000010110000111101110",
   "000010110000111110011",
   "000010010000111111001",
   "000010100000111111110",
   "000010110001000000011",
   "000011000001000001000",
   "000010100001000001110",
   "000010110001000010011",
   "000010100001000011001",
   "000011000001000011110",
   "000010110001000100100",
   "000011010001000101001",
   "000011000001000101111",
   "000010110001000110101",
   "000010110001000111011",
   "000010110001001000001",
   "000010110001001000111",
   "000010110001001001101",
   "000010110001001010011",
   "000011000001001011001",
   "000011000001001011111",
   "000011010001001100101",
   "000011100001001101011",
   "000011000001001110010",
   "000011100001001111000",
   "000011000001001111111",
   "000011100001010000101",
   "000011010001010001100",
   "000011000001010010011",
   "000011100001010011001",
   "000011100001010100000",
   "000011100001010100111",
   "000011100001010101110",
   "000011100001010110101",
   "000011100001010111100",
   "000011110001011000011",
   "000100000001011001010",
   "000011100001011010010",
   "000011110001011011001",
   "000100000001011100000",
   "000011110001011101000",
   "000100010001011101111",
   "000100000001011110111",
   "000011110001011111111",
   "000011110001100000111",
   "000011110001100001111",
   "000100010001100010110",
   "000100010001100011110",
   "000011110001100100111",
   "000100000001100101111",
   "000100010001100110111",
   "000100100001100111111",
   "000100000001101001000",
   "000100100001101010000",
   "000100010001101011001",
   "000100100001101100001",
   "000100100001101101010",
   "000100010001101110011",
   "000100010001101111100",
   "000100010001110000101",
   "000100100001110001110",
   "000100100001110010111",
   "000100110001110100000",
   "000101000001110101001",
   "000100110001110110011",
   "000101000001110111100",
   "000100110001111000110",
   "000100100001111010000",
   "000101000001111011001",
   "000101000001111100011",
   "000101000001111101101",
   "000101000001111110111",
   "000101010010000000001",
   "000101100010000001011",
   "000101000010000010110",
   "000101010010000100000",
   "000101000010000101011",
   "000101100010000110101",
   "000101010010001000000",
   "000101010010001001011",
   "000101110010001010101",
   "000101110010001100000",
   "000101010010001101100",
   "000101100010001110111",
   "000101110010010000010",
   "000110000010010001101",
   "000101110010010011001",
   "000110000010010100100",
   "000110000010010110000",
   "000101110010010111100",
   "000101110010011001000",
   "000101110010011010100",
   "000110000010011100000",
   "000110010010011101100",
   "000110100010011111000",
   "000110000010100000101",
   "000110100010100010001",
   "000110010010100011110",
   "000110010010100101011",
   "000110110010100110111",
   "000110110010101000100",
   "000110010010101010010",
   "000110100010101011111",
   "000110110010101101100",
   "000111000010101111001",
   "000110110010110000111",
   "000110110010110010101",
   "000111010010110100010",
   "000111010010110110000",
   "000111010010110111110",
   "000111100010111001100",
   "000111000010111011011",
   "000111010010111101001",
   "000111110010111110111",
   "000111100011000000110",
   "000111010011000010101",
   "000111010011000100100",
   "000111010011000110011",
   "000111100011001000010",
   "000111110011001010001",
   "001000000011001100000",
   "000111110011001110000",
   "001000010011001111111",
   "001000000011010001111",
   "001000000011010011111",
   "001000000011010101111",
   "001000010011010111111",
   "001000100011011001111",
   "001000000011011100000",
   "001000100011011110000",
   "001000010011100000001",
   "001000010011100010010",
   "001000010011100100011",
   "001000100011100110100",
   "001000100011101000101",
   "001000110011101010110",
   "001000100011101101000",
   "001001000011101111001",
   "001001000011110001011",
   "001001000011110011101",
   "001001000011110101111",
   "001001010011111000001",
   "001001100011111010011",
   "001001010011111100110",
   "001001100011111111000",
   "001001100100000001011",
   "001001100100000011110",
   "001001100100000110001",
   "001001110100001000100",
   "001010000100001010111",
   "001001110100001101011",
   "001001100100001111111",
   "001010010100010010010",
   "001010010100010100110",
   "001010010100010111010",
   "001010100100011001110",
   "001010000100011100011",
   "001010100100011110111",
   "001010010100100001100",
   "001010010100100100001",
   "001010010100100110110",
   "001010100100101001011",
   "001010110100101100000",
   "001011000100101110101",
   "001010110100110001011",
   "001010110100110100001",
   "001010110100110110111",
   "001010110100111001101",
   "001011000100111100011",
   "001011010100111111001",
   "001011000101000010000",
   "001011100101000100110",
   "001011100101000111101",
   "001011110101001010100",
   "001011110101001101011",
   "001011100101010000011",
   "001011110101010011010",
   "001011110101010110010",
   "001100010101011001001",
   "001100010101011100001",
   "001100100101011111001",
   "001100000101100010010",
   "001100100101100101010",
   "001100010101101000011",
   "001100010101101011100",
   "001100110101101110100",
   "001100010101110001110",
   "001100100101110100111",
   "001101000101111000000",
   "001100110101111011010",
   "001100110101111110100",
   "001101100110000001101",
   "001100110110000101000",
   "001101000110001000010",
   "001101100110001011100",
   "001101010110001110111",
   "001101010110010010010",
   "001101010110010101101",
   "001101100110011001000",
   "001101110110011100011",
   "001110000110011111110",
   "001101110110100011010",
   "001101110110100110110",
   "001101110110101010010",
   "001110000110101101110",
   "001110010110110001010",
   "001110000110110100111",
   "001110100110111000011",
   "001110100110111100000",
   "001110100110111111101",
   "001110110111000011010",
   "001111000111000110111",
   "001110110111001010101",
   "001110110111001110011",
   "001111010111010010000",
   "001111100111010101110",
   "001111000111011001101",
   "001111010111011101011",
   "001111000111100001010",
   "001111100111100101000",
   "001111100111101000111",
   "001111110111101100110",
   "010000000111110000101",
   "001111110111110100101",
   "010000000111111000100",
   "010000000111111100100",
      others => (others => '0'));
        begin
      return tmp;
      end init_rom;
        signal rom : memory_t := init_rom;
   signal Y0 :  std_logic_vector(20 downto 0);
begin
        process(clk)
   begin
   if(rising_edge(clk)) then
        Y0 <= rom(  TO_INTEGER(unsigned(X))  );
   end if;
   end process;
    Y <= Y0;
end architecture;

--------------------------------------------------------------------------------
--                 IntMultiplier_UsingDSP_4_8_8_signed_uid54
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved
-- Authors: Florent de Dinechin, Kinga Illyes, Bogdan Popa, Bogdan Pasca, 2012
--------------------------------------------------------------------------------
-- Pipeline depth: 1 cycles

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;
library std;
use std.textio.all;
library work;

entity IntMultiplier_UsingDSP_4_8_8_signed_uid54 is
   port ( clk, rst : in std_logic;
          X : in  std_logic_vector(3 downto 0);
          Y : in  std_logic_vector(7 downto 0);
          R : out  std_logic_vector(7 downto 0)   );
end entity;

architecture arch of IntMultiplier_UsingDSP_4_8_8_signed_uid54 is
signal XX_m55, XX_m55_d1 :  std_logic_vector(7 downto 0);
signal YY_m55, YY_m55_d1 :  std_logic_vector(3 downto 0);
signal DSP_mult_53 :  std_logic_vector(42 downto 0);
signal heap_bh56_w0_0 : std_logic;
signal heap_bh56_w1_0 : std_logic;
signal heap_bh56_w2_0 : std_logic;
signal heap_bh56_w3_0 : std_logic;
signal heap_bh56_w4_0 : std_logic;
signal heap_bh56_w5_0 : std_logic;
signal heap_bh56_w6_0 : std_logic;
signal heap_bh56_w7_0 : std_logic;
signal heap_bh56_w8_0 : std_logic;
signal heap_bh56_w9_0 : std_logic;
signal CompressionResult56 :  std_logic_vector(9 downto 0);
begin
   process(clk)
      begin
         if clk'event and clk = '1' then
            XX_m55_d1 <=  XX_m55;
            YY_m55_d1 <=  YY_m55;
         end if;
      end process;
   XX_m55 <= Y ;
   YY_m55 <= X ;
   ----------------Synchro barrier, entering cycle 1----------------
   DSP_mult_53 <= ((XX_m55_d1(7) & XX_m55_d1(7) & XX_m55_d1(7) & XX_m55_d1(7) & XX_m55_d1(7) & XX_m55_d1(7) & XX_m55_d1(7) & XX_m55_d1(7) & XX_m55_d1(7) & XX_m55_d1(7) & XX_m55_d1(7) & XX_m55_d1(7) & XX_m55_d1(7) & XX_m55_d1(7) & XX_m55_d1(7) & XX_m55_d1(7) & XX_m55_d1(7)) & XX_m55_d1) * ((YY_m55_d1(3) & YY_m55_d1(3) & YY_m55_d1(3) & YY_m55_d1(3) & YY_m55_d1(3) & YY_m55_d1(3) & YY_m55_d1(3) & YY_m55_d1(3) & YY_m55_d1(3) & YY_m55_d1(3) & YY_m55_d1(3) & YY_m55_d1(3) & YY_m55_d1(3) & YY_m55_d1(3)) & YY_m55_d1);
   heap_bh56_w0_0 <= DSP_mult_53(2); -- cycle= 1 cp= 2.387e-09
   heap_bh56_w1_0 <= DSP_mult_53(3); -- cycle= 1 cp= 2.387e-09
   heap_bh56_w2_0 <= DSP_mult_53(4); -- cycle= 1 cp= 2.387e-09
   heap_bh56_w3_0 <= DSP_mult_53(5); -- cycle= 1 cp= 2.387e-09
   heap_bh56_w4_0 <= DSP_mult_53(6); -- cycle= 1 cp= 2.387e-09
   heap_bh56_w5_0 <= DSP_mult_53(7); -- cycle= 1 cp= 2.387e-09
   heap_bh56_w6_0 <= DSP_mult_53(8); -- cycle= 1 cp= 2.387e-09
   heap_bh56_w7_0 <= DSP_mult_53(9); -- cycle= 1 cp= 2.387e-09
   heap_bh56_w8_0 <= DSP_mult_53(10); -- cycle= 1 cp= 2.387e-09
   heap_bh56_w9_0 <= DSP_mult_53(11); -- cycle= 1 cp= 2.387e-09

   -- Beginning of code generated by BitHeap::generateCompressorVHDL
   -- code generated by BitHeap::generateSupertileVHDL()
   ----------------Synchro barrier, entering cycle 0----------------

   -- Adding the constant bits

   ----------------Synchro barrier, entering cycle 1----------------
   CompressionResult56 <= heap_bh56_w9_0 & heap_bh56_w8_0 & heap_bh56_w7_0 & heap_bh56_w6_0 & heap_bh56_w5_0 & heap_bh56_w4_0 & heap_bh56_w3_0 & heap_bh56_w2_0 & heap_bh56_w1_0 & heap_bh56_w0_0;
   -- End of code generated by BitHeap::generateCompressorVHDL
   R <= CompressionResult56(9 downto 2);
end architecture;

--------------------------------------------------------------------------------
--                           IntAdder_14_f400_uid59
--                     (IntAdderClassical_14_f400_uid61)
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2010)
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_14_f400_uid59 is
   port ( clk, rst : in std_logic;
          X : in  std_logic_vector(13 downto 0);
          Y : in  std_logic_vector(13 downto 0);
          Cin : in std_logic;
          R : out  std_logic_vector(13 downto 0)   );
end entity;

architecture arch of IntAdder_14_f400_uid59 is
begin
   process(clk)
      begin
         if clk'event and clk = '1' then
         end if;
      end process;
   --Classical
    R <= X + Y + Cin;
end architecture;

--------------------------------------------------------------------------------
--                     PolynomialEvaluator_degree1_uid52
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved
-- Authors: Bogdan Pasca, Florent de Dinechin (2010-2012)
--------------------------------------------------------------------------------
-- Pipeline depth: 2 cycles

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity PolynomialEvaluator_degree1_uid52 is
   port ( clk, rst : in std_logic;
          Y : in  std_logic_vector(2 downto 0);
          a0 : in  std_logic_vector(12 downto 0);
          a1 : in  std_logic_vector(7 downto 0);
          R : out  std_logic_vector(13 downto 0)   );
end entity;

architecture arch of PolynomialEvaluator_degree1_uid52 is
   component IntAdder_14_f400_uid59 is
      port ( clk, rst : in std_logic;
             X : in  std_logic_vector(13 downto 0);
             Y : in  std_logic_vector(13 downto 0);
             Cin : in std_logic;
             R : out  std_logic_vector(13 downto 0)   );
   end component;

   component IntMultiplier_UsingDSP_4_8_8_signed_uid54 is
      port ( clk, rst : in std_logic;
             X : in  std_logic_vector(3 downto 0);
             Y : in  std_logic_vector(7 downto 0);
             R : out  std_logic_vector(7 downto 0)   );
   end component;

signal sigmaP0 :  std_logic_vector(7 downto 0);
signal yT1 :  std_logic_vector(3 downto 0);
signal piP1, piP1_d1 :  std_logic_vector(7 downto 0);
signal op1_1 :  std_logic_vector(13 downto 0);
signal op2_1 :  std_logic_vector(13 downto 0);
signal sigmaP1 :  std_logic_vector(13 downto 0);
signal a0_d1, a0_d2 :  std_logic_vector(12 downto 0);
begin
   process(clk)
      begin
         if clk'event and clk = '1' then
            piP1_d1 <=  piP1;
            a0_d1 <=  a0;
            a0_d2 <=  a0_d1;
         end if;
      end process;
   -- LSB weight of sigmaP0 is=2 size=8
   sigmaP0 <= a1;
   -- weight of yT1 is=-8 size=4
   yT1 <= "0" & Y(2 downto 0);
   -- weight of piP1 is=-6 size=12
   Product_1: IntMultiplier_UsingDSP_4_8_8_signed_uid54  -- pipelineDepth=1 maxInDelay=0
      port map ( clk  => clk,
                 rst  => rst,
                 R => piP1,
                 X => yT1,
                 Y => sigmaP0);
   ----------------Synchro barrier, entering cycle 1----------------
   ----------------Synchro barrier, entering cycle 2----------------
   -- the delay at the output of the multiplier is : 0
   op1_1 <= (6 downto 0 => piP1_d1(7)) & piP1_d1(6 downto 0);
   op2_1 <= (0 downto 0 => a0_d2(12)) & a0_d2;
   Sum1: IntAdder_14_f400_uid59  -- pipelineDepth=0 maxInDelay=4.4472e-10
      port map ( clk  => clk,
                 rst  => rst,
                 Cin => '1',
                 R => sigmaP1,
                 X => op1_1,
                 Y => op2_1);
   R <= sigmaP1(13 downto 0);
end architecture;

--------------------------------------------------------------------------------
--                            FunctionEvaluator_49
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved
-- Authors: Bogdan Pasca, Mioara Joldes, Florent de Dinechin (2010)
--------------------------------------------------------------------------------
-- Pipeline depth: 4 cycles

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity FunctionEvaluator_49 is
   port ( clk, rst : in std_logic;
          X : in  std_logic_vector(10 downto 0);
          R : out  std_logic_vector(10 downto 0)   );
end entity;

architecture arch of FunctionEvaluator_49 is
   component PolyCoeffTable_8_21 is
      port ( clk, rst : in std_logic;
             X : in  std_logic_vector(7 downto 0);
             Y : out  std_logic_vector(20 downto 0)   );
   end component;

   component PolynomialEvaluator_degree1_uid52 is
      port ( clk, rst : in std_logic;
             Y : in  std_logic_vector(2 downto 0);
             a0 : in  std_logic_vector(12 downto 0);
             a1 : in  std_logic_vector(7 downto 0);
             R : out  std_logic_vector(13 downto 0)   );
   end component;

signal addr :  std_logic_vector(7 downto 0);
signal Coef, Coef_d1 :  std_logic_vector(20 downto 0);
signal y :  std_logic_vector(2 downto 0);
signal a0 :  std_logic_vector(12 downto 0);
signal a1 :  std_logic_vector(7 downto 0);
signal Rpe :  std_logic_vector(13 downto 0);
signal X_d1, X_d2 :  std_logic_vector(10 downto 0);
begin
   process(clk)
      begin
         if clk'event and clk = '1' then
            Coef_d1 <=  Coef;
            X_d1 <=  X;
            X_d2 <=  X_d1;
         end if;
      end process;
   addr <= X(10 downto 3);
   GeneratedTable: PolyCoeffTable_8_21  -- pipelineDepth=1 maxInDelay=0
      port map ( clk  => clk,
                 rst  => rst,
                 X => addr,
                 Y => Coef);
   ----------------Synchro barrier, entering cycle 1----------------
   ----------------Synchro barrier, entering cycle 2----------------
   y <= X_d2(2 downto 0);
   a0<= Coef_d1(12 downto 0);
   a1<= Coef_d1(20 downto 13);
   PolynomialEvaluator: PolynomialEvaluator_degree1_uid52  -- pipelineDepth=2 maxInDelay=0
      port map ( clk  => clk,
                 rst  => rst,
                 R => Rpe,
                 Y => y,
                 a0 => a0,
                 a1 => a1);
   ----------------Synchro barrier, entering cycle 4----------------
   -- weight of poly result is : 2
    R <= Rpe(13 downto 3);
end architecture;

--------------------------------------------------------------------------------
--                                 LNSAdd_4_9
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved
-- Authors: Sylvain Collange (2008)
--------------------------------------------------------------------------------
-- combinatorial

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity LNSAdd_4_9 is
   port ( 	
		  clk_p: in  std_logic;
		  rst_p: in  std_logic;
		  x : in  std_logic_vector(12 downto 0);
          r : out  std_logic_vector(8 downto 0)   );
end entity;

architecture arch of LNSAdd_4_9 is
   component FunctionEvaluator_29 is
      port ( clk, rst : in std_logic;
             X : in  std_logic_vector(10 downto 0);
             R : out  std_logic_vector(7 downto 0)   );
   end component;

   component FunctionEvaluator_49 is
      port ( clk, rst : in std_logic;
             X : in  std_logic_vector(10 downto 0);
             R : out  std_logic_vector(10 downto 0)   );
   end component;

   component FunctionEvaluator_9 is
      port ( clk, rst : in std_logic;
             X : in  std_logic_vector(11 downto 0);
             R : out  std_logic_vector(3 downto 0)   );
   end component;

	signal xi0 :  std_logic_vector(11 downto 0);
	signal out_t0 :  std_logic_vector(3 downto 0);
	signal xi1 :  std_logic_vector(10 downto 0);
	signal out_t1 :  std_logic_vector(7 downto 0);
	signal out_t2 :  std_logic_vector(10 downto 0);


begin
   xi0 <= x(11 downto 0);
   inst_t0: FunctionEvaluator_9  -- pipelineDepth=4 maxInDelay=0
      port map ( clk  => clk_p,   
                 rst  => rst_p,
                 R => out_t0,
                 X => xi0);
   xi1 <= x(10 downto 0);
   inst_t1: FunctionEvaluator_29  -- pipelineDepth=4 maxInDelay=0
      port map ( clk  => clk_p,
                 rst  => rst_p,
                 R => out_t1,
                 X => xi1);
   inst_t2: FunctionEvaluator_49  -- pipelineDepth=4 maxInDelay=0
      port map ( clk  => clk_p,
                 rst  => rst_p,
                 R => out_t2,
                 X => xi1);
  r <= (8 downto 3 => '0') & out_t0(2 downto 0)
         when x(12 downto 12) /= (12 downto 12 => '1') else
       (8 downto 6 => '0') & out_t1(5 downto 0)
         when x(11) /= '1' else
       out_t2(8 downto 0);
end architecture;

--------------------------------------------------------------------------------
--                               Cotran_4_9_6_4
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved
-- Authors: Sylvain Collange, Jesus Garcia (2005-2008)
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Cotran_4_9_6_4 is
   port (
		  clk_p: in  std_logic;
		  rst_p: in  std_logic;
		  Z : in  std_logic_vector(13 downto 0);
          IsSub : in std_logic;
          SBDB : out  std_logic_vector(13 downto 0)   );
end entity;

architecture arch of Cotran_4_9_6_4 is
   constant F : positive := 9;
   constant K : positive := 4;
   constant wEssZero : positive := 13;
   constant wBreak : positive := 6;
   constant DB_Max_Input : std_logic_vector := std_logic_vector(to_signed(-4879, K+F+1));
   signal SelMuxC, SelMuxB : std_logic_vector (1 downto 0);
   signal Special, IsEssZero : std_logic;
   signal Zh     : std_logic_vector (12 downto wBreak);
   signal Zl     : std_logic_vector (wBreak-1 downto 0);
   signal F1_v   : std_logic_vector (K+F downto 0);
   signal F2_v   : std_logic_vector (K+F downto 0);
   signal Zsum   : std_logic_vector (K+F downto 0);
   signal Zdif   : std_logic_vector (K+F downto 0);
   signal ZEssZero : std_logic_vector (K+F downto 0);
   signal Zfinal : std_logic_vector (K+F downto 0);
   signal DB0    : std_logic_vector (K+F downto 0);
   signal SB0 : std_logic_vector(F-1 downto 0);
   signal SBArg : std_logic_vector(K+F downto 0);
   signal SBPos : std_logic_vector(F downto 0);
   signal SB1 : std_logic_vector(F downto 0);
   signal SBArgSign : std_logic;
   signal SBEssZero : std_logic;

   component CotranF1Table_4_9_6 is
      port ( X : in  std_logic_vector(6 downto 0);
             Y : out  std_logic_vector(13 downto 0)   );
   end component;

   component CotranF2Table_9_6 is
      port ( X : in  std_logic_vector(5 downto 0);
             Y : out  std_logic_vector(13 downto 0)   );
   end component;

   component CotranF3Table_9_6 is
      port ( X : in  std_logic_vector(7 downto 0);
             Y : out  std_logic_vector(9 downto 0)   );
   end component;
 
  component LNSAdd_4_9 is
      port ( 
			clk_p: in  std_logic;
			rst_p: in  std_logic;
			x : in  std_logic_vector(12 downto 0);
            r : out  std_logic_vector(8 downto 0)   );
   end component;

begin

   Zh <= Z(12 downto wBreak);
   Zl <= Z(wBreak-1 downto 0);

   IsEssZero <= '1' when Z(K+F downto wBreak) < DB_Max_Input(K+F downto wBreak) else '0';

   Special <=
     '1' when Zh = (12 downto wBreak => '1') else
     '0';

   f1 : CotranF1Table_4_9_6
     port map (
       x => Zh,
       y => F1_v(13 downto 0));

   f2 : CotranF2Table_9_6
     port map (
       x => Zl,
       y => F2_v(13 downto 0));

   f3 : CotranF3Table_9_6
     port map (
       x => Z(7 downto 0),
       y => SBPos);

   SelMuxB <= IsSub & (IsEssZero or Special);

   SelMuxC <= (IsEssZero or (not IsSub)) & Special;
   Zdif <= std_logic_vector(signed(F2_v) - signed(F1_v) - signed(Z));
   Zsum  <= Z;
   ZEssZero <= '1' & (K+F-1 downto 0 => '0');
   with SelMuxB select                        -- MUX for the address to sb()
     Zfinal <=
     Zdif  when "10",
     ZEssZero when "11",
     Zsum  when others;

   SBArg <= Zfinal;

   with SelMuxC select
     DB0 <=
     F1_v                   when "00",   -- subtraction, not special case
     F2_v                   when "01",   -- subtraction, special case (not EZ)
     (F+K downto 0 => '0') when others;  -- addition, or subtraction and EZ

   sb : LNSAdd_4_9 port map (
							   clk_p => clk_p,
		  					   rst_p => rst_p,
							   x => SBArg(12 downto 0),
							   r => SB0);
	
	SBEssZero <=         '1' when SBArg(K+F downto wEssZero) /= (K+F downto wEssZero => '1') else
												'0';
	SBArgSign <= SBArg(K+F);

   -- special cases : essential zero, zero, positive
   SB1 <= SBPos when SBArgSign = '0' else
         (F downto 0 => '0') when SBEssZero = '1' else
         '0' & SB0;
   SBDB <= std_logic_vector(signed(DB0) + signed('0' & SB1));
end architecture;

--------------------------------------------------------------------------------
--                          Cotran_Hybrid_4_9_6_4_1
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved
-- Authors: Sylvain Collange, Jérémie Detrey (2008)
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Cotran_Hybrid_4_9_6_4_1 is
   port ( 
			clk_p : in std_logic;
			rst_p : in std_logic;
			Z : in  std_logic_vector(13 downto 0);
          	IsSub : in std_logic;
          	SBDB : out  std_logic_vector(13 downto 0)   );
end entity;

architecture arch of Cotran_Hybrid_4_9_6_4_1 is

   component Cotran_4_9_6_4 is port ( 
				clk_p : in std_logic;
			   	rst_p : in std_logic;
				Z : in std_logic_vector(13 downto 0);
             	IsSub : in std_logic;
             	SBDB : out  std_logic_vector(13 downto 0)   );
   end component;

   signal Out_Cotran : std_logic_vector(13 downto 0);

begin
   cotran : Cotran_4_9_6_4
     port map (
			   clk_p => clk_p,
			   rst_p => rst_p,
			   Z => Z,
			   IsSub => IsSub,
			   SBDB => Out_Cotran
			 );

   SBDB <= Out_Cotran;
end architecture;

--------------------------------------------------------------------------------
--                               LNSAddSub_4_9
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved
-- Authors: Jérémie Detrey, Florent de Dinechin (2003-2004), Sylvain Collange (2008)
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity LNSAddSub_4_9 is 
   port ( 
		  clk_p: in  std_logic;
		  rst_p: in  std_logic;
		  nA : in  std_logic_vector(15 downto 0);
          nB : in  std_logic_vector(15 downto 0);
          nR : out  std_logic_vector(15 downto 0)   );
end entity;

architecture arch of LNSAddSub_4_9 is

   component Cotran_Hybrid_4_9_6_4_1 is
      port (
				clk_p : in std_logic;
			   	rst_p : in std_logic;
				Z : in  std_logic_vector(13 downto 0);
            	IsSub : in std_logic;
            	SBDB : out  std_logic_vector(13 downto 0)   );
   end component;




   constant wE : positive := 4;
   constant wF : positive := 9;
   constant wEssZero : positive := 13;
   constant j : positive := 5;
   constant DB_Max_Input : integer := -4879;

   signal X, Y, R : std_logic_vector(wE + wF + 1 downto 0);
   signal Ov : std_logic;
   signal Zero : std_logic;
   signal xR : std_logic_vector(1 downto 0);
   signal xAB : std_logic_vector(3 downto 0);
   signal xA, xB : std_logic_vector(1 downto 0);
   signal sAB : std_logic;

   signal nA_r, nB_r : std_logic_vector(wE + wF + 2 downto 0);

   signal Z : std_logic_vector(wE + wF downto 0);
   signal Xv, Yv : std_logic_vector(wE + wF downto 0);
   signal SBDB : std_logic_vector(wE + wF downto 0);
   signal Za, Zb : std_logic_vector(wE + wF downto 0);
   signal IsEssZero, Special, SelMuxA : std_logic;
   signal R0_1 : std_logic_vector(wE + wF downto 0);
begin
   nA_r <= nA;
   nB_r <= nB;

   X(wE+wF-1 downto 0) <= nA(wE+wF-1 downto 0);
   X(wE+wF) <= nA(wE+wF-1);
   X(wE+wF+1) <= nA(wE+wF);     -- sign

   Y(wE+wF-1 downto 0) <= nB(wE+wF-1 downto 0);
   Y(wE+wF) <= nB(wE+wF-1);
   Y(wE+wF+1) <= nB(wE+wF);

   xR <=        "00"    when Zero = '1' else
                "10"    when Ov = '1' else
                "01";

   sAB <= nA_r(wE+wF) xor nB_r(wE+wF);

   Xv <= X(wE+wF downto 0);
   Yv <= Y(wE+wF downto 0);

   Za <= std_logic_vector(signed(Xv) - signed(Yv));
   Zb <= std_logic_vector(signed(Yv) - signed(Xv));

   with Za(wE+wF) select                   -- MUX for the negative
        Z <=
                Za when '1',                        -- Y > X
                Zb when others;                     -- X > Y

   addsub : Cotran_Hybrid_4_9_6_4_1
        port map (
				clk_p => clk_p,
			   	rst_p => rst_p,
                Z => Z,
                IsSub => sAB,
                SBDB => SBDB);

   IsEssZero <= '1' when signed(Z(wE+wF downto j)) < to_signed(DB_Max_Input, wE + wF - j + 1) else '0';

   Special <=
        '1' when Z(wEssZero-1 downto j) = (wEssZero-1 downto j => '1') else
        '0';

   SelMuxA <= (Za(wE+wF) and ((not sAB) or IsEssZero or Special) ) or
               (Zb(wE+wF) and (sAB and (not IsEssZero) and (not Special)) );

   with SelMuxA select
        R0_1 <=
                Yv when '1',
                Xv when others;

   R <= std_logic_vector(resize(signed(SBDB), wE+wF+2) + resize(signed(R0_1), wE+wF+2));


   xA <= nA_r(wE+wF+2 downto wE+wF+1);
   xB <= nB_r(wE+wF+2 downto wE+wF+1);
   xAB <= nA_r(wE+wF+2 downto wE+wF+1) & nB_r(wE+wF+2 downto wE+wF+1);

   nR(wE+wF+2 downto wE+wF+1) <= "11"       when xA =  "11" or xB = "11" else
                                 xR         when xAB = "0101" else
                                 "1" & sAB  when xAB = "1010" else
                                 xB         when xA =   "00" else
                                 xA;


   with xAB select
        nR(wE+wF) <=    R(wE+wF+1)                      when "0101",
                        nA_r(wE+wF) and nB_r(wE+wF)     when "0000",
                        nB_r(wE+wF)                     when "0001",
                        nA_r(wE+wF)                     when others;

   with xAB select
        nR(wE+wF-1 downto 0) <= R(wE+wF-1 downto 0)     when "0101",
                                nA_r(wE+wF-1 downto 0)  when "0100",
                                nB_r(wE+wF-1 downto 0)  when others;

end architecture;
