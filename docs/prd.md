# Product Requirements Document (PRD)
## 2D Platformer Game

**Version:** 1.0  
**Date:** March 21, 2026  
**Status:** Active

---

## 1. Executive Summary

A classic 2D platformer game built with Godot Engine 4.6 featuring a knight protagonist navigating through hazardous environments, collecting coins, avoiding enemies, and reaching the end goal. The game combines retro pixel art aesthetics with smooth physics-based gameplay.

---

## 2. Product Vision

Create an engaging, accessible 2D platformer that provides satisfying gameplay through intuitive controls, responsive physics, and rewarding progression. The game targets casual to mid-core gamers who enjoy classic platformer challenges.

---

## 3. Target Audience

- **Primary:** Casual gamers aged 10-30
- **Secondary:** Retro game enthusiasts
- **Platform:** Desktop (Linux/Windows/Mac)

---

## 4. Core Game Mechanics

### 4.1 Player System
- **Movement Speed:** 100 units/sec
- **Jump Velocity:** -300 units
- **Health:** 3 hearts (health bar displayed in HUD)
- **Lives:** 3 lives system (lose life when health reaches 0)
- **Controls:**
  - Move Left/Right: Left/Right arrow keys
  - Jump: Space key
  - Sword Attack: Enter key
- **Physics:** Gravity-based, CharacterBody2D with momentum and friction
- **Combat:** Can defeat enemies by jumping on them (Mario-style) OR sword attack
- **Collision Layer:** 2 (separate from world geometry)

### 4.2 Combat System
- **Jump Attack:** Player can jump on enemy heads to defeat them (bounce effect)
- **Sword Attack:** Press Enter to swing sword, damages enemies in range
- **Damage:** Player takes 1 heart damage on enemy contact
- **Invincibility:** Brief invincibility frames after taking damage (prevent instant re-damage)

### 4.3 Collectibles System
- **Coins:**
  - Function: Currency/money system
  - Display: Simple counter in HUD
  - Feedback: Coin collect sound + visual disappearance
- **Fruits:**
  - Function: Inventory items (collection progress)
  - Display: Shown in inventory screen (accessed via inventory button)
  - Feedback: Power-up sound + visual disappearance
  - Future: Consumable items (healing, etc.) - not implemented in MVP

### 4.4 Enemy System (Slimes)
- **Green Slimes:**
  - Behavior: Patrol platform width, chase player within 150px radius
  - Speed: Normal patrol speed
  - Difficulty: Standard enemy
- **Purple Slimes:**
  - Behavior: Same patrol/chase logic but faster/more aggressive
  - Speed: Faster than green slimes
  - Difficulty: Harder variant
- **AI Logic:**
  1. Patrol back and forth on current platform (detect platform edges)
  2. Detect player within 150px radius
  3. Switch to chase mode when player detected
  4. Resume patrol if player leaves detection range
- **Death:** Can be killed by jump attack OR sword attack
- **Spawn:** Fixed positions defined in level design

### 4.5 Hazards & Death
- **Kill Zones:** Bottom of screen or designated death areas
- **Health Loss:** Instantly lose all remaining health (1 life lost)
- **Lives System:**
  - Start with 3 lives
  - Lose 1 life when health reaches 0
  - Respawn at level start when life lost
  - Game Over when all lives lost → Return to main menu
- **Feedback:** Hurt sound + scene reload

---

## 5. Game Features

### 5.1 Completed Features (Current)
- [x] Player character with movement and jump physics
- [x] Collision detection with platforms
- [x] Basic coin collection system (no sound yet)
- [x] Kill zones and basic death/respawn mechanics
- [x] Animated sprites (player, slimes)
- [x] Moving platforms
- [x] Tile-based level layout

### 5.2 MVP Features (To Implement)
- [ ] **Player Combat System**
  - [ ] Sword attack animation and hitbox
  - [ ] Jump-on-enemy kill mechanic
  - [ ] Invincibility frames after damage
- [ ] **Health & Lives System**
  - [ ] 3 hearts health bar
  - [ ] 3 lives counter
  - [ ] Respawn on death
  - [ ] Game Over → Main Menu
