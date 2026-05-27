 library IEEE;
 use IEEE.STD_LOGIC_1164.ALL;
 use IEEE.NUMERIC_STD.ALL;

 entity Adder is
     Generic (
         N : integer := 16
     );
     Port (
         clk : in  STD_LOGIC;
         A   : in  STD_LOGIC_VECTOR(N-1 downto 0);
         B   : in  STD_LOGIC_VECTOR(N-1 downto 0);
         SUM : out STD_LOGIC_VECTOR(N-1 downto 0)
     );
 end Adder;

 architecture Behavioral of Adder is
     signal sum_internal : signed(N-1 downto 0);
 begin

     process(clk)
     begin
         if rising_edge(clk) then
             sum_internal <= signed(A) + signed(B);
         end if;
     end process;

     SUM <= std_logic_vector(sum_internal);

 end Behavioral;





-- library IEEE;
-- use IEEE.STD_LOGIC_1164.ALL;
-- use IEEE.NUMERIC_STD.ALL;

-- entity Adder is
--     Generic (
--         N : integer := 16  -- Bit-width of the adder
--     );
--     Port (
--         A       : in  STD_LOGIC_VECTOR(N-1 downto 0);
--         B       : in  STD_LOGIC_VECTOR(N-1 downto 0);
--         SUM     : out STD_LOGIC_VECTOR(N-1 downto 0)  
--     );
-- end Adder;

-- architecture Behavioral of Adder is
--     signal sum_internal : signed(N-1 downto 0);  -- Internal sum with overflow bit
-- begin
--     process (A, B)
--     begin
--         sum_internal <= signed(A) + signed(B);-- Extend for overflow
--     end process;

--     SUM <= std_logic_vector(sum_internal); -- Convert to std_logic_vector
    
-- end Behavioral;


