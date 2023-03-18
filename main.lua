--VARIABLES--
local locations = {
	["1"] = {0.5084, 0.8818, 85}, -- ORGRIMMAR
	["2"] = {0.4223, 0.1221, 1}, -- DUROTA (FUERA DE ORGRIMMAR)
	["3"] = {0.5084, 0.8818, 85},
	["4"] = {0.5084, 0.8818, 85},
	["5"] = {0.5084, 0.8818, 85}
}
local startedEvent = false
local currentRound = "1"
local fje_UpdateInterval = 6.0
local isPlayingRadar = false
local isPlayingBgMusic = false
local isPlayingFoundSound1 = false
local isPlayingFoundSound2 = false
local isPlayingFoundSound3 = false
local isPlayingFoundSound4 = false
local isPlayingFoundSound5 = false
local roundFinished1 = false
local roundFinished2 = false
local roundFinished3 = false
local roundFinished4 = false
local roundFinished5 = false

local margen1 = 0.75
local margen2 = 0.40
local margen3 = 0.25
local margen4 = 0.10
local margen5 = 0.05


--FUNCIONES--
function ComputeDistance(instance1, y1, x1, instance2, y2, x2)
  return instance1 == instance2 and ((x2 - x1) ^ 2 + (y2 - y1) ^ 2) ^ 0.5
end

function fje_OnUpdate(self, elapsed)
	if( startedEvent == false ) then return false end
  self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed; 	

  while (self.TimeSinceLastUpdate > fje_UpdateInterval) do

  	if( currentRound == "1" ) then
  		findJuegoconelcodo1()
  	elseif( currentRound == "2" ) then
  		findJuegoconelcodo2()
  	elseif( currentRound == "3" ) then
  		findJuegoconelcodo3()
  	elseif( currentRound == "4" ) then
  		findJuegoconelcodo4()
  	elseif( currentRound == "5" ) then
  		findJuegoconelcodo5()
		end

		self.TimeSinceLastUpdate = self.TimeSinceLastUpdate - fje_UpdateInterval;
  end
end

function handleRadar(playRadar)
	if( playRadar ~= false and isPlayingRadar == false ) then
		local willPlay, soundHandle = PlaySoundFile("Interface\\Addons\\FindJuegoconelcodoEvent\\sounds\\sonar"..playRadar..".mp3", "Master")
		playRadar = false
	end
end

function handleLoc()
	local targetLocX = locations[currentRound][1]
	local targetLocY = locations[currentRound][2]
	local targetLocInstance = locations[currentRound][3]

	mapID = C_Map.GetBestMapForUnit("player")
	position = C_Map.GetPlayerMapPosition(mapID, "player");
	posX, posY = position:GetXY()
	distance = ComputeDistance(mapID, posY, posX, targetLocInstance, targetLocY, targetLocX)

	return distance
end

function startBgMusic()
	if( isPlayingBgMusic == false ) then
		isPlayingBgMusic = true
		PlayMusic("Interface\\Addons\\FindJuegoconelcodoEvent\\sounds\\bg_music.mp3", "Master")
	end
end

function stopBgMusic()
	if( isPlayingBgMusic ~= false ) then
		isPlayingBgMusic = false
		StopMusic()
	end
end

--COMANDO FINDJUEGOCONELCODO1--
function findJuegoconelcodo1()
	if( roundFinished1 ~= false ) then return true end
	distance = handleLoc()

	if( distance == false ) then
		print('Parece que todavía no estás en la zona correcta')
		stopBgMusic()
	else
		local playRadar = false

		startBgMusic()

		if( distance <= margen1 and distance > margen2 ) then
			print('Sientes una energía poderosa a lo lejos, parece que estás en la zona correcta')
			playRadar = "1"
		else
			if( distance <= margen2 and distance > margen3) then
				print('Todavía estás lejos del objetivo')
				playRadar = "2"
			else
				if( distance <= margen3 and distance > margen4 ) then
					print('Te estás acercando, presta atención a tus alrededores')
					playRadar = "3"
				else
					if( distance <= margen4 and distance > margen5 ) then
						print('La energía que emana de tu objetivo es tan fuerte que estás a punto de desmayarte')
						playRadar = "4"
					else
						print('¡Felicidades! Has encontrado el objetivo de esta ronda. Reclama tu premio')
						if( isPlayingFoundSound1 == false ) then
							isPlayingFoundSound1 = true
							roundFinished1 = true
							PlaySoundFile("Interface\\Addons\\FindJuegoconelcodoEvent\\sounds\\agradecer_vida.mp3", "Master")
						end
					end
				end
			end
		end

		handleRadar(playRadar)
	end
end

