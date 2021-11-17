Config = {}

-- Hydrant Settings
Config.HydrantModels = {
    200846641,
	687935120,
    -366155374,
    -97646180
}

-- Text/Notification Settings
Config.Use3DText = false

-- Distance Settings
Config.ConnectionDistance = 2.0 -- Only used if not using bt-target (how close you have to be)
Config.MaxDistance = 15.0 -- Max distance you can get from the hydrant before auto-disconnect
Config.DistanceWarning = true -- Will alert the player when they are 2.0 away from auto disconnect
Config.DistanceWarningValue = 2.0 -- How far away from the max distance you want the player to be alerted

-- Debug will simply print messages in both the client log (F8) and into the server log for most actions
Config.EnableDebug = true