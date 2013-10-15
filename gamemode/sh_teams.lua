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
function GetMapSetPos()
if game.GetMap() == ("finalfrontier_a10_nx91_v2") then
	local ShipPos = {}
	ShipPos[TEAM_Or] = Vector(-4720, 3883, 1208) 
	ShipPos[TEAM_Bl] = Vector( 4720, 7973, 1208)
	ShipPos[TEAM_Pu] = Vector(-4721.388672, -221.870987, 1208.031250)
	ShipPos[TEAM_Gr] = Vector(-4731.745117, -4325.389160, 1208.031250)
	else
	local ShipPos = {}
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
		ply:SetPos(Vector(-4720, 3883, 1208))
		end
	if ply:Team() == TEAM_Bl then
		ply:SetPos(Vector(4720, 7973, 1208))
		end
	if ply:Team() == TEAM_Pu then
		ply:SetPos(Vector(-4721.388672, -221.870987, 1208.031250))
		end
	if ply:Team() == TEAM_Gr then
		ply:SetPos(Vector(-4731.745117, -4325.389160, 1208.031250))
		end
	end
	end

if SERVER then
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
