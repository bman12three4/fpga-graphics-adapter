-- Copyright (C) 1991-2014 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus II 64-Bit"
-- VERSION "Version 13.1.4 Build 182 03/12/2014 SJ Web Edition"

-- DATE "04/09/2020 13:26:03"

-- 
-- Device: Altera EP3C16F484C6 Package FBGA484
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY CYCLONEIII;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE CYCLONEIII.CYCLONEIII_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	fpga_graphics_adapter IS
    PORT (
	clk : IN std_logic;
	clk_ext1 : IN std_logic;
	cs : IN std_logic;
	rs : IN std_logic_vector(3 DOWNTO 0);
	wren : IN std_logic;
	data_bi : BUFFER std_logic_vector(7 DOWNTO 0);
	r_vga_o : BUFFER std_logic_vector(3 DOWNTO 0);
	g_vga_o : BUFFER std_logic_vector(3 DOWNTO 0);
	b_vga_o : BUFFER std_logic_vector(3 DOWNTO 0);
	v_sync_o : BUFFER std_logic;
	h_sync_o : BUFFER std_logic
	);
END fpga_graphics_adapter;

-- Design Ports Information
-- rs[0]	=>  Location: PIN_AB14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rs[1]	=>  Location: PIN_AA14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rs[2]	=>  Location: PIN_AB15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rs[3]	=>  Location: PIN_AA15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- r_vga_o[0]	=>  Location: PIN_H19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- r_vga_o[1]	=>  Location: PIN_H17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- r_vga_o[2]	=>  Location: PIN_H20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- r_vga_o[3]	=>  Location: PIN_H21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- g_vga_o[0]	=>  Location: PIN_H22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- g_vga_o[1]	=>  Location: PIN_J17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- g_vga_o[2]	=>  Location: PIN_K17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- g_vga_o[3]	=>  Location: PIN_J21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- b_vga_o[0]	=>  Location: PIN_K22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- b_vga_o[1]	=>  Location: PIN_K21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- b_vga_o[2]	=>  Location: PIN_J22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- b_vga_o[3]	=>  Location: PIN_K18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- v_sync_o	=>  Location: PIN_L22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- h_sync_o	=>  Location: PIN_L21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- data_bi[0]	=>  Location: PIN_AA5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- data_bi[1]	=>  Location: PIN_AB5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- data_bi[2]	=>  Location: PIN_AA8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- data_bi[3]	=>  Location: PIN_AB8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- data_bi[4]	=>  Location: PIN_AA10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- data_bi[5]	=>  Location: PIN_AB10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- data_bi[6]	=>  Location: PIN_AA13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- data_bi[7]	=>  Location: PIN_AB13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clk	=>  Location: PIN_G21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clk_ext1	=>  Location: PIN_U7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- wren	=>  Location: PIN_AA16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- cs	=>  Location: PIN_AB16,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF fpga_graphics_adapter IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_clk : std_logic;
SIGNAL ww_clk_ext1 : std_logic;
SIGNAL ww_cs : std_logic;
SIGNAL ww_rs : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_wren : std_logic;
SIGNAL ww_data_bi : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_r_vga_o : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_g_vga_o : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_b_vga_o : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_v_sync_o : std_logic;
SIGNAL ww_h_sync_o : std_logic;
SIGNAL \b|altpll_component|auto_generated|pll1_INCLK_bus\ : std_logic_vector(1 DOWNTO 0);
SIGNAL \b|altpll_component|auto_generated|pll1_CLK_bus\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \c|hsync~clkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \b|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \rs[0]~input_o\ : std_logic;
SIGNAL \rs[1]~input_o\ : std_logic;
SIGNAL \rs[2]~input_o\ : std_logic;
SIGNAL \rs[3]~input_o\ : std_logic;
SIGNAL \data_bi[0]~input_o\ : std_logic;
SIGNAL \data_bi[1]~input_o\ : std_logic;
SIGNAL \data_bi[2]~input_o\ : std_logic;
SIGNAL \data_bi[3]~input_o\ : std_logic;
SIGNAL \data_bi[4]~input_o\ : std_logic;
SIGNAL \data_bi[5]~input_o\ : std_logic;
SIGNAL \data_bi[6]~input_o\ : std_logic;
SIGNAL \data_bi[7]~input_o\ : std_logic;
SIGNAL \cs~input_o\ : std_logic;
SIGNAL \clk_ext1~input_o\ : std_logic;
SIGNAL \wren~input_o\ : std_logic;
SIGNAL \data_bi~16_combout\ : std_logic;
SIGNAL \clk~input_o\ : std_logic;
SIGNAL \b|altpll_component|auto_generated|wire_pll1_fbout\ : std_logic;
SIGNAL \b|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\ : std_logic;
SIGNAL \c|h_pixel[0]~10_combout\ : std_logic;
SIGNAL \c|h_pixel[5]~21\ : std_logic;
SIGNAL \c|h_pixel[6]~22_combout\ : std_logic;
SIGNAL \c|h_pixel[6]~23\ : std_logic;
SIGNAL \c|h_pixel[7]~24_combout\ : std_logic;
SIGNAL \c|h_pixel[7]~25\ : std_logic;
SIGNAL \c|h_pixel[8]~26_combout\ : std_logic;
SIGNAL \c|h_pixel[8]~27\ : std_logic;
SIGNAL \c|h_pixel[9]~28_combout\ : std_logic;
SIGNAL \c|h_pixel~30_combout\ : std_logic;
SIGNAL \c|h_pixel[0]~11\ : std_logic;
SIGNAL \c|h_pixel[1]~12_combout\ : std_logic;
SIGNAL \c|h_pixel[1]~13\ : std_logic;
SIGNAL \c|h_pixel[2]~14_combout\ : std_logic;
SIGNAL \c|h_pixel[2]~15\ : std_logic;
SIGNAL \c|h_pixel[3]~16_combout\ : std_logic;
SIGNAL \c|h_pixel[3]~17\ : std_logic;
SIGNAL \c|h_pixel[4]~18_combout\ : std_logic;
SIGNAL \c|h_pixel[4]~19\ : std_logic;
SIGNAL \c|h_pixel[5]~20_combout\ : std_logic;
SIGNAL \c|hsync~2_combout\ : std_logic;
SIGNAL \c|hsync~4_combout\ : std_logic;
SIGNAL \c|hsync~5_combout\ : std_logic;
SIGNAL \c|hsync~0_combout\ : std_logic;
SIGNAL \c|hsync~1_combout\ : std_logic;
SIGNAL \c|hsync~3_combout\ : std_logic;
SIGNAL \c|hsync~6_combout\ : std_logic;
SIGNAL \c|hsync~q\ : std_logic;
SIGNAL \c|hsync~clkctrl_outclk\ : std_logic;
SIGNAL \c|line[0]~10_combout\ : std_logic;
SIGNAL \c|line[7]~26\ : std_logic;
SIGNAL \c|line[8]~27_combout\ : std_logic;
SIGNAL \c|line[8]~28\ : std_logic;
SIGNAL \c|line[9]~29_combout\ : std_logic;
SIGNAL \c|vsync~3_combout\ : std_logic;
SIGNAL \c|line~20_combout\ : std_logic;
SIGNAL \c|line[0]~11\ : std_logic;
SIGNAL \c|line[1]~12_combout\ : std_logic;
SIGNAL \c|line[1]~13\ : std_logic;
SIGNAL \c|line[2]~14_combout\ : std_logic;
SIGNAL \c|line[2]~15\ : std_logic;
SIGNAL \c|line[3]~16_combout\ : std_logic;
SIGNAL \c|line[3]~17\ : std_logic;
SIGNAL \c|line[4]~18_combout\ : std_logic;
SIGNAL \c|line[4]~19\ : std_logic;
SIGNAL \c|line[5]~21_combout\ : std_logic;
SIGNAL \c|line[5]~22\ : std_logic;
SIGNAL \c|line[6]~23_combout\ : std_logic;
SIGNAL \c|line[6]~24\ : std_logic;
SIGNAL \c|line[7]~25_combout\ : std_logic;
SIGNAL \c|vsync~4_combout\ : std_logic;
SIGNAL \c|vsync~1_combout\ : std_logic;
SIGNAL \c|vsync~0_combout\ : std_logic;
SIGNAL \c|vsync~2_combout\ : std_logic;
SIGNAL \c|vsync~5_combout\ : std_logic;
SIGNAL \c|vsync~q\ : std_logic;
SIGNAL \c|line\ : std_logic_vector(9 DOWNTO 0);
SIGNAL \b|altpll_component|auto_generated|wire_pll1_clk\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \c|h_pixel\ : std_logic_vector(9 DOWNTO 0);

