
/* ----------------------------------------------------------------------------
Function: BTC_fnc_mil_getBuilding

Description:
    Fill me when you edit me !

Parameters:
    _rpos - [Array]
    _n - [Number]

Returns:

Examples:
    (begin example)
        _result = [] call BTC_fnc_mil_getBuilding;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_rpos", [0, 0, 0], [[]]],
    ["_n", 0, [0]]
];

private _structure = objNull;
private _structures = [_rpos, 70] call BTC_fnc_mil_getStructures;

if (_structures isEqualTo []) then {
    private _houses = [_rpos, 50] call BTC_fnc_getHouses;
    if (_houses isEqualTo []) then {
        _structure = "";
    } else {
        _structure = selectRandom _houses;
        _n = 1;
    };
} else {
    _structure = selectRandom _structures;
    _n = count (_structure buildingPos -1);
    if (_n > 8) then {
        _n = 2;
    } else {
        _n = floor (_n/2);
    };
};

[_n, _structure]
