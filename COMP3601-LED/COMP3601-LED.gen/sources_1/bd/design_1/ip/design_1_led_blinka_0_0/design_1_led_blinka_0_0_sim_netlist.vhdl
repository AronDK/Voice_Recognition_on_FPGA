-- Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2021.1 (win64) Build 3247384 Thu Jun 10 19:36:33 MDT 2021
-- Date        : Wed Sep 20 13:13:54 2023
-- Host        : AronLaptop running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim -rename_top design_1_led_blinka_0_0 -prefix
--               design_1_led_blinka_0_0_ design_1_led_blinka_0_0_sim_netlist.vhdl
-- Design      : design_1_led_blinka_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xck26-sfvc784-2LV-c
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_led_blinka_0_0_led_blinka is
  port (
    led_out : out STD_LOGIC;
    clk_10MHZ : in STD_LOGIC
  );
end design_1_led_blinka_0_0_led_blinka;

architecture STRUCTURE of design_1_led_blinka_0_0_led_blinka is
  signal clear : STD_LOGIC;
  signal \clk_counter[0]_i_3_n_0\ : STD_LOGIC;
  signal \clk_counter[0]_i_4_n_0\ : STD_LOGIC;
  signal \clk_counter[0]_i_5_n_0\ : STD_LOGIC;
  signal \clk_counter[0]_i_6_n_0\ : STD_LOGIC;
  signal clk_counter_reg : STD_LOGIC_VECTOR ( 23 downto 7 );
  signal \clk_counter_reg[0]_i_2_n_0\ : STD_LOGIC;
  signal \clk_counter_reg[0]_i_2_n_1\ : STD_LOGIC;
  signal \clk_counter_reg[0]_i_2_n_10\ : STD_LOGIC;
  signal \clk_counter_reg[0]_i_2_n_11\ : STD_LOGIC;
  signal \clk_counter_reg[0]_i_2_n_12\ : STD_LOGIC;
  signal \clk_counter_reg[0]_i_2_n_13\ : STD_LOGIC;
  signal \clk_counter_reg[0]_i_2_n_14\ : STD_LOGIC;
  signal \clk_counter_reg[0]_i_2_n_15\ : STD_LOGIC;
  signal \clk_counter_reg[0]_i_2_n_2\ : STD_LOGIC;
  signal \clk_counter_reg[0]_i_2_n_3\ : STD_LOGIC;
  signal \clk_counter_reg[0]_i_2_n_4\ : STD_LOGIC;
  signal \clk_counter_reg[0]_i_2_n_5\ : STD_LOGIC;
  signal \clk_counter_reg[0]_i_2_n_6\ : STD_LOGIC;
  signal \clk_counter_reg[0]_i_2_n_7\ : STD_LOGIC;
  signal \clk_counter_reg[0]_i_2_n_8\ : STD_LOGIC;
  signal \clk_counter_reg[0]_i_2_n_9\ : STD_LOGIC;
  signal \clk_counter_reg[16]_i_1_n_1\ : STD_LOGIC;
  signal \clk_counter_reg[16]_i_1_n_10\ : STD_LOGIC;
  signal \clk_counter_reg[16]_i_1_n_11\ : STD_LOGIC;
  signal \clk_counter_reg[16]_i_1_n_12\ : STD_LOGIC;
  signal \clk_counter_reg[16]_i_1_n_13\ : STD_LOGIC;
  signal \clk_counter_reg[16]_i_1_n_14\ : STD_LOGIC;
  signal \clk_counter_reg[16]_i_1_n_15\ : STD_LOGIC;
  signal \clk_counter_reg[16]_i_1_n_2\ : STD_LOGIC;
  signal \clk_counter_reg[16]_i_1_n_3\ : STD_LOGIC;
  signal \clk_counter_reg[16]_i_1_n_4\ : STD_LOGIC;
  signal \clk_counter_reg[16]_i_1_n_5\ : STD_LOGIC;
  signal \clk_counter_reg[16]_i_1_n_6\ : STD_LOGIC;
  signal \clk_counter_reg[16]_i_1_n_7\ : STD_LOGIC;
  signal \clk_counter_reg[16]_i_1_n_8\ : STD_LOGIC;
  signal \clk_counter_reg[16]_i_1_n_9\ : STD_LOGIC;
  signal \clk_counter_reg[8]_i_1_n_0\ : STD_LOGIC;
  signal \clk_counter_reg[8]_i_1_n_1\ : STD_LOGIC;
  signal \clk_counter_reg[8]_i_1_n_10\ : STD_LOGIC;
  signal \clk_counter_reg[8]_i_1_n_11\ : STD_LOGIC;
  signal \clk_counter_reg[8]_i_1_n_12\ : STD_LOGIC;
  signal \clk_counter_reg[8]_i_1_n_13\ : STD_LOGIC;
  signal \clk_counter_reg[8]_i_1_n_14\ : STD_LOGIC;
  signal \clk_counter_reg[8]_i_1_n_15\ : STD_LOGIC;
  signal \clk_counter_reg[8]_i_1_n_2\ : STD_LOGIC;
  signal \clk_counter_reg[8]_i_1_n_3\ : STD_LOGIC;
  signal \clk_counter_reg[8]_i_1_n_4\ : STD_LOGIC;
  signal \clk_counter_reg[8]_i_1_n_5\ : STD_LOGIC;
  signal \clk_counter_reg[8]_i_1_n_6\ : STD_LOGIC;
  signal \clk_counter_reg[8]_i_1_n_7\ : STD_LOGIC;
  signal \clk_counter_reg[8]_i_1_n_8\ : STD_LOGIC;
  signal \clk_counter_reg[8]_i_1_n_9\ : STD_LOGIC;
  signal \clk_counter_reg_n_0_[0]\ : STD_LOGIC;
  signal \clk_counter_reg_n_0_[1]\ : STD_LOGIC;
  signal \clk_counter_reg_n_0_[2]\ : STD_LOGIC;
  signal \clk_counter_reg_n_0_[3]\ : STD_LOGIC;
  signal \clk_counter_reg_n_0_[4]\ : STD_LOGIC;
  signal \clk_counter_reg_n_0_[5]\ : STD_LOGIC;
  signal \clk_counter_reg_n_0_[6]\ : STD_LOGIC;
  signal led_on_i_1_n_0 : STD_LOGIC;
  signal \^led_out\ : STD_LOGIC;
  signal \NLW_clk_counter_reg[16]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 to 7 );
  attribute ADDER_THRESHOLD : integer;
  attribute ADDER_THRESHOLD of \clk_counter_reg[0]_i_2\ : label is 16;
  attribute ADDER_THRESHOLD of \clk_counter_reg[16]_i_1\ : label is 16;
  attribute ADDER_THRESHOLD of \clk_counter_reg[8]_i_1\ : label is 16;
