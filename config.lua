Config                            = {}
Config.DrawDistance               = 100.0

Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = false
Config.EnableVaultManagement      = true
Config.EnableMoneyWash            = true
Config.MaxInService               = -1
Config.Locale                     = 'fr'

Config.AuthorizedVehicles = {
	{ name = 'phantom', trailer = 'trailers',  label = 'Véhicule de Fonction - Phantom' },
}

Config.Blips = {

	Blip = {
      Pos     = { x = 1200.63, y = -1276.875, z = 34.38},
      Sprite  = 237,
      Display = 4,
      Scale   = 1.2,
      Colour  = 4,
    },

}

Config.Zones = {

    Cloakrooms = {
        Pos   = { x = 1200.63, y = -1276.875, z = 34.38},
        Size  = { x = 1.5, y = 1.5, z = 1.0 },
        Color = { r = 0, g = 100, b = 0 },
        Type  = 27,
    },

    Vaults = {
        Pos   = { x = 1192.1, y = -1268.86, z = 34.3213},
        Size  = { x = 1.3, y = 1.3, z = 1.0 },
        Color = { r = 0, g = 100, b = 0 },
        Type  = 27,
    },
	
    Harvest = {
		Pos	  = { x = -534.323669433594, y = 5373.794921875, z = 69.503059387207 },
        Size  = { x = 1.5, y = 1.5, z = 1.0 },
        Color = { r = 0, g = 100, b = 0 },
        Type  = 27,
		Sprite  = 237,
        Display = 4,
        Scale   = 1.2,
        Colour  = 4,
    },
	
    Craft = {
		Pos	  = { x = -552.214660644531, y = 5326.90966796875, z = 72.5996017456055 },
        Size  = { x = 1.5, y = 1.5, z = 1.0 },
        Color = { r = 0, g = 100, b = 0 },
        Type  = 27,
    },
	
    Craft2 = {
		Pos	  = { x = -501.386596679688, y = 5280.53076171875, z = 79.6187744140625 },
        Size  = { x = 1.5, y = 1.5, z = 1.0 },
        Color = { r = 0, g = 100, b = 0 },
        Type  = 27,
    },

    Delivery = {
		Pos	  = { x = 1201.3558349609, y = -1327.5159912109, z = 34.226093292236 },
        Size  = { x = 1.5, y = 1.5, z = 1.0 },
        Color = { r = 0, g = 100, b = 0 },
        Type  = 27,
    },

    Vehicles = {
        Pos          = { x = 1191.9681396484, y = -1261.7775878906, z =  34.35},
        SpawnPoint   = { x = 1194.6257324219, y = -1286.955078125, z =  34.121524810791},
        Size         = { x = 1.8, y = 1.8, z = 1.0 },
        Color        = { r = 255, g = 255, b = 0 },
        Type         = 23,
        Heading      = 285.1,
    },

    VehicleDeleters = {
        Pos   = { x = 1216.8983154297, y = -1229.2396240234, z =  34.403507232666},
        Size  = { x = 3.0, y = 3.0, z = 0.2 },
        Color = { r = 255, g = 255, b = 0 },
        Type  = 1,
    },
	
    BossActions = {
        Pos   = { x = 1218.81, y = -1267.09, z = 35.4235},
        Size  = { x = 1.5, y = 1.5, z = 1.0 },
        Color = { r = 0, g = 100, b = 0 },
        Type  = 27,
    },

}

Config.Uniforms = {
  work_outfit = {
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 42,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 11,
        ['pants_1'] = 47,   ['pants_2'] = 1,
        ['shoes_1'] = 25,   ['shoes_2'] = 0,
        ['chain_1'] = 0,  ['chain_2'] = 0
    },
    female = {
        ['tshirt_1'] = 3,   ['tshirt_2'] = 0,
        ['torso_1'] = 8,    ['torso_2'] = 2,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 5,
        ['pants_1'] = 44,   ['pants_2'] = 4,
        ['shoes_1'] = 0,    ['shoes_2'] = 0,
        ['chain_1'] = 0,    ['chain_2'] = 2
    }
  }
}