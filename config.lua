Config = {}

Config.MinimumMethJobPolice = 0 -- Police Needed
Config.AlertChance = 100 -- Dispatch Chance
Config.Cooldown = 360 --- Cooldown

Config.NeedCash = false -- Cash to start?
Config.RunCost = 6000 -- Amount of cash
Config.NeedItem = "phone" -- Item to start
Config.RemoveItem = false --  Remove Item

Config.Payout = math.random(15000, 22000) -- How much you get paid
Config.Item = "meth" -- The item you receive from the job
Config.ItemChance = 100 -- Percentage chance to get items
Config.ItemAmount = math.random(20, 40) -- Amount of items you recieve

Config.SpecialItemChance = 100 -- Percentage of getting rare item on job.
Config.SpecialItem = "coke" -- Percentage chance to get item
Config.SpecialItemAmount = 1

Config.StartModel = "a_m_y_mexthug_01" -- Starting Ped
Config.StartCoords = vector4(-944.58, 323.74, 70.35, 359.05)

Config.FinishModel = "a_f_y_business_01" -- Finish Ped
Config.FinishCoords = vector4(-2206.095, 228.346, 173.602, 292.33)

Config.Carspawn1 = vector3(94.12, -2190.89, 6.0) -- Just props
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
