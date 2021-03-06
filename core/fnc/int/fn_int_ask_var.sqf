
/* ----------------------------------------------------------------------------
Function: BTC_fnc_int_ask_var

Description:
    Fill me when you edit me !

Parameters:
    _id - [Object]
    _target - [String]
    _varName - []

Returns:

Examples:
    (begin example)
        _result = [] call BTC_fnc_int_ask_var;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_id", 0, [0, ""]],
    ["_target", objNull, [objNull]],
    ["_varName", "btc_int_ask_data", [""]]
];

private _data = switch (_id) do {
    case 0 : {_target getVariable ["active", false];};
    case 1 : {
        private _hd = objNull;
        {
            if (_x inArea [getPosWorld _target, 3000, 3000, 0, false]) then {
                _hd = _x;
            };
        } forEach btc_hideouts;
        _hd;
    };
    case 3 : {_target getVariable ["cargo", []];};
    case 4 : {_target getVariable ["tow", objNull];};
    case 8 : {count btc_hideouts;};
    case 9 : {[_target] call BTC_fnc_db_saveObjectStatus;};
    case 10 : {
        private _units = allUnits select {alive _x};
        _units append entities [["Car", "Tank", "Ship", "Air"], []];
        _units apply {[_x, owner _x]};
    };
    case 11 : {floor diag_fps;};
    default {missionNamespace getVariable [_id, []];};
};

missionNamespace setVariable [_varName, _data, remoteExecutedOwner];
