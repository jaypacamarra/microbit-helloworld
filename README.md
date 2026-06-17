# Microbit Hello World

This repository can be used as a reference for people trying to learn
how to program the microbit with zephyr. It contains a collection of reference
applications that demonstrate the usage of the LED matrix, buttons, and
various exposed peripherals on the microbit.

## Hardware

You can learn more about the microbit hardware in the official docs: 
[microbit documentation](https://microbit.org/get-started/user-guide/introduction/).

## Getting Started

1. Follow the getting started steps from the Zephyr documentation, [Getting
   Started](https://docs.zephyrproject.org/latest/develop/getting_started/index.html).

2. Clone this repository in the zephyr rtos workspace you have created.

3. Build the reference application of your choice.

```bash
west build -b bbc_microbit samples/helloworld
```

4. Flash the application to your microbit board.

```bash
west flash samples/helloworld
```
