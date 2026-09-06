# Guardian Rover

A MATLAB/Simulink obstacle-avoidance control system for a simple rover. The model takes distance readings from three directions (front, left, right) and turns them into a drive command and speed output, entirely in simulation.

## Overview

Guardian Rover simulates the decision-making logic of a rover that needs to react to obstacles on its front, left, and right sides. The project focuses on signal processing, debounced obstacle detection, rule-based decision logic, and safety/emergency handling — all built and tested inside Simulink, with a companion MATLAB App for interactive testing.

## Features

- **Sensor processing** — Front/Left/Right sensor voltages are gain-calibrated and processed into structured bus signals (distance value + "close" flag per sensor).
- **Obstacle detection** — The three "close" flags are combined with a logical OR into a raw obstacle signal.
- **Debounce filtering** — The raw obstacle signal passes through a custom MATLAB S-Function (`DebounceFilter`) to avoid reacting to noisy, momentary readings.
- **Decision logic** — A MATLAB Function block (`DecideRobotState`) maps front/left/right distances and the debounced obstacle flag into one of five states:
  - `IDLE`
  - `FORWARD`
  - `TURN LEFT`
  - `TURN RIGHT`
  - `STOP`
- **State routing** — A Switch Case structure routes the active state to dedicated subsystems, recombined into a single state output.
- **Command & speed generation** — Each state drives a corresponding command string and a saturated speed value (0–100).
- **Emergency latch** — A push-button trigger can force-override the state machine straight to `STOP`, regardless of sensor readings, until reset.
- **Scheduled diagnostics** — A 100 ms diagnostics subsystem tracks the active sensor's distance and maintains a running counter.
- **Logging** — Final state and front distance are logged to the workspace for inspection after each run.

## MATLAB App (`project_test.mlapp`)

A small companion app built with App Designer that runs the Simulink simulation directly:

- Adjusts the **front sensor's gain calibration** via a slider.
- Runs the simulation with `simulink.Simulation` / `uisimcontrols` / `uisimprogress`.
- Plots the **live front distance signal** on a time scope.
- Displays the **final state** reached at the end of each run.

## Repository Contents

| File | Description |
|---|---|
| `Robot_Project.slx` | Main Simulink model containing the sensor processing, decision logic, and diagnostics. |
| `project_test.mlapp` | MATLAB App for interactive testing and visualization of the front sensor path. |

## Requirements

- MATLAB
- Simulink
- Stateflow (used by the embedded MATLAB Function block)

## Usage

1. Open `Robot_Project.slx` in Simulink and run the simulation to see the state, command, and speed outputs.
2. Open `project_test.mlapp` in App Designer (or run it) to interactively adjust the front sensor gain and observe the resulting front distance and final state.

## Status

This project is currently simulation-only — it has not been deployed to physical hardware. It serves as a foundation for future work, such as hardware integration or expanded sensor logic.

## License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.