SLASH_FINDJUEGOCONELCODO11 = '/codo1'
SlashCmdList["FINDJUEGOCONELCODO1"] = findJuegoconelcodo1


--COMANDO FINDJUEGOCONELCODO2--
function findJuegoconelcodo2()
	if( roundFinished2 ~= false ) then return true end
	distance = handleLoc()

	if( distance == false ) then
		print('Parece que todavía no estás en la zona correcta')
		stopBgMusic()
	else
		local playRadar = false

		startBgMusic()

		if( distance <= margen1 and distance > margen2 ) then
			print('Sientes una energía poderosa a lo lejos, parece que estás en la zona correcta')
		else
			if( distance <= margen2 and distance > margen3) then
				print('Todavía estás lejos del objetivo')
				playRadar = "1"
			else
				if( distance <= margen3 and distance > margen4 ) then
					print('Te estás acercando, presta atención a tus alrededores')
					playRadar = "2"
				else
					if( distance <= margen4 and distance > margen5 ) then
						print('La energía que emana de tu objetivo es tan fuerte que estás a punto de desmayarte')
						playRadar = "3"
					else
						print('¡Felicidades! Has encontrado el objetivo de esta ronda. Reclama tu premio')
						if( isPlayingFoundSound2 == false ) then
							isPlayingFoundSound2 = true
							roundFinished2 = true
							PlaySoundFile("Interface\\Addons\\FindJuegoconelcodoEvent\\sounds\\agradecer_vida.mp3", "Master")
						end
					end
				end
			end
		end

		handleRadar(playRadar)
	end
end

SLASH_FINDJUEGOCONELCODO21 = '/codo2'
SlashCmdList["FINDJUEGOCONELCODO2"] = findJuegoconelcodo2


--COMANDO FINDJUEGOCONELCODO3--
function findJuegoconelcodo3()
	if( roundFinished3 ~= false ) then return true end
	distance = handleLoc()

	if( distance == false ) then
		print('Parece que todavía no estás en la zona correcta')
		stopBgMusic()
	else
		local playRadar = false

		startBgMusic()

		if( distance <= margen1 and distance > margen2 ) then
			print('Sientes una energía poderosa a lo lejos, parece que estás en la zona correcta')
		else
			if( distance <= margen2 and distance > margen3) then
				print('Todavía estás lejos del objetivo')
				playRadar = "1"
			else
				if( distance <= margen3 and distance > margen4 ) then
					print('Te estás acercando, presta atención a tus alrededores')
					playRadar = "2"
				else
					if( distance <= margen4 and distance > margen5 ) then
						print('La energía que emana de tu objetivo es tan fuerte que estás a punto de desmayarte')
						playRadar = "3"
					else
						print('¡Felicidades! Has encontrado el objetivo de esta ronda. Reclama tu premio')
						if( isPlayingFoundSound3 == false ) then
							isPlayingFoundSound3 = true
							roundFinished3 = true
							PlaySoundFile("Interface\\Addons\\FindJuegoconelcodoEvent\\sounds\\agradecer_vida.mp3", "Master")
						end
					end
				end
			end
		end

		handleRadar(playRadar)
	end
end

SLASH_FINDJUEGOCONELCODO31 = '/codo3'
SlashCmdList["FINDJUEGOCONELCODO3"] = findJuegoconelcodo3


--COMANDO FINDJUEGOCONELCODO4--
function findJuegoconelcodo4()
	if( roundFinished4 ~= false ) then return true end
	distance = handleLoc()

	if( distance == false ) then
		print('Parece que todavía no estás en la zona correcta')
		stopBgMusic()
	else
		local playRadar = false

		startBgMusic()

		if( distance <= margen1 and distance > margen2 ) then
			print('Sientes una energía poderosa a lo lejos, parece que estás en la zona correcta')
		else
			if( distance <= margen2 and distance > margen3) then
				print('Todavía estás lejos del objetivo')
				playRadar = "1"
			else
				if( distance <= margen3 and distance > margen4 ) then
					print('Te estás acercando, presta atención a tus alrededores')
					playRadar = "2"
				else
					if( distance <= margen4 and distance > margen5 ) then
						print('La energía que emana de tu objetivo es tan fuerte que estás a punto de desmayarte')
						playRadar = "3"
					else
						print('¡Felicidades! Has encontrado el objetivo de esta ronda. Reclama tu premio')
						if( isPlayingFoundSound4 == false ) then
							isPlayingFoundSound4 = true
							roundFinished4 = true
							PlaySoundFile("Interface\\Addons\\FindJuegoconelcodoEvent\\sounds\\agradecer_vida.mp3", "Master")
						end
					end
				end
			end
		end

		handleRadar(playRadar)
	end
