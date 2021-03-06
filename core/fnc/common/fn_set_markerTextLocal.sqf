
/* ----------------------------------------------------------------------------
Function: BTC_fnc_set_markerTextLocal

Description:
    Add local text to a marker.

Parameters:
    _marker - Marker to add text locally [String]
    _text - Text to add locally. [String]
    _arg - Argument for custom text. [String, Number]

Returns:

Examples:
    (begin example)
        [] call BTC_fnc_set_markerTextLocal;
    (end)

Author:
    1kuemmel1

---------------------------------------------------------------------------- */

params [
    ["_marker", "", [""]],
    ["_text", "", [""]],
    ["_arg", "", ["", 0]]
];

//check for localized text
_text = if (isLocalized _text) then {localize _text};

//set markerText
_marker setMarkerTextLocal format [_text, _arg];