BEGIN

ww_clk <= clk;
ww_clk_ext1 <= clk_ext1;
ww_cs <= cs;
ww_rs <= rs;
ww_wren <= wren;
data_bi <= ww_data_bi;
r_vga_o <= ww_r_vga_o;
g_vga_o <= ww_g_vga_o;
b_vga_o <= ww_b_vga_o;
v_sync_o <= ww_v_sync_o;
h_sync_o <= ww_h_sync_o;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\b|altpll_component|auto_generated|pll1_INCLK_bus\ <= (gnd & \clk~input_o\);

\b|altpll_component|auto_generated|wire_pll1_clk\(0) <= \b|altpll_component|auto_generated|pll1_CLK_bus\(0);
\b|altpll_component|auto_generated|wire_pll1_clk\(1) <= \b|altpll_component|auto_generated|pll1_CLK_bus\(1);
\b|altpll_component|auto_generated|wire_pll1_clk\(2) <= \b|altpll_component|auto_generated|pll1_CLK_bus\(2);
\b|altpll_component|auto_generated|wire_pll1_clk\(3) <= \b|altpll_component|auto_generated|pll1_CLK_bus\(3);
\b|altpll_component|auto_generated|wire_pll1_clk\(4) <= \b|altpll_component|auto_generated|pll1_CLK_bus\(4);

\c|hsync~clkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \c|hsync~q\);

\b|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \b|altpll_component|auto_generated|wire_pll1_clk\(0));

-- Location: IOOBUF_X41_Y23_N23
\r_vga_o[0]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_r_vga_o(0));

-- Location: IOOBUF_X41_Y25_N2
\r_vga_o[1]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_r_vga_o(1));

-- Location: IOOBUF_X41_Y22_N2
\r_vga_o[2]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_r_vga_o(2));

-- Location: IOOBUF_X41_Y21_N23
\r_vga_o[3]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_r_vga_o(3));

-- Location: IOOBUF_X41_Y20_N2
\g_vga_o[0]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_g_vga_o(0));

-- Location: IOOBUF_X41_Y24_N23
\g_vga_o[1]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_g_vga_o(1));

-- Location: IOOBUF_X41_Y21_N16
\g_vga_o[2]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_g_vga_o(2));

