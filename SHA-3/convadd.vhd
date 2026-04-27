
library IEEE;
use ieee.std_logic_1164.all;
	
entity convadd is
	generic(i:integer:=0);
	port(
			add: out std_logic_vector(7 downto 0) 
		  );
end convadd;

architecture rtl of convadd is

begin

genadd0:
if i=0 generate
   add <= "00000000";
end generate;

genadd1:
if i=1 generate
   add <= "00000001";
end generate;

genadd2:
if i=2 generate
   add <= "00000010";
end generate;

genadd3:
if i=3 generate
   add <= "00000011";
end generate;

genadd4:
if i=4 generate
   add <= "00000100";
end generate;

genadd5:
if i=5 generate
   add <= "00000101";
end generate;

genadd6:
if i=6 generate
   add <= "00000110";
end generate;

genadd7:
if i=7 generate
   add <= "00000111";
end generate;

genadd8:
if i=8 generate
   add <= "00001000";
end generate;

genadd9:
if i=9 generate
   add <= "00001001";
end generate;

genadd10:
if i=10 generate
   add <= "00001010";
end generate;

genadd11:
if i=11 generate
   add <= "00001011";
end generate;

genadd12:
if i=12 generate
   add <= "00001100";
end generate;

genadd13:
if i=13 generate
   add <= "00001101";
end generate;

genadd14:
if i=14 generate
   add <= "00001110";
end generate;

genadd15:
if i=15 generate
   add <= "00001111";
end generate;

genadd16:
if i=16 generate
   add <= "00010000";
end generate;

genadd17:
if i=17 generate
   add <= "00010001";
end generate;

genadd18:
if i=18 generate
   add <= "00010010";
end generate;

genadd19:
if i=19 generate
   add <= "00010011";
end generate;

genadd20:
if i=20 generate
   add <= "00010100";
end generate;

genadd21:
if i=21 generate
   add <= "00010101";
end generate;

genadd22:
if i=22 generate
   add <= "00010110";
end generate;

genadd23:
if i=23 generate
   add <= "00010111";
end generate;

genadd24:
if i=24 generate
   add <= "00011000";
end generate;

genadd25:
if i=25 generate
   add <= "00011001";
end generate;

genadd26:
if i=26 generate
   add <= "00011010";
end generate;

genadd27:
if i=27 generate
   add <= "00011011";
end generate;

genadd28:
if i=28 generate
   add <= "00011100";
end generate;

genadd29:
if i=29 generate
   add <= "00011101";
end generate;

genadd30:
if i=30 generate
   add <= "00011110";
end generate;

genadd31:
if i=31 generate
   add <= "00011111";
end generate;

genadd32:
if i=32 generate
   add <= "00100000";
end generate;

genadd33:
if i=33 generate
   add <= "00100001";
end generate;

genadd34:
if i=34 generate
   add <= "00100010";
end generate;

genadd35:
if i=35 generate
   add <= "00100011";
end generate;

genadd36:
if i=36 generate
   add <= "00100100";
end generate;

genadd37:
if i=37 generate
   add <= "00100101";
end generate;

genadd38:
if i=38 generate
   add <= "00100110";
end generate;

genadd39:
if i=39 generate
   add <= "00100111";
end generate;

genadd40:
if i=40 generate
   add <= "00101000";
end generate;

genadd41:
if i=41 generate
   add <= "00101001";
end generate;

genadd42:
if i=42 generate
   add <= "00101010";
end generate;

genadd43:
if i=43 generate
   add <= "00101011";
end generate;

genadd44:
if i=44 generate
   add <= "00101100";
end generate;

genadd45:
if i=45 generate
   add <= "00101101";
end generate;

genadd46:
if i=46 generate
   add <= "00101110";
end generate;

genadd47:
if i=47 generate
   add <= "00101111";
end generate;

genadd48:
if i=48 generate
   add <= "00110000";
end generate;

genadd49:
if i=49 generate
   add <= "00110001";
end generate;

genadd50:
if i=50 generate
   add <= "00110010";
end generate;

genadd51:
if i=51 generate
   add <= "00110011";
end generate;

genadd52:
if i=52 generate
   add <= "00110100";
end generate;

