table.insert(LevelList,"darkrp")
darkrp = darkrp or {}
darkrp.Name = "Allah RP"
darkrp.NoSelectRandom = true
darkrp.ArestTime = 60

darkrp.limits = {
    vehicle = false,
    ragdoll = 1,
    prop = 10,
    effect = 5,
    npc = false,
    swep = false,
}



NOTIFY_GENERIC = 0
NOTIFY_ERROR = 1
NOTIFY_UNDO = 2
NOTIFY_HINT = 3
NOTIFY_CLEANUP = 4--lmao

function darkrp.StartRound()
    game.CleanUpMap(false)
    if not CLIENT then 
        darkrp.StartRoundSV()
    else
        darkrp.StartRoundCL()
    end 
end