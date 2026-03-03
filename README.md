# Microbit Hello World

This repository can be used as a reference for people trying to learn how to program
the microbit. The hello world program is built to run bare-metal.

## Hardware

Microbit v1.5
- **application processor**: `nRF51822`
- **interface processor**: `NXP KL26Z`

The **application processor** is where your user code goes while the **interface processor**
is in charge of loading your program in the application processor.

## Program

This hello world program will print a scrolling "Hello World!" message
on the 5x5 LED matrix.

There is also the two user buttons `User Button A` and `User Button B` which
will be used to decrement or increment (depending on which button you press) and 
have the updated counter value displayed on the 5x5 LED matrix momentarily.

## Dependencies

1. **Host OS** - `Ubuntu >= 22.04`. 
2. **Build utils** - `cmake`, `ninja`, `arm-gcc` toolchain, `build-essentials`.

## Building

TODO

## Flashing

TODO

## Debugging

TODO
