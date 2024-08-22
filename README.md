# Welding-Torch
With this script you can weld open a car.

This script is based on qb-vehiclekeys, You can weld open NPC and Player cars.

## Installation:

### Items in ox inv:
    ["welding_torch"] = {
		    label = "Welding Torch",
		    weight = 500,
		    durability = 0,1,
		    client = {
			    image = "welding_torch.png",
		    }
	    },
    
    ["welding_gas"] = {
	  	  label = "Weld gas",
		    weight = 3000,
		    durability = 0,1,
	  	  description = "A gas bottle so you can weld with your welding torch",
	  	  client = {
		  	  image = "welding_gas.png",
		    }
	    },
### languages:
    Change in the fxmanifest wich language you wanna use. You can use Dutch or English or add you own language

### Ensuring:
    Add this 'ensure Welding-Torch' to your server.cfg after ox lib, inventory and target also qbcore/qbox
