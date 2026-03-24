# Development Tasks

**Project:** 2D Platformer Game  
**Goal:** Divide work into independent modules for parallel development

---

## Task Structure

Each task is **independent** and can be developed in isolation. Dependencies are clearly marked.

**Task Format:**
- **ID:** Unique identifier
- **Owner:** Team/Developer
- **Dependencies:** What must be completed first
- **Deliverables:** What to create
- **Integration:** How to connect with other modules

---

## Phase 1: Core Systems (No Dependencies)

### TASK-001: Game Manager
**Owner:** Backend Team  
**Dependencies:** None  
**Deliverables:**
- Create `scripts/game_manager.gd` (Autoload singleton)
- Global variables: `health`, `lives`, `coins`, `fruits`
- Functions: `take_damage()`, `add_coin()`, `add_fruit()`, `reset_stats()`

**Integration Points:**
```gdscript
# Other scripts will use:
GameManager.health
GameManager.lives
GameManager.coins
GameManager.take_damage()
```

**Testing:** Create test scene, call functions, verify values update

---

### TASK-002: Audio Manager
**Owner:** Audio Team  
**Dependencies:** None  
**Deliverables:**
- Create `scripts/audio_manager.gd` (Autoload singleton)
- Load all sound files from `assets/sounds/`
- Load music from `assets/music/`
- Functions: `play_jump()`, `play_coin()`, `play_hurt()`, `play_sword()`, `play_powerup()`, `play_music()`
- Volume control: `set_music_volume(value)`, `set_sfx_volume(value)`

**Integration Points:**
```gdscript
# Other scripts will use:
AudioManager.play_jump()
AudioManager.play_coin()
AudioManager.set_music_volume(0.5)
```

**Testing:** Call each play function, verify sounds play

---

### TASK-003: Main Menu UI
**Owner:** UI Team  
**Dependencies:** None  
**Deliverables:**
- Create `scenes/main_menu.tscn`
- Buttons: Play, Settings, Quit
- Connect Play → `get_tree().change_scene_to_file("res://scenes/game.tscn")`
- Connect Quit → `get_tree().quit()`
- Connect Settings → Open settings scene

**Integration Points:**
- None (standalone)
- Update `project.godot` to set main_menu.tscn as entry point

**Testing:** Run scene, click buttons, verify navigation

---

### TASK-004: Settings Menu UI
**Owner:** UI Team  
**Dependencies:** TASK-002 (Audio Manager)  
**Deliverables:**
- Create `scenes/settings_menu.tscn`
- Sliders: Music Volume, SFX Volume
- Buttons: Controls Remapping (placeholder), Fullscreen Toggle
- Back button → Return to main menu
- Connect sliders to `AudioManager.set_music_volume()`, `AudioManager.set_sfx_volume()`

**Integration Points:**
```gdscript
# Slider signals:
AudioManager.set_music_volume(value)
AudioManager.set_sfx_volume(value)
```

**Testing:** Adjust sliders, verify volume changes

---

## Phase 2: Gameplay Systems (Depend on Phase 1)

### TASK-005: Player Health & Lives
**Owner:** Gameplay Team  
**Dependencies:** TASK-001 (Game Manager)  
**Deliverables:**
- Update `scripts/player.gd`
- Add health tracking (connect to GameManager.health)
- Add lives tracking (connect to GameManager.lives)
- Implement damage handling: reduce health, check for death
- Implement respawn: reload scene if lives > 0, else go to main menu
- Add invincibility timer after damage (1-2 seconds)

**Integration Points:**
```gdscript
# In player.gd:
func take_damage():
    if not invincible:
        GameManager.take_damage()
        # Start invincibility frames
        
func _check_death():
    if GameManager.health <= 0:
        GameManager.lives -= 1
        if GameManager.lives > 0:
            GameManager.reset_stats()
            get_tree().reload_current_scene()
        else:
            get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
```

**Testing:** Take damage, verify health decreases, verify respawn, verify game over

---

