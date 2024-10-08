Config = {}
Config.minEarn = 100
Config.maxEarn = 1500
Config.RegisterEarnings = math.random(Config.minEarn, Config.maxEarn)
Config.MinimumStoreRobberyPolice = 2
Config.resetTime = (60 * 1000) * 30
Config.tickInterval = 1000
Config.stickyNoteChance = 10 -- Percent chance to get the safe code from a cash register

Config.Registers = {
  --[4] = {vector3(), robbed = false, name = "", time = 0, safeKey = nil},
  [1] = {vector3(-3169.21, 1045.0, 20.93), robbed = false, name = "Suburban Outfitters [Chumash Plaza]", time = 0, safeKey = nil},
  [2] = {vector3(-3169.91, 1043.42, 20.93), robbed = false, name = "Suburban Outfitters [Chumash Plaza]", time = 0, safeKey = nil},
  [3] = {vector3(-3170.64, 1041.76, 20.93), robbed = false, name = "Suburban Outfitters [Chumash Plaza]", time = 0, safeKey = nil},
  [4] = {vector3(-3170.95, 1073.82, 20.95), robbed = false, name = "Ink Inc Tattoos [Chumash Plaza]", time = 0, safeKey = nil},
  [5] = {vector3(-3170.81, 1083.71, 20.96), robbed = false, name = "Ammunation [Chumash Plaza]", time = 0, safeKey = nil},
  [6] = {vector3(-3173.01, 1089.71, 20.84), robbed = false, name = "Ammunation [Chumash Plaza]", time = 0, safeKey = nil},
  [7] = {vector3(-3041.14, 583.87, 7.9), robbed = false, name = "24/7 Supermarket [Chumash South]", time = 0, safeKey = 1},
  [8] = {vector3(-3038.92, 584.5, 7.9), robbed = false, name = "24/7 Supermarket [Chumash South]", time = 0, safeKey = 1},
  [9] = {vector3(-2966.46, 390.89, 15.04), robbed = false, name = "Rob's Liquor [Chumash]", time = 0, safeKey = 2},
  [10] = {vector3(-3244.56, 1000.14, 12.83), robbed = false, name = "24/7 Supermarket [Chumash North]", time = 0, safeKey = 3},
  [11] = {vector3(-3242.24, 999.98, 12.83), robbed = false, name = "24/7 Supermarket [Chumash North]", time = 0, safeKey = 3},
  [12] = {vector3(-1818.9, 792.9, 138.08), robbed = false, name = "Pump N' Dump", time = 0, safeKey = 4},
  [13] = {vector3(-1820.17, 794.28, 138.08), robbed = false, name = "Pump N' Dump", time = 0, safeKey = 4},
  [14] = {vector3(-2539.73, 2313.99, 33.34), robbed = false, name = "Haus of Gas", time = 0, safeKey = 5},
  [15] = {vector3(-2539.57, 2311.66, 33.34), robbed = false, name = "Haus of Gas", time = 0, safeKey = 5},
  [16] = {vector3(-1118.45, 2694.37, 18.67), robbed = false, name = "Ammunation [Zancudo]", time = 0, safeKey = nil},
  [17] = {vector3(-1117.61, 2700.26, 18.67), robbed = false, name = "Ammunation [Zancudo]", time = 0, safeKey = nil},
  [18] = {vector3(549.42, 2669.06, 42.15), robbed = false, name = "24/7 Supermarket [Harmony]", time = 0, safeKey = 6},
  [19] = {vector3(549.05, 2671.39, 42.15), robbed = false, name = "24/7 Supermarket [Harmony]", time = 0, safeKey = 6},
  [20] = {vector3(613.63, 2761.02, 42.16), robbed = false, name = "Suburban Outfitters [Harmony]", time = 0, safeKey = nil},
  [21] = {vector3(613.51, 2762.75, 42.16), robbed = false, name = "Suburban Outfitters [Harmony]", time = 0, safeKey = nil},
  [22] = {vector3(613.38, 2764.55, 42.16), robbed = false, name = "Suburban Outfitters [Harmony]", time = 0, safeKey = nil},
  [23] = {vector3(1201.36, 2707.55, 38.29), robbed = false, name = "Dollar Tee", time = 0, safeKey = nil},
  [24] = {vector3(1201.36, 2710.71, 38.29), robbed = false, name = "Dollar Tee", time = 0, safeKey = nil},
  [25] = {vector3(2554.88, 381.39, 108.74), robbed = false, name = "24/7 Supermarket [Tataviam]", time = 0, safeKey = 9},
  [26] = {vector3(2557.21, 381.29, 108.74), robbed = false, name = "24/7 Supermarket [Tataviam]", time = 0, safeKey = 9},
  [27] = {vector3(1982.39, 3053.33, 47.22), robbed = false, name = "Yellow Jack Pub", time = 0, safeKey = nil},
  [28] = {vector3(2676.02, 3280.52, 55.24), robbed = false, name = "Gas N' Porn", time = 0, safeKey = 10},
  [29] = {vector3(2678.07, 3279.39, 55.24), robbed = false, name = "Gas N' Porn", time = 0, safeKey = 10},
  [30] = {vector3(1958.96, 3741.98, 32.34), robbed = false, name = "24/7 Supermarket [Sandy Shores]", time = 0, safeKey = 11},
  [31] = {vector3(1960.13, 3740.0, 32.34), robbed = false, name = "24/7 Supermarket [Sandy Shores]", time = 0, safeKey = 11},
  [32] = {vector3(1861.44, 3748.55, 33.15), robbed = false, name = "Alamo Body Art & Piercing", time = 0, safeKey = nil},
  [33] = {vector3(1930.83, 3727.52, 32.94), robbed = false, name = "O'Sheas Barbers Shop", time = 0, safeKey = nil},
  [34] = {vector3(1696.64, 4924.54, 42.18), robbed = false, name = "Mike's Hard Gas", time = 0, safeKey = 12},
  [35] = {vector3(1698.22, 4923.21, 42.06), robbed = false, name = "Mike's Hard Gas", time = 0, safeKey = 12},
  [36] = {vector3(1393.07, 3605.96, 31.11), robbed = false, name = "Liquor Ace", time = 0, safeKey = nil},
  [37] = {vector3(1693.57, 3761.6, 34.82), robbed = false, name = "Ammunation [Sandy Shores]", time = 0, safeKey = nil},
  [38] = {vector3(1693.31, 3755.66, 34.82), robbed = false, name = "Ammunation [Sandy Shores]", time = 0, safeKey = nil},
  [39] = {vector3(1691.87, 4817.82, 42.13), robbed = false, name = "Grapeseed Discount Threads", time = 0, safeKey = nil},
  [40] = {vector3(1695.0, 4818.23, 42.13), robbed = false, name = "Grapeseed Discount Threads", time = 0, safeKey = nil},
  [41] = {vector3(1728.86, 6417.26, 35.03), robbed = false, name = "Gas N' Go", time = 0, safeKey = 13},
  [42] = {vector3(1727.85, 6415.14, 35.03), robbed = false, name = "Gas N' Go", time = 0, safeKey = 13},
  [43] = {vector3(160.52, 6641.74, 31.6), robbed = false, name = "Don's Country Store", time = 0, safeKey = 14},
  [44] = {vector3(162.16, 6643.22, 31.6), robbed = false, name = "Don's Country Store", time = 0, safeKey = 14},
  [45] = {vector3(-0.43, 6511.2, 31.94), robbed = false, name = "Paleto Discount Threads", time = 0, safeKey = nil},
  [46] = {vector3(1.71, 6508.89, 31.94), robbed = false, name = "Paleto Discount Threads", time = 0, safeKey = nil},
  [47] = {vector3(-161.07, 6321.23, 31.5), robbed = false, name = "Del Vecchio Liquor", time = 0, safeKey = 15}, -- DEL VECCHIO LIQUOR
  [48] = {vector3(-278.11, 6231.05, 31.8), robbed = false, name = "Herr Kutz Barber", time = 0, safeKey = nil},
  [49] = {vector3(-290.99, 6199.91, 31.61), robbed = false, name = "Alamo Body Art & Piercing", time = 0, safeKey = nil},
  [50] = {vector3(-330.81, 6079.62, 31.57), robbed = false, name = "Ammunation [Paleto]", time = 0, safeKey = nil},
  [51] = {vector3(-330.29, 6085.55, 31.57), robbed = false, name = "Ammunation [Paleto]", time = 0, safeKey = nil},
  [52] = {vector3(2571.15, 296.96, 108.85), robbed = false, name = "Ammunation [Tataviam]", time = 0, safeKey = nil},
  [53] = {vector3(2566.59, 293.13, 108.85), robbed = false, name = "Ammunation [Tataviam]", time = 0, safeKey = nil},
  [54] = {vector3(1165.9, 2710.81, 38.15), robbed = false, name = "Rob's Liquor [Harmony]", time = 0, safeKey = 16},
  [55] = {vector3(4.81, 6511.24, 31.94), robbed = false, name = "Paleto Discount Threads", time = 0, safeKey = nil},
  [56] = {vector3(-1101.41, 2711.75, 19.7), robbed = false, name = "Blanche's Discount Threads", time = 0, safeKey = nil},
  [57] = {vector3(-1095.75, 2712.06, 19.11), robbed = false, name = "Blanche's Discount Threads", time = 0, safeKey = nil},
  [58] = {vector3(-1097.78, 2714.42, 19.11), robbed = false, name = "Blanche's Discount Threads", time = 0, safeKey = nil},
  [59] = {vector3(1197.49, 2711.09, 38.29), robbed = false, name = "Dollar Tee", time = 0, safeKey = nil},
  [60] = {vector3(1694.87, 4822.11, 42.13), robbed = false, name = "Grapeseed Discount Threads", time = 0, safeKey = nil},
}

