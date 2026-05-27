--------------------------------------------------------------------------------
--                           IntAdder_14_f400_uid3
--                      (IntAdderClassical_14_f400_uid5)
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

entity IntAdder_14_f400_uid3 is
   port ( clk, rst : in std_logic;
          X : in  std_logic_vector(13 downto 0);
          Y : in  std_logic_vector(13 downto 0);
          Cin : in std_logic;
          R : out  std_logic_vector(13 downto 0)   );
end entity;

architecture arch of IntAdder_14_f400_uid3 is
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
--                                 LNSMul_4_9
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved
-- Authors: Jérémie Detrey, Florent de Dinechin (2003-2004), Sylvain Collange (2008)
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity LNSMul_4_9 is
   port ( clk, rst : in std_logic;
          nA : in  std_logic_vector(15 downto 0);
          nB : in  std_logic_vector(15 downto 0);
          nR : out  std_logic_vector(15 downto 0)   );
end entity;

architecture arch of LNSMul_4_9 is
   component IntAdder_14_f400_uid3 is
      port ( clk, rst : in std_logic;
             X : in  std_logic_vector(13 downto 0);
             Y : in  std_logic_vector(13 downto 0);
             Cin : in std_logic;
             R : out  std_logic_vector(13 downto 0)   );
   end component;

signal X :  std_logic_vector(13 downto 0);
signal Y :  std_logic_vector(13 downto 0);
signal eRn :  std_logic_vector(13 downto 0);
signal sRn : std_logic;
signal xRn :  std_logic_vector(1 downto 0);
signal nRn :  std_logic_vector(15 downto 0);
signal xA :  std_logic_vector(1 downto 0);
signal xB :  std_logic_vector(1 downto 0);
signal xAB :  std_logic_vector(3 downto 0);
constant wE: positive := 4;
constant wF: positive := 9;
begin

   process(clk)

      begin
         if clk'event and clk = '1' then
         end if;
      end process;

   X<= nA(wE+wF-1) & nA(wE+wF-1 downto 0);
   Y<= nB(wE+wF-1) & nB(wE+wF-1 downto 0);

   my_add: IntAdder_14_f400_uid3  -- pipelineDepth=0 maxInDelay=0
      port map ( clk  => clk,
                 rst  => rst,
                 Cin => '0',
                 R => eRn,
                 X => X,
                 Y => Y);

   sRn <= nA(wE+wF) xor nB(wE+wF);
   xRn <= "00" when eRn(wE+wF downto wE+wF-1) = "10" else
         "10" when eRn(wE+wF downto wE+wF-1) = "01" else
         "01";
   nRn <= xRn & sRn & eRn(wE+wF-1 downto 0);
   xA <= nA(wE+wF+2 downto wE+wF+1);
   xB <= nB(wE+wF+2 downto wE+wF+1);
   xAB <= xA & xB when xA >= xB else
         xB & xA;

   with xAB select nR(wE+wF+2 downto wE+wF+1) <= xRn  when "0101",
												 "00" when "0000" | "0100",
												 "10" when "1001" | "1010",
												 "11" when others;

   nR(wE+wF downto 0) <= nRn(wE+wF downto 0);

end architecture;