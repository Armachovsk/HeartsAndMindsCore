
/* ----------------------------------------------------------------------------
Function: BTC_fnc_mil_create_group

Description:
    Fill me when you edit me !

Parameters:
    _city - [Number]
    _area - [Number]
    _n - [Number]
    _wp - [Array]
    _type_divers - [Array]
    _type_units - [Boolean]
    _p_sea - [Side]
    _enemy_side - [Array]
    _wp_ratios - []

Returns:

Examples:
    (begin example)
        _result = [] call BTC_fnc_mil_create_group;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_city", objNull, [objNull, []]],
    ["_area", 300, [0]],
    ["_n", 0, [0]],
    ["_wp", 0, [0]],
    ["_type_divers", btc_type_divers, [[]]],
    ["_type_units", btc_type_units, [[]]],
    ["_p_sea", btc_p_sea, [true]],
    ["_enemy_side", btc_enemy_side, [east]],
    ["_wp_ratios", btc_p_mil_wp_ratios, [[]]]
];
_wp_ratios params ["_wp_house_probability", "_wp_sentry_probability"];

// Find a position
([_city, _area] call BTC_fnc_city_findPos) params ["_rpos", "_pos_iswater"];

private _group = createGroup _enemy_side;
private _groups = [];
_groups pushBack _group;

// Handle different case of wp
switch (true) do {
    case (_wp <= _wp_house_probability) : {
        ([_rpos, _n] call BTC_fnc_mil_getBuilding) params ["_n", "_structure"];
        if (_structure isEqualTo "") exitWith {
            [_city, _area, _n, _wp_sentry_probability, _type_divers, _type_units, _p_sea, _enemy_side, _wp_ratios] call BTC_fnc_mil_create_group;
        };
        for "_i" from 1 to _n do {
            private _grp = createGroup _enemy_side;
            [_grp, _rpos, 1] call BTC_fnc_mil_createUnits;
            _grp setVariable ["btc_inHouse", typeOf _structure];
            [_grp, _structure] call BTC_fnc_house_addWP;
            _groups pushBack _grp;
        };
    };
    case (_wp > _wp_house_probability && _wp <= _wp_sentry_probability) : {
        [_group, _rpos, _n, _pos_iswater] call BTC_fnc_mil_createUnits;
        [_group, _rpos, _area, 2 + floor (random 4), "MOVE", "SAFE", "RED", "LIMITED", "STAG COLUMN", "", [5, 10, 20]] call CBA_fnc_taskPatrol;
    };
    case (_wp > _wp_sentry_probability) : {
        [_group, _rpos, _n, _pos_iswater] call BTC_fnc_mil_createUnits;
        [_group, _rpos, -1, "SENTRY", "AWARE", "RED"] call CBA_fnc_addWaypoint;
    };
};

if (btc_debug_log) then {
    [format ["_this = %1 ; POS %2 UNITS N %3 _wp_ratios %4", _this, _rpos, _n, _wp_ratios], __FILE__, [false]] call BTC_fnc_debug_message;
};

_groups
