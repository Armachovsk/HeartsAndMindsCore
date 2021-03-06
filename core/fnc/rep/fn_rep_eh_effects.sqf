
/* ----------------------------------------------------------------------------
Function: BTC_fnc_rep_eh_effects

Description:
    Add effects when player do bad things (call militia, take weapons/grenade).

Parameters:
    _pos - Position where bad stuff happened. [Array]

Returns:

Examples:
    (begin example)
        [getPos player] call BTC_fnc_rep_eh_effects;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

if (btc_global_reputation >= 600) exitWith {};

params [
    ["_pos", [0, 0, 0], [[]]]
];

private _rep = (btc_global_reputation / 100);
private _random = random (10 - _rep);

if (_random <= 3) exitWith {};

if (time > (btc_rep_militia_called + btc_rep_militia_call_time)) then {
    if (_random > 3) then { //CALL MILITIA
        [_pos] call BTC_fnc_rep_call_militia;
    };
};
if (btc_global_reputation < 300) then {
    if (_random > 4) then { //GET WEAPONS
        [_pos, 300] call BTC_fnc_civ_get_weapons;
    };
} else {
    if (_random > 1) then { //GET GRENADE
        [_pos, 300] call BTC_fnc_civ_get_grenade;
    };
};

if (btc_debug_log) then {
    [format ["REP = %1 - RANDOM = %2 - RINF TIME = %3 - MILITIA/WEAPONS = %4/%5", _rep, _random, time > (btc_rep_militia_called + btc_rep_militia_call_time), _random > 3, _random > 4], __FILE__, [false]] call BTC_fnc_debug_message;
};
