
/* ----------------------------------------------------------------------------
Function: BTC_fnc_civ_evacuate

Description:
    Evacuate civlians around a position in an area of 200 to a safe position.

Parameters:
    _position - Position to search for cilivians in a area of 200. [Array]
    _position_evac - Safe position where civilians will move to. [Array]

Returns:
    _civilians - Civlians found. [Array]
Examples:
    (begin example)
        _civilians = [[0, 0, 0], [100, 100, 100]] call BTC_fnc_civ_evacuate;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_position", [], [[]]],
    ["_position_evac", [], [[]]]
];

private _civilians = (allUnits select {side _x isEqualTo civilian}) inAreaArray [_position, 200, 200];

if (_position_evac isEqualTo []) then {
    private _safe = (nearestTerrainObjects [_position, ["CHURCH", "CHAPEL"], 400]);
    if (_safe isEqualTo []) then {
        _position_evac = [_position, 0, 500, 30, 0, 60 * (pi / 180), 0] call BIS_fnc_findSafePos;
    } else {
        private _safe_building = _safe select 0;
        if ((_safe_building buildingPos -1) isEqualTo []) then {
            _position_evac = _safe_building getPos [((boundingBox _safe_building) select 1 select 0) + 10, getDir _safe_building];
        } else {
            _position_evac = getPos _safe_building;
        };
    };
};

{
    private _group = group _x;
    [_group] call CBA_fnc_clearWaypoints;

    [_group, _position_evac, 20] call BTC_fnc_civ_addWP;
} forEach _civilians;

_civilians
