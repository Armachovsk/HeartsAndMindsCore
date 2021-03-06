
/* ----------------------------------------------------------------------------
Function: BTC_fnc_mil_createUnits

Description:
    Fill me when you edit me !

Parameters:
    _group - [Group]
    _pos - [Array]
    _number - [Number]
    _pos_iswater - [Boolean]
    _type_units - [Array]
    _type_divers - [Array]

Returns:

Examples:
    (begin example)
        _result = [] call BTC_fnc_mil_createUnits;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_group", grpNull, [grpNull]],
    ["_pos", [0, 0, 0], [[]]],
    ["_number", 0, [0]],
    ["_pos_iswater", false, [false]],
    ["_type_units", btc_type_units, [[]]],
    ["_type_divers", btc_type_divers, [[]]]
];

for "_i" from 1 to _number do {
    private _unit_type = if (_pos_iswater) then {
        selectRandom _type_divers;
    } else {
        selectRandom _type_units;
    };

    private _unit = _group createUnit [_unit_type, _pos, [], 0, "CARGO"];
    [_unit] joinSilent _group;

    if (canSuspend) then {
        sleep 1;
    };
};
[_group] call BTC_fnc_mil_unit_create;

_group