-- Location: IOOBUF_X41_Y20_N23
\g_vga_o[3]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_g_vga_o(3));

-- Location: IOOBUF_X41_Y19_N16
\b_vga_o[0]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_b_vga_o(0));

-- Location: IOOBUF_X41_Y19_N9
\b_vga_o[1]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_b_vga_o(1));

-- Location: IOOBUF_X41_Y19_N2
\b_vga_o[2]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_b_vga_o(2));

-- Location: IOOBUF_X41_Y21_N9
\b_vga_o[3]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_b_vga_o(3));

-- Location: IOOBUF_X41_Y18_N23
\v_sync_o~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \c|vsync~q\,
	devoe => ww_devoe,
	o => ww_v_sync_o);

-- Location: IOOBUF_X41_Y18_N16
\h_sync_o~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \c|hsync~q\,
	devoe => ww_devoe,
	o => ww_h_sync_o);

-- Location: IOOBUF_X9_Y0_N30
\data_bi[0]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "true")
-- pragma translate_on
PORT MAP (
	i => \data_bi~16_combout\,
	oe => VCC,
	devoe => ww_devoe,
	o => ww_data_bi(0));

-- Location: IOOBUF_X9_Y0_N23
\data_bi[1]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "true")
-- pragma translate_on
PORT MAP (
	i => \data_bi~16_combout\,
	oe => VCC,
	devoe => ww_devoe,
	o => ww_data_bi(1));

-- Location: IOOBUF_X16_Y0_N30
\data_bi[2]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "true")
-- pragma translate_on
PORT MAP (
	i => \data_bi~16_combout\,
	oe => VCC,
	devoe => ww_devoe,
	o => ww_data_bi(2));

-- Location: IOOBUF_X16_Y0_N23
\data_bi[3]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "true")
-- pragma translate_on
PORT MAP (
	i => \data_bi~16_combout\,
	oe => VCC,
	devoe => ww_devoe,
	o => ww_data_bi(3));

-- Location: IOOBUF_X19_Y0_N2
\data_bi[4]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "true")
-- pragma translate_on
PORT MAP (
	i => \data_bi~16_combout\,
	oe => VCC,
	devoe => ww_devoe,
	o => ww_data_bi(4));

-- Location: IOOBUF_X21_Y0_N30
\data_bi[5]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "true")
-- pragma translate_on
PORT MAP (
	i => \data_bi~16_combout\,
	oe => VCC,
	devoe => ww_devoe,
	o => ww_data_bi(5));

-- Location: IOOBUF_X23_Y0_N30
\data_bi[6]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "true")
-- pragma translate_on
PORT MAP (
	i => \data_bi~16_combout\,
	oe => VCC,
	devoe => ww_devoe,
	o => ww_data_bi(6));

-- Location: IOOBUF_X23_Y0_N23
\data_bi[7]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "true")
-- pragma translate_on
PORT MAP (
	i => \data_bi~16_combout\,
	oe => VCC,
	devoe => ww_devoe,
	o => ww_data_bi(7));

-- Location: IOIBUF_X28_Y0_N15
\cs~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_cs,
	o => \cs~input_o\);

-- Location: IOIBUF_X3_Y0_N22
\clk_ext1~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk_ext1,
	o => \clk_ext1~input_o\);

-- Location: IOIBUF_X28_Y0_N22
\wren~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_wren,
	o => \wren~input_o\);

-- Location: LCCOMB_X24_Y1_N16
\data_bi~16\ : cycloneiii_lcell_comb
-- Equation(s):
-- \data_bi~16_combout\ = (\cs~input_o\) # ((!\wren~input_o\) # (!\clk_ext1~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \cs~input_o\,
	datac => \clk_ext1~input_o\,
	datad => \wren~input_o\,
	combout => \data_bi~16_combout\);

-- Location: IOIBUF_X41_Y15_N1
\clk~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk,
	o => \clk~input_o\);

-- Location: PLL_2
\b|altpll_component|auto_generated|pll1\ : cycloneiii_pll
-- pragma translate_off
GENERIC MAP (
	auto_settings => "false",
	bandwidth_type => "medium",
	c0_high => 11,
	c0_initial => 1,
	c0_low => 10,
	c0_mode => "odd",
	c0_ph => 0,
	c1_high => 0,
	c1_initial => 0,
	c1_low => 0,
	c1_mode => "bypass",
	c1_ph => 0,
	c1_use_casc_in => "off",
	c2_high => 0,
	c2_initial => 0,
	c2_low => 0,
	c2_mode => "bypass",
	c2_ph => 0,
	c2_use_casc_in => "off",
	c3_high => 0,
	c3_initial => 0,
	c3_low => 0,
	c3_mode => "bypass",
	c3_ph => 0,
	c3_use_casc_in => "off",
	c4_high => 0,
	c4_initial => 0,
	c4_low => 0,
	c4_mode => "bypass",
	c4_ph => 0,
	c4_use_casc_in => "off",
	charge_pump_current_bits => 1,
	clk0_counter => "c0",
	clk0_divide_by => 147,
	clk0_duty_cycle => 50,
	clk0_multiply_by => 74,
	clk0_phase_shift => "0",
	clk1_counter => "unused",
	clk1_divide_by => 0,
	clk1_duty_cycle => 50,
	clk1_multiply_by => 0,
	clk1_phase_shift => "0",
	clk2_counter => "unused",
	clk2_divide_by => 0,
	clk2_duty_cycle => 50,
	clk2_multiply_by => 0,
	clk2_phase_shift => "0",
	clk3_counter => "unused",
	clk3_divide_by => 0,
	clk3_duty_cycle => 50,
	clk3_multiply_by => 0,
	clk3_phase_shift => "0",
	clk4_counter => "unused",
	clk4_divide_by => 0,
	clk4_duty_cycle => 50,
	clk4_multiply_by => 0,
	clk4_phase_shift => "0",
	compensate_clock => "clock0",
	inclk0_input_frequency => 20000,
	inclk1_input_frequency => 0,
	loop_filter_c_bits => 0,
	loop_filter_r_bits => 16,
	m => 74,
	m_initial => 1,
	m_ph => 0,
	n => 7,
	operation_mode => "normal",
	pfd_max => 200000,
	pfd_min => 3076,
	pll_compensation_delay => 5738,
	self_reset_on_loss_lock => "off",
	simulation_type => "timing",
	switch_over_type => "auto",
	vco_center => 1538,
	vco_divide_by => 0,
	vco_frequency_control => "auto",
	vco_max => 3333,
	vco_min => 1538,
	vco_multiply_by => 0,
	vco_phase_shift_step => 236,
	vco_post_scale => 2)
