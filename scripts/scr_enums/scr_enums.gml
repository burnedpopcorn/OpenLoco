// NOTE
// - Any unknown{val} enums are used in code somewhere, but rarely and are basically unused
// - ones labeled as unused dont appear anywhere in code, but are here because they are present in SAGE build 
// - lines like // {val} means that entry existed, but doesn't exist in the code, and idk the would be name of it

// also you could just remove the unknown and unused ones and the values for every entry
// they're just here to be faithful to the original build
enum states 
{
    normal				= 0,
	bounce				= 1,
	tumble				= 2,
    finishingblow		= 3,
    ejected				= 4,
	transitioncutscene	= 5, // unused except one place
	fireass				= 6,
    firemouth			= 7,
	titlescreen			= 8,
	hookshot			= 9,
    tacklecharge		= 10,
	
	// the idk section
	unknown11			= 11,
	unknown12			= 12,
    zombie				= 13,
	// 14
	unknown15			= 15,
	// 16
	
    climbwall			= 17,
	knightpepslopes		= 18,
    portal				= 19,
	secondjump			= 20, // unused
    chainsawbump		= 21,
    handstandjump		= 22,
    gottreasure			= 23,
	knightpep			= 24,
    knightpepattack		= 25,
    meteorpep			= 26,
	bombpep				= 27,
    grabbing			= 28,
	chainsawpogo		= 29,
	shotgunjump			= 30,
	stunned				= 31,
	highjump			= 32,
	chainsaw			= 33,
	facestomp			= 34,
	unknown35			= 35,
	timesup				= 36,
	machroll			= 37,
	shotgun				= 38,
	pistol				= 39,
	machfreefall		= 40,
	throwin				= 41,
	slam				= 42,
	superslam			= 43,
	lawnmower			= 44,
	grind				= 45,
	grab				= 46,
	punch				= 47,
	backkick			= 48,
	uppunch				= 49,
	shoulder			= 50,
	backbreaker			= 51,
	bossdefeat			= 52, // unused
	pizzathrow			= 53,
	bossintro			= 54,
	gameover			= 55,
	keyget				= 56,
	tackle				= 57,
	jump				= 58,
	ladder				= 59,
	slipnslide			= 60,
	comingoutdoor		= 61,
	smirk				= 62, // unused
	Sjump				= 63,
	victory				= 64,
	Sjumpprep			= 65,
	crouch				= 66,
	crouchjump			= 67,
	crouchslide			= 68,
	mach1				= 69,
	mach2				= 70,
	machslide			= 71,
	bump				= 72,
	hurt				= 73,
	freefall			= 74,
	hang				= 75,
	// 76
	freefallland		= 77,
	door				= 78,
	barrelcrouch		= 79,
    barrelfloat			= 80, // unused
    barrelmach2			= 81, // unused
    barrelmach1			= 82, // unused
    barrelfall			= 83, // unused
    barrelnormal		= 84, // unused
    barrelslipnslide	= 85, // unused
    barrelroll			= 86, // unused
	current				= 87,
	
	// idk section 2.0
	unknown88			= 88,
	taxi				= 89,
	// 90
	mach3				= 91,
	freefallprep		= 92,
	Sjumpland			= 93,
	// 94
	unknown95			= 95,
	// 96
	throwing			= 97,
	// 98
	// 99
	// 100
	// 101
	// 102
	// 103
	// 104
	// 105
	
	// enemy states
	grabbed				= 106,
	hit					= 107,
	land				= 108,
	charge				= 109,
	actor				= 110,
	
	debugstate			= 111,
	zombiejump			= 112,
	parrying			= 113,
	faceplant			= 114,
	gateeject			= 115,
	bubble				= 116,
	zombieattack		= 117,
	lawnmowerslide		= 118,
	slipbanana			= 119,
	lungeattack			= 120,
	kungfu				= 121,
	genobeam			= 122,
	slidekick			= 123,
	// 124
	cappythrow			= 125,
	unknown126			= 126,
	cape				= 127,
	capefall			= 128,
	geno_normal			= 129,
	geno_jump			= 130,
	geno_shoot			= 131,
}

// player special attacks
enum playerspecialmove
{
	kungfu			= 0,
	shoulderbash	= 1,
	faceplant		= 2,
	cappy			= 3, // default
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

// for obj_gatespawnplayer
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