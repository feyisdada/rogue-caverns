# Rogue Caverns

An endless 2D platformer built in GDScript (Godot). Climb as high as you can, collect coins, and beat your best height.

<img width="288" height="177" alt="start screen" src="https://github.com/user-attachments/assets/1a4a5f4a-0b54-4476-994f-df516cd70e84" />


## Gameplay

<img width="256" height="192" alt="gameplay" src="https://github.com/user-attachments/assets/073b4564-692f-41bb-b1f4-029dd6dcb1b9" />


## Features

- **Procedural level generation:** platforms generate continuously as you climb, so every run is different
- **Reachability check:** every platform is placed within jumping distance
- **Scaling difficulty:** the further you climb, the harder the platform placement gets
- **Random coin spawning:** coins appear on platforms with a set probability
- **HUD:** shows current height, coins and best height
- **Pause menu:** pause and resume with Esc
- **Saved best score:** best height is stored in a JSON file between sessions

<img width="112" height="64" alt="HUD" src="https://github.com/user-attachments/assets/d4081b01-d981-4429-b635-1af181189830" />



## How It Works

### Level generation

The game keeps 6 rows of platforms generated above the player at all times. As the player climbs, new rows are created at the top and platforms far below are deleted to save memory. Each platform gets a random length and x position, and coins spawn on its tiles with a 15% chance.

<img width="495" height="628" alt="Level generation 1/3" src="https://github.com/user-attachments/assets/e6196856-2c88-4889-bf9c-93f6f61a407a" /><br>
<img width="452" height="570" alt="Level generation 2/3" src="https://github.com/user-attachments/assets/5ff7a022-ca46-470a-a13b-11407323e173" /><br>
<img width="223" height="78" alt="Level generation 3/3" src="https://github.com/user-attachments/assets/dcf518f3-03d0-4a12-9e0a-e95301028d9b" />





<img width="452" height="410" alt="Level generation pseudocode" src="https://github.com/user-attachments/assets/f4c57a83-2516-4a7b-9017-3febfd594870" />



### Reachability check

For each new platform, the generator picks a random x position and measures the horizontal gap between its edges and the edges of the previous platform. If the smallest gap is within `MAX_EDGE_GAP`, the position is accepted. Otherwise it tries again, up to 10 times. If every attempt fails, it falls back to placing the platform right next to the previous one, so the game never gets stuck and a jump is always possible.

### Saving the best score

When a run ends, the game compares your height to the saved best and only overwrites it if you beat it. The best height is written to a JSON file with `save_game()` and loaded when the game launches.

<img width="221" height="591" alt="Save system flowchart" src="https://github.com/user-attachments/assets/e51bea39-f1e8-4deb-b9a8-d274e9e878d6" />


## Controls

| Action | Key |
|--------|-----|
| Move left | A |
| Move right | D |
| Jump | Space |
| Pause | Esc |

## What I Learned

Early on, some platforms spawned too far apart and made levels impossible. I found this through reachability testing and fixed it by adding a maximum edge gap and a fallback placement. After that, 50+ rows generated with no impossible jumps.

## Author

Feyisayo Dada
