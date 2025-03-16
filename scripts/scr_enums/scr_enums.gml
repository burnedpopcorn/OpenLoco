enum states 
{
    normal			= 0,
    grabbed			= 106,
    finishingblow	= 3,
    tumble			= 2,
	titlescreen		= 8,
    ejected			= 4,
    firemouth		= 7,
    fireass			= 6,
    tacklecharge	= 10,
    zombie			= 13,
    climbwall		= 17,
    portal			= 19,
    chainsawbump	= 21,
    handstandjump	= 22,
    gottreasure		= 23,
    meteorpep		= 26,
    grabbing		= 28,
	chainsawpogo	= 29,
	shotgunjump		= 30,
	stunned			= 31,
	highjump		= 32,
	chainsaw		= 33,
	facestomp		= 34,
	timesup			= 36,
	machroll		= 37,
	shotgun			= 38,
	machfreefall	= 40,
	throwin			= 41,
	superslam		= 43,
	slam			= 42,
	lawnmower		= 44,
	grind			= 45,
	grab			= 46,
	punch			= 47,
	backkick		= 48,
	uppunch			= 49,
	shoulder		= 50,
	backbreaker		= 51,
	bossintro		= 54,
	gameover		= 55,
	Sjumpland		= 93,
	freefallprep	= 92,
	keyget			= 56,
	tackle			= 57,
	slipnslide		= 60,
	ladder			= 59,
	jump			= 58,
	victory			= 64,
	comingoutdoor	= 61,
	Sjump			= 63,
	Sjumpprep		= 65,
	crouch			= 66,
	crouchjump		= 67,
	crouchslide		= 68,
	mach1			= 69,
	mach2			= 70,
	mach3			= 91,
	machslide		= 71,
	bump			= 72,
	hurt			= 73,
	freefall		= 74,
	freefallland	= 77,
	hang			= 75,
	door			= 78,
	current			= 87,
	taxi			= 89,
	actor			= 110,
	debugstate		= 111,
	zombiejump		= 112,
	parrying		= 113,
	faceplant		= 114,
	gateeject		= 115,
	bubble			= 116,
	zombieattack	= 117,
	lawnmowerslide	= 118,
	slipbanana		= 119,
	lungeattack		= 120,
	kungfu			= 121,
	genobeam		= 122,
	slidekick		= 123,
	cappythrow		= 125,
	cape			= 127,
	capefall		= 128,
	
	geno_normal		= 129,
	geno_jump		= 130,
	geno_shoot		= 131,
}

enum playerspecialmove
{
	kungfu			= 0,
	shoulderbash	= 1,
	faceplant		= 2,
	cappy			= 3,
}
	
enum baddiestates
{
	// idk man, its just like that in the original
	idle			= 0,
	charge			= 109,
	turn			= 127,
	walk			= 110,
	land			= 108,
	hit				= 107,
	stun			= 128,
	throwing		= 97,
	grabbed			= 106,
	rage			= 125,
	
	// only obj_dedede uses it im pretty sure
	bounce			= 1,
}

// for cappy
enum cappystates
{
	fly				= 0,
	enemykill		= 1,
	comeback		= 2,
}

// player afterimages
enum afterimgs
{
	grabimg			= 0,
	runningcolors	= 1,
	unusedimg		= 2, // never could get it to trigger
}

// patrick pillar
enum pillar
{
	idle			= 0,
	hit				= 1,
}

// for obj_gatespawnplayer CHANGE ENUM NAME
enum gatespawn
{
	init			= 0,
	spawn			= 1,
	die				= 2,
}

// for obj_escapespawn
enum spawnbaddies
{
	idle			= 0,
	checkplayer		= 1,
	spawn			= 2,
	die				= 3,
}

// for obj_fakepep (unused, but still)
enum fakepepmoves
{
	idle			= 0,
	walk			= 110,
	hit				= 107,
	jump			= 58,
}

// obj_bosscontroller
enum boss_states
{
	intro1			= 0,
	intro2			= 1,
	intro3			= 2,
	ingameintro		= 3,
	
	enterfight		= 4,
	fighting		= 5,//the do nothing state
	
	endingcutscene	= 6,
	ending			= 7,
	ended			= 8,
}

enum ballstates
{
	air				= 0,
	land			= 1,
}

// zombie arena
enum zarena
{
	idle			= 0,
	start			= 1,
	startcheck		= 2,
	gameloop		= 3,
	ending			= 4,
}

// temp enums for colmesh
enum colmesh_enum 
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_6,
    Value_7,
    Value_8,
    Value_9,
    Value_10,
    Value_11,
    Value_12,
    Value_13,
    Value_14,
}
	
// temporary
enum UnknownEnum {
    Value_m5 = -5,
    Value_m1 = -1,
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_6,
    Value_7,
    Value_8,
    Value_9,
    Value_10,
    Value_11,
    Value_12,
    Value_13,
    Value_14,
    Value_15,
    Value_16,
    Value_17,
    Value_18,
    Value_19,
    Value_20,
    Value_21,
    Value_22,
    Value_23,
    Value_24,
    Value_25,
    Value_26,
    Value_27,
    Value_28,
    Value_29,
    Value_30,
    Value_31,
    Value_32,
    Value_33,
    Value_34,
    Value_35,
    Value_36,
    Value_37,
    Value_38,
    Value_39,
    Value_40,
    Value_41,
    Value_42,
    Value_43,
    Value_44,
    Value_45,
    Value_46,
    Value_47,
    Value_48,
    Value_49,
    Value_50,
    Value_51,
    Value_52,
    Value_53,
    Value_54,
    Value_55,
    Value_56,
    Value_57,
    Value_58,
    Value_59,
    Value_60,
    Value_61,
    Value_62,
    Value_63,
    Value_64,
    Value_65,
    Value_66,
    Value_67,
    Value_68,
    Value_69,
    Value_70,
    Value_71,
    Value_72,
    Value_73,
    Value_74,
    Value_75,
    Value_76,
    Value_77,
    Value_78,
    Value_79,
    Value_80,
    Value_81,
    Value_87 = 87,
    Value_88,
    Value_89,
    Value_91 = 91,
    Value_92,
    Value_93,
    Value_96 = 96,
    Value_97,
    Value_106 = 106,
    Value_107,
    Value_108,
    Value_109,
    Value_110,
    Value_111,
    Value_112,
    Value_113,
    Value_114,
    Value_115,
    Value_116,
    Value_117,
    Value_118,
    Value_119,
    Value_120,
    Value_121,
    Value_122,
    Value_123,
    Value_125 = 125,
    Value_126,
    Value_127,
    Value_128,
    Value_129,
    Value_130,
    Value_131,
};