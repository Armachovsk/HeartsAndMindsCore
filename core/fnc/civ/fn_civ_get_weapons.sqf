
/* ----------------------------------------------------------------------------
Function: BTC_fnc_civ_get_weapons

Description:
    Search for civilians at a position in a range to add weapons to their inventory.

Parameters:
    _pos - Position to search for civilians. [Array]
    _range - Range to find civilians around the position. [Number]
    _units - Pass directly units to add weapons. [Array]

Returns:

Examples:
    (begin example)
        [getPos player, 200] call BTC_fnc_civ_get_weapons;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_pos", [0, 0, 0], [[]]],
    ["_range", 300, [0]],
    ["_units", [], [[]]]
];

if (_units isEqualTo []) then {
    _units = _pos nearEntities [btc_civ_type_units, _range];
    _units = _units select {side _x isEqualTo civilian};
};

{
    if (btc_debug_log) then {
        [format ["%1 - %2", _x, side _x], __FILE__, [false]] call BTC_fnc_debug_message;
    };

    _x call BTC_fnc_rep_remove_eh;
    [_x, "", 2] call ace_common_fnc_doAnimation;
    [_x] call BTC_fnc_civ_add_weapons;

    [_x] joinSilent createGroup [btc_enemy_side, true];

    (group _x) setVariable ["getWeapons", true];

    (group _x) setBehaviour "AWARE";
    [group _x, getPos _x, -1, "GUARD", "UNCHANGED", "RED", nil, nil, nil, nil, 10] call CBA_fnc_addWaypoint;
} forEach _units;
