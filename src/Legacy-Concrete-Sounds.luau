--!native

local ProjectRoadworkHeader = [[--[LEGACY-CONCRETE-SOUNDS]------------------------------------------
  FILE:             Legacy-Concrete-Sounds.luau
  DESCRIPTION:      A simple concrete sound script for vehicles.
  USAGE:            A-Chassis Tune/Plugins/Legacy-Concrete-Sounds.luau
  DEPENDENCIES:     N/A
  LANGUAGE:         Luau
  
  GROUP:            Project Roadwork
  VERSION:          0.2.0-alpha
  CREATED:          2025-10-29 11:31 PM CDT  
  LAST UPDATED:     2025-10-30 1:31 AM CDT   
  LICENSE:          MPL-2.0

  CODEBERG REPO:    https://codeberg.org/project-roadwork/legacy-concrete-sounds (!!!MAIN!!!)
  GITHUB REPO:      https://github.com/project-roadwork/legacy-concrete-sounds (MIRRORED/BACKUP)
  
  NOTES: Use the accompanying repository links for documentation, help, or
  to propose a suggestion or comment. The NOTICE file can be found in the respository
  links.
  
  LICENSE HEADER:
	This Source Code Form is subject to the terms of the Mozilla Public
	License, v. 2.0. If a copy of the MPL was not distributed with this
	file, You can obtain one at https://mozilla.org/MPL/2.0/.
  
  DECOMPILING NOTICE: If you are seeing this header since you somehow decompiled this
  script, great job! You may be happy for what you did; however, you may soon figure
  out that this script is actually open source. By decompiling this script,
  you miss out on clarified variables, comments, and steps on how to actually use
  this software. Probably it is better to get this script from source right?
  
  AUTHORS:
   Illinois_Roadbuff (2653606809) - October 29th, 2025 - Created the file
-----------------------------------------------------------------------------------]]

--[[ TABLE OF CONTENTS:
   A. ADDITIONAL INFORMATION AND NOTICE
   B. LOOP BEHAVIOR
   C. SERVER REPLICATION
   
   Additional comments are provided in several lines.
]]

--[[A. ADDITIONAL INFORMATION AND NOTICE:

	MPL NOTICE:
     Roadwork: Legacy-Concrete-Sounds
     Initial developer: Illinois_Roadbuff (2653606809)
     Copyright 2025 Illinois_Roadbuff and the Project Roadwork Contributors

     This Source Code Form is subject to the terms of the Mozilla Public
     License, v. 2.0. If a copy of the MPL was not distributed with this
     file, You can obtain one at https://mozilla.org/MPL/2.0/.
   
   	 ORIGINAL SOURCE REPOSITORIES:
 	  CODEBERG REPO:    https://codeberg.org/project-roadwork/legacy-concrete-sounds (!!!MAIN!!!)
 	  GITHUB REPO:      https://github.com/project-roadwork/legacy-concrete-sounds (MIRRORED/BACKUP)
   
   ADDITIONAL INFORMATION:
   
	 i. This is a simplified client-sided script that is meant to imitate concrete 
	    pavement sounds in real life when a vehicle is moving or when a tire is moving
	    along a concrete paved surface.
	
	 ii. This script DOES NOT provide server-sided replication, so ONLY the local
	     player can hear the sounds. Should you wish to add server-side replication,
	     assistance is provided in the "C. SERVER REPLICATION" section near line 180.
	
	 iii. This script is client-sided, and is meant to be used in an A-Chassis vehicle
	      under the "Plugins" folder.
	 
	  iv. In order to make this script work for your needs, you MUST add a model
	      named "Sensor" under "car.Body" and a part named "Sensor1" under the model
	      with collisions off. Ensure that you have Sensor1.CanQuery and
	      Sensor1.CanTouch enabled in properties. The sensor must be placed in the
	      front of the vehicle adjacent to the lower bumper with half ot the part 
	      touching the ground.
	 
	      Additionally, you must have at least THREE concrete sounds named "Concrete1",
	      "Concrete2", and "Concrete3" which is parented under the DriveSeat.
	  
	  v. Should you continue to be unsuccessful with the script prerequisites, you 
	     may utilize the sample model in the accompanying repository links under 
	     /sample if it is provided.
	    
	 vi. You may assign sounds to different colors or even materials. You may also
	     expand on how many concrete sounds this script can handle by modifying the
	     respective sounds and volume tables.
	 
	 vii. This original source script is licensed under the Mozilla Public License
	     v2.0, which is an open source license. Personally, I find it to be the middle
	     ground between MIT/Expact + Apache-2.0, and GPL licenses. GPL and AGPL licences
	     require the whole source to be open-sourced if one intends to use this script
	     per se, so I am not willing to go towards that extent. 
	 
	     This is not legal advice, but ensure that you open source any changes you
	     make to this and let other players know where to get the original source code. 
	     As per MPL-2.0, you must provide this notice file in the source code distrubution.
	 
]]
task.wait(1) -- delay

