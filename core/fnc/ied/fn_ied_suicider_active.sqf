
/* ----------------------------------------------------------------------------
Function: BTC_fnc_ied_suicider_active

Description:
    Activate the suicider by adding explosive charge around his pelvis and force suicider to move in the direction of soldier.

Parameters:
    _suicider - Suicider created. [Object]

Returns:

Examples:
    (begin example)
        [_suicider] call BTC_fnc_ied_suicider_active;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_suicider", objNull, [objNull]]
];

[_suicider] joinSilent createGroup [btc_enemy_side, true];

_suicider call BTC_fnc_rep_remove_eh;

[group _suicider] call CBA_fnc_clearWaypoints;

private _trigger = createTrigger ["EmptyDetector", getPos _suicider];
_trigger setTriggerArea [5, 5, 0, false];
_trigger setTriggerActivation [str btc_player_side, "PRESENT", false];
_trigger setTriggerStatements ["this", "thisTrigger call BTC_fnc_ied_allahu_akbar;", ""];
_trigger setVariable ["suicider", _suicider];

_trigger attachTo [_suicider, [0, 0, 0]];

private _array = getPos _suicider nearEntities ["SoldierWB", 30];

if (_array isEqualTo []) exitWith {};

private _expl1 = "DemoCharge_Remote_Ammo" createVehicle (position _suicider);
_expl1 attachTo [_suicider, [-0.1, 0.1, 0.15], "Pelvis"];
private _expl2 = "DemoCharge_Remote_Ammo" createVehicle (position _suicider);
_expl2 attachTo [_suicider, [0, 0.15, 0.15], "Pelvis"];
private _expl3 = "DemoCharge_Remote_Ammo" createVehicle (position _suicider);
_expl3 attachTo [_suicider, [0.1, 0.1, 0.15], "Pelvis"];

[_expl1, _expl2, _expl3] remoteExecCall ["BTC_fnc_ied_belt", 0];

_suicider addEventHandler ["Killed", {
    params ["_unit", "_killer"];

    if !(isPlayer _killer) then {
        (attachedObjects _unit) call CBA_fnc_deleteEntity;
    };
}];

(group _suicider) setBehaviour "CARELESS";
(group _suicider) setSpeedMode "FULL";

if (btc_debug_log) then {
    [format ["_suicider = %1 POS %2 START LOOP", _suicider, getPos _suicider], __FILE__, [false]] call BTC_fnc_debug_message;
};

[_suicider, _trigger] call BTC_fnc_ied_suicider_activeLoop;