begin
  led_out <= \^led_out\;
\clk_counter[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAAAAAA8888888"
    )
        port map (
      I0 => clk_counter_reg(23),
      I1 => clk_counter_reg(22),
      I2 => clk_counter_reg(20),
      I3 => \clk_counter[0]_i_3_n_0\,
      I4 => clk_counter_reg(19),
      I5 => clk_counter_reg(21),
      O => clear
    );
\clk_counter[0]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFEEEEEEEA"
    )
        port map (
      I0 => \clk_counter[0]_i_5_n_0\,
      I1 => clk_counter_reg(15),
      I2 => clk_counter_reg(14),
      I3 => \clk_counter[0]_i_6_n_0\,
      I4 => clk_counter_reg(13),
      I5 => clk_counter_reg(18),
      O => \clk_counter[0]_i_3_n_0\
    );
\clk_counter[0]_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \clk_counter_reg_n_0_[0]\,
      O => \clk_counter[0]_i_4_n_0\
    );
\clk_counter[0]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => clk_counter_reg(16),
      I1 => clk_counter_reg(17),
      O => \clk_counter[0]_i_5_n_0\
    );
\clk_counter[0]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAAAAA88800000"
    )
        port map (
      I0 => clk_counter_reg(12),
      I1 => clk_counter_reg(9),
      I2 => clk_counter_reg(8),
      I3 => clk_counter_reg(7),
      I4 => clk_counter_reg(10),
      I5 => clk_counter_reg(11),
      O => \clk_counter[0]_i_6_n_0\
    );
\clk_counter_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_10MHZ,
      CE => '1',
      D => \clk_counter_reg[0]_i_2_n_15\,
      Q => \clk_counter_reg_n_0_[0]\,
      R => clear
    );