Config.Safes = {
  [1] = {vector3(-3047.88, 585.61, 7.9), type = "keypad", name = "24/7 Supermarket [Chumash South]", robbed = false},
  [2] = {vector3(-2959.64, 387.08, 14.04), type = "padlock", name = "Rob's Liquor [Chumash]", robbed = false},
  [3] = {vector3(-3250.02, 1004.43, 12.83), type = "keypad", name = "24/7 Supermarket [Chumash North]", robbed = false},
  [4] = {vector3(-1829.27, 798.76, 138.19), type = "keypad", name = "Pump N' Dump", robbed = false},
  [5] = {vector3(-2542.48, 2305.83, 33.22), type = "keypad", name = "Haus of Gas", robbed = false},
  [6] = {vector3(546.41, 2662.8, 42.15), type = "keypad", name = "24/7 Supermarket [Harmony]", robbed = false},
  [9] = {vector3(2549.27, 384.84, 108.62), type = "keypad", name = "24/7 Supermarket [Tataviam]", robbed = false},
  [10] = {vector3(2672.69, 3286.63, 55.24), type = "keypad", name = "Gas N' Porn", robbed = false},
  [11] = {vector3(1959.26, 3748.92, 32.34), type = "keypad", name = "24/7 Supermarket [Sandy Shores]", robbed = false},
  [12] = {vector3(1707.93, 4920.47, 42.06), type = "keypad", name = "Mike's Hard Gas", robbed = false}, -- 116
  [13] = {vector3(1734.78, 6420.84, 35.03), type = "keypad", name = "Gas N' Go", robbed = false},
  [14] = {vector3(168.95, 6644.74, 31.70), type = "keypad", name = "Don's Country Store", robbed = false},
  [15] = {vector3(-168.40, 6318.80, 30.58), type = "padlock", name = "Del Vecchio Liquor", robbed = false}, -- DEL VECCHIO LIQUOR
  [16] = {vector3(1169.31, 2717.79, 37.15), type = "padlock", name = "Rob's Liquor [Harmony]", robbed = false}
}