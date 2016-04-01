Changelog 0.8.0 -> 0.8.1

  * Reduced Infected Finale Spawn Radius to normal state, a small bug exists in the client UI which will quickly flash "spawn" and "too close to survivors", rest assured you can spawn without any problems as this is a client side UI bug.

**Changelog 0.7.5 -> 0.8.0**
  * Hardcore Mode is fully functional, execute it by "rotoblin\_hardcore.cfg".
  * Hardcore Mode removes all pills except finale and saferoom clusters, all throwables, all canisters and limits the amount of melees to 2 before cooldown kicks in.
  * Cvars for regulating throwables, canisters and melees are as followed: rotoblin\_melee\_penalty, rotoblin\_enable\_cannisters, rotoblin\_enable\_throwables
  * rotoblin\_health\_style 3 is used for Hardcore Mode and 1 for normal mode.
  * ~ You can always check the server settings by typing rotoblin\_version.

**Changelog 0.7.4 -> 0.7.5**
  * Added PumpSwap module (no longer can you shoot, swap to pistol and shoot again without having a delay incurred)
  * Added Hunting Rifle limit to 1, you won't be allowed to pick more. This is customizable via your cfg file or the cvar rotoblin\_limit\_huntingrifle x
  * Removed thirdperson module as valve fixed this in the sacrifice update.

**Changelog 0.7.2b -> 0.7.4**
  * Revamped entire package, removed sourcemod, metamod and stripper. Anyone who wishes to install Rotoblin will have to first go through http://code.google.com/p/rotoblin/wiki/Installation to make sure they have the required files for rotoblin to work.
  * Re-compiled SDKHooks with the latest sourcemod/metamod so if you were having troubles getting sdkhooks to load then the new rotoblin version should fix this, you will require SourceMod 1.4.0-hg3146 and Metamod 1.9.0-hg737 or a newer version, you can get the direct links from the Installation Rotoblin Wiki page.
  * Merged both rotoblin windows and linux packages into one, so all you do is extract into your /l4d/left4dead/ folder after following the installation guide.

**Changelog 0.7.2b -> 0.7.2c**
  * Fixed teams not getting placed in the right team after map and scores not resetting every new campaign.

**Changelog 0.7.1a -> 0.7.2b**
  * Scores were resetting after every map, but there's still a bug that the scores resets when you swap over to a new campaign, you'll need to type !sm\_resetscores to reset them to 0 or re-execute rotoblin (Fix is already implemented and will be in a later build)


**Changelog 0.7.1 -> 0.7.1a**

  * Fixed GetTeamScore signature for linux.
  * Fixed l4dscores.smx crashing.

**Changelog 0.7 -> 0.7.1**

Version 0.7.1
  * Fixed error logging upon survivor being incapacitated
  * Fixed unreserve lobby module not starting upon plugin start
  * Changed various parts of the infected exploit fixes module

**Changelog 0.6.2 -> 0.7.**

Version 0.7.0
  * Added No Prop Fading module. Props wont fade away as long tank is alive and fade away 20 seconds after the tank have been killed
  * Added No Peeking module. Prevents thirdperson\_sholder mode abuse to look around corners, cvar: rotoblin\_block\_thridperson, on by default
  * Added 2vs2mod module. Rotoblin now support 2vs2 configs. Ensures infected bots will auto slayed upon spawn. Cvar: rotoblin\_enable\_2v2
  * Added Report Status module. Clients can now type rotoblin\_version into their console to see convars and status of the rotoblin installation on the server
  * Added detection and blocking for "telespawn" where infected can spawn ontop of the survivors
  * Added TANK\_PASSED event to the tank manager helper
  * Added rotoblin\_pause cvar to set whether the game can be paused by Rotoblin
  * Added revive block upon a survivor gets hit by a tank rock to Ghost Tank module
  * Added debug print to Ghost Tank module
  * Added mat\_hdr\_level check. Clients with low mat\_hdr\_level will be kicked
  * Removed block ghost ducking cvar and reverted to on by default
  * Fixed ghost ducking affect spawn jumping clients
  * Fixed invalid entity index errors with health control module upon late spawn medkit
  * Fixed checks for invalid entity indexes on late weapon spawns in weapon control module
  * Fixed missing includes, added to the rotoblin.includes folder
  * Changed method of blocking AI tanks from throwing
  * Changed default health style to replace all medkits from replace all but finale medkits
  * Changed various parts of the tank manager helper module
  * Changed various parts of the spec boss module
  * Changed draw function of the infected frustartion module
  * Changed various parts of the event manger helper module

**Changelog 0.6.1(b) -> 0.6.2**

Version 0.6.2
  * Added cvar for crouchbug fix and changed to disabled by default
    * rotoblin\_block\_ghost\_duck
  * Added more error checking upon plugin start up to ensure all modules is 100% operational
  * Fixed debug logging client indexes helper
  * Fixed if logic in health control module
  * Changed logic in weapon control module
  * Changed FakeClientCommandEx to FakeClientCommand in pause module

**//Rotoblin 0.6.2**

Ratehack which kicks people for having a too high interp (customizable cvars in cfg)

Tankhud which is only shown to spectators when the tank is alive

Tank frustration hud for the infected

Pause function that works like the singleplayer pause

Respawning of horde infront of you if the horde is too far behind

Bugfixes such as no scratching while getting melee'd and no crouchbugging exploit

Cvar to adjust T2

Cvar to adjust kits/pills.