-- pragma translate_on
PORT MAP (
	fbin => \b|altpll_component|auto_generated|wire_pll1_fbout\,
	inclk => \b|altpll_component|auto_generated|pll1_INCLK_bus\,
	fbout => \b|altpll_component|auto_generated|wire_pll1_fbout\,
	clk => \b|altpll_component|auto_generated|pll1_CLK_bus\);

-- Location: CLKCTRL_G8
\b|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl\ : cycloneiii_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \b|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \b|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\);

-- Location: LCCOMB_X37_Y14_N10
\c|h_pixel[0]~10\ : cycloneiii_lcell_comb
-- Equation(s):
-- \c|h_pixel[0]~10_combout\ = \c|h_pixel\(0) $ (VCC)
-- \c|h_pixel[0]~11\ = CARRY(\c|h_pixel\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010110101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|h_pixel\(0),
	datad => VCC,
	combout => \c|h_pixel[0]~10_combout\,
	cout => \c|h_pixel[0]~11\);

-- Location: LCCOMB_X37_Y14_N20
\c|h_pixel[5]~20\ : cycloneiii_lcell_comb
-- Equation(s):
-- \c|h_pixel[5]~20_combout\ = (\c|h_pixel\(5) & (!\c|h_pixel[4]~19\)) # (!\c|h_pixel\(5) & ((\c|h_pixel[4]~19\) # (GND)))
-- \c|h_pixel[5]~21\ = CARRY((!\c|h_pixel[4]~19\) # (!\c|h_pixel\(5)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \c|h_pixel\(5),
	datad => VCC,
	cin => \c|h_pixel[4]~19\,
	combout => \c|h_pixel[5]~20_combout\,
	cout => \c|h_pixel[5]~21\);

