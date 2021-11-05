params [
    ["_beforeInit", {}, [{}]],
    ["_afterInit", {}, [{}]]
];

enableSaving [false, false];

[] call _beforeInit;

if (hasInterface) then {btc_intro_done = [] spawn BTC_fnc_intro;};

if (isServer) then {
    [] call compile preprocessFileLineNumbers "HeartsAndMindsCore\core\init_server.sqf";
};

[] call compile preprocessFileLineNumbers "HeartsAndMindsCore\core\init_common.sqf";

if (!isDedicated && hasInterface) then {
    [] call compile preprocessFileLineNumbers "HeartsAndMindsCore\core\init_player.sqf";
};

if (!isDedicated && !hasInterface) then {
    [] call compile preprocessFileLineNumbers "HeartsAndMindsCore\core\init_headless.sqf";
};

[] call _afterInit;
