Config = {}

Config.MinimumMethJobPolice = 0
Config.AlertChance = 90
Config.Cooldown = 360 --- Cooldown until next allowed meth run

Config.NeedCash = false
Config.RunCost = 6000
Config.NeedItem = "usb_green"

Config.Payout = math.random(15000, 22000) -- How much you get paid
Config.Item = "meth" -- The item you receive from the job
Config.MethChance = 350 -- Percentage chance to get meth
Config.MethAmount = math.random(5, 10) -- Amount of meth you recieve

Config.SpecialRewardChance = 300 -- Percentage of getting rare item on job. Multiplied by 100. 0.1% = 1, 1% = 10, 20% = 200, 50% = 500, etc. Default 0.1%.
Config.SpecialItem = "usb_green" -- Put a rare item here which will have 0.1% chance of being given on the run.

Config.StartModel = "a_m_y_mexthug_01" -- Starting Ped
Config.StartCoords = vector4(-944.58, 323.74, 70.35, 359.05)

Config.FinishModel = "a_f_y_business_01" -- Starting Ped
Config.FinishCoords = vector4(-2206.095, 228.346, 173.602, 292.33)

Config.Itemtime = 3 * 1000 -- 5 minutes (time for the case to open after you collect it)
Config.Carspawn1 = vector3(94.12, -2190.89, 6.0) -- Spawn location for vehicle (it serves not purpose just there...)
Config.Carspawn2 = vector3(104.783, -2195.59, 6.038)

Config['methguards'] = {
    ['npcguards'] = {
        { coords = vector3(95.37, -2188.82, 5.96), heading = 244.45, model = 'g_m_y_mexgoon_01'},
        { coords = vector3(94.2, -2192.24, 6.02), heading = 228.7, model = 'g_m_y_mexgoon_02'},
        { coords = vector3(96.23, -2197.66, 6.04), heading = 320.58, model = 'g_m_y_mexgoon_03'},
        { coords = vector3(97.15, -2200.37, 6.18), heading = 321.18, model = 'g_m_y_mexgoon_01'},
        { coords = vector3(95.86, -2180.01, 5.95), heading = 174.34, model = 'g_m_y_mexgoon_02'},
        { coords = vector3(103.62, -2180.27, 5.95), heading = 145.75, model = 'g_m_y_ballaeast_01'},
        { coords = vector3(111.53, -2203.49, 6.03), heading = 359.15, model = 'g_m_y_ballaorig_01'},
        { coords = vector3(97.14, -2216.26, 6.49), heading = 86.53, model = 'g_m_y_ballasout_01'},
        { coords = vector3(86.3, -2216.46, 6.09), heading = 323.79, model = 'g_m_y_ballaeast_01'},
        { coords = vector3(105.4, -2203.81, 6.04), heading = 1.6, model = 'g_m_y_ballaorig_01'},
    },
}