
/* ----------------------------------------------------------------------------
Function: BTC_fnc_side_create

Description:
    Create side mission inside the H&M task system.

Parameters:
    _cycle - Cycle side mission. [Boolean]
    _side_fnc_name - Side mission function name. [String]

Returns:

Examples:
    (begin example)
        [false, "BTC_fnc_side_supply"] spawn BTC_fnc_side_create;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_cycle", false, [false]],
    ["_side_fnc_name", "", [""]]
];

if (_side_fnc_name isEqualTo "") then {
    if (btc_side_list_use isEqualTo []) then {
        btc_side_list_use = btc_side_list call BIS_fnc_arrayShuffle;
    };
    _side_fnc_name = format ["BTC_fnc_side_%1", btc_side_list_use deleteAt 0];
};

btc_side_ID = btc_side_ID + 1;
private _tskID = format ["btc_tsk_%1", btc_side_ID];
if ([_tskID] call BIS_fnc_taskExists) exitWith {
    _this call BTC_fnc_side_create;
};

[_tskID] call (missionNamespace getVariable [_side_fnc_name, {}]);

if (_cycle) then {
    [true] spawn BTC_fnc_side_create;
};