end

SLASH_FINDJUEGOCONELCODO41 = '/codo4'
SlashCmdList["FINDJUEGOCONELCODO4"] = findJuegoconelcodo4


--COMANDO FINDJUEGOCONELCODO5--
function findJuegoconelcodo5()
	if( roundFinished5 ~= false ) then return true end
	distance = handleLoc()

	if( distance == false ) then
		print('Parece que todavía no estás en la zona correcta')
		stopBgMusic()
	else
		local playRadar = false

		startBgMusic()

		if( distance <= margen1 and distance > margen2 ) then
			print('Sientes una energía poderosa a lo lejos, parece que estás en la zona correcta')
		else
			if( distance <= margen2 and distance > margen3) then
				print('Todavía estás lejos del objetivo')
				playRadar = "1"
			else
				if( distance <= margen3 and distance > margen4 ) then
					print('Te estás acercando, presta atención a tus alrededores')
					playRadar = "2"
				else
					if( distance <= margen4 and distance > margen5 ) then
						print('La energía que emana de tu objetivo es tan fuerte que estás a punto de desmayarte')
						playRadar = "3"
					else
						print('¡Felicidades! Has encontrado el objetivo de esta ronda. Reclama tu premio')
						if( isPlayingFoundSound5 == false ) then
							isPlayingFoundSound5 = true
							roundFinished5 = true
							PlaySoundFile("Interface\\Addons\\FindJuegoconelcodoEvent\\sounds\\agradecer_vida.mp3", "Master")
						end
					end
				end
			end
		end

		handleRadar(playRadar)
	end
end

SLASH_FINDJUEGOCONELCODO51 = '/codo5'
SlashCmdList["FINDJUEGOCONELCODO5"] = findJuegoconelcodo5


--COMANDO GETCURRENTLOC--
function getCurrentLoc()
	mapID = C_Map.GetBestMapForUnit("player")
	position = C_Map.GetPlayerMapPosition(mapID, "player");
	posX, posY = position:GetXY()
	currentLocation = C_Map.GetMapInfo(mapID)
	print("-------------------------------------")
	print("X: " .. posX)
	print("Y: " .. posY)
	print("Instancia: " .. currentLocation.name .. " (" .. mapID .. ")")
	print("-------------------------------------")
end
SLASH_GETCURRENTLOC1 = '/codoloc'
SlashCmdList["GETCURRENTLOC"] = getCurrentLoc


--COMANDO CODOEVENTO--
function toggleEvento()
	if( startedEvent == false ) then
		print('Addon activado. Te recomendamos activar la música del juego. !Disfruta el evento! :)')
		startedEvent = true
	else
		print('Addon desactivado')
		startedEvent = false
		stopBgMusic()
	end
end
SLASH_CODOEVENTO1 = '/codoevento'
SlashCmdList["CODOEVENTO"] = toggleEvento


--COMANDO SETRONDA1--
function setRonda1()
	print('Ronda 1 comenzada. ¡Buena suerte!')
	isPlayingFoundSound1 = false
	roundFinished1 = false
	currentRound = "1"
	stopBgMusic()
end
SLASH_SETRONDA11 = '/codoronda1'
SlashCmdList["SETRONDA1"] = setRonda1


--COMANDO SETRONDA2--
function setRonda2()
	print('Ronda 2 comenzada. ¡Buena suerte!')
	isPlayingFoundSound2 = false
	roundFinished2 = false
	currentRound = "2"
	stopBgMusic()
end
SLASH_SETRONDA21 = '/codoronda2'
SlashCmdList["SETRONDA2"] = setRonda2


--COMANDO SETRONDA3--
function setRonda3()
	print('Ronda 3 comenzada. ¡Buena suerte!')
	isPlayingFoundSound3 = false
	roundFinished3 = false
	currentRound = "3"
	stopBgMusic()
end
SLASH_SETRONDA31 = '/codoronda3'
SlashCmdList["SETRONDA3"] = setRonda3


--COMANDO SETRONDA4--
function setRonda4()
	print('Ronda 4 comenzada. ¡Buena suerte!')
	isPlayingFoundSound4 = false
	roundFinished4 = false
	currentRound = "4"
	stopBgMusic()
end
SLASH_SETRONDA41 = '/codoronda4'
SlashCmdList["SETRONDA4"] = setRonda4


--COMANDO SETRONDA5--
function setRonda5()
	print('Ronda 5 comenzada. ¡Buena suerte!')
	isPlayingFoundSound5 = false
	roundFinished5 = false
	currentRound = "5"
	stopBgMusic()
end
SLASH_SETRONDA51 = '/codoronda5'
SlashCmdList["SETRONDA5"] = setRonda5
