fx_version 'cerulean'
games {'gta5'}
lua54 'yes'

author 'maji#1118'
version '1.0.0'

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    'client/main.lua',
}

server_scripts {
    'server/main.lua',
}

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua',
}