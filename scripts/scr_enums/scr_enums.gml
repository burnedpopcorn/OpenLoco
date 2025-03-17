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
	
	// missing states
	unknown126		= 126, // in obj_secretportal for some reason
	unknown95		= 95,
	unknown88		= 88,
	unknown79		= 79,
	unknown53		= 53,
	unknown39		= 39,
	unknown27		= 27,
	unknown25		= 25,
	unknown24		= 24,
	unknown18		= 18,
	unknown15		= 15,
	unknown12		= 12,
	unknown9		= 9,
}

// player special attacks
enum playerspecialmove
{
	kungfu			= 0,
	shoulderbash	= 1,
	faceplant		= 2,
	cappy			= 3, // default
}

// enemy states
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
	
	// unused ones kinda
	bounce			= 1,
	unknown			= 126,
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

// transformation text
enum texteffect
{
	smoothupdown	= 0,
	crazyshake		= 1,
	randupdown		= 2,
}

enum TVstates
{
	maintv			= 0,
	whitenoise		= 1,
	delay			= 2, //whitenoise timer to switch to main
	
	start			= 3,
}

// temp name
enum combonum
{
	state0			= 0,
	state1			= 1,
	state2			= 2,
}

// patrick pillar
enum pillar
{
	idle			= 0,
	hit				= 1,
}

// obj_textbox | Yoshi NPC
enum npctext
{
	startidle	= 0,
	opentextbox	= 1,
	npctalk		= 2,
	checktxtbox = 3,
	endidle		= 4,
}

// for obj_savesystem
enum savestate
{
	idle		= 0,
	bufdelete	= 1,
	bufload		= 2,
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

enum antileakcounter
{
	disabled		= 0,
	enabled			= 1,
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