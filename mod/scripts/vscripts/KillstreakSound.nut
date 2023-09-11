untyped

global function KillstreakSound_Init

void function KillstreakSound_Init()
{
	AddCallback_OnPlayerKilled(AddStreak)
	print("====== init KillstreakSound")
}


float lastKillTime = 0
int playerStreak = 0

#if CLIENT

int vidsize = 1
float killstreakLifeTime = 20

void function PlayKillstreakSound()
{
	int audioNumber = playerStreak
	if (audioNumber > 5) audioNumber = 5
	GetLocalClientPlayer().ClientCommand("playvideo killss" + audioNumber + " " + vidsize + " " + vidsize)
	GetLocalClientPlayer().ClientCommand("playvideo killss" + audioNumber + " " + vidsize + " " + vidsize)
}

void function AddStreak(ObituaryCallbackParams Streakparams)
{
	if(Streakparams.victim == GetLocalClientPlayer())
	{
		print("dead")
		playerStreak = 0
		return
	}

    if(Streakparams.attacker != GetLocalClientPlayer())
	{
        return
	}

	if (Time() > lastKillTime + killstreakLifeTime)
	{
		playerStreak = 0
	}

	playerStreak++
	thread PlayKillstreakSound()
	lastKillTime = Time()
}


#endif