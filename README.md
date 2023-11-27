# Modified Versoin of [ps-methrun](https://github.com/trclassic92/ps-methrun)

# Additions by me
* Need an item to start
* Moved location in city
* Changed peds to Vagos and Ballas
* Changed props
* Added cars
* Added a different ped to end the mission
* Changed ped logic
* Added ps-dispatch alert

# Add to qb-core
Items to add to qb-core>shared>items.lua
```
["securitycase"] =        {["name"] = "securitycase",       ["label"] = "Security Case",        ["weight"] = 1000, ["type"] = "item", ["image"] = "securitycase.png", ["unique"] = true, ["useable"] = false, ['shouldClose'] = false, ["combinable"] = nil, ["description"] = "Security case with a timer lock"},
["meth_cured"] =          {["name"] = "meth_cured",         ["label"] = "Ice",                  ["weight"] = 100, ["type"] = "item", ["image"] = "meth_cured.png", ["unique"] = false, ["useable"] = false, ['shouldClose'] = false, ["combinable"] = nil, ["description"] = "Crystal meth"},
["casekey"] =             {["name"] = "casekey",            ["label"] = "Case Key",             ["weight"] = 0, ["type"] = "item", ["image"] = "key1.png", ["unique"] = true, ["useable"] = false, ['shouldClose'] = false, ["combinable"] = nil, ["description"] = "Key for a case"},

```

# Dependencies
* Memory Game - https://github.com/NathanERP/memorygame_2
* qb-target - https://github.com/BerkieBb/qb-target
