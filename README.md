# Legacy Concrete Sounds (LCS)

**Legacy Concrete Sounds (LCS) is a client-sided script tailored towards simplicity that is meant to imitate concrete 
pavement sounds in real life when a vehicle is moving or when a tire is moving
along a concrete paved surface.**

*An advanced version of concrete sounds will be developed some time in the future.*

**(ℹ️ MAIN) CODEBERG REPO:** https://codeberg.org/project-roadwork/legacy-concrete-sounds

**(❌ MIRRORED/BACKUP) GITHUB REPO:** https://github.com/project-roadwork/legacy-concrete-sounds

***Please use the main repository especially with contributions!*** *Additionally, please **DO NOT** make any changes in the mirrored repository as it cannot be pulled into the main repo.*

---

### A. PREREQUISITES

	
1. This script is meant to be used in an A-Chassis vehicle
under the `Plugins` folder.
	 
2. In order to make this script work for your needs, **you MUST add a model
named `Sensor` under `car.Body` and a part named `Sensor1` under the model
with collisions off. Ensure that you have `Sensor1.CanQuery` and
`Sensor1.CanTouch` enabled in properties.** 

3. **The sensor must be placed in the
front of the vehicle adjacent to the lower bumper with half ot the part 
touching the ground.**
	 
4. **You must have at least THREE concrete sounds named "Concrete1",
"Concrete2", and "Concrete3" which is parented under the DriveSeat.**

![image](https://codeberg.org/project-roadwork/legacy-concrete-sounds/raw/branch/main/media/LCS-explorer.jpg)

5. Should you continue to be unsuccessful with the script prerequisites, *you 
may utilize the sample model in the accompanying repository links under 
/sample if it is provided.*

### B. CUSTOMIZATION OPPORTUNITIES
1. *You may assign sounds to different colors or even materials. You may also
expand on how many concrete sounds this script can handle by modifying the
respective sounds and volume tables.*    

2. *You may expand the number of sounds this script can handle by modifiying the respective `sound` and `volume` tables.*

### C. OTHER NOTES
1. **This script DOES NOT provide server-sided replication right now,** so ONLY the local
player can hear the sounds. Should you wish to add server-side replication,
*assistance is provided in the `"C. SERVER REPLICATION"` section  in the script near line 180.*


### D. LICENSE
This software is licensed under the Mozilla Public License 2.0, which is an open source license. 

#### License Comparison (not legal advice)

| Feature / License        | Expact (aka "MIT")    | Apache 2.0 | MPL 2.0       | GPL / AGPL v3               |
| ------------------------ | ------ | ---------- | ------------- | ------------------------ |
| **Permissive**           | ✅      | ✅          | ℹ️ Partial    | ❌                        |
| **Patent Clause**         | ❌      | ✅          | ✅             | ✅                        |
| **Proprietary Use OK**   | ✅      | ✅          | ✅¹           | ❌  (Must release whole source)                       |
| **Roblox Asset Usage**   | ✅      | ✅          | ℹ️ Depends; must share any changes    | ❌ May violate terms      |

* ¹ Proprietary use in MPL is permitted (allowed) as long as the MPL-covered files remain open souce.

### E. CONTRIBUTIONS
All contributions are welcome!


	 