- [ ] **Enemy AI**
  - [ ] Platform width patrol logic
  - [ ] 150px detection radius chase
  - [ ] Green slime (normal speed)
  - [ ] Purple slime (faster/aggressive)
  - [ ] Death on jump attack or sword hit
- [ ] **Audio System**
  - [ ] Jump sound effect
  - [ ] Coin collect sound
  - [ ] Sword swing sound
  - [ ] Hurt sound
  - [ ] Power-up sound (fruits)
  - [ ] Background music loop
- [ ] **UI/HUD**
  - [ ] Lives counter display
  - [ ] Health bar (3 hearts)
  - [ ] Coin counter
  - [ ] Inventory button
  - [ ] Inventory screen (shows collected fruits)
- [ ] **Level Completion**
  - [ ] Exit door object
  - [ ] Win condition trigger
- [ ] **Menus**
  - [ ] Main menu (Play, Settings, Quit)
  - [ ] Settings menu (Music volume, SFX volume, Controls remapping, Fullscreen toggle)

### 5.3 Future Enhancements (Post-MVP)
- [ ] Multiple levels with level select
- [ ] Fruit consumables (healing, power-ups)
- [ ] Shop system (spend coins)
- [ ] Save/load functionality
- [ ] Achievement system
- [ ] Boss battles
- [ ] Level editor
- [ ] Additional enemy types
- [ ] Checkpoints

---

## 6. Technical Requirements

### 6.1 Platform & Engine
- **Engine:** Godot 4.6
- **Platform:** Desktop (cross-platform)
- **Physics:** Jolt Physics
- **Rendering:** Forward Plus

### 6.2 Performance
- Target 60 FPS
- Fast scene loading (< 2 seconds)
- Responsive input (< 16ms latency)

### 6.3 Asset Standards
- **Sprites:** Pixel art, nearest neighbor filtering
- **Audio:** WAV format for SFX, MP3 for music
- **Fonts:** PixelOperator8 (8px pixel font)

---

## 7. User Stories

### Epic 1: Core Gameplay
- As a player, I want to move my character left and right so I can navigate the level
- As a player, I want to jump so I can reach platforms and avoid hazards
- As a player, I want to collect coins so I can increase my score
- As a player, I want to avoid enemies so I don't die

### Epic 2: Game Feedback
- As a player, I want to hear sounds when I collect items so I get immediate feedback
- As a player, I want to see my score so I can track my progress
- As a player, I want the level to reset when I die so I can try again

### Epic 3: Progression
- As a player, I want to reach the end of the level so I can win
- As a player, I want to complete multiple levels so I have more gameplay

---

## 8. Success Metrics

- **Engagement:** Average play session > 5 minutes
- **Completion:** Level completion rate > 70%
- **Satisfaction:** No game-breaking bugs, smooth gameplay

---

## 9. MVP Definition

### Minimum Viable Product Scope
The MVP includes:
- **Player Systems:**
  - Playable character with movement and jumping
  - 3 hearts health bar
  - 3 lives system with respawn
  - Sword attack combat
  - Jump-on-enemy combat
- **Enemies:**
  - Green slime with patrol + chase AI
  - Purple slime (harder variant)
  - Can be killed by player
- **Collectibles:**
  - Coins with counter
  - Fruits with inventory display
- **Audio:**
  - All sound effects (jump, coin, hurt, sword, power-up)
  - Background music
- **UI/HUD:**
  - Lives counter
  - Health bar
  - Coin counter
  - Inventory button and screen
- **Level:**
  - One complete level with platforms
  - Exit door for level completion
- **Menus:**
  - Main menu (Play, Settings, Quit)
  - Settings (Music volume, SFX volume, Controls, Fullscreen)

### Out of Scope for MVP
- Multiple levels
- Fruit consumables (healing effects)
- Shop system
- Save/load functionality
- Achievements
- Boss battles
- Checkpoints
- Level editor

---

## 10. Technical Architecture