-- Location: LCCOMB_X37_Y14_N22
\c|h_pixel[6]~22\ : cycloneiii_lcell_comb
-- Equation(s):
-- \c|h_pixel[6]~22_combout\ = (\c|h_pixel\(6) & (\c|h_pixel[5]~21\ $ (GND))) # (!\c|h_pixel\(6) & (!\c|h_pixel[5]~21\ & VCC))
-- \c|h_pixel[6]~23\ = CARRY((\c|h_pixel\(6) & !\c|h_pixel[5]~21\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \c|h_pixel\(6),
	datad => VCC,
	cin => \c|h_pixel[5]~21\,
	combout => \c|h_pixel[6]~22_combout\,
	cout => \c|h_pixel[6]~23\);

-- Location: FF_X37_Y14_N23
\c|h_pixel[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \b|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \c|h_pixel[6]~22_combout\,
	sclr => \c|h_pixel~30_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \c|h_pixel\(6));

-- Location: LCCOMB_X37_Y14_N24
\c|h_pixel[7]~24\ : cycloneiii_lcell_comb
-- Equation(s):
-- \c|h_pixel[7]~24_combout\ = (\c|h_pixel\(7) & (!\c|h_pixel[6]~23\)) # (!\c|h_pixel\(7) & ((\c|h_pixel[6]~23\) # (GND)))
-- \c|h_pixel[7]~25\ = CARRY((!\c|h_pixel[6]~23\) # (!\c|h_pixel\(7)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \c|h_pixel\(7),
	datad => VCC,
	cin => \c|h_pixel[6]~23\,
	combout => \c|h_pixel[7]~24_combout\,
	cout => \c|h_pixel[7]~25\);

-- Location: FF_X37_Y14_N25
\c|h_pixel[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \b|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \c|h_pixel[7]~24_combout\,
	sclr => \c|h_pixel~30_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \c|h_pixel\(7));

-- Location: LCCOMB_X37_Y14_N26
\c|h_pixel[8]~26\ : cycloneiii_lcell_comb
-- Equation(s):
-- \c|h_pixel[8]~26_combout\ = (\c|h_pixel\(8) & (\c|h_pixel[7]~25\ $ (GND))) # (!\c|h_pixel\(8) & (!\c|h_pixel[7]~25\ & VCC))
-- \c|h_pixel[8]~27\ = CARRY((\c|h_pixel\(8) & !\c|h_pixel[7]~25\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \c|h_pixel\(8),
	datad => VCC,
	cin => \c|h_pixel[7]~25\,
	combout => \c|h_pixel[8]~26_combout\,
	cout => \c|h_pixel[8]~27\);

-- Location: FF_X37_Y14_N27
\c|h_pixel[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \b|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \c|h_pixel[8]~26_combout\,
	sclr => \c|h_pixel~30_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \c|h_pixel\(8));

-- Location: LCCOMB_X37_Y14_N28
\c|h_pixel[9]~28\ : cycloneiii_lcell_comb
-- Equation(s):
-- \c|h_pixel[9]~28_combout\ = \c|h_pixel[8]~27\ $ (\c|h_pixel\(9))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datad => \c|h_pixel\(9),
	cin => \c|h_pixel[8]~27\,
	combout => \c|h_pixel[9]~28_combout\);

-- Location: FF_X37_Y14_N29
\c|h_pixel[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \b|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \c|h_pixel[9]~28_combout\,
	sclr => \c|h_pixel~30_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \c|h_pixel\(9));

-- Location: LCCOMB_X37_Y14_N2
\c|h_pixel~30\ : cycloneiii_lcell_comb
-- Equation(s):
-- \c|h_pixel~30_combout\ = (\c|h_pixel\(8) & (\c|h_pixel\(9) & ((\c|h_pixel\(7)) # (!\c|hsync~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|hsync~2_combout\,
	datab => \c|h_pixel\(7),
	datac => \c|h_pixel\(8),
	datad => \c|h_pixel\(9),
	combout => \c|h_pixel~30_combout\);

-- Location: FF_X37_Y14_N11
\c|h_pixel[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \b|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \c|h_pixel[0]~10_combout\,
	sclr => \c|h_pixel~30_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \c|h_pixel\(0));

-- Location: LCCOMB_X37_Y14_N12
\c|h_pixel[1]~12\ : cycloneiii_lcell_comb
-- Equation(s):
-- \c|h_pixel[1]~12_combout\ = (\c|h_pixel\(1) & (!\c|h_pixel[0]~11\)) # (!\c|h_pixel\(1) & ((\c|h_pixel[0]~11\) # (GND)))
-- \c|h_pixel[1]~13\ = CARRY((!\c|h_pixel[0]~11\) # (!\c|h_pixel\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \c|h_pixel\(1),
	datad => VCC,
	cin => \c|h_pixel[0]~11\,
	combout => \c|h_pixel[1]~12_combout\,
	cout => \c|h_pixel[1]~13\);

-- Location: FF_X37_Y14_N13
\c|h_pixel[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \b|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \c|h_pixel[1]~12_combout\,
	sclr => \c|h_pixel~30_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \c|h_pixel\(1));

-- Location: LCCOMB_X37_Y14_N14
\c|h_pixel[2]~14\ : cycloneiii_lcell_comb
-- Equation(s):
-- \c|h_pixel[2]~14_combout\ = (\c|h_pixel\(2) & (\c|h_pixel[1]~13\ $ (GND))) # (!\c|h_pixel\(2) & (!\c|h_pixel[1]~13\ & VCC))
-- \c|h_pixel[2]~15\ = CARRY((\c|h_pixel\(2) & !\c|h_pixel[1]~13\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \c|h_pixel\(2),
	datad => VCC,
	cin => \c|h_pixel[1]~13\,
	combout => \c|h_pixel[2]~14_combout\,
	cout => \c|h_pixel[2]~15\);

-- Location: FF_X37_Y14_N15
\c|h_pixel[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \b|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \c|h_pixel[2]~14_combout\,
	sclr => \c|h_pixel~30_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \c|h_pixel\(2));

-- Location: LCCOMB_X37_Y14_N16
\c|h_pixel[3]~16\ : cycloneiii_lcell_comb
-- Equation(s):
-- \c|h_pixel[3]~16_combout\ = (\c|h_pixel\(3) & (!\c|h_pixel[2]~15\)) # (!\c|h_pixel\(3) & ((\c|h_pixel[2]~15\) # (GND)))
-- \c|h_pixel[3]~17\ = CARRY((!\c|h_pixel[2]~15\) # (!\c|h_pixel\(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \c|h_pixel\(3),
	datad => VCC,
	cin => \c|h_pixel[2]~15\,
	combout => \c|h_pixel[3]~16_combout\,
	cout => \c|h_pixel[3]~17\);

-- Location: FF_X37_Y14_N17
\c|h_pixel[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \b|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \c|h_pixel[3]~16_combout\,
	sclr => \c|h_pixel~30_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \c|h_pixel\(3));

-- Location: LCCOMB_X37_Y14_N18
\c|h_pixel[4]~18\ : cycloneiii_lcell_comb
-- Equation(s):
-- \c|h_pixel[4]~18_combout\ = (\c|h_pixel\(4) & (\c|h_pixel[3]~17\ $ (GND))) # (!\c|h_pixel\(4) & (!\c|h_pixel[3]~17\ & VCC))
-- \c|h_pixel[4]~19\ = CARRY((\c|h_pixel\(4) & !\c|h_pixel[3]~17\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \c|h_pixel\(4),
	datad => VCC,
	cin => \c|h_pixel[3]~17\,
	combout => \c|h_pixel[4]~18_combout\,
	cout => \c|h_pixel[4]~19\);

-- Location: FF_X37_Y14_N19
\c|h_pixel[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \b|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \c|h_pixel[4]~18_combout\,
	sclr => \c|h_pixel~30_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \c|h_pixel\(4));

-- Location: FF_X37_Y14_N21
\c|h_pixel[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \b|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \c|h_pixel[5]~20_combout\,
	sclr => \c|h_pixel~30_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \c|h_pixel\(5));

-- Location: LCCOMB_X36_Y14_N24
\c|hsync~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \c|hsync~2_combout\ = (!\c|h_pixel\(5) & !\c|h_pixel\(6))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \c|h_pixel\(5),
	datad => \c|h_pixel\(6),
	combout => \c|hsync~2_combout\);

-- Location: LCCOMB_X37_Y14_N6
\c|hsync~4\ : cycloneiii_lcell_comb
-- Equation(s):
-- \c|hsync~4_combout\ = (\c|hsync~2_combout\ & (((!\c|h_pixel\(3) & !\c|h_pixel\(2))) # (!\c|h_pixel\(4))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|hsync~2_combout\,
	datab => \c|h_pixel\(3),
	datac => \c|h_pixel\(2),
	datad => \c|h_pixel\(4),
	combout => \c|hsync~4_combout\);

-- Location: LCCOMB_X37_Y14_N4
\c|hsync~5\ : cycloneiii_lcell_comb
-- Equation(s):
-- \c|hsync~5_combout\ = (\c|hsync~4_combout\) # (((\c|h_pixel\(8)) # (!\c|h_pixel\(9))) # (!\c|h_pixel\(7)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|hsync~4_combout\,
	datab => \c|h_pixel\(7),
	datac => \c|h_pixel\(8),
	datad => \c|h_pixel\(9),
	combout => \c|hsync~5_combout\);

-- Location: LCCOMB_X37_Y14_N0
\c|hsync~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \c|hsync~0_combout\ = (\c|h_pixel\(5) & (\c|h_pixel\(4) & ((\c|h_pixel\(3)) # (\c|h_pixel\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|h_pixel\(5),
	datab => \c|h_pixel\(3),
	datac => \c|h_pixel\(2),
	datad => \c|h_pixel\(4),
	combout => \c|hsync~0_combout\);

-- Location: LCCOMB_X37_Y14_N30
\c|hsync~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \c|hsync~1_combout\ = (!\c|h_pixel\(8) & (\c|hsync~0_combout\ & (\c|h_pixel\(6) & \c|h_pixel\(7))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|h_pixel\(8),
	datab => \c|hsync~0_combout\,
	datac => \c|h_pixel\(6),
	datad => \c|h_pixel\(7),
	combout => \c|hsync~1_combout\);

-- Location: LCCOMB_X37_Y14_N8
\c|hsync~3\ : cycloneiii_lcell_comb
-- Equation(s):
-- \c|hsync~3_combout\ = (\c|hsync~1_combout\) # ((\c|hsync~2_combout\ & (\c|h_pixel\(8) & !\c|h_pixel\(7))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101011101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|hsync~1_combout\,
	datab => \c|hsync~2_combout\,
	datac => \c|h_pixel\(8),
	datad => \c|h_pixel\(7),
	combout => \c|hsync~3_combout\);

-- Location: LCCOMB_X40_Y15_N16
\c|hsync~6\ : cycloneiii_lcell_comb
-- Equation(s):
-- \c|hsync~6_combout\ = (\c|hsync~5_combout\ & ((\c|hsync~q\) # ((\c|hsync~3_combout\ & \c|h_pixel\(9))))) # (!\c|hsync~5_combout\ & (\c|hsync~3_combout\ & ((\c|h_pixel\(9)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|hsync~5_combout\,
	datab => \c|hsync~3_combout\,
	datac => \c|hsync~q\,
	datad => \c|h_pixel\(9),
	combout => \c|hsync~6_combout\);

-- Location: FF_X40_Y15_N17
\c|hsync\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \b|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \c|hsync~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \c|hsync~q\);

-- Location: CLKCTRL_G7
\c|hsync~clkctrl\ : cycloneiii_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \c|hsync~clkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \c|hsync~clkctrl_outclk\);

-- Location: LCCOMB_X39_Y18_N8
\c|line[0]~10\ : cycloneiii_lcell_comb
-- Equation(s):
-- \c|line[0]~10_combout\ = \c|line\(0) $ (VCC)
-- \c|line[0]~11\ = CARRY(\c|line\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \c|line\(0),
	datad => VCC,
	combout => \c|line[0]~10_combout\,
	cout => \c|line[0]~11\);

-- Location: LCCOMB_X39_Y18_N22
\c|line[7]~25\ : cycloneiii_lcell_comb
-- Equation(s):
-- \c|line[7]~25_combout\ = (\c|line\(7) & (!\c|line[6]~24\)) # (!\c|line\(7) & ((\c|line[6]~24\) # (GND)))
-- \c|line[7]~26\ = CARRY((!\c|line[6]~24\) # (!\c|line\(7)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \c|line\(7),
	datad => VCC,
	cin => \c|line[6]~24\,
	combout => \c|line[7]~25_combout\,
	cout => \c|line[7]~26\);

-- Location: LCCOMB_X39_Y18_N24
\c|line[8]~27\ : cycloneiii_lcell_comb
-- Equation(s):
-- \c|line[8]~27_combout\ = (\c|line\(8) & (\c|line[7]~26\ $ (GND))) # (!\c|line\(8) & (!\c|line[7]~26\ & VCC))
-- \c|line[8]~28\ = CARRY((\c|line\(8) & !\c|line[7]~26\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \c|line\(8),
	datad => VCC,
	cin => \c|line[7]~26\,
	combout => \c|line[8]~27_combout\,
	cout => \c|line[8]~28\);

-- Location: FF_X39_Y18_N25
\c|line[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \c|hsync~clkctrl_outclk\,
	d => \c|line[8]~27_combout\,
	sclr => \c|line~20_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \c|line\(8));

-- Location: LCCOMB_X39_Y18_N26
\c|line[9]~29\ : cycloneiii_lcell_comb
-- Equation(s):
-- \c|line[9]~29_combout\ = \c|line\(9) $ (\c|line[8]~28\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \c|line\(9),
	cin => \c|line[8]~28\,
	combout => \c|line[9]~29_combout\);

-- Location: FF_X39_Y18_N27
\c|line[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \c|hsync~clkctrl_outclk\,
	d => \c|line[9]~29_combout\,
	sclr => \c|line~20_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \c|line\(9));

-- Location: LCCOMB_X39_Y18_N4
\c|vsync~3\ : cycloneiii_lcell_comb
-- Equation(s):
-- \c|vsync~3_combout\ = (((!\c|line\(1) & !\c|line\(0))) # (!\c|line\(3))) # (!\c|line\(2))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111011101111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|line\(2),
	datab => \c|line\(3),
	datac => \c|line\(1),
	datad => \c|line\(0),
	combout => \c|vsync~3_combout\);

-- Location: LCCOMB_X39_Y18_N0
\c|line~20\ : cycloneiii_lcell_comb
-- Equation(s):
-- \c|line~20_combout\ = (\c|line\(9) & ((\c|line\(8)) # ((!\c|vsync~4_combout\) # (!\c|vsync~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000101010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|line\(9),
	datab => \c|line\(8),
	datac => \c|vsync~3_combout\,
	datad => \c|vsync~4_combout\,
	combout => \c|line~20_combout\);

-- Location: FF_X39_Y18_N9
\c|line[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \c|hsync~clkctrl_outclk\,
	d => \c|line[0]~10_combout\,
	sclr => \c|line~20_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \c|line\(0));

-- Location: LCCOMB_X39_Y18_N10
\c|line[1]~12\ : cycloneiii_lcell_comb
-- Equation(s):
-- \c|line[1]~12_combout\ = (\c|line\(1) & (!\c|line[0]~11\)) # (!\c|line\(1) & ((\c|line[0]~11\) # (GND)))
-- \c|line[1]~13\ = CARRY((!\c|line[0]~11\) # (!\c|line\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \c|line\(1),
	datad => VCC,
	cin => \c|line[0]~11\,
	combout => \c|line[1]~12_combout\,
	cout => \c|line[1]~13\);

-- Location: FF_X39_Y18_N11
\c|line[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \c|hsync~clkctrl_outclk\,
	d => \c|line[1]~12_combout\,
	sclr => \c|line~20_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \c|line\(1));

-- Location: LCCOMB_X39_Y18_N12
\c|line[2]~14\ : cycloneiii_lcell_comb
-- Equation(s):
-- \c|line[2]~14_combout\ = (\c|line\(2) & (\c|line[1]~13\ $ (GND))) # (!\c|line\(2) & (!\c|line[1]~13\ & VCC))
-- \c|line[2]~15\ = CARRY((\c|line\(2) & !\c|line[1]~13\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \c|line\(2),
	datad => VCC,
	cin => \c|line[1]~13\,
	combout => \c|line[2]~14_combout\,
	cout => \c|line[2]~15\);

-- Location: FF_X39_Y18_N13
\c|line[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \c|hsync~clkctrl_outclk\,
	d => \c|line[2]~14_combout\,
	sclr => \c|line~20_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \c|line\(2));

-- Location: LCCOMB_X39_Y18_N14
\c|line[3]~16\ : cycloneiii_lcell_comb
-- Equation(s):
-- \c|line[3]~16_combout\ = (\c|line\(3) & (!\c|line[2]~15\)) # (!\c|line\(3) & ((\c|line[2]~15\) # (GND)))
-- \c|line[3]~17\ = CARRY((!\c|line[2]~15\) # (!\c|line\(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \c|line\(3),
	datad => VCC,
	cin => \c|line[2]~15\,
	combout => \c|line[3]~16_combout\,
	cout => \c|line[3]~17\);

-- Location: FF_X39_Y18_N15
\c|line[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \c|hsync~clkctrl_outclk\,
	d => \c|line[3]~16_combout\,
	sclr => \c|line~20_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \c|line\(3));

-- Location: LCCOMB_X39_Y18_N16
\c|line[4]~18\ : cycloneiii_lcell_comb
-- Equation(s):
-- \c|line[4]~18_combout\ = (\c|line\(4) & (\c|line[3]~17\ $ (GND))) # (!\c|line\(4) & (!\c|line[3]~17\ & VCC))
-- \c|line[4]~19\ = CARRY((\c|line\(4) & !\c|line[3]~17\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \c|line\(4),
	datad => VCC,
	cin => \c|line[3]~17\,
	combout => \c|line[4]~18_combout\,
	cout => \c|line[4]~19\);

-- Location: FF_X39_Y18_N17
\c|line[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \c|hsync~clkctrl_outclk\,
	d => \c|line[4]~18_combout\,
	sclr => \c|line~20_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \c|line\(4));

-- Location: LCCOMB_X39_Y18_N18
\c|line[5]~21\ : cycloneiii_lcell_comb
-- Equation(s):
-- \c|line[5]~21_combout\ = (\c|line\(5) & (!\c|line[4]~19\)) # (!\c|line\(5) & ((\c|line[4]~19\) # (GND)))
-- \c|line[5]~22\ = CARRY((!\c|line[4]~19\) # (!\c|line\(5)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \c|line\(5),
	datad => VCC,
	cin => \c|line[4]~19\,
	combout => \c|line[5]~21_combout\,
	cout => \c|line[5]~22\);

-- Location: FF_X39_Y18_N19
\c|line[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \c|hsync~clkctrl_outclk\,
	d => \c|line[5]~21_combout\,
	sclr => \c|line~20_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \c|line\(5));

-- Location: LCCOMB_X39_Y18_N20
\c|line[6]~23\ : cycloneiii_lcell_comb
-- Equation(s):
-- \c|line[6]~23_combout\ = (\c|line\(6) & (\c|line[5]~22\ $ (GND))) # (!\c|line\(6) & (!\c|line[5]~22\ & VCC))
-- \c|line[6]~24\ = CARRY((\c|line\(6) & !\c|line[5]~22\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \c|line\(6),
	datad => VCC,
	cin => \c|line[5]~22\,
	combout => \c|line[6]~23_combout\,
	cout => \c|line[6]~24\);

-- Location: FF_X39_Y18_N21
\c|line[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \c|hsync~clkctrl_outclk\,
	d => \c|line[6]~23_combout\,
	sclr => \c|line~20_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \c|line\(6));

-- Location: FF_X39_Y18_N23
\c|line[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \c|hsync~clkctrl_outclk\,
	d => \c|line[7]~25_combout\,
	sclr => \c|line~20_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \c|line\(7));

-- Location: LCCOMB_X39_Y18_N2
\c|vsync~4\ : cycloneiii_lcell_comb
-- Equation(s):
-- \c|vsync~4_combout\ = (!\c|line\(7) & (!\c|line\(5) & (!\c|line\(6) & !\c|line\(4))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|line\(7),
	datab => \c|line\(5),
	datac => \c|line\(6),
	datad => \c|line\(4),
	combout => \c|vsync~4_combout\);

-- Location: LCCOMB_X39_Y18_N6
\c|vsync~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \c|vsync~1_combout\ = (((!\c|line\(6)) # (!\c|line\(8))) # (!\c|line\(5))) # (!\c|line\(7))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|line\(7),
	datab => \c|line\(5),
	datac => \c|line\(8),
	datad => \c|line\(6),
	combout => \c|vsync~1_combout\);

-- Location: LCCOMB_X39_Y18_N28
\c|vsync~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \c|vsync~0_combout\ = (\c|line\(4)) # ((\c|line\(1) & (\c|line\(3) & \c|line\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|line\(1),
	datab => \c|line\(4),
	datac => \c|line\(3),
	datad => \c|line\(2),
	combout => \c|vsync~0_combout\);

-- Location: LCCOMB_X40_Y18_N2
\c|vsync~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \c|vsync~2_combout\ = (\c|line\(9) & (\c|vsync~q\)) # (!\c|line\(9) & (((\c|vsync~1_combout\) # (\c|vsync~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110111011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|line\(9),
	datab => \c|vsync~q\,
	datac => \c|vsync~1_combout\,
	datad => \c|vsync~0_combout\,
	combout => \c|vsync~2_combout\);

-- Location: LCCOMB_X40_Y18_N16
\c|vsync~5\ : cycloneiii_lcell_comb
-- Equation(s):
-- \c|vsync~5_combout\ = (\c|vsync~2_combout\) # ((\c|vsync~4_combout\ & (!\c|line\(8) & \c|vsync~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c|vsync~4_combout\,
	datab => \c|line\(8),
	datac => \c|vsync~3_combout\,
	datad => \c|vsync~2_combout\,
	combout => \c|vsync~5_combout\);

-- Location: FF_X40_Y18_N17
\c|vsync\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \c|hsync~clkctrl_outclk\,
	d => \c|vsync~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \c|vsync~q\);

-- Location: IOIBUF_X23_Y0_N8
\rs[0]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_rs(0),
	o => \rs[0]~input_o\);

-- Location: IOIBUF_X23_Y0_N15
\rs[1]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_rs(1),
	o => \rs[1]~input_o\);

-- Location: IOIBUF_X26_Y0_N8
\rs[2]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_rs(2),
	o => \rs[2]~input_o\);

-- Location: IOIBUF_X26_Y0_N15
\rs[3]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_rs(3),
	o => \rs[3]~input_o\);

-- Location: IOIBUF_X9_Y0_N29
\data_bi[0]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_data_bi(0),
	o => \data_bi[0]~input_o\);

-- Location: IOIBUF_X9_Y0_N22
\data_bi[1]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_data_bi(1),
	o => \data_bi[1]~input_o\);

-- Location: IOIBUF_X16_Y0_N29
\data_bi[2]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_data_bi(2),
	o => \data_bi[2]~input_o\);

-- Location: IOIBUF_X16_Y0_N22
\data_bi[3]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_data_bi(3),
	o => \data_bi[3]~input_o\);

-- Location: IOIBUF_X19_Y0_N1
\data_bi[4]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_data_bi(4),
	o => \data_bi[4]~input_o\);

-- Location: IOIBUF_X21_Y0_N29
\data_bi[5]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_data_bi(5),
	o => \data_bi[5]~input_o\);

-- Location: IOIBUF_X23_Y0_N29
\data_bi[6]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_data_bi(6),
	o => \data_bi[6]~input_o\);

-- Location: IOIBUF_X23_Y0_N22
\data_bi[7]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_data_bi(7),
	o => \data_bi[7]~input_o\);
END structure;