\clk_counter_reg[0]_i_2\: unisim.vcomponents.CARRY8
     port map (
      CI => '0',
      CI_TOP => '0',
      CO(7) => \clk_counter_reg[0]_i_2_n_0\,
      CO(6) => \clk_counter_reg[0]_i_2_n_1\,
      CO(5) => \clk_counter_reg[0]_i_2_n_2\,
      CO(4) => \clk_counter_reg[0]_i_2_n_3\,
      CO(3) => \clk_counter_reg[0]_i_2_n_4\,
      CO(2) => \clk_counter_reg[0]_i_2_n_5\,
      CO(1) => \clk_counter_reg[0]_i_2_n_6\,
      CO(0) => \clk_counter_reg[0]_i_2_n_7\,
      DI(7 downto 0) => B"00000001",
      O(7) => \clk_counter_reg[0]_i_2_n_8\,
      O(6) => \clk_counter_reg[0]_i_2_n_9\,
      O(5) => \clk_counter_reg[0]_i_2_n_10\,
      O(4) => \clk_counter_reg[0]_i_2_n_11\,
      O(3) => \clk_counter_reg[0]_i_2_n_12\,
      O(2) => \clk_counter_reg[0]_i_2_n_13\,
      O(1) => \clk_counter_reg[0]_i_2_n_14\,
      O(0) => \clk_counter_reg[0]_i_2_n_15\,
      S(7) => clk_counter_reg(7),
      S(6) => \clk_counter_reg_n_0_[6]\,
      S(5) => \clk_counter_reg_n_0_[5]\,
      S(4) => \clk_counter_reg_n_0_[4]\,
      S(3) => \clk_counter_reg_n_0_[3]\,
      S(2) => \clk_counter_reg_n_0_[2]\,
      S(1) => \clk_counter_reg_n_0_[1]\,
      S(0) => \clk_counter[0]_i_4_n_0\
    );
\clk_counter_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_10MHZ,
      CE => '1',
      D => \clk_counter_reg[8]_i_1_n_13\,
      Q => clk_counter_reg(10),
      R => clear
    );
\clk_counter_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_10MHZ,
      CE => '1',
      D => \clk_counter_reg[8]_i_1_n_12\,
      Q => clk_counter_reg(11),
      R => clear
    );
\clk_counter_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_10MHZ,
      CE => '1',
      D => \clk_counter_reg[8]_i_1_n_11\,
      Q => clk_counter_reg(12),
      R => clear
    );
\clk_counter_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_10MHZ,
      CE => '1',
      D => \clk_counter_reg[8]_i_1_n_10\,
      Q => clk_counter_reg(13),
      R => clear
    );
\clk_counter_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_10MHZ,
      CE => '1',
      D => \clk_counter_reg[8]_i_1_n_9\,
      Q => clk_counter_reg(14),
      R => clear
    );
\clk_counter_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_10MHZ,
      CE => '1',
      D => \clk_counter_reg[8]_i_1_n_8\,
      Q => clk_counter_reg(15),
      R => clear
    );
\clk_counter_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_10MHZ,
      CE => '1',
      D => \clk_counter_reg[16]_i_1_n_15\,
      Q => clk_counter_reg(16),
      R => clear
    );
\clk_counter_reg[16]_i_1\: unisim.vcomponents.CARRY8
     port map (
      CI => \clk_counter_reg[8]_i_1_n_0\,
      CI_TOP => '0',
      CO(7) => \NLW_clk_counter_reg[16]_i_1_CO_UNCONNECTED\(7),
      CO(6) => \clk_counter_reg[16]_i_1_n_1\,
      CO(5) => \clk_counter_reg[16]_i_1_n_2\,
      CO(4) => \clk_counter_reg[16]_i_1_n_3\,
      CO(3) => \clk_counter_reg[16]_i_1_n_4\,
      CO(2) => \clk_counter_reg[16]_i_1_n_5\,
      CO(1) => \clk_counter_reg[16]_i_1_n_6\,
      CO(0) => \clk_counter_reg[16]_i_1_n_7\,
      DI(7 downto 0) => B"00000000",
      O(7) => \clk_counter_reg[16]_i_1_n_8\,
      O(6) => \clk_counter_reg[16]_i_1_n_9\,
      O(5) => \clk_counter_reg[16]_i_1_n_10\,
      O(4) => \clk_counter_reg[16]_i_1_n_11\,
      O(3) => \clk_counter_reg[16]_i_1_n_12\,
      O(2) => \clk_counter_reg[16]_i_1_n_13\,
      O(1) => \clk_counter_reg[16]_i_1_n_14\,
      O(0) => \clk_counter_reg[16]_i_1_n_15\,
      S(7 downto 0) => clk_counter_reg(23 downto 16)
    );
\clk_counter_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_10MHZ,
      CE => '1',
      D => \clk_counter_reg[16]_i_1_n_14\,
      Q => clk_counter_reg(17),
      R => clear
    );
\clk_counter_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_10MHZ,
      CE => '1',
      D => \clk_counter_reg[16]_i_1_n_13\,
      Q => clk_counter_reg(18),
      R => clear
    );
\clk_counter_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_10MHZ,
      CE => '1',
      D => \clk_counter_reg[16]_i_1_n_12\,
      Q => clk_counter_reg(19),
      R => clear
    );
\clk_counter_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_10MHZ,
      CE => '1',
      D => \clk_counter_reg[0]_i_2_n_14\,
      Q => \clk_counter_reg_n_0_[1]\,
      R => clear
    );
