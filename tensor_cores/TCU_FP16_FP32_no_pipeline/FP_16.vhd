library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- 16-bit floating-point parallel multiplier entity declaration
entity FP_16 is
    generic (
        EXP_WIDTH : natural := 5;  -- Exponent width
        MANT_WIDTH : natural := 10  -- Mantissa width
    );
    port (
        A : in std_logic_vector((EXP_WIDTH + MANT_WIDTH) - 1 downto 0);
        B : in std_logic_vector((EXP_WIDTH + MANT_WIDTH) - 1 downto 0);
        Result : out std_logic_vector((2 * (EXP_WIDTH + MANT_WIDTH)) - 1 downto 0)
    );
end entity FP_16;

-- 16-bit floating-point parallel multiplier architecture
architecture behavioral of FP_16 is
begin
    process(A, B)
        variable a_exponent, b_exponent, result_exponent : integer;
        variable a_mantissa, b_mantissa, result_mantissa : unsigned(MANT_WIDTH - 1 downto 0);
        variable result_sign : std_logic;
        variable intermediate_result : signed(((EXP_WIDTH + MANT_WIDTH) * 2) - 1 downto 0);
    begin
        -- Extract exponent, mantissa, and sign for A and B
        a_exponent := to_integer(unsigned(A((EXP_WIDTH + MANT_WIDTH) - 1 downto MANT_WIDTH)));
        b_exponent := to_integer(unsigned(B((EXP_WIDTH + MANT_WIDTH) - 1 downto MANT_WIDTH)));
        a_mantissa := unsigned(A(MANT_WIDTH - 1 downto 0));
        b_mantissa := unsigned(B(MANT_WIDTH - 1 downto 0));
        result_sign := A((EXP_WIDTH + MANT_WIDTH) * 2) xor B((EXP_WIDTH + MANT_WIDTH) * 2);

        -- Multiply mantissas
        intermediate_result := signed(a_mantissa) * signed(b_mantissa);

        -- Calculate exponent and normalize result
        result_exponent := a_exponent + b_exponent - 2**(EXP_WIDTH - 1) + 1;
        result_mantissa := unsigned(intermediate_result((EXP_WIDTH + MANT_WIDTH - 1) downto EXP_WIDTH));

        -- Normalize result if necessary
        if intermediate_result((EXP_WIDTH + MANT_WIDTH) - 1) = '0' then
            -- Shift mantissa to the right if no overflow occurred
            result_mantissa := result_mantissa(result_mantissa'high - 1 downto 0);
        else
            -- Normalize by shifting mantissa to the left
            result_mantissa := result_mantissa(result_mantissa'high - 1 downto 0) & '0';
            result_exponent := result_exponent + 1;
        end if;

        -- Construct the result
        Result <= std_logic_vector(result_sign & unsigned(result_exponent) & result_mantissa);
    end process;
end architecture behavioral;