### TASK-006: Player Combat System
**Owner:** Gameplay Team  
**Dependencies:** TASK-001 (Game Manager), TASK-002 (Audio Manager)  
**Deliverables:**
- Update `scripts/player.gd`
- Add sword attack: Enter key triggers attack animation + hitbox
- Add sword hitbox (Area2D child node)
- Detect enemy collision in hitbox → call `enemy.die()`
- Add jump-on-enemy detection: if velocity.y > 0 and touching enemy head → call `enemy.die()`
- Play `AudioManager.play_sword()` on attack

**Integration Points:**
```gdscript
# In player.gd sword hitbox signal:
func _on_sword_hitbox_body_entered(body):
    if body.has_method("die"):
        body.die()

# Jump kill detection:
func _physics_process():
    for collision in get_slide_collision_count():
        var collider = get_slide_collision(collision).get_collider()
        if collider.is_in_group("enemy") and velocity.y > 0:
            collider.die()
            velocity.y = JUMP_VELOCITY * 0.7  # Bounce
```

**Testing:** Attack enemy, jump on enemy, verify enemy dies

---

### TASK-007: Enemy AI System
**Owner:** AI Team  
**Dependencies:** TASK-001 (Game Manager)  
**Deliverables:**
- Create `scripts/slime.gd`
- State machine: PATROL, CHASE, DEAD
- Patrol logic: Detect platform edges (RayCast2D), move back/forth
- Chase logic: Detect player in 150px radius (Area2D), move toward player
- Speed variants: Green = 50, Purple = 80
- `die()` function: Play death animation, queue_free()
- Add slimes to "enemy" group

**Integration Points:**
```gdscript
# In slime.gd:
enum State { PATROL, CHASE, DEAD }

func die():
    state = State.DEAD
    # Play death animation
    queue_free()

# Player will call: slime.die()
```

**Testing:** Place slime in scene, verify patrol, verify chase, verify death

---

### TASK-008: Coin Collection System
**Owner:** Gameplay Team  
**Dependencies:** TASK-001 (Game Manager), TASK-002 (Audio Manager)  
**Deliverables:**
- Update `scripts/coin.gd`
- Replace print with `GameManager.coins += 1`
- Add `AudioManager.play_coin()` call
- Update existing coins in game.tscn

**Integration Points:**
```gdscript
# In coin.gd:
func _on_body_entered(body):
    if body.name == "Player":
        GameManager.coins += 1
        AudioManager.play_coin()
        queue_free()
```

**Testing:** Collect coins, verify counter increases, verify sound plays

---

### TASK-009: Fruit Collection System
**Owner:** Gameplay Team  
**Dependencies:** TASK-001 (Game Manager), TASK-002 (Audio Manager)  
**Deliverables:**
- Create `scripts/fruit.gd`
- Similar to coin: Add to `GameManager.fruits` array
- Play `AudioManager.play_powerup()`
- Create `scenes/fruit.tscn`
- Place fruits in game.tscn

**Integration Points:**
```gdscript
# In fruit.gd:
func _on_body_entered(body):
    if body.name == "Player":
        GameManager.fruits.append("fruit")
        AudioManager.play_powerup()
        queue_free()
```

**Testing:** Collect fruits, verify array updates, verify sound plays

---

### TASK-010: Kill Zone Integration
**Owner:** Gameplay Team  
**Dependencies:** TASK-001 (Game Manager), TASK-005 (Player Health)  
**Deliverables:**
- Update `scripts/kill_zone.gd`
- Replace direct reload with player damage call
- Call player's `take_damage()` 3 times (instant death)

**Integration Points:**
```gdscript
# In kill_zone.gd:
func _on_body_entered(body):
    if body.name == "Player":
        # Instant death - reduce all health
        for i in range(3):
            body.take_damage()
```

**Testing:** Fall into kill zone, verify instant death, verify respawn

---

## Phase 3: UI Systems (Depend on Phase 1 & 2)

### TASK-011: HUD Display
**Owner:** UI Team  
**Dependencies:** TASK-001 (Game Manager)  
**Deliverables:**
- Create `scenes/hud.tscn` (CanvasLayer)
- Add to game.tscn as child node
- Display: Lives (3 icons), Health (3 hearts), Coins (icon + number)
- Update in `_process()`: Read from `GameManager.lives`, `GameManager.health`, `GameManager.coins`

