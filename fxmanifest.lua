fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'AymanScripts'
description 'Vehicle Unlock Script with Welding Torch for QBCore and Ox Inventory'
version '1.0.0'

shared_scripts { 
    '@ox_lib/init.lua',
    '@qb-core/shared/locale.lua',
    'locales/nl.lua',
}

client_scripts {
    'client.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua', 
    'server.lua',
}

dependencies {
    'qb-core',
    'ox_inventory',
    'ox_lib',
    'oxmysql'
}