genadd53:
if i=53 generate
   add <= "00110101";
end generate;

genadd54:
if i=54 generate
   add <= "00110110";
end generate;

genadd55:
if i=55 generate
   add <= "00110111";
end generate;

genadd56:
if i=56 generate
   add <= "00111000";
end generate;

genadd57:
if i=57 generate
   add <= "00111001";
end generate;

genadd58:
if i=58 generate
   add <= "00111010";
end generate;

genadd59:
if i=59 generate
   add <= "00111011";
end generate;

genadd60:
if i=60 generate
   add <= "00111100";
end generate;

genadd61:
if i=61 generate
   add <= "00111101";
end generate;

genadd62:
if i=62 generate
   add <= "00111110";
end generate;

genadd63:
if i=63 generate
   add <= "00111111";
end generate;

genadd64:
if i=64 generate
   add <= "01000000";
end generate;

genadd65:
if i=65 generate
   add <= "01000001";
end generate;

genadd66:
if i=66 generate
   add <= "01000010";
end generate;

genadd67:
if i=67 generate
   add <= "01000011";
end generate;

genadd68:
if i=68 generate
   add <= "01000100";
end generate;

genadd69:
if i=69 generate
   add <= "01000101";
end generate;

genadd70:
if i=70 generate
   add <= "01000110";
end generate;

genadd71:
if i=71 generate
   add <= "01000111";
end generate;

genadd72:
if i=72 generate
   add <= "01001000";
end generate;

genadd73:
if i=73 generate
   add <= "01001001";
end generate;

genadd74:
if i=74 generate
   add <= "01001010";
end generate;

genadd75:
if i=75 generate
   add <= "01001011";
end generate;

genadd76:
if i=76 generate
   add <= "01001100";
end generate;

genadd77:
if i=77 generate
   add <= "01001101";
end generate;

genadd78:
if i=78 generate
   add <= "01001110";
end generate;

genadd79:
if i=79 generate
   add <= "01001111";
end generate;

genadd80:
if i=80 generate
   add <= "01010000";
end generate;

genadd81:
if i=81 generate
   add <= "01010001";
end generate;

genadd82:
if i=82 generate
   add <= "01010010";
end generate;

genadd83:
if i=83 generate
   add <= "01010011";
end generate;

genadd84:
if i=84 generate
   add <= "01010100";
end generate;

genadd85:
if i=85 generate
   add <= "01010101";
end generate;

genadd86:
if i=86 generate
   add <= "01010110";
end generate;

genadd87:
if i=87 generate
   add <= "01010111";
end generate;

genadd88:
if i=88 generate
   add <= "01011000";
end generate;

genadd89:
if i=89 generate
   add <= "01011001";
end generate;

genadd90:
if i=90 generate
   add <= "01011010";
end generate;

genadd91:
if i=91 generate
   add <= "01011011";
end generate;

genadd92:
if i=92 generate
   add <= "01011100";
end generate;

genadd93:
if i=93 generate
   add <= "01011101";
end generate;

genadd94:
if i=94 generate
   add <= "01011110";
end generate;

genadd95:
if i=95 generate
   add <= "01011111";
end generate;

genadd96:
if i=96 generate
   add <= "01100000";
end generate;

genadd97:
if i=97 generate
   add <= "01100001";
end generate;

genadd98:
if i=98 generate
   add <= "01100010";
end generate;

genadd99:
if i=99 generate
   add <= "01100011";
end generate;

genadd100:
if i=100 generate
   add <= "01100100";
end generate;

genadd101:
if i=101 generate
   add <= "01100101";
end generate;

genadd102:
if i=102 generate
   add <= "01100110";
end generate;

genadd103:
if i=103 generate
   add <= "01100111";
end generate;

genadd104:
if i=104 generate
   add <= "01101000";
end generate;

genadd105:
if i=105 generate
   add <= "01101001";
end generate;

genadd106:
if i=106 generate
   add <= "01101010";
end generate;

genadd107:
if i=107 generate
   add <= "01101011";
end generate;

genadd108:
if i=108 generate
   add <= "01101100";
end generate;

genadd109:
if i=109 generate
   add <= "01101101";
end generate;

genadd110:
if i=110 generate
   add <= "01101110";