**Integration Points:**
```gdscript
# In hud.gd:
func _process(delta):
    lives_label.text = str(GameManager.lives)
    health_label.text = str(GameManager.health)
    coins_label.text = str(GameManager.coins)
```

**Testing:** Play game, verify HUD updates when values change

---

### TASK-012: Inventory System
**Owner:** UI Team  
**Dependencies:** TASK-001 (Game Manager), TASK-009 (Fruit Collection)  
**Deliverables:**
- Create `scripts/inventory.gd`
- Create `scenes/inventory.tscn` (popup overlay)
- Display grid of collected fruits from `GameManager.fruits`
- Add inventory button to HUD (opens overlay)
- Close button to hide overlay

**Integration Points:**
```gdscript
# In inventory.gd:
func show_inventory():
    for fruit in GameManager.fruits:
        # Add fruit icon to grid
    visible = true
```

**Testing:** Collect fruits, open inventory, verify fruits displayed

---

### TASK-013: Level Exit Door
**Owner:** Level Design Team  
**Dependencies:** None  
**Deliverables:**
- Create `scripts/exit_door.gd`
- Create `scenes/exit_door.tscn` (Area2D with sprite)
- On player enter: Print "Level Complete!" (placeholder for future levels)
- Place in game.tscn

**Integration Points:**
```gdscript
# In exit_door.gd:
func _on_body_entered(body):
    if body.name == "Player":
        print("Level Complete!")
        # Future: Load next level
```

**Testing:** Reach door, verify completion message

---

### TASK-014: Background Music
**Owner:** Audio Team  
**Dependencies:** TASK-002 (Audio Manager)  
**Deliverables:**
- Update `scripts/audio_manager.gd`
- Add `play_music()` function to loop `time_for_adventure.mp3`
- Call `AudioManager.play_music()` in game.tscn `_ready()`

**Integration Points:**
```gdscript
# In game.gd (or game scene script):
func _ready():
    AudioManager.play_music()
```

**Testing:** Start game, verify music plays and loops

---

## Parallel Development Guide

### Team A: Backend (Tasks 001, 002)
- Work on Game Manager and Audio Manager first
- These are needed by all other teams
- Can test independently with print statements

### Team B: UI (Tasks 003, 004, 011, 012)
- Start with Main Menu (no dependencies)
- Then Settings (needs Audio Manager)
- Then HUD and Inventory (need Game Manager)

### Team C: Gameplay (Tasks 005, 006, 008, 009, 010)
- Wait for Game Manager and Audio Manager
- Work on Player systems first
- Then Collectibles
- Then Kill Zone integration

### Team D: AI & Level (Tasks 007, 013, 014)
- Enemy AI needs Game Manager
- Exit door and music can start earlier
- AI can be tested with placeholder player

---

## Integration Testing Checklist

After all tasks complete:
- [ ] Start game → Main menu appears
- [ ] Click Play → Game loads, music plays
- [ ] Move player → HUD shows correct values
- [ ] Collect coin → Counter increases, sound plays
- [ ] Collect fruit → Sound plays, inventory updates
- [ ] Enemy patrol/chase → Works correctly
- [ ] Attack enemy → Enemy dies
- [ ] Jump on enemy → Enemy dies, player bounces
- [ ] Take damage → Health decreases, invincibility activates
- [ ] Lose all health → Lose life, respawn
- [ ] Lose all lives → Return to main menu
- [ ] Open inventory → Shows collected fruits
- [ ] Reach exit door → Level complete message
- [ ] Settings menu → Volume controls work

---

## Notes

- All tasks use **signals and singletons** for communication (no direct references)
- Each task can be **tested in isolation** with mock data
- **Merge conflicts minimized** - different files for each team
- **Clear interfaces** defined for integration points
- Follow **Godot best practices**: Autoload for managers, signals for events

---

**Total Tasks:** 14  
**Estimated Time:** 2-3 weeks with parallel development  
**Teams:** 4 (Backend, UI, Gameplay, AI/Level)
