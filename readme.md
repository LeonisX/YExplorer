������� ��� �������� ���� Yoda Stories
======================================

�������������� ����������: 13.10.2014-23.10.2014


������ ���������:
-----------------

29.12.2015
* TMemoryStream ������ ������ ������� ����
* ����������, �������� ������
* ����� ���������� ������� �� ��������� ���������
* ����� ����� �� ������
* ������ ����� �� ������� ������

28.12.2015
* ��������� ����. ����� ����������� ����� ������� � ����
* ����������� � ������� ������ - ������ �����, �������. ������ ������������ �����.
* ��������� ������
- ���� ��������� �� ����������� �� ����

27.12.2015
* ���� ����������
* ���� ���

26.12.2015
* ���� ���� ������� �� PUZ2

25.12.2015
* ���������� ���������� ���� ������� �� IACT, ��������� �� ���� ��������� �������.

24.12.2015
* �������������� ����������� ����������� �������� ������ ��� ������ ����� ����
* ����������� �������� �����
* ����������� �������� ��������� ��������
* ���������� ������ � ���� ����
* ���������� ������ ���������������� ������ (���� ������ � ������, �.�. ������ �� ���)
 

23.12.2015
* HEX-�������� �� Markus Stephany - ������� ������ �� 30 �������� 2007-�� ����.
* �������� ���������� ��������� ������
* ������� � ��������, �������������� ������� � HEX-��������� ��� �����, ����� �����.
* ��������� �������� ��� ���������� ������, ������, ����
* ����� ���� ������, ����� �� ���� ��� ���� (�������������� ������)

22.12.2015
* ����������� ������������ ����
* ���������� ���� �� ����
* ���������� �������� �� ����

21.12.2015
* �������� ������ ���� ������ (����� TGEN), ��������� ���������� ��������� � ������
* ��������� ��� ����������� � Sections.txt
* ���������� ������ ������� � SNDS.txt
* ���������� ������ (��������) � ����������� �����������
* ������� � ���������

20.12.2015
* ������� ������� ������������.
* ������ ��� ��������

19.12.2015
* ����� ������ � ������������ DTA �����
* ������ ���� - �������� DTA ����� � ������ � ��� ������������
* ������ ������ VERS, STUP, SNDS

18.12.2015
* ������������� � ���������� ������� (TGEN)

17.12.2015
* �������� ��������� ������, ���������������� ���


TODO
----

���������� ��������� ������ � ���������� ������ � ���� ���������

��������� ����� ������ � ������

�������� �������������� ������� � ������ ���������� � ���

������ ������ ��� ������� ������� (IACT, PUZ2, TNAM)

������ ������ ��� ������� ���� (���� �� ������ ��������)



HEX!!!!!

TILE TYPES:
bit0 = transparent
bit1 = non-colliding, bottom layer
bit2 = colliding, middle layer
bit3 = push/pull block
bit4 = non-colliding, top layer
bit5 = mini map tile
bit6 = weapon
bit7 = item
bit8 = character

FLAGS FOR WEAPONS:
bit16 = light blaster
bit17 = heavy blaster, thermal detonator
bit18 = lightsaber
bit19 = the force

FLAGS FOR ITEMS:
bit16 = keycard
bit17 = item (for use)
bit18 = item (part of)
bit19 = item (to trade)
bit20 = locator
bit22 = health pack

FLAGS FOR CHARACTERS:
bit16 = player
bit17 = enemy
bit18 = friendly

FLAGS FOR OTHER TILES:
bit16 = door, passage, ladder

FLAGS FOR MINI-MAP TILES:
bit17 = specific mini map tile (home)
bit18 = specific mini map tile (puzzle, unsolved)
bit19 = specific mini map tile (puzzle solved) 
bit20 = specific mini map tile (gateway, unsolved)
bit21 = specific mini map tile (gateway, solved)
bit22 = specific mini map tile (up wall, locked)
bit23 = specific mini map tile (down wall, locked)
bit24 = specific mini map tile (left wall, locked)
bit25 = specific mini map tile (right wall, locked)
bit26 = specific mini map tile (up wall, unlocked)
bit27 = specific mini map tile (down wall, unlocked)
bit28 = specific mini map tile (left wall, unlocked)
bit29 = specific mini map tile (right wall, unlocked)
bit30 = specific mini map tile (objective)
bit31 = specific mini map tile (position) 

2	2	Bottom layer
4	4	Middle layer
5	5	Middle layer (transparent)
D	13	Push/pull block
10	16	Top layer
11	17	Top layer (transparent)

10041	65601   Light Blaster
20041	131137  Heavy Blaster, Thermal Detonator
40041   262209	Lightsaber
80041   524353	The Force

10081   65665	Keycard
20081   131201	Item (for use)
40081   262273	Item (part of)
80081   524417	Item (to trade)
100081  1048705	Locator
400081  4194433	Health pack

10101   65793	Player
20101   131329	Enemy character
40101   262401	Friendly character

10002   65538	Door, passage, ladder

20020   131104	Mini map (home)
40020   262176	Mini map (puzzle, unsolved)
80020   524320	Mini map (puzzle solved) 
100020  1048608 Mini map (gateway, unsolved)
200020  2097184 Mini map (gateway, solved)
400020  4194336 Mini map (up wall, locked)
800020  8388640 Mini map (down wall, locked)
1000020 16777248 Mini map (left wall, locked)
2000020 33554464 Mini map (right wall, locked)
4000020 67108896 Mini map (up wall, unlocked)
8000020  134217760 Mini map (down wall, unlocked)
10000020 268435488 Mini map (left wall, unlocked)
20000020 536870944 Mini map (right wall, unlocked)
40000020 1073741856 Mini map (objective)
80000020 2147483680 Mini map (current position) 
	 2000000000





























