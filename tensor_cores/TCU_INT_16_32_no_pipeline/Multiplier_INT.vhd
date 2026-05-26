library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Multiplier is
    Generic (
        N : integer := 16  -- Bit-width of input integers
    );
    Port (
        A     : in  STD_LOGIC_VECTOR(N-1 downto 0);  -- Multiplier
        B     : in  STD_LOGIC_VECTOR(N-1 downto 0);  -- Multiplicand
        P     : out STD_LOGIC_VECTOR( (2*N)-1 downto 0)  -- Product (2N-bit result)
    );
end Multiplier;

architecture Behavioral of Multiplier is
    signal product_internal : signed( (2*N)-1 downto 0);  -- Internal signed multiplication
begin
    process(A, B)
    begin
        product_internal <=  signed(A) * signed(B) ;  -- Multiply signed integers
    end process;

    P <= std_logic_vector(product_internal);  -- Convert result to std_logic_vector


end Behavioral;



---library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

--entity Multiplier is
--    Generic (
--        N : integer := 16
--    );
--    Port (
--        clk : in  STD_LOGIC;
--        A   : in  STD_LOGIC_VECTOR(N-1 downto 0);
--        B   : in  STD_LOGIC_VECTOR(N-1 downto 0);
--        P   : out STD_LOGIC_VECTOR((2*N)-1 downto 0)
--    );
--end Multiplier;

--architecture Behavioral of Multiplier is
--    signal product_internal : signed((2*N)-1 downto 0);
--begin

--    process(clk)
--    begin
--        if rising_edge(clk) then
--            product_internal <= signed(A) * signed(B);
--        end if;
--    end process;

--    P <= std_logic_vector(product_internal);

--end Behavioral;