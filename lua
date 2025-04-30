#!/bin/sh

LUAROCKS_SYSCONFDIR='/etc/luarocks' exec '/usr/bin/luajit' -e 'package.path="/home/sebastian/dotfiles/lua_modules/share/lua/5.1/?.lua;/home/sebastian/dotfiles/lua_modules/share/lua/5.1/?/init.lua;/home/sebastian/.luarocks/share/lua/5.1/?.lua;/home/sebastian/.luarocks/share/lua/5.1/?/init.lua;/usr/share/lua/5.1/?.lua;/usr/share/lua/5.1/?/init.lua;"..package.path;package.cpath="/home/sebastian/dotfiles/lua_modules/lib64/lua/5.1/?.so;/home/sebastian/.luarocks/lib64/lua/5.1/?.so;/usr/lib64/lua/5.1/?.so;"..package.cpath' $([ "$*" ] || echo -i) "$@"
