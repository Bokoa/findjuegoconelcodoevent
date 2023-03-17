--FUNCIONES--
function ComputeDistance(instance1, y1, x1, instance2, y2, x2)
  return instance1 == instance2 and ((x2 - x1) ^ 2 + (y2 - y1) ^ 2) ^ 0.5
end

--COMANDO GETCURRENTLOC--
local function getCurrentLoc()
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
SLASH_GETCURRENTLOC1 = '/getcurrentloc'
SlashCmdList["GETCURRENTLOC"] = getCurrentLoc


local margen1 = 0.75
local margen2 = 0.40
local margen3 = 0.25
local margen4 = 0.10
local margen5 = 0.05

--COMANDO FINDJUEGOCONELCODO1--
local function findJuegoconelcodo1()
	local targetLocX = 0.5084
	local targetLocY = 0.8818
	local targetLocInstance = 85 --ORGRIMMAR
	mapID = C_Map.GetBestMapForUnit("player")
	position = C_Map.GetPlayerMapPosition(mapID, "player");
	posX, posY = position:GetXY()
	distance = ComputeDistance(mapID, posY, posX, targetLocInstance, targetLocY, targetLocX)
	if( distance == false ) then
		print('Parece que todavía no estás en la zona correcta')
	else
		local playSound = false
		if( distance <= margen1 and distance > margen2 ) then
			print('Sientes una energía poderosa a lo lejos')
		else
			if( distance <= margen2 and distance > margen3) then
				print('Todavía estás lejos del objetivo')
				playSound = 'vs_chant_evoc_lf'
			else
				if( distance <= margen3 and distance > margen4 ) then
					print('Te estás acercando, vigila tu espalda')
					playSound = 'vs_chant_ench_hf_1'
				else
					if( distance <= margen4 and distance > margen5 ) then
						print('La energía que emana de tu objetivo es tan fuerte que estás a punto de desmayarte')
						playSound = 'vs_chant_necr_hf'
					else
						print('Felicidades! Has encontrado el objetivo de la primera ronda. Reclama tu premio')
					end
				end
			end
		end

		if( playSound ~= false ) then
			PlaySoundFile("Interface\\Addons\\FindJuegoconelcodoEvent\\sounds\\"..playSound..".ogg", "Master")
		end
	end
end

SLASH_FINDJUEGOCONELCODO11 = '/findjuegoconelcodo1'
SlashCmdList["FINDJUEGOCONELCODO1"] = findJuegoconelcodo1


--LOOP--
local locations = {
	["1"] = {0.5084, 0.8818, 85}, --ORGRIMMAR
	["2"] = {0.5084, 0.8818, 85}
}

fje_UpdateInterval = 10.0;
function fje_OnUpdate(self, elapsed)
  self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed; 	

  while (self.TimeSinceLastUpdate > fje_UpdateInterval) do

  	--BUG AQUI??? COMPROBAR ESTE BUCLE
  	for k, v in pairs(locations) do
			print(k)
			print(v)
		end

  	local targetLocX = 0.5084
		local targetLocY = 0.8818
		local targetLocInstance = 85 --ORGRIMMAR
		mapID = C_Map.GetBestMapForUnit("player")
		position = C_Map.GetPlayerMapPosition(mapID, "player");
		posX, posY = position:GetXY()
		distance = ComputeDistance(mapID, posY, posX, targetLocInstance, targetLocY, targetLocX)
		if( distance == false ) then
			print('Parece que todavía no estás en la zona correcta')
		else
			local playSound = false
			if( distance <= margen1 and distance > margen2 ) then
				print('Sientes una energía poderosa a lo lejos')
			else
				if( distance <= margen2 and distance > margen3) then
					print('Todavía estás lejos del objetivo')
					playSound = 'vs_chant_evoc_lf'
				else
					if( distance <= margen3 and distance > margen4 ) then
						print('Te estás acercando, vigila tu espalda')
						playSound = 'vs_chant_ench_hf_1'
					else
						if( distance <= margen4 and distance > margen5 ) then
							print('La energía que emana de tu objetivo es tan fuerte que estás a punto de desmayarte')
							playSound = 'vs_chant_necr_hf'
						else
							print('Felicidades! Has encontrado el objetivo de la primera ronda. Reclama tu premio')
						end
					end
				end
			end

			if( playSound ~= false ) then
				PlaySoundFile("Interface\\Addons\\FindJuegoconelcodoEvent\\sounds\\"..playSound..".ogg", "Master")
			end
		end
		self.TimeSinceLastUpdate = self.TimeSinceLastUpdate - fje_UpdateInterval;
  end
end