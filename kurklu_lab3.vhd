library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity kurklu_lab3 is
	port(
		clk : in std_logic :='0';
		reset_n : in std_logic :='0';
		scl : inout std_logic := 'X';
		sda : inout std_logic := 'X';
		cs_n : out std_logic := '1';
		key : in std_logic :='X';
		segment0 : out std_logic_vector(6 downto 0);
		segment1 : out std_logic_vector(6 downto 0);
		segment2 : out std_logic_vector(6 downto 0);
		segment3 : out std_logic_vector(6 downto 0);
		segment4 : out std_logic_vector(6 downto 0);
		segment5 : out std_logic_vector(6 downto 0));
		
end entity kurklu_lab3;


architecture rit of kurklu_lab3 is

    component kurklu_lab3_sys is
        port (
            clk_clk       : in std_logic := 'X'; -- clk
            reset_reset_n : in std_logic := 'X';  -- reset_n
				opencores_i2c_0_export_0_scl_pad_io : inout std_logic := 'X'; -- scl_pad_io
            opencores_i2c_0_export_0_sda_pad_io : inout std_logic := 'X';  -- sda_pad_io
				key_external_connection_export      : in    std_logic := 'X'; -- export
				seg0_external_connection_export     : out   std_logic_vector(3 downto 0);        -- export
            seg1_external_connection_export     : out   std_logic_vector(3 downto 0);        -- export
            seg2_external_connection_export     : out   std_logic_vector(3 downto 0);        -- export
            seg3_external_connection_export     : out   std_logic_vector(3 downto 0);        -- export
            seg4_external_connection_export     : out   std_logic_vector(3 downto 0);        -- export
            seg5_external_connection_export     : out   std_logic_vector(6 downto 0)         -- export
        );
    end component kurklu_lab3_sys;
	 
	component bin_to_7seg is
			port(
				input : in std_logic_vector(3 downto 0):= (others => 'X');
				output : out std_logic_vector(6 downto 0));
	end component bin_to_7seg;
	
	
signal tmp0 : std_logic_vector(3 downto 0);
signal tmp1 : std_logic_vector(3 downto 0);
signal tmp2 : std_logic_vector(3 downto 0);
signal tmp3 : std_logic_vector(3 downto 0);
signal tmp4 : std_logic_vector(3 downto 0);
	
begin
    u0 : component kurklu_lab3_sys
        port map (
            clk_clk       => clk,       --   clk.clk
            reset_reset_n => reset_n,  -- reset.reset_n
				opencores_i2c_0_export_0_scl_pad_io => scl, -- opencores_i2c_0_export_0.scl_pad_io
            opencores_i2c_0_export_0_sda_pad_io => sda,  --                         .sda_pad_io
				key_external_connection_export      => key,      --  key_external_connection.export
				seg0_external_connection_export     => tmp0,     -- seg0_external_connection.export
            seg1_external_connection_export     => tmp1,     -- seg1_external_connection.export
            seg2_external_connection_export     => tmp2,     -- seg2_external_connection.export
            seg3_external_connection_export     => tmp3,     -- seg3_external_connection.export
            seg4_external_connection_export     => tmp4,     -- seg4_external_connection.export
            seg5_external_connection_export     => segment5     -- seg5_external_connection.export
        );
		  
		  
		  
	convert0 : component bin_to_7seg
			port map (
				input => tmp0,
				output => segment0);
				
	convert1 : component bin_to_7seg
			port map (
				input => tmp1,
				output => segment1);
				
	convert2 : component bin_to_7seg
			port map (
				input => tmp2,
				output => segment2);
				
	convert3 : component bin_to_7seg
			port map (
				input => tmp3,
				output => segment3);
				
	convert4 : component bin_to_7seg
			port map (
				input => tmp4,
				output => segment4);

end architecture;





