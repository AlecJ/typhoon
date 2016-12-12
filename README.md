# typhoon
simple 1v1 arcade game that uses a beat detection algorithm

based on love2d and lua

Current state
the game currently creates the hexagonal grid that the players will play in. It also has beginning functionality for grid spaces activating and becoming obstacles for the player. Currently, the center hexagon is selected to be active and after a given interval, neighboring hexagons also become active.

TO DO
Make the center hexagon aligned with the width and height
Creat the player class
Give the player collision with the hexagons
Do not make a hexagon active if a player is inside it
Allow the player to shoot projectiles
Give hexagons damage and make them inactive if a certain amount of damage is taken
Sync the growing of the obstacles to a beat
Sync the shooting of the player to a beat

