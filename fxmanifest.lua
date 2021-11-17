fx_version 'cerulean'
game 'gta5'
description 'ESX Fire Hydrant - Use hydrants to fight fires'
author 'Abel Gaming'
version '1.2'

dependencies {
    "dubCase-HoseFix" -- https://github.com/Abel-Gaming/dubCase-HoseFix (Must use this fork!)
}

server_scripts {
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'config.lua',
	'client/main.lua'
}