\clk_counter_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_10MHZ,
      CE => '1',
      D => \clk_counter_reg[16]_i_1_n_11\,
      Q => clk_counter_reg(20),
      R => clear
    );
\clk_counter_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_10MHZ,
      CE => '1',
      D => \clk_counter_reg[16]_i_1_n_10\,
      Q => clk_counter_reg(21),
      R => clear
    );
\clk_counter_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_10MHZ,
      CE => '1',
      D => \clk_counter_reg[16]_i_1_n_9\,
      Q => clk_counter_reg(22),
      R => clear
    );
\clk_counter_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_10MHZ,
      CE => '1',
      D => \clk_counter_reg[16]_i_1_n_8\,
      Q => clk_counter_reg(23),
      R => clear
    );
\clk_counter_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_10MHZ,
      CE => '1',
      D => \clk_counter_reg[0]_i_2_n_13\,
      Q => \clk_counter_reg_n_0_[2]\,
      R => clear
    );
\clk_counter_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_10MHZ,
      CE => '1',
      D => \clk_counter_reg[0]_i_2_n_12\,
      Q => \clk_counter_reg_n_0_[3]\,
      R => clear
    );
\clk_counter_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_10MHZ,
      CE => '1',
      D => \clk_counter_reg[0]_i_2_n_11\,
      Q => \clk_counter_reg_n_0_[4]\,
      R => clear
    );
\clk_counter_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_10MHZ,
      CE => '1',
      D => \clk_counter_reg[0]_i_2_n_10\,
      Q => \clk_counter_reg_n_0_[5]\,
      R => clear
    );
\clk_counter_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_10MHZ,
      CE => '1',
      D => \clk_counter_reg[0]_i_2_n_9\,
      Q => \clk_counter_reg_n_0_[6]\,
      R => clear
    );
\clk_counter_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_10MHZ,
      CE => '1',
      D => \clk_counter_reg[0]_i_2_n_8\,
      Q => clk_counter_reg(7),
      R => clear
    );
\clk_counter_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_10MHZ,
      CE => '1',
      D => \clk_counter_reg[8]_i_1_n_15\,
      Q => clk_counter_reg(8),
      R => clear
    );
\clk_counter_reg[8]_i_1\: unisim.vcomponents.CARRY8
     port map (
      CI => \clk_counter_reg[0]_i_2_n_0\,
      CI_TOP => '0',
      CO(7) => \clk_counter_reg[8]_i_1_n_0\,
      CO(6) => \clk_counter_reg[8]_i_1_n_1\,
      CO(5) => \clk_counter_reg[8]_i_1_n_2\,
      CO(4) => \clk_counter_reg[8]_i_1_n_3\,
      CO(3) => \clk_counter_reg[8]_i_1_n_4\,
      CO(2) => \clk_counter_reg[8]_i_1_n_5\,
      CO(1) => \clk_counter_reg[8]_i_1_n_6\,
      CO(0) => \clk_counter_reg[8]_i_1_n_7\,
      DI(7 downto 0) => B"00000000",
      O(7) => \clk_counter_reg[8]_i_1_n_8\,
      O(6) => \clk_counter_reg[8]_i_1_n_9\,
      O(5) => \clk_counter_reg[8]_i_1_n_10\,
      O(4) => \clk_counter_reg[8]_i_1_n_11\,
      O(3) => \clk_counter_reg[8]_i_1_n_12\,
      O(2) => \clk_counter_reg[8]_i_1_n_13\,
      O(1) => \clk_counter_reg[8]_i_1_n_14\,
      O(0) => \clk_counter_reg[8]_i_1_n_15\,
      S(7 downto 0) => clk_counter_reg(15 downto 8)
    );
\clk_counter_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_10MHZ,
      CE => '1',
      D => \clk_counter_reg[8]_i_1_n_14\,
      Q => clk_counter_reg(9),
      R => clear
    );
led_on_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => clear,
      I1 => \^led_out\,
      O => led_on_i_1_n_0
    );
led_on_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_10MHZ,
      CE => '1',
      D => led_on_i_1_n_0,
      Q => \^led_out\,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_led_blinka_0_0 is
  port (
    clk_10MHZ : in STD_LOGIC;
    led_out : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of design_1_led_blinka_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_1_led_blinka_0_0 : entity is "design_1_led_blinka_0_0,led_blinka,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of design_1_led_blinka_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of design_1_led_blinka_0_0 : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of design_1_led_blinka_0_0 : entity is "led_blinka,Vivado 2021.1";
end design_1_led_blinka_0_0;

architecture STRUCTURE of design_1_led_blinka_0_0 is
begin
inst: entity work.design_1_led_blinka_0_0_led_blinka
     port map (
      clk_10MHZ => clk_10MHZ,
      led_out => led_out
    );
end STRUCTURE;
