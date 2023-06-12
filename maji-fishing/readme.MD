# Fishing Script made with OX_LIB 

## Add this to your qb-smallresources/server/logs.lua
    local Webhooks = {
        --Your other logs
        ['fishing'] = '',
    }

## Place the images inside your inventory folder

## Place the items inside your qb-core/shared/items.lua

    ["walleye"] 			= {["name"] = "walleye",  	     		    ["label"] = "Walleye",	 		    ["weight"] = 1, 		["type"] = "item", 		["image"] = "walleye.png", 				["unique"] = false, 	    ["useable"] = false, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = ""},
    ["channelcatfish"] 		= {["name"] = "channelcatfish",  	        ["label"] = "Channel Catfish",	 	["weight"] = 1, 		["type"] = "item", 		["image"] = "channelcatfish.png", 				["unique"] = false, 	    ["useable"] = false, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = ""},
    ["bluegill"] 			= {["name"] = "bluegill",  	     		    ["label"] = "Bluegill",	 		    ["weight"] = 1, 		["type"] = "item", 		["image"] = "bluegill.png", 				["unique"] = false, 	    ["useable"] = false, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = ""},
    ["bass"] 				= {["name"] = "bass",  	     		        ["label"] = "Bass",	 		        ["weight"] = 1, 		["type"] = "item", 		["image"] = "bass.png", 				["unique"] = false, 	    ["useable"] = false, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = ""},
    ["goldfish"] 			= {["name"] = "goldfish",  	     		    ["label"] = "Goldfish",	 		    ["weight"] = 1, 		["type"] = "item", 		["image"] = "goldfish.png", 				["unique"] = false, 	    ["useable"] = false, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = ""},
    ["trout"] 				= {["name"] = "trout",  	     		    ["label"] = "Trout",	 		    ["weight"] = 1, 		["type"] = "item", 		["image"] = "trout.png", 				["unique"] = false, 	    ["useable"] = false, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = ""},
    ["catfish"] 			= {["name"] = "catfish",  	     		    ["label"] = "Catfish",	 		    ["weight"] = 1, 		["type"] = "item", 		["image"] = "catfish.png", 				["unique"] = false, 	    ["useable"] = false, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = ""},

### This is not a drag and drop resource. You will need to configure it to your liking. 

# if you would like to support me, here is my ko-fi link:

# https://ko-fi.com/majidev