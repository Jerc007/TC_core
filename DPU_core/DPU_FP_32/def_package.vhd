----------------------------------------------------------------------------
-- Company:         	Politecnico di Torino
-- Engineer:          	Josie E. Rodriguez Condia
--
-- Create Date:     		23/10/2022
-- Module Name:   	internal packages
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


Library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package def_package is
        type operand_array is array(natural range <>) of std_logic_vector;
		constant long : natural := 32;
end package;