### Project Structure
```
first-game/
├── scenes/           # Godot scene files (.tscn)
│   ├── game.tscn     # Main game scene
│   ├── player.tscn   # Player character
│   ├── coin.tscn     # Collectible
│   ├── slime.tscn    # Enemy
│   ├── platform.tscn # Platforms
│   └── kill_zone.tscn# Death zones
├── scripts/          # GDScript files (.gd)
│   ├── player.gd     # Player controller
│   ├── coin.gd       # Collection logic
│   ├── kill_zone.gd  # Death/respawn
│   └── slime.gd      # Enemy AI (pending)
├── assets/           # Game assets
│   ├── sprites/      # Images
│   ├── sounds/       # Audio files
│   ├── music/        # Background music
│   └── fonts/        # Typography
└── project.godot     # Project configuration
```

### Key Scripts
- **player.gd:** CharacterBody2D physics, input handling
- **coin.gd:** Area2D collision detection
- **kill_zone.gd:** Area2D death detection + scene reload
- **slime.gd:** Enemy AI (to be implemented)

---

## 11. Risk Assessment

| Risk | Impact | Probability | Mitigation |
|------|--------|-------------|------------|
| Physics bugs | High | Medium | Thorough testing on edge cases |
| Performance issues | Medium | Low | Optimize scene complexity |
| Asset loading failures | Medium | Low | Verify all imports |
| Input lag | High | Low | Use _physics_process not _process |

---

## 12. Dependencies

- Godot Engine 4.6
- All sprite assets already imported
- Sound files ready (need AudioPlayer nodes)
- Music file ready (needs AudioStreamPlayer)

---

## 13. Timeline

### Sprint 1 (Current)
- Complete enemy AI implementation
- Add sound system
- Implement score tracking
- Build UI/HUD

### Sprint 2 (Future)
- Level completion/goal system
- Additional levels
- Polish and bug fixes

---

## 14. Glossary

- **CharacterBody2D:** Godot node for physics-based character movement
- **Area2D:** Godot node for detection without collision response
- **TileMap:** 2D grid-based level rendering
- **HUD:** Heads-Up Display (UI elements)
- **MVP:** Minimum Viable Product

---

## 15. Detailed System Specifications

### 15.1 Health & Lives System
```
Player Stats:
- Health: 3/3 hearts (current/max)
- Lives: 3/3 lives (current/max)

Damage Flow:
1. Player touches enemy/hazard
2. Play hurt sound
3. Reduce health by 1 heart
4. Activate invincibility frames (1-2 seconds)
5. Update health bar UI

Death Flow:
1. Health reaches 0
2. Reduce lives by 1
3. Check if lives > 0
   - YES: Respawn at level start, reset health to 3
   - NO: Game Over → Return to main menu
4. Update lives counter UI
```

### 15.2 Enemy AI Specification
```
Slime States:
- PATROL: Move back/forth on platform
- CHASE: Move toward player
- DEAD: Play death animation, remove from scene

PATROL Mode:
- Detect platform edges using raycasts
- Move at normal speed (green) or fast speed (purple)
- Reverse direction at edges
- Check for player in 150px radius every frame

CHASE Mode:
- Calculate direction to player
- Move toward player at chase speed
- Check if player left detection radius
- Return to PATROL if player > 150px away

Combat:
- Player jumps on slime head → Slime dies
- Player sword hits slime → Slime dies
- Slime touches player body → Player takes damage
```

### 15.3 Inventory System
```
Inventory Data:
- coins_collected: int (total coins)
- fruits: Array[String] (list of collected fruit types)

Inventory UI:
- Button in HUD opens inventory overlay
- Display grid of collected fruits
- Show coin total
- Close button to return to game
```

### 15.4 Audio Manager Specification
```
Audio Channels:
- Music: AudioStreamPlayer (background music loop)
- SFX: Multiple AudioStreamPlayer nodes for sounds

Volume Control:
- Master volume: 0.0 to 1.0
- Music volume: 0.0 to 1.0 (multiplied by master)
- SFX volume: 0.0 to 1.0 (multiplied by master)

Sound Triggers:
- jump.wav → player.gd on jump input
- coin.wav → coin.gd on body_entered
- hurt.wav → player.gd on damage taken
- power_up.wav → fruit.gd on body_entered
- sword_swing.wav → player.gd on attack input
```

