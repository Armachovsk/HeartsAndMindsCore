
/* ----------------------------------------------------------------------------
Function: BTC_fnc_civ_addWP

Description:
    Add waypoints to a group. The group will patrol inside a first house, then 4 waypoints outside are added and finally the group will patrol again in an other house.

Parameters:
    _group - Group where waypoints will be added. [Group]
    _pos - Position to search house and position to patrol. [Array]
    _radius - Radius number to search around the position. [Number]

Returns:

Examples:
    (begin example)
        [_group] call BTC_fnc_civ_addWP;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_group", grpNull, [grpNull]],
    ["_pos", getPos leader param [0], [[]]],
    ["_radius", 50, [0]]
];

[_group, _pos, -1, "MOVE", "SAFE", "NO CHANGE", "LIMITED"] call CBA_fnc_addWaypoint;

private _houses = [_pos, _radius] call BTC_fnc_getHouses;
if !(_houses isEqualTo []) then {
    private _house = selectRandom _houses;
    [_group, _house] call BTC_fnc_house_addWP_loop;
    _houses = _houses - [_house];
};

for "_i" from 1 to 4 do {
    private _wp_pos = [_pos, _radius] call BTC_fnc_randomize_pos;
    [_group, _wp_pos, -1, "MOVE"] call CBA_fnc_addWaypoint;
};

if !(_houses isEqualTo []) then {
    private _house = selectRandom _houses;
    [_group, _house] call BTC_fnc_house_addWP_loop;
    _houses = _houses - [_house];
};

[_group, _pos, -1, "CYCLE"] call CBA_fnc_addWaypoint;
