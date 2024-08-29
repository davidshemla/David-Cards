--packs Duel
--credits to andre and AlphaKretin, tag functionality by senpaizuri, rescripted by MLD
--re-rescripted by edo9300
local selfs={}
if self_table then
	function self_table.initial_effect(c) table.insert(selfs,c) end
end
local id=511005094
if self_code then id=self_code end
if not SealedDuel then
	SealedDuel={}
	local function finish_setup()
		--Pre-draw
		local e1=Effect.GlobalEffect()
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_STARTUP)
		e1:SetCountLimit(1)
		e1:SetOperation(SealedDuel.op)
		Duel.RegisterEffect(e1,0)
	end
	--define pack
	--pack[1]=Kaiba, [2]=Duel Academy, [3]=Yugi, [4]=Joey, [5]=5D's
	--[1]=rare, [2]=common, [3]=foil
	pack={}
		pack[1]={}
		pack[1][1]={
			89631147, 97590748, 14898067, 30113682, 62651957, 65622692, 64500000, 53347303, 34627841, 79814787,
            71039903, 88241506, 72855441, 45644898, 8240199, 36734924, 14235211, 45467446, 30012506, 77411244,
            3405259, 23265594, 39890958, 53839837, 17655904, 27847700, 43973174, 48800175, 59750328, 24874630,
            2783661, 98045062, 58641905, 87025064, 50371210, 24382602, 11082056, 68005187, 10667321, 23265313,
            43845801, 39238953, 55713623, 95286165, 29228529, 57728571, 35027493, 54974237, 4931121, 83555667,
            13513663, 36261276, 44095762, 57470761, 86871614, 54591086, 23995348, 2129638, 1561110, 58859575,
            91998121, 84687358, 58293343, 22804644, 62873545, 40908371, 31786629, 65192027, 10097168, 25862681,
            34408491, 62265044, 72549351, 6853254, 41620959, 38120068, 94145022, 59438931, 62015409, 14558128,
            24508238, 51638941, 96300057, 28183605, 54578613, 59755122, 56832966, 12580477, 26902560, 73628505,
            43422537, 39701395, 79844764, 57139487, 50078509, 62762898, 58831685, 38277918, 90873992, 26725158,
            44763025, 43487744, 16970158, 42364257, 24068492, 72589042, 8978197, 44373896, 71867500, 7852510,
		}
		pack[1][2]={}
		pack[1][3]={}
		for _,v in ipairs(pack[1][1]) do table.insert(pack[1][2],v) end
		for _,v in ipairs(pack[1][1]) do table.insert(pack[1][3],v) end
		pack[2]={}
		pack[2][1]={
			21844577, 58932616, 84327329, 20721929, 89943724, 57116034, 98585345, 6480253, 79979666, 59793705,
            86188410, 89252153, 32679370, 17955766, 89621922, 43237273, 85087012, 54959865, 80344569, 17732278,
            40044919, 37195861, 80908502, 4906301, 69884162, 58554959, 95943058, 50304345, 26701483, 89312388,
            75434695, 62107981, 51085303, 98266377, 95362816, 9327502, 5126490, 30915572, 15341821, 33776734,
            42256406, 35809262, 61204971, 47737087, 83121692, 10526791, 25366484, 81197327, 29343734, 52031567,
            14225239, 55615891, 81003500, 55171412, 81566151, 28677304, 48996569, 85507811, 5128859, 41517968,
            78512663, 17032740, 60493189, 22160245, 21947653, 58332301, 13293158, 50282757, 86676862, 49352945,
            86346643, 74711057, 68745629, 31111109, 45906428, 25573054, 61968753, 97362768, 63035430, 19394153,
            27191436, 67951831, 29612557, 20065322, 74825788, 213326, 37318031, 63703130, 191749, 78387742,
            42015635, 1845204, 47274077, 47596607, 55428811, 94820406, 12071500, 48130397, 11913700, 75141056,
            1539051, 25090294, 76442616, 22020907, 44676200, 71060915, 26647858, 22479888, 55985014, 84361420,
            10759529, 36586443, 74095602, 81167171, 19024706, 43452193, 37412656, 26509612, 41613948, 77608643,
            13093792, 40591390, 28355718, 54749427, 17132130, 55461064, 80744121, 81866673, 9411399, 56570271,
            83965311, 93431862, 39829561, 36625827, 41436536, 88820235, 76263644, 75041269, 89899996, 22147147,
            53527835, 45809008, 72204747, 74329404, 35464895, 99075257, 62868900, 15294090, 43405287, 8698851,
            9201964, 32710364, 32933942, 68215963, 95600067, 69937550, 21698716, 7093411, 79856792, 95326659,
            60876124, 35486099, 72881007, 8275702, 34487429, 10004783, 47408488, 96331676, 47121070, 7617253,
            63806265, 70095155, 26439287, 3370104, 3657444, 74157028, 1546124, 64599569, 37630732, 3659803,
            77565204, 85852291, 88643579, 25132288, 22587018, 8062132, 72677437, 30312361, 12958919, 48343627,
            75732622, 78371393, 4779091, 31764700, 92826944, 24661486, 32750510, 71564252, 93709215, 79473793,
            52512994, 14462257, 65422840, 97811903, 55690251, 18511384, 18895832, 38430673, 81674782, 54306223,
            33900648, 30241314, 16067089, 70342110, 93217231, 44430454, 90582719, 48092532, 94853057, 83039729,
            64398890, 90397998, 69025477, 31904181, 95519486, 27782503, 63176202, 24508238, 29590752, 5975022,
            41470137, 78868776, 4253484, 77642288, 38280762, 92373006, 79407975, 25924653, 96235275, 59019082,
            95503687, 58996430, 57774843, 7183277, 57731460, 2067935, 27346636, 98891840, 24285858, 27178262,
            35224440, 2362787, 27970830, 27581098, 6859683, 46874015, 84613836, 21007444, 28877100, 96216229
		}
		pack[2][2]={}
		pack[2][3]={}
		for _,v in ipairs(pack[2][1]) do table.insert(pack[2][2],v) end
		for _,v in ipairs(pack[2][1]) do table.insert(pack[2][3],v) end
		pack[3]={}
		pack[3][1]={
            49140998, 41356846, 99785935, 85639257, 6150045, 50287060, 980973, 46384672, 73879377, 84430950,
            85489096, 61528025, 16255442, 77207191, 39256679, 16768387, 65240384, 50323155, 41426869, 55761792,
            5405694, 72989439, 76792184, 53183600, 14087893, 29401950, 52090844, 87910978, 71413901, 78193832,
            69243953, 72892473, 95727991, 91152258, 1801154, 1248895, 57139487, 4031928, 9596126, 50412166,
            4796100, 7565547, 10375182, 22666164, 94192409, 69035382, 96420087, 38999506, 31036355, 28279543,
            70074904, 3773196, 37043180, 7572887, 13722870, 70676581, 14536035, 53129443, 66214679, 53375573,
            2314238, 99789342, 46986422, 38033127, 50725996, 40737112, 97642679, 20522190, 38107923, 98502115,
            92377303, 47233801, 38247752, 40921744, 76925842, 95286165, 69542930, 89086566, 87880531, 74701381,
            56769674, 24096228, 16435215, 50045299, 62873545, 43250041, 60082869, 59820352, 97342942, 75043725,
            5556668, 33396948, 68401546, 41392891, 64752646, 66788016, 84834865, 33550694, 6368039, 11549357,
            5818798, 95178994, 97017120, 13039848, 38445524, 4149689, 67959180, 75500286, 44330098, 79571449,
            25262697, 99877698, 62473983, 17393207, 30213599, 37101832, 93023479, 63695531, 24317029, 26084285,
            32022366, 85742772, 46668237, 41172955, 73544866, 10755153, 74367458, 47150851, 9633505, 46037213,
            98446407, 18144507, 35762283, 19613556, 2047519, 98069388, 75830094, 11224103, 48229808, 9264485,
            61740673, 56647086, 90876561, 12829151, 79109599, 64788463, 87210505, 40640059, 88240808, 7902349,
            44519536, 54976796, 3136426, 25290459, 37721209, 49587034, 23171610, 96384007, 58054262, 23782705,
            60999392, 63995093, 62279055, 67227834, 77414722, 28553439, 81210420, 30208479, 50755, 36045450,
            27827272, 1224927, 72657739, 54652250, 38369349, 95492061, 29549364, 7359741, 7562372, 44656491,
            32012842, 37520316, 15800838, 49217579, 41482598, 44095762, 83764719, 74848038, 33508719, 79106360,
            57839750, 40703222, 69279219, 25774450, 47507260, 74591968, 60482781, 83011278, 15025844, 39552864,
            5318639, 47355498, 81843628, 22567609, 20065549, 52077741, 39537362, 967928, 63356631, 27847700,
            55144522, 43711255, 41442341, 77044671, 25652259, 12580477, 4178474, 37576645, 86445415, 32807846,
            64631466, 70903634, 8124921, 30450531, 95515060, 93382620, 51452091, 72405967, 61441708, 13604200,
            56120475, 96947648, 26202165, 3819470, 59560625, 95956346, 95638658, 73665146, 72443568, 1995985,
            74388798, 37267041, 90357090, 8131171, 32274490, 97169186, 45985838, 41420027, 84749824, 88619463,
            37383714, 81510157, 4259068, 93260132, 18807109, 23205979, 15866454, 60764581, 13955608, 70781055,
            423585, 14644902, 16589042, 12923641, 72302403, 44073668, 64734921, 38730226, 61505339, 97093037,
            52101615, 92719314, 30606547, 88696724, 15717011, 14778250, 63391643, 36361633, 33734439, 79875176,
            90960358, 43509019, 42386471, 15270885, 16392422, 65458948, 91842653, 89997728, 15259704, 53582587,
            4206964, 39111158, 75622824, 21900719, 94119974, 60806437, 60399954, 70368879, 75347539, 87774234,
            73891874, 68427465, 87796900, 70345785, 71280811, 13839120
        }
		pack[3][2]={}
		pack[3][3]={}
        for _,v in ipairs(pack[3][1]) do table.insert(pack[3][2],v) end
		for _,v in ipairs(pack[3][1]) do table.insert(pack[3][3],v) end
		pack[4]={}
		pack[4][1]={
            34460851, 44287299, 26378150, 68846917, 88819587, 48305365, 49791928, 14977074, 3573512, 48766543,
            64428736, 53832650, 80600490, 63432835, 89904598, 54844990, 49417509, 89987208, 40453765, 71625222,
            20394040, 77585514, 3643300, 51345461, 21015833, 79870141, 78658564, 66362965, 423705, 64335805,
            2460565, 78706415, 16222645, 11021521, 90790253, 91512835, 36262024, 96561011, 57046845, 36354008,
            30860696, 42035045, 69933858, 26376390, 57902462, 30707994, 83602069, 67300516, 88264979, 69488544,
            4722253, 45231178, 41462084, 3366982, 12580477, 46130346, 27847700, 83764719, 55144522, 32268901,
            42703248, 70828912, 74137509, 73915051, 95281259, 33767325, 75417459, 81439174, 42534368, 76895648,
            4206964, 126218, 68540059, 21598948, 7565547, 29401950, 55773067, 96008713, 37390590, 76812113,
            34100324, 12493482, 12206212, 52040216, 47480070, 55821894, 10979723, 91932350, 27927359, 54415063,
            6924874, 75064463, 71209500, 80316585, 68815132, 90219263, 18144507, 81325903, 29228529, 75782277,
            12181376, 712559, 63224564, 17653779, 22359980, 85742772, 58621589, 55608151, 19252988, 77778835,
            31709826, 90980792, 4335645, 76052811, 102380, 99050989, 62543393, 40320754, 21593977, 99747800,
            65169794, 21770260, 95220856, 42664989, 98494543, 76714458, 77414722, 44095762, 21558682, 65830223,
            93382620, 54704216, 55256016, 1224927, 37507488, 26905245, 66516792, 94119974, 38289717, 51934376,
            37265642, 46457856, 42625254, 13069066, 75390004, 45894482, 94568601, 65287621, 2671330, 38670435,
            83235263, 90654356, 79409334, 63259351, 36042004, 80186010, 16507828, 22431243, 84808313, 83682725,
            10080320, 47325505, 23869735, 11925569, 58419204, 42175079, 79569173, 6740720, 87322378, 3797883,
            24311372, 49587396, 33621868, 73911410, 81480460, 50705071, 46700124, 26302522, 41420027, 66672569,
            20277860, 29491031, 56387350, 19153634, 89111398, 77044671, 23205979, 53839837, 71200730, 34193084,
            57281778, 63012333, 26495087, 70821187, 22056710, 23421244, 55696885, 3072077, 17259470, 70595331,
            34294855, 63665875, 5186893, 31571902, 68670547, 62782218, 54622031, 2204140, 4861205, 4064256,
            31467372, 66835946, 60577362, 97077563, 3149764, 80955168, 67284908, 51228280, 97612389, 25833572,
            25955164, 62340868, 98434877, 94773007, 30778711, 63162310, 99551425, 64389297, 97687912, 2903036,
            34016756, 70781055, 11761845, 91842653, 16475472, 37620434, 66235877, 6850209, 33731070, 79126789,
            6214884, 32619583, 78004197, 5498296, 60228941, 93554166, 93431518, 74117290, 61623148, 33017655,
            29826127, 24317029, 50712728, 99690140, 3381441, 3825890, 47355498, 99523325, 3549275, 46303688,
            25551951, 84290642, 70050374, 87751584, 36562627, 32015116, 38299233, 83241722, 59905358, 3280747,
            62325062, 5606466, 80723580, 99590524, 11593137, 93220472, 79575620, 85605684, 41006930, 53129443,
            19613556, 5318639, 32807846, 27770341, 14087893, 60764581, 67169062, 38120068, 98069388, 1248895,
            53582587, 94192409, 53239672, 50323155, 30459350
        }
		pack[4][2]={}
		pack[4][3]={}
		for _,v in ipairs(pack[4][1]) do table.insert(pack[4][2],v) end
		for _,v in ipairs(pack[4][1]) do table.insert(pack[4][3],v) end
        pack[5]={}
		pack[5][1]={
            36472900, 63977008, 9365703, 96182448, 23571046, 67270095, 92676637, 88559132, 14943837, 40348946,
            71971554, 21159309, 20932152, 57421866, 56286179, 28859794, 36643046, 97268402, 52840598, 53855409,
            78922939, 15310033, 68120130, 56410040, 51855378, 56897896, 83295594, 14017402, 60800381, 23693634,
            44508095, 18013090, 46195773, 29071332, 2322421, 7841112, 42810973, 3429238, 74860293, 24696097,
            50091196, 87259077, 59771339, 79068663, 2295440, 25231813, 51630558, 39701395, 96363153, 15629801,
            98427577, 98273947, 94634433, 16674846, 42079445, 58120309, 97021916, 13821299, 54343893, 23770284,
            19665973, 13708425, 6903857, 32391566, 5780210, 89127526, 40583194, 77087109, 70902743, 40529384,
            67030233, 36407615, 97489701, 80321197, 15576074, 50215517, 87614611, 23008320, 59593925, 24566654,
            24673894, 50078509, 18634367, 41197012, 2986553, 62379337, 50164989, 41160533, 59042331, 85431040,
            44125452, 67441435, 98884569, 49674183, 81146288, 96470883, 23087070, 51852507, 73580472, 4290468,
            71645242, 69584564, 65079854, 1073952, 14730606, 87046457, 23440062, 13438207, 70391588, 2009101,
            49003716, 75498415, 22835145, 58820853, 85215458, 11613567, 46710683, 72714392, 9109991, 26775203,
            52869807, 89258906, 78564023, 4068622, 31053337, 16516630, 52900379, 88305978, 49460512, 41902352,
            28190303, 69031175, 76913983, 33236860, 9012916, 32441317, 94681654, 91351370, 4168871, 59839761,
            59616123, 89040386, 44028461, 53519297, 72278479, 10875327, 46263076, 33537328, 69931927, 41181774,
            79798060, 15187079, 67987302, 95453143, 96907086, 39967326, 29934351, 82340056, 63468625, 4545683,
            39648965, 75733063, 2137678, 38522377, 31930787, 68140974, 86997073, 12986778, 59371387, 85775486,
            67328336, 4081825, 41475424, 77864539, 15394083, 41788781, 88283496, 14677495, 40666140, 77060848,
            13455953, 40844552, 76348260, 2333365, 61777313, 73417207, 30604579, 67098114, 93483212, 55154048,
            91148083, 28643791, 50433147, 89914395, 16308000, 42793609, 89792713, 15286412, 42671151, 88069166,
            14464864, 86827882, 64910482, 1315120, 37300735, 64898834, 293542, 36687247, 90953320, 62560742,
            98558751, 24943456, 51447164, 97836203, 11264180, 58258899, 3868277, 40253382, 76641981, 88671720,
            42280216, 78275321, 78552773, 5220687, 23434538, 74530899, 8967776, 69514125, 7391448, 43385557,
            70780151, 32646477, 95526884, 2403771, 39402797, 25862681, 25958491, 27315304, 39823987, 66818682,
            86137485, 33198837, 2956282, 25165047, 68124775, 93353691, 98012938, 35537860, 67723438, 32391631,
            5851097, 4587638, 65703851, 45178472
        }
		pack[5][2]={}
		pack[5][3]={}
		for _,v in ipairs(pack[5][1]) do table.insert(pack[5][2],v) end
		for _,v in ipairs(pack[5][1]) do table.insert(pack[5][3],v) end
	local namechange={
		--0 - alternate art, 1 - anime/vg/illegal counterpart
		[11082056]={ [1]={11082056,170000151}; };
		[22804644]={ [1]={22804644,170000150}; };
		[23265313]={ [1]={23265313,511002540}; };
		[23265594]={ [1]={23265594,511002851}; };
		[23995348]={ [1]={23995348,511006007}; };
		[24874630]={ [1]={24874630,511001596,511600104}; };
		[29228529]={ [1]={29228529,511777003}; };
		[34408491]={ [1]={34408491,511001992}; };
		[36261276]={ [1]={36261276,511002539}; };
		[39238953]={ [1]={39238953,511000168}; };
		[39701395]={ [1]={39701395,511600013}; };
		[44095762]={ [1]={44095762,513000001}; };
		[48800175]={ [1]={48800175,511002419}; };
		[50078509]={ [1]={50078509,511600109}; };
		[53347303]={ [1]={53347303,511002418}; };
		[54591086]={ [1]={54591086,513000122}; };
		[55713623]={ [1]={55713623,511002777}; };
		[56832966]={ [1]={56832966,511001706}; };
		[57470761]={ [1]={57470761,170000149}; };
		[57728571]={ [1]={57728571,513000009,511000822}; };
		[58293343]={ [1]={58293343,170000155}; };
		[58641905]={ [1]={58641905,511002776}; };
		[59750328]={ [1]={59750328,511001149}; };
		[62873545]={ [1]={62873545,511002859}; };
		[64500000]={ [1]={64500000,511019003,511002853}; };
		[65622692]={ [1]={65622692,511019002,511002852}; };
		[68005187]={ [1]={68005187,513000054}; };
		[83555667]={ [1]={83555667,511000824}; };
		[84687358]={ [1]={84687358,170000154}; };
		[86871614]={ [1]={86871614,511600007}; };
		[95286165]={ [1]={95286165,511000987}; };
		[96300057]={ [1]={96300057,511002901}; };
		[3370104]={ [1]={3370104,511007022}; };
		[3657444]={ [1]={3657444,511002464}; };
		[3659803]={ [1]={3659803,511010525}; };
		[4779091]={ [1]={4779091,511001392}; };
		[5126490]={ [1]={5126490,511000497}; };
		[6480253]={ [1]={6480253,511024001}; };
		[8062132]={ [1]={8062132,511002110}; };
		[9327502]={ [1]={9327502,511002351}; };
		[12958919]={ [1]={12958919,511002834}; };
		[14462257]={ [1]={14462257,511002261}; };
		[15341821]={ [1]={15341821,511005643}; };
		[17032740]={ [1]={17032740,511001652}; };
		[17132130]={ [1]={17132130,511002729}; };
		[17732278]={ [1]={17732278,511600103}; };
		[17955766]={ [1]={17955766,511231002}; };
		[22147147]={ [1]={22147147,511000309}; };
		[25132288]={ [1]={25132288,511000364}; };
		[29612557]={ [1]={29612557,511023008}; };
		[30312361]={ [1]={30312361,511001926}; };
		[31111109]={ [1]={31111109,511001645}; };
		[31764700]={ [1]={31764700,511600424}; };
		[32710364]={ [1]={32710364,511001823}; };
		[32750510]={ [1]={32750510,511002260}; };
		[33776734]={ [1]={33776734,511018000}; };
		[33900648]={ [1]={33900648,511000306}; };
		[35809262]={ [1]={35809262,511018028}; };
		[37195861]={ [1]={37195861,511002350}; };
		[37630732]={ [1]={37630732,511002825}; };
		[40044919]={ [1]={40044919,511002036}; };
		[40591390]={ [1]={40591390,511806001}; };
		[41517968]={ [1]={41517968,511023005}; };
		[43452193]={ [1]={43452193,511310017}; };
		[47121070]={ [1]={47121070,511001129}; };
		[47596607]={ [1]={47596607,511777006}; };
		[48130397]={ [1]={48130397,511003010}; };
		[49352945]={ [1]={49352945,511023007}; };
		[50282757]={ [1]={50282757,511023015}; };
		[50304345]={ [1]={50304345,511024010}; };
		[52512994]={ [1]={52512994,511002371}; };
		[55171412]={ [1]={55171412,511023010}; };
		[55461064]={ [1]={55461064,511027000}; };
		[55690251]={ [1]={55690251,511002277}; };
		[56570271]={ [1]={56570271,511003116}; };
		[57116034]={ [1]={57116034,511018019}; };
		[58996430]={ [1]={58996430,511003020}; };
		[60876124]={ [1]={60876124,511600378}; };
		[61204971]={ [1]={61204971,511002533}; };
		[63035430]={ [1]={63035430,511002379}; };
		[64599569]={ [1]={64599569,511002108}; };
		[65422840]={ [1]={65422840,511002265}; };
		[68745629]={ [1]={68745629,511002353}; };
		[71564252]={ [1]={71564252,513000038}; };
		[74711057]={ [1]={74711057,511023013}; };
		[75732622]={ [1]={75732622,511002836}; };
		[76263644]={ [1]={76263644,511002195}; };
		[77565204]={ [1]={77565204,513000094,511002997}; };
		[77608643]={ [1]={77608643,511018024}; };
		[78371393]={ [1]={78371393,511001391}; };
		[78512663]={ [1]={78512663,511023006}; };
		[79407975]={ [1]={79407975,511001139}; };
		[79473793]={ [1]={79473793,511001784}; };
		[79856792]={ [1]={79856792,511600140}; };
		[79979666]={ [1]={79979666,810000011}; };
		[83121692]={ [1]={83121692,511600286}; };
		[83965311]={ [1]={83965311,511000614}; };
		[85852291]={ [1]={85852291,511000613}; };
		[88643579]={ [1]={88643579,511000362}; };
		[89252153]={ [1]={89252153,511023014}; };
		[89312388]={ [1]={89312388,511600012}; };
		[92826944]={ [1]={92826944,511002370}; };
		[95326659]={ [1]={95326659,511002946}; };
		[97811903]={ [1]={97811903,513000096,511000307}; };
		[99075257]={ [1]={99075257,511002728}; };
		[1224927]={ [1]={1224927,511000376}; };
		[2047519]={ [1]={2047519,511020008}; };
		[6368039]={ [1]={6368039,511009557}; };
		[7562372]={ [1]={7562372,511600239}; };
		[8131171]={ [1]={8131171,511000818}; };
		[12923641]={ [1]={12923641,511003008}; };
		[13604200]={ [1]={13604200,511777009}; };
		[13839120]={ [1]={13839120,511019008}; };
		[13955608]={ [1]={13955608,511015121,511003022}; };
		[15025844]={ [1]={15025844,511009014}; };
		[15259704]={ [1]={15259704,511004007}; };
		[15800838]={ [1]={15800838,511003026}; };
		[16435215]={ [1]={16435215,511000218}; };
		[18807109]={ [1]={18807109,511001016}; };
		[22666164]={ [1]={22666164,511015115}; };
		[24096228]={ [1]={24096228,513000055}; };
		[26202165]={ [1]={26202165,511002631}; };
		[27827272]={ [1]={27827272,511002502}; };
		[28553439]={ [1]={28553439,511600038,511004004}; };
		[30606547]={ [1]={30606547,511010700}; };
		[36045450]={ [1]={36045450,511600006,511600005}; };
		[37383714]={ [1]={37383714,511001593}; };
		[37520316]={ [1]={37520316,511000278}; };
		[38033127]={ [1]={38033127,511600100}; };
		[38247752]={ [1]={38247752,511002416}; };
		[40640059]={ [1]={40640059,511002854}; };
		[40703222]={ [1]={40703222,810000034}; };
		[40737112]={ [1]={40737112,511001039}; };
		[41172955]={ [1]={41172955,511019006}; };
		[41442341]={ [1]={41442341,511002194}; };
		[44095762]={ [1]={44095762,513000001}; };
		[46668237]={ [1]={46668237,511001661}; };
		[47355498]={ [1]={47355498,511002998}; };
		[49587034]={ [1]={49587034,511600004}; };
		[50045299]={ [1]={50045299,511001040}; };
		[50287060]={ [1]={50287060,511600061}; };
		[52090844]={ [1]={52090844,511005647}; };
		[53582587]={ [1]={53582587,511310007}; };
		[58054262]={ [1]={58054262,511015116}; };
		[61740673]={ [1]={61740673,511002996}; };
		[62873545]={ [1]={62873545,511002859}; };
		[63391643]={ [1]={63391643,511600170}; };
		[64788463]={ [1]={64788463,511001594}; };
		[65240384]={ [1]={65240384,511001595,65240394}; };
		[67227834]={ [1]={67227834,511002515,511600171}; };
		[74848038]={ [1]={74848038,511001651}; };
		[75043725]={ [1]={75043725,511003027}; };
		[75347539]={ [1]={75347539,511000462}; };
		[75500286]={ [1]={75500286,511000208}; };
		[77207191]={ [1]={77207191,511009558}; };
		[81510157]={ [1]={81510157,511000372}; };
		[86445415]={ [1]={86445415,511019007}; };
		[87880531]={ [1]={87880531,511600096}; };
		[87910978]={ [1]={87910978,511002549,511002995}; };
		[88619463]={ [1]={88619463,513000095}; };
		[90876561]={ [1]={90876561,511002617}; };
		[93382620]={ [1]={93382620,511020009}; };
		[95286165]={ [1]={95286165,511000987}; };
		[95727991]={ [1]={95727991,511004015,511000228}; };
		[97342942]={ [1]={97342942,511003218}; };
		[99789342]={ [1]={99789342,511002532}; };
		[126218]={ [1]={126218,511000540}; };
		[1224927]={ [1]={1224927,511000376}; };
		[10080320]={ [1]={10080320,511002874}; };
		[19252988]={ [1]={19252988,511013024}; };
		[21558682]={ [1]={21558682,511000248}; };
		[21593977]={ [1]={21593977,21593987}; };
		[21770260]={ [1]={21770260,511002461}; };
		[22359980]={ [1]={22359980,513000002}; };
		[25955164]={ [1]={25955164,511002506}; };
		[26302522]={ [1]={26302522,511002509}; };
		[26376390]={ [1]={26376390,511002387}; };
		[26495087]={ [1]={26495087,511019001}; };
		[26905245]={ [1]={26905245,511009214}; };
		[29228529]={ [1]={29228529,511777003}; };
		[31709826]={ [1]={31709826,513000142}; };
		[33767325]={ [1]={33767325,511021008}; };
		[34016756]={ [1]={34016756,511000474}; };
		[34294855]={ [1]={34294855,511008509}; };
		[41462084]={ [1]={41462084,511000539}; };
		[42035045]={ [1]={42035045,511003058}; };
		[42534368]={ [1]={42534368,511020001}; };
		[42625254]={ [1]={42625254,511003059}; };
		[42664989]={ [1]={42664989,511001126}; };
		[44095762]={ [1]={44095762,513000001}; };
		[45231178]={ [1]={45231178,511001128}; };
		[45894482]={ [1]={45894482,511003006}; };
		[47355498]={ [1]={47355498,511002998}; };
		[49417509]={ [1]={49417509,511003065}; };
		[51228280]={ [1]={51228280,511130000}; };
		[53582587]={ [1]={53582587,511310007}; };
		[53832650]={ [1]={53832650,511003063}; };
		[54844990]={ [1]={54844990,511003064}; };
		[55256016]={ [1]={55256016,511002446}; };
		[55821894]={ [1]={55821894,511006010}; };
		[60577362]={ [1]={60577362,511006003}; };
		[62340868]={ [1]={62340868,511002508}; };
		[63162310]={ [1]={63162310,511000477}; };
		[63432835]={ [1]={63432835,511003067}; };
		[63665875]={ [1]={63665875,511003057}; };
		[64428736]={ [1]={64428736,511003060}; };
		[65830223]={ [1]={65830223,513000026}; };
		[68540059]={ [1]={68540059,511006005}; };
		[71625222]={ [1]={71625222,511002403}; };
		[73915051]={ [1]={73915051,511600290}; };
		[74137509]={ [1]={74137509,511000541}; };
		[76052811]={ [1]={76052811,511015127}; };
		[76714458]={ [1]={76714458,511001785}; };
		[77585514]={ [1]={77585514,513000053}; };
		[80600490]={ [1]={80600490,511003066}; };
		[81439174]={ [1]={81439174,511001056}; };
		[81480460]={ [1]={81480460,511000769}; };
		[85605684]={ [1]={85605684,511000378}; };
		[88264979]={ [1]={88264979,511000670,88264988}; };
		[89904598]={ [1]={89904598,511003069}; };
		[89987208]={ [1]={89987208,511003068}; };
		[90790253]={ [1]={90790253,511009331}; };
		[91512835]={ [1]={91512835,511000695}; };
		[93382620]={ [1]={93382620,511020009}; };
		[94773007]={ [1]={94773007,511000475}; };
		[97077563]={ [1]={97077563,511002048}; };
		[98434877]={ [1]={98434877,511002507}; };
		[98494543]={ [1]={98494543,511016003}; };
		[99050989]={ [1]={99050989,511003056}; };
		[99551425]={ [1]={99551425,511002616}; };
		[293542]={ [1]={293542,513000181,511000075}; };
		[1073952]={ [1]={1073952,511002701}; };
		[1315120]={ [1]={1315120,511000074}; };
		[2137678]={ [1]={2137678,511002529}; };
		[2333365]={ [1]={2333365,511002985}; };
		[2403771]={ [1]={2403771,511600116}; };
		[3429238]={ [1]={3429238,511001982}; };
		[4068622]={ [1]={4068622,511002602}; };
		[4081825]={ [1]={4081825,511002527}; };
		[4168871]={ [1]={4168871,810000056}; };
		[5780210]={ [1]={5780210,511002603}; };
		[7391448]={ [1]={7391448,511002994}; };
		[8967776]={ [1]={8967776,513000052}; };
		[9012916]={ [1]={9012916,511027112}; };
		[10875327]={ [1]={10875327,511000239}; };
		[12986778]={ [1]={12986778,511002378}; };
		[13821299]={ [1]={13821299,511013002}; };
		[14730606]={ [1]={14730606,511021002}; };
		[15187079]={ [1]={15187079,511000242}; };
		[15310033]={ [1]={15310033,511002135}; };
		[15629801]={ [1]={15629801,511002844}; };
		[16308000]={ [1]={16308000,511777010}; };
		[16516630]={ [1]={16516630,511600076}; };
		[20932152]={ [1]={20932152,511002860}; };
		[23440062]={ [1]={23440062,511002989}; };
		[24566654]={ [1]={24566654,511010530}; };
		[24696097]={ [1]={24696097,513000012}; };
		[24943456]={ [1]={24943456,511000077}; };
		[25165047]={ [1]={25165047,511000558}; };
		[25231813]={ [1]={25231813,511010532}; };
		[28190303]={ [1]={28190303,511002664}; };
		[29934351]={ [1]={29934351,511013025}; };
		[30604579]={ [1]={30604579,511000247}; };
		[32391566]={ [1]={32391566,511013004}; };
		[32646477]={ [1]={32646477,511000229}; };
		[33236860]={ [1]={33236860,511001954}; };
		[33537328]={ [1]={33537328,511000250}; };
		[36407615]={ [1]={36407615,511009313}; };
		[36687247]={ [1]={36687247,513000183,511000073}; };
		[37300735]={ [1]={37300735,513000036}; };
		[38522377]={ [1]={38522377,511001644}; };
		[39648965]={ [1]={39648965,511002530}; };
		[39701395]={ [1]={39701395,511600013}; };
		[39823987]={ [1]={39823987,511001981}; };
		[40348946]={ [1]={40348946,511002755}; };
		[40529384]={ [1]={40529384,511013005}; };
		[40666140]={ [1]={40666140,511002796}; };
		[40844552]={ [1]={40844552,511000251}; };
		[41181774]={ [1]={41181774,511000252}; };
		[42671151]={ [1]={42671151,511003080}; };
		[46263076]={ [1]={46263076,511000255}; };
		[49674183]={ [1]={49674183,511002214}; };
		[50078509]={ [1]={50078509,511600109}; };
		[50091196]={ [1]={50091196,511001963}; };
		[51447164]={ [1]={51447164,513000015,511000076}; };
		[51855378]={ [1]={51855378,511002021}; };
		[53519297]={ [1]={53519297,810000051}; };
		[56286179]={ [1]={56286179,511002910}; };
		[57421866]={ [1]={57421866,511013018}; };
		[58120309]={ [1]={58120309,511002520}; };
		[59771339]={ [1]={59771339,511027027}; };
		[60800381]={ [1]={60800381,511009416}; };
		[62379337]={ [1]={62379337,511021009}; };
		[62560742]={ [1]={62560742,511001973}; };
		[63468625]={ [1]={63468625,511002517}; };
		[64898834]={ [1]={64898834,513000035}; };
		[64910482]={ [1]={64910482,513000182,511000072}; };
		[66818682]={ [1]={66818682,513000186,100000153}; };
		[67030233]={ [1]={67030233,513000078}; };
		[67098114]={ [1]={67098114,511000260}; };
		[67441435]={ [1]={67441435,511002598}; };
		[69931927]={ [1]={69931927,511000262}; };
		[71645242]={ [1]={71645242,511014000}; };
		[72714392]={ [1]={72714392,511002219}; };
		[74530899]={ [1]={74530899,513000039}; };
		[75733063]={ [1]={75733063,511002528}; };
		[77087109]={ [1]={77087109,511002880}; };
		[78275321]={ [1]={78275321,511009950}; };
		[79798060]={ [1]={79798060,511000263}; };
		[80321197]={ [1]={80321197,511001501}; };
		[81146288]={ [1]={81146288,511002039}; };
		[82340056]={ [1]={82340056,511247015}; };
		[83295594]={ [1]={83295594,511002136}; };
		[86137485]={ [1]={86137485,511002841}; };
		[87046457]={ [1]={87046457,511003005}; };
		[87259077]={ [1]={87259077,511001956}; };
		[87614611]={ [1]={87614611,511002483}; };
		[88305978]={ [1]={88305978,511002623}; };
		[89040386]={ [1]={89040386,511030014}; };
		[89914395]={ [1]={89914395,511002988}; };
		[93353691]={ [1]={93353691,511001967}; };
		[93483212]={ [1]={93483212,511000264}; };
		[95453143]={ [1]={95453143,513000004,100000150}; };
		[96363153]={ [1]={96363153,511002846}; };
		[97489701]={ [1]={97489701,513000013}; };
		[97836203]={ [1]={97836203,513000014}; };
		[98558751]={ [1]={98558751,511000078}; };
	}
	function SealedDuel.alternate(code,anime)
		local chk=anime and 1 or 0
		if not namechange[code] or not namechange[code][chk] then return code end
		local num=Duel.GetRandomNumber(1,#namechange[code][chk])
		return namechange[code][chk][num]
	end
	function SealedDuel.op(e,tp,eg,ep,ev,re,r,rp)
		for _,card in ipairs(selfs) do
			Duel.SendtoDeck(card,0,-2,REASON_RULE)
		end
		local counts={}
		counts[0]=Duel.GetPlayersCount(0)
		counts[1]=Duel.GetPlayersCount(1)
		Duel.DisableShuffleCheck()
		Duel.Hint(HINT_CARD,0,id)
		--tag variable defining
		local z,o=tp,1-tp
		
		--pack selection
		local selectpack={}
		for _,sel in ipairs({Duel.SelectCardsFromCodes(tp,1,5,false,true,511005095,511005096,511005097,511005098,511005099)}) do
			selectpack[sel[2]]=true
		end

        --pack checking
		if selectpack[3] and not selectpack[1] and not selectpack[2] and not selectpack[4] and not selectpack[5] then
			selectpack[2]=true
		end
		
		--treat as all monster types
		if true then
			local getrc=Card.GetRace
			Card.GetRace=function(c)
				if c:IsMonster() then return 0xfffffff end
				return getrc(c)
			end
			local getorigrc=Card.GetOriginalRace
			Card.GetOriginalRace=function(c)
				if c:IsMonster() then return 0xfffffff end
				return getorigrc(c)
			end
			local getprevrc=Card.GetPreviousRaceOnField
			Card.GetPreviousRaceOnField=function(c)
				if (c:GetPreviousTypeOnField()&TYPE_MONSTER)~=0 then return 0xfffffff end
				return getprevrc(c)
			end
			local isrc=Card.IsRace
			Card.IsRace=function(c,r)
				if c:IsMonster() then return true end
				return isrc(c,r)
			end
		end
		--anime counterparts select
		anime=Duel.SelectYesNo(tp,aux.Stringid(4006,15))
		if anime then
			Duel.Hint(HINT_OPSELECTED,tp,aux.Stringid(4006,15))
		end
			
		--anime counterparts
		local groups={}
		groups[0]={}
		groups[1]={}
		for i=1,counts[0] do
			groups[0][i]={}
		end
		for i=1,counts[1] do
			groups[1][i]={}
		end
		
		for p=z,o do
			for team=1,counts[p] do
				for i=1,12 do
					local packnum=0
					--random set among selected sets
					repeat
						packnum=Duel.GetRandomNumber(1,5)
					until selectpack[packnum]
					for i=1,5 do
						local rarity
						if i==1 then
							rarity=1
						elseif i<5 then
							rarity=2
						else
							rarity=3
						end
						local code
						if rarity==3 and packnum==3 then
							local tempn=3
							repeat
								tempn=Duel.GetRandomNumber(1,5)
							until tempn~=3 and selectpack[tempn]
							code=pack[tempn][3][Duel.GetRandomNumber(1,#pack[tempn][3])]
						else
							code=pack[packnum][rarity][Duel.GetRandomNumber(1,#pack[packnum][rarity])]
						end
						local finalcode=SealedDuel.alternate(code,anime)
						table.insert(groups[p][team],finalcode)
					end
				end
			end
		end
		
		for p=z,o do
			for team=1,counts[p] do
				Duel.SendtoDeck(Duel.GetFieldGroup(p,0xff,0),nil,-2,REASON_RULE)
				for idx,code in ipairs(groups[p][team]) do
					Debug.AddCard(code,p,p,LOCATION_DECK,1,POS_FACEDOWN_DEFENSE)
				end
				Debug.ReloadFieldEnd()
				Duel.Hint(HINT_SELECTMSG,p,aux.Stringid(4002,7))
				local fg=Duel.GetFieldGroup(p,0xff,0)
				local exclude=fg:Select(p,0,#fg-20,nil)
				if exclude then
					Duel.SendtoDeck(exclude,nil,-2,REASON_RULE)
				end
				Duel.ShuffleDeck(p)
				Duel.ShuffleExtra(p)
				local dtpg=Duel.GetDecktopGroup(p,Duel.GetStartingHand(p))
				Duel.ConfirmCards(p,dtpg)
				if Duel.SelectYesNo(p,aux.Stringid(id,0)) then
					Duel.MoveToDeckBottom(dtpg)
				end
				if counts[p]~=1 then
					Duel.TagSwap(p)
				end
			end
		end
	end
	finish_setup()
end
if not Duel.GetStartingHand then
	Duel.GetStartingHand=function() return 5 end
end
