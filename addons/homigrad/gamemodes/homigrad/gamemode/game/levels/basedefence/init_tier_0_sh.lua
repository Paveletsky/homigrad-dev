--table.insert(LevelList,"basedefence") временно убрано
basedefence = {}
basedefence.Name = "Zombie Defence"

basedefence.red = {"Выжившие",Color(155,155,155)}
basedefence.blue = {"Zombie",Color(55,55,255)}

basedefence.teamEncoder = {
    [1] = "red",
    [2] = "blue"
}

basedefence.NoSelectRandom = true
basedefence.RoundRandomDefalut = 1

function basedefence.StartRound()
    team.SetColor(1,basedefence.red[2])
    team.SetColor(2,basedefence.blue[2])

    game.CleanUpMap(false)

    if CLIENT then return end

    basedefence.StartRoundSV()
end

basedefence.SupportCenter = true