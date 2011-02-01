/*
 * ============================================================================
 *
 *  File:			rotoblin.finalespawn.sp
 *  Type:			Module
 *  Description:	Reduces the spawn range on finales to normal spawning 
 *					range.
 *	Credits:		Confogl Team, <confogl.googlecode.com>
 *
 *  Copyright (C) 2010  Mr. Zero <mrzerodk@gmail.com>
 *  This file is part of Rotoblin.
 *
 *  Rotoblin is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  Rotoblin is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with Rotoblin.  If not, see <http://www.gnu.org/licenses/>.
 *
 * ============================================================================
 */

/*
 * ==================================================
 *                     Variables
 * ==================================================
 */

/*
 * --------------------
 *       Private
 * --------------------
 */

static	const			GHOST_SPAWN_STATE_TOO_CLOSE = 256;
static	const			GHOST_SPAWN_STATE_SPAWN_READY = 0;

static	const			MIN_SPAWN_RANGE = 150;

static			bool:	g_bIsFinaleActive = false;

/*
 * ==================================================
 *                     Forwards
 * ==================================================
 */

/**
 * Called on plugin start.
 *
 * @noreturn
 */
public _FinaleSpawn_OnPluginStart()
{
	HookPublicEvent(EVENT_ONPLUGINENABLE, _FS_OnPluginEnabled);
	HookPublicEvent(EVENT_ONPLUGINDISABLE, _FS_OnPluginDisabled);
}

/**
 * Called on plugin enabled.
 *
 * @noreturn
 */
public _FS_OnPluginEnabled()
{
	HookPublicEvent(EVENT_ONCLIENTPUTINSERVER, _FS_OnClientPutInServer);
	HookPublicEvent(EVENT_ONCLIENTDISCONNECT_POST, _FS_OnClientDisconnect);

	HookEvent("round_end", _FS_OnRoundChange_Event, EventHookMode_PostNoCopy);
	HookEvent("round_start", _FS_OnRoundChange_Event, EventHookMode_PostNoCopy);
	HookEvent("finale_start", _FS_OnFinaleStart_Event, EventHookMode_PostNoCopy);

	for (new client = 1; client <= MaxClients; client++)
	{
		if (!IsClientInGame(client)) continue;
		SDKHook(client, SDKHook_PreThink, _FS_OnPreThink);
	}
}

/**
 * Called on plugin disabled.
 *
 * @noreturn
 */
public _FS_OnPluginDisabled()
{
	UnhookPublicEvent(EVENT_ONCLIENTPUTINSERVER, _FS_OnClientPutInServer);
	UnhookPublicEvent(EVENT_ONCLIENTDISCONNECT_POST, _FS_OnClientDisconnect);

	UnhookEvent("round_end", _FS_OnRoundChange_Event, EventHookMode_PostNoCopy);
	UnhookEvent("round_start", _FS_OnRoundChange_Event, EventHookMode_PostNoCopy);
	UnhookEvent("finale_start", _FS_OnFinaleStart_Event, EventHookMode_PostNoCopy);

	for (new client = 1; client <= MaxClients; client++)
	{
		if (!IsClientInGame(client)) continue;
		SDKUnhook(client, SDKHook_PreThink, _FS_OnPreThink);
	}
}

/**
 * Called when round start / end event is fired.
 *
 * @param event			Handle to event.
 * @param name			String containing the name of the event.
 * @param dontBroadcast	True if event was not broadcast to clients, false 
 *						otherwise.
 * @noreturn
 */
public _FS_OnRoundChange_Event(Handle:event, const String:name[], bool:dontBroadcast)
{
	g_bIsFinaleActive = false;
}

/**
 * Called when finale start event is fired.
 *
 * @param event			Handle to event.
 * @param name			String containing the name of the event.
 * @param dontBroadcast	True if event was not broadcast to clients, false 
 *						otherwise.
 * @noreturn
 */
public _FS_OnFinaleStart_Event(Handle:event, const String:name[], bool:dontBroadcast)
{
	g_bIsFinaleActive = true;
}

/**
 * Called on client put in server.
 *
 * @param client		Client index.
 * @noreturn
 */
public _FS_OnClientPutInServer(client)
{
	SDKHook(client, SDKHook_PreThink, _FS_OnPreThink);
}

/**
 * Called on client disconnect.
 *
 * @param client		Client index.
 * @noreturn
 */
public _FS_OnClientDisconnect(client)
{
	SDKUnhook(client, SDKHook_PreThink, _FS_OnPreThink);
}

/**
 * Called on client pre think.
 *
 * @param client		Client index.
 * @noreturn
 */
public _FS_OnPreThink(client)
{
	if (!g_bIsFinaleActive) return;

	if (!IsClientInGame(client) ||
		GetClientTeam(client) != TEAM_INFECTED ||
		!IsPlayerGhost(client))
		return;

	if (GetPlayerGhostSpawnState(client) == GHOST_SPAWN_STATE_TOO_CLOSE)
	{
		if (!IsGhostTooCloseToSurvivors(client))
		{
			SetPlayerGhostSpawnState(client, GHOST_SPAWN_STATE_SPAWN_READY);
		}
	}
}

/*
 * ==================================================
 *                    Private API
 * ==================================================
 */

/**
 * Returns whether ghost is too close to any survivors.
 *
 * @param client		Client index of ghost.
 * @return				True if too close to any survivor, false otherwise.
 */
static bool:IsGhostTooCloseToSurvivors(client)
{
	new survivor;
	decl Float:survivorOrigin[3];
	decl Float:ghostOrigin[3];
	GetClientAbsOrigin(client, ghostOrigin);

	for (new i = 0; i < SurvivorCount; i++)
	{
		survivor = SurvivorIndex[i];
		if (survivor <= 0 || !IsClientInGame(survivor) || !IsPlayerAlive(survivor)) continue;
		GetClientAbsOrigin(SurvivorIndex[i], survivorOrigin);
		if (GetVectorDistance(survivorOrigin, ghostOrigin, true) <= MIN_SPAWN_RANGE) return true;
	}

	return false;
}

/**
 * Retrives players ghost spawn state.
 *
 * @param client		Client index.
 * @return				Ghost spawn state of client.
 */
static GetPlayerGhostSpawnState(client)
{
	return GetEntProp(client, Prop_Send, "m_ghostSpawnState");
}

/**
 * Sets player ghost spawn state.
 *
 * @param client		Client index.
 * @param spawnState	Spawn state to set.
 * @noreturn
 */
static SetPlayerGhostSpawnState(client, spawnState)
{
	SetEntProp(client, Prop_Send, "m_ghostSpawnState", spawnState);
}