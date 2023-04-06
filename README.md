# Fire Hydrant Script [STANDALONE]
Connect to hydrants to fight fires!

## Dependencies
- [HoseLS](https://github.com/LondonStudios/HoseLS)
- [bt-target](https://github.com/brentN5/bt-target) (Optional)

## BT-Target Code
Place the following code at the bottom of the client.lua file of bt-target
```
-- Fire Hydrants --
Citizen.CreateThread(function()
	local hydrants = {
        200846641,
		687935120,
		-366155374,
		-97646180
    }
    AddTargetModel(hydrants, {
        options = {
            {
                event = "esx_FireHydrant:Connect",
                icon = "fas fa-link",
                label = "Connect",
            }
        },
        job = {"all"},
        distance = 2.5
    })
end)
```
