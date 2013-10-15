TEAM_Or = 1
team.SetUp(TEAM_Or, "Orange", Color(222,127,18,255), true)
TEAM_Bl = 2
team.SetUp(TEAM_Bl, "Blue", Color(0,0,255,255), true)
TEAM_Pu = 3
team.SetUp(TEAM_Pu, "Purple", Color(92,10,139,200), true)
TEAM_Gr = 4
team.SetUp(TEAM_Gr, "Green", Color(19,139,10,255), true) 

function TableShuffle(t)
	math.randomseed(CurTime())
	local n = #t
	while n > 2 do
		local k = math.random(1, n)
		t[n], t[k] = t[k], t[n]
		n = n - 1
	end
	return t
end

if SERVER then
	ShipPos = {}
	function GetMapSetPos()
		if game.GetMap() == ("finalfrontier_a10_nx91_v2") then
			ShipPos[TEAM_Or] = Vector(-4720, 3883, 1208)
			ShipPos[TEAM_Bl] = Vector(-4720, 7982, 1208)
			ShipPos[TEAM_Pu] = Vector(-4720, -222, 1208)
			ShipPos[TEAM_Gr] = Vector(-4732, -4325, 1208)
		else
			ShipPos[TEAM_Or] = Vector(-4720, 3883, 1208)
			ShipPos[TEAM_Bl] = Vector( 4720, 7973, 1208)
		end
	end
	GetMapSetPos()
end

function CheckTeams()
	if team.NumPlayers(1)*4<team.NumPlayers(2)+team.NumPlayers(3)+team.NumPlayers(4) then
		return 1
	elseif team.NumPlayers(2)*4<team.NumPlayers(1)+team.NumPlayers(3)+team.NumPlayers(4) then
		return 2
	elseif team.NumPlayers(3)*4<team.NumPlayers(2)+team.NumPlayers(1)+team.NumPlayers(4) then
		return 3
	else
		return 4
	end
end


if SERVER then
	function ShipSet(ply)
		if ply:Team() == TEAM_Or then
			ply:SetPos(ShipPos[Team_OR])
		elseif ply:Team() == TEAM_Bl then
			ply:SetPos(ShipPos[Team_Bl])
		elseif ply:Team() == TEAM_Pu then
			ply:SetPos(ShipPos[Team_Pu])
		elseif ply:Team() == TEAM_Gr then
			ply:SetPos(ShipPos[Team_Gr])
		end
	end
	function ShuffleTeams()
		for k, v in pairs(player:GetAll()) do
			v:SetTeam(10)
			--v:ChatPrint("SpecTeam + "..team.GetName(v:Team()))
		end
		local TeamShuffle = TableShuffle(player:GetAll())
		for k, v in pairs(TeamShuffle) do
			v:SetTeam(CheckTeams())
			--v:ChatPrint(team.GetName(v:Team()))
		end
		TeamShuffle = {}
	end
end
