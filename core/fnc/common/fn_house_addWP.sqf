
/* ----------------------------------------------------------------------------
Function: BTC_fnc_house_addWP

Description:
    Add waypoints to group to patrol inside an house.

Parameters:
    _group - Group to add waypoints. [Group]
    _house - House use to patrol. [Object]

Returns:

Examples:
    (begin example)
        [group player, ([getPos player] call BTC_fnc_getHouses) select 0] call BTC_fnc_house_addWP;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_group", grpNull, [grpNull]],
    ["_house", objNull, [objNull]]
];

private _allpositions = [_group, _house] call BTC_fnc_house_addWP_loop;

private _wp = [_group, [_allpositions select 0, 0.2] call CBA_fnc_randPos, -1, "CYCLE", "UNCHANGED", "NO CHANGE", "UNCHANGED", "NO CHANGE", "", [15, 20, 30]] call CBA_fnc_addWaypoint;
_wp waypointAttachObject _house;
_wp setWaypointHousePosition 0;
