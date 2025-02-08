fx_version 'cerulean'
games { 'gta5' }
lua54 'yes'

author 'xliel development'
description 'A simple killfeed script for FiveM'
version '1.0.1'

shared_scripts { 'shared/config.lua' }
server_scripts { 'server/*.lua' }
client_scripts { 'client/*.lua' }

ui_page 'web/build/index.html'
files { 'web/build/index.html', 'web/build/**/*' }
escrow_ignore {
    'shared/*.lua',
    'server/*.lua',
    'client/*.lua',
}
