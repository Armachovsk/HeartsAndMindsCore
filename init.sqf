enableSaving [false, false];

if (hasInterface) then {btc_intro_done = [] spawn BTC_fnc_intro;};

[] call compile preprocessFileLineNumbers "specbased\mission_frameworks\btc_hearts_and_minds\core\def\mission.sqf";
[] call compile preprocessFileLineNumbers "specbased\mission_frameworks\btc_hearts_and_minds\define_mod.sqf";

if (isServer) then {
    [] call compile preprocessFileLineNumbers "specbased\mission_frameworks\btc_hearts_and_minds\core\init_server.sqf";
};

[] call compile preprocessFileLineNumbers "specbased\mission_frameworks\btc_hearts_and_minds\core\init_common.sqf";

if (!isDedicated && hasInterface) then {
    [] call compile preprocessFileLineNumbers "specbased\mission_frameworks\btc_hearts_and_minds\core\init_player.sqf";
};

if (!isDedicated && !hasInterface) then {
    [] call compile preprocessFileLineNumbers "specbased\mission_frameworks\btc_hearts_and_minds\core\init_headless.sqf";
};