### 15.5 UI/HUD Layout
```
Top-Left Corner:
- Lives: 3 heart icons
- Health: 3 heart icons (filled/empty based on health)
- Coins: Coin icon + number (e.g., "🪙 5")

Top-Right Corner:
- Inventory Button: "Bag" icon, opens inventory overlay

Inventory Overlay (Center Screen):
- Semi-transparent background
- Grid display of collected fruits
- Coin total display
- Close button (X)
```

---

## 16. Implementation Priority

### Phase 1: Core Systems (Week 1)
1. Health & Lives system
2. Enemy AI (patrol + chase)
3. Combat system (jump + sword)

### Phase 2: Audio & UI (Week 2)
4. Audio manager + all sounds
5. HUD implementation
6. Inventory system

### Phase 3: Polish (Week 3)
7. Main menu
8. Settings menu
9. Level completion (exit door)
10. Bug fixes and testing

---

## 17. Appendices

### A. Controls Reference
- **Move Left:** Left Arrow
- **Move Right:** Right Arrow
- **Jump:** Space key
- **Sword Attack:** Enter key

### B. Audio Design
**Sound Effects:**
- jump.wav - Player jump
- coin.wav - Coin collection
- hurt.wav - Player takes damage
- power_up.wav - Fruit collection
- explosion.wav - Enemy death (optional)
- tap.wav - UI interaction

**Background Music:**
- time_for_adventure.mp3 - Loop continuously during gameplay

### C. Asset Specifications
**Sprites (all pixel art, nearest neighbor filtering):**
- knight.png - 32x32 per frame, 4-frame idle animation (8fps)
- coin.png - Collectible coin
- fruit.png - Collectible fruit
- slime_green.png - 24x24 per frame, 4-frame animation (8fps)
- slime_purple.png - Purple variant (same specs)
- platforms.png - Platform tiles
- world_tileset.png - World tilemap

**Fonts:**
- PixelOperator8.ttf - Main UI font
- PixelOperator8-Bold.ttf - Emphasis text

### D. Level Design Specifications
- **Main Scene:** scenes/game.tscn
- **Camera:** 4x zoom, limit_bottom=120, smoothing enabled
- **TileMap:** Custom tileset with physics collisions
- **Platforms:** Static and animated (horizontal movement, 2s loop)
- **Coins:** 5 placed in level
- **Slimes:** 1+ placed enemies
- **Exit Door:** Level completion trigger (to be added)

### E. Known Issues & Missing Features

**Critical Missing (Block Gameplay):**
- No health/lives system (instant death only)
- No enemy AI (slimes are static)
- No combat mechanics (can't defeat enemies)
- No audio playback (all sounds silent)
- No UI/HUD elements

**Important Missing (Affects UX):**
- No main menu (game starts immediately)
- No level completion (no win condition)
- No inventory system
- No settings

**Minor Issues:**
- Coins print to console instead of updating score
- Death just reloads scene (no lives tracking)
- Player has no attack animation

### F. Technical Implementation Notes

**Player Script (scripts/player.gd):**
- Currently: Movement + jump only
- Needs: Health tracking, lives tracking, sword attack, invincibility frames, damage handling

**Coin Script (scripts/coin.gd):**
- Currently: Prints "+1" and removes coin
- Needs: Play sound, update global coin counter

**Kill Zone Script (scripts/kill_zone.gd):**
- Currently: Reloads scene on timer
- Needs: Integrate with health/lives system instead of direct reload

**New Scripts Needed:**
- scripts/slime.gd - Enemy AI (patrol, chase, death)
- scripts/game_manager.gd - Global state (lives, coins, fruits)
- scripts/audio_manager.gd - Sound playback
- scripts/ui/hud.gd - HUD display
- scripts/ui/inventory.gd - Inventory screen
- scripts/ui/main_menu.gd - Main menu
- scripts/ui/settings.gd - Settings menu
- scripts/exit_door.gd - Level completion trigger

---

**Document Status:** Complete - Ready for implementation  
**Last Updated:** March 21, 2026  
**Next Steps:** Begin Phase 1 implementation (Health & Lives system)
