# First Game - 2D Platformer

A 2D platformer game built with Godot Engine 4.6.

## Game Features

- **Player Character**: A knight that can run and jump
- **Collectibles**: Coins and fruits to collect
- **Enemies**: Green and purple slimes
- **Hazards**: Kill zones that reset the level
- **Sound Effects**: Jump, coin collection, power-up, hurt, and explosion sounds
- **Background Music**: Adventure-themed music

## Controls

- **Left/Right Arrow**: Move the player
- **Space/Enter**: Jump

## Project Structure

```
first-game/
├── scenes/           # Godot scene files
│   ├── game.tscn     # Main game scene
│   ├── player.tscn   # Player character scene
│   ├── coin.tscn     # Collectible coin scene
│   ├── slime.tscn    # Enemy slime scene
│   ├── platform.tscn # Platform scene
│   └── kill_zone.tscn# Hazard zone scene
├── scripts/          # GDScript files
│   ├── player.gd     # Player movement and physics
│   ├── coin.gd       # Coin collection logic
│   └── kill_zone.gd  # Death zone and respawn logic
├── assets/
│   ├── sprites/      # Game sprites
│   │   ├── knight.png
│   │   ├── coin.png
│   │   ├── fruit.png
│   │   ├── slime_green.png
│   │   ├── slime_purple.png
│   │   ├── platforms.png
│   │   └── world_tileset.png
│   └── music/        # Background music
│       └── time_for_adventure.mp3
└── project.godot     # Godot project configuration
```

## Requirements

- Godot Engine 4.6 or later

## How to Run

1. Open Godot Engine 4.6
2. Click "Import" and select the project folder
3. Open the project and press F5 or click the play button

## Technical Details

- **Physics Engine**: Jolt Physics (3D)
- **Renderer**: Forward Plus
- **Texture Filtering**: Nearest (pixel art style)

## Gameplay

Navigate through platforms, collect coins, avoid slimes and hazards. If you touch a kill zone or enemy, the level will restart.