-- VARIABLES
local version = "0.2.0-alpha"
local car = script.Parent.Car.Value
local seat = car:WaitForChild("DriveSeat")
local sensorModel = car.Body:WaitForChild("Sensor")
local sensor = sensorModel:FindFirstChild("Sensor1") -- assumed front of vehicle

if not sensorModel then -- safety net
	warn(`:: Legacy Concrete Sounds {version} :: "sensorModel" does not exist; aborting script. Is the model "Sensor" named correctly and parented under car.Body?`)
	return
elseif not sensor then
	warn(`:: Legacy Concrete Sounds {version} :: The part "Sensor1" does not exist under the model "Sensor" in car.Body; aborting script. Is the part "Sensor1" named correctly and is parented under car.Body.Sensor?`)
	return
end

task.wait(2) -- see comment below

local sounds = { -- checks if the sound exists in the drive seat within 1 + 2 seconds. FYI it does not check each sound concurrently and goes in order, so it cannot take too much time!!!!!
	Concrete1 = seat:WaitForChild("Concrete1", 1) or false, -- must have "or false" or else safety net is rendered useless since just "nil" per se will not work 
	Concrete2  = seat:WaitForChild("Concrete2", 1) or false,
	Concrete3 = seat:WaitForChild("Concrete3", 1) or false,
}

for name, sound in sounds do -- safety net warning if sounds don't exist
	if not sound then
		warn(`:: Legacy Concrete Sounds {version} :: Failed to find sound under DriveSeat in 4+ seconds: {name}; aborting script. Is the sound name correct and parented under DriveSeat?`)
		return
	else
		sound.Looped = true -- loops and plays sounds if not already
		sound:Play()
	end
end

local volumes = { -- volume table
	Concrete1 = 0,
	Concrete2 = 0,
	Concrete3 = 0,
}

--[[B. LOOP BEHAVIOR:
	This loop continusly:
	   1. Set default sound volumes to 0
       2. Checks parts touching the sensor
       3. Checks if the material is concrete and color
       4. Adjusts volumes by color and speed by velocity
    RECOMMENDED INTERVAL: 0.15 SECONDS
]]

-- FYI you can switch this loop with a sensor.Touched event, but it would be a problem if the part is very long
local function Loop()
	while true do
		-- set default sound volume levels to 0
		for k in volumes do
			volumes[k] = 0
		end

		-- get all touching parts
		for _, part in sensor:GetTouchingParts() do
			local mat = part.Material -- get part material
			local color = part.Color -- get part color

			if mat == Enum.Material.Concrete then -- checks if part is concrete
				if color == Color3.fromRGB(217, 169, 135) then -- assign sound for part color

					volumes.Concrete2 = 5.5
					volumes.Concrete3 = 1.5 -- you can have multiple sounds playing at the same time
				else
					volumes.Concrete1 = 0.7 -- default concrete sound if no color assignment
				end
			end
		end

		-- get speed and pitch
		local speed = seat.AssemblyLinearVelocity.Magnitude
		local pitchBase = (speed / 100) + 0.02 -- adjust if needed

	--[[C. SERVER REPLICATION:
		If you want the sounds to be sent to the server so that 
	all of the players can hear it, you may send the sounds table to the
	server via remote event, then let the server do the pitch handling via 
	seat.AssemblyLinearVelocity.Magnitude. Then, you move the code below
	to the server script. 
	]]

		-- set pitch values
		sounds.Concrete1.PlaybackSpeed = pitchBase 
		sounds.Concrete2.PlaybackSpeed = pitchBase
		sounds.Concrete3.PlaybackSpeed = pitchBase

		-- set volume values
		sounds.Concrete1.Volume = volumes.Concrete1
		sounds.Concrete2.Volume = volumes.Concrete2
		sounds.Concrete3.Volume = volumes.Concrete3


		task.wait(0.1) -- adjust if needed
	end
end

task.defer(Loop)

print(`:: Legacy Concrete Sounds {version} :: Loaded successfully!`)