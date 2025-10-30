# Legacy Concrete Sounds
---

## A. INFORMATION + PREREQUISITES

1. This is a simplified client-sided script that is meant to imitate concrete 
pavement sounds in real life when a vehicle is moving or when a tire is moving
along a concrete paved surface.
	
2. **This script DOES NOT provide server-sided replication,** so ONLY the local
player can hear the sounds. Should you wish to add server-side replication,
assistance is provided in the "C. SERVER REPLICATION" section near line 180.
	
3. This script is client-sided, and is meant to be used in an A-Chassis vehicle
under the "Plugins" folder.
	 
4. In order to make this script work for your needs, **you MUST add a model
named "Sensor" under "car.Body" and a part named "Sensor1" under the model
with collisions off. Ensure that you have Sensor1.CanQuery and
Sensor1.CanTouch enabled in properties. The sensor must be placed in the
front of the vehicle adjacent to the lower bumper with half ot the part 
touching the ground.**
	 
5. Additionally, **you must have at least THREE concrete sounds named "Concrete1",
"Concrete2", and "Concrete3" which is parented under the DriveSeat.**
	  
6. Should you continue to be unsuccessful with the script prerequisites, *you 
may utilize the sample model in the accompanying repository links under 
/sample if it is provided.*
	    
7. *You may assign sounds to different colors or even materials. You may also
expand on how many concrete sounds this script can handle by modifying the
respective sounds and volume tables.*

## B. LICENSE
This software is licensed under the Mozilla Public License 2.0, which is an open source license.
	 
