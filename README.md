# ggj-2023-roots-one - shRooter

Game Plan

- [x] Left-right / Top-down
- [x] SpaceShip/Hirn ist Spieler
- [ ] Geile Hintergrundgrafiken
    - [x] Nebel
    - [x] Sterne
    - [ ] Kometen
    - [ ] Explosionen
- [x] Mathematische Wurzeln sind Gegner -> fliegen auf den Spieler zu
    - [ ] ansteigender Schwierigkeitsgrad (Sqrt 1-100, Sqrt 100-1000, Geschwindigkeit...)
    - [ ] Idee von Patrick: Wurzeln die der User oft genug richtig gelöst hat, werden vom Schiff automatisch markiert als gute Wurzeln
- [ ] ~~Bewegung auf einer Linie~~
- [x] böse Wurzeln abschießen
- [x] Leben verlieren, wenn die Wurzeln bestimmte Linie überschreiten oder falsche Wurzeln getroffen oder Schiff
  kollidiert
- [ ] (Ergebnis der Wurzel ist prozentualer Schaden von Max HP)
- [x] getroffene Wurzeln lassen Ergebnis zurück

The roots of all evil

- MainMenu
- Game / Level
    - BackgroundLayer
    - InterfaceLayer
        - HealthBar
        - Score
        - GameTime
        - HUD oben mit Leben und Score
        - HUD unten evtl. leer
        - (Ammo)
    - Player : KinematicBody2D
        - Sprite2D
        - ColissionShape2D
    - Enemies
    - Main Menu

# Chat GPT Ideen zu unserem Spiel

## provide a game idea for a space side scrolling game where a spaceship shoots on mathematic roots

In this side-scrolling space shooter, players control a spaceship that must navigate through an asteroid field while
shooting at various math-based enemies. The enemies take the form of roots, such as square roots and cube roots, and
they are constantly approaching the player's ship. To defeat them, players must use their laser weapons to shoot at the
roots and reduce them to their simplified form. For example, to defeat a square root, players must shoot it until it
becomes a 1. As they progress through the levels, the roots become increasingly complex and difficult to defeat.
Power-ups and upgrades can be collected along the way to help the player's ship become stronger and more equipped to
handle the challenges ahead. The goal of the game is to reach the end of the asteroid field and defeat the final boss,
which takes the form of an extremely complex root.

## now make the game about solving roots in year head

In this side-scrolling space adventure, players control a spaceship that is traveling through the year head to solve
various math-based roots. The roots appear as obstacles in the player's path, and they must be solved to clear the way
and progress through the levels. To solve a root, players must use their onboard computer to input the correct solution.
The roots start out simple, but as the player advances through the levels, they become increasingly complex and
challenging. Along the way, players can collect power-ups that enhance their ship's abilities and help them solve the
roots more quickly. The ultimate goal of the game is to reach the end of the year head and solve the final root, which
is the most difficult one of all. With fast-paced gameplay, challenging puzzles, and a futuristic setting, this game is
sure to provide hours of entertainment for fans of math and space exploration.
