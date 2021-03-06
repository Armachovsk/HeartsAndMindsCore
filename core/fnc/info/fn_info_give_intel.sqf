
/* ----------------------------------------------------------------------------
Function: BTC_fnc_info_give_intel

Description:
    Give intel to the player.

Parameters:
    _asker - Player. [Object]

Returns:
    _intelType - Return the type of intel. [Number]

Examples:
    (begin example)
        _intelType = [player] call BTC_fnc_info_give_intel;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_asker", objNull, [objNull]]
];

private _intelType = random 100;

if (btc_hideouts isEqualTo []) then {_intelType = (btc_info_intel_type select 0) - 10;};

switch (true) do {
    case (_intelType < (btc_info_intel_type select 0)) : { //cache
        [true] call BTC_fnc_info_cache;
    };
    case (_intelType > (btc_info_intel_type select 1) && _intelType < 101) : { //both
        [true] call BTC_fnc_info_cache;
        [] call BTC_fnc_info_hideout;
        [5] remoteExecCall ["BTC_fnc_show_hint", _asker];
    };
    case (_intelType > (btc_info_intel_type select 0) && _intelType < (btc_info_intel_type select 1)) : { //hd
        [] call BTC_fnc_info_hideout;
        [5] remoteExecCall ["BTC_fnc_show_hint", _asker];
    };
    default {
        [3] remoteExecCall ["BTC_fnc_show_hint", _asker];
    };
};

_intelType