end generate;

genadd111:
if i=111 generate
   add <= "01101111";
end generate;

genadd112:
if i=112 generate
   add <= "01110000";
end generate;

genadd113:
if i=113 generate
   add <= "01110001";
end generate;

genadd114:
if i=114 generate
   add <= "01110010";
end generate;

genadd115:
if i=115 generate
   add <= "01110011";
end generate;

genadd116:
if i=116 generate
   add <= "01110100";
end generate;

genadd117:
if i=117 generate
   add <= "01110101";
end generate;

genadd118:
if i=118 generate
   add <= "01110110";
end generate;

genadd119:
if i=119 generate
   add <= "01110111";
end generate;

genadd120:
if i=120 generate
   add <= "01111000";
end generate;

genadd121:
if i=121 generate
   add <= "01111001";
end generate;

genadd122:
if i=122 generate
   add <= "01111010";
end generate;

genadd123:
if i=123 generate
   add <= "01111011";
end generate;

genadd124:
if i=124 generate
   add <= "01111100";
end generate;

genadd125:
if i=125 generate
   add <= "01111101";
end generate;

genadd126:
if i=126 generate
   add <= "01111110";
end generate;

genadd127:
if i=127 generate
   add <= "01111111";
end generate;

genadd128:
if i=128 generate
   add <= "10000000";
end generate;

genadd129:
if i=129 generate
   add <= "10000001";
end generate;

genadd130:
if i=130 generate
   add <= "10000010";
end generate;

genadd131:
if i=131 generate
   add <= "10000011";
end generate;

genadd132:
if i=132 generate
   add <= "10000100";
end generate;

genadd133:
if i=133 generate
   add <= "10000101";
end generate;

genadd134:
if i=134 generate
   add <= "10000110";
end generate;

genadd135:
if i=135 generate
   add <= "10000111";
end generate;

genadd136:
if i=136 generate
   add <= "10001000";
end generate;

genadd137:
if i=137 generate
   add <= "10001001";
end generate;

genadd138:
if i=138 generate
   add <= "10001010";
end generate;

genadd139:
if i=139 generate
   add <= "10001011";
end generate;

genadd140:
if i=140 generate
   add <= "10001100";
end generate;

genadd141:
if i=141 generate
   add <= "10001101";
end generate;

genadd142:
if i=142 generate
   add <= "10001110";
end generate;

genadd143:
if i=143 generate
   add <= "10001111";
end generate;

genadd144:
if i=144 generate
   add <= "10010000";
end generate;

genadd145:
if i=145 generate
   add <= "10010001";
end generate;

genadd146:
if i=146 generate
   add <= "10010010";
end generate;

genadd147:
if i=147 generate
   add <= "10010011";
end generate;

genadd148:
if i=148 generate
   add <= "10010100";
end generate;

genadd149:
if i=149 generate
   add <= "10010101";
end generate;

genadd150:
if i=150 generate
   add <= "10010110";
end generate;

genadd151:
if i=151 generate
   add <= "10010111";
end generate;

genadd152:
if i=152 generate
   add <= "10011000";
end generate;

genadd153:
if i=153 generate
   add <= "10011001";
end generate;

genadd154:
if i=154 generate
   add <= "10011010";
end generate;

genadd155:
if i=155 generate
   add <= "10011011";
end generate;

genadd156:
if i=156 generate
   add <= "10011100";
end generate;

genadd157:
if i=157 generate
   add <= "10011101";
end generate;

genadd158:
if i=158 generate
   add <= "10011110";
end generate;

genadd159:
if i=159 generate
   add <= "10011111";
end generate;

genadd160:
if i=160 generate
   add <= "10100000";
end generate;

genadd161:
if i=161 generate
   add <= "10100001";
end generate;

genadd162:
if i=162 generate
   add <= "10100010";
end generate;

genadd163:
if i=163 generate
   add <= "10100011";
end generate;

genadd164:
if i=164 generate
   add <= "10100100";
end generate;

genadd165:
if i=165 generate
   add <= "10100101";
end generate;

genadd166:
if i=166 generate
   add <= "10100110";
end generate;

genadd167:
if i=167 generate
   add <= "10100111";
end generate;
	
end rtl;
