
/* ----------------------------------------------------------------------------
Function: BTC_fnc_rep_explosives_defuse

Description:
    Change reputation when an explosive has been defused.

Parameters:
    _ied - IED object. [Object]
    _unit - Unit defusing the IED. [Object]

Returns:

Examples:
    (begin example)
        _result = [] call BTC_fnc_rep_explosives_defuse;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_ied", objNull, [objNull]],
    ["_unit", objNull, [objNull]]
];

private _type_ied = typeOf _ied;
if ((_type_ied select [0, _type_ied find "_"]) in (btc_type_ieds_ace apply {_x select [0, _x find "_"]})) then {
    btc_rep_bonus_disarm call BTC_fnc_rep_change;
};
