
/* ----------------------------------------------------------------------------
Function: BTC_fnc_info_search_for_intel

Description:
    Fill me when you edit me !

Parameters:
    _target - [Object]

Returns:

Examples:
    (begin example)
        _result = [] call BTC_fnc_info_search_for_intel;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_target", objNull, [objNull]]
];

private _radius = 7;
if (_target isKindOf "Man") then {_radius = 4;};
if (_target isKindOf "Helicopter") then {_radius = 20;};

private _onFinish = {
    params ["_args"];
    _args params ["_target", "_player"];

    [_target, _player] remoteExecCall ["BTC_fnc_info_has_intel", 2];
};
private _condition = {
    params ["_args"];
    _args params ["_target", "_player", "_radius"];

    _target distance _player < _radius
};

[btc_int_search_intel_time, [_target, player, _radius], _onFinish, {}, localize "STR_BTC_HAM_CON_INFO_SEARCH_BAR", _condition, ["isnotinside"]] call ace_common_fnc_progressBar;
