
/* ----------------------------------------------------------------------------
Function: BTC_fnc_ied_suiciderLoop

Description:
    Search for soldier around and when found, activate the suicider.

Parameters:
    _suicider - Suicider created. [Object]

Returns:

Examples:
    (begin example)
        [_suicider] call BTC_fnc_ied_suiciderLoop;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

[{
    params ["_suicider"];

    if (alive _suicider && !isNull _suicider) then {
        if !((_suicider nearEntities ["SoldierWB", 25]) isEqualTo []) exitWith {
            _suicider call BTC_fnc_ied_suicider_active;
        };
        _this call BTC_fnc_ied_suiciderLoop;
    };
}, _this, 5] call CBA_fnc_waitAndExecute;
