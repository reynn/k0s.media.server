# Raspberry Pi Cluster [WIP]

Building a small [Raspberry Pi][raspberry-pi-official] cluster running a minimal Kubernetes distribution.
The components should scale to whatever level cluster you want to run.
I wanted to start with a 4 nodes as they will be attaching to an existing K3s distribution eventually.

## Components

__Prices were taken on 04/26/2021__

| Name                    | Count | Cost (USD) | Link                           |
| ----------------------- | :---: | ---------- | ------------------------------ |
| Raspberry Pi 4b 4gb     |   4   | $55        | [PiShop][pishop-raspberry-pi]  |
| 128gb SD Card           |   4   | $20        | [PiShop][pishop-large-sd-card] |
| OLED Display HAT        |   4   | $13        | [PiShop][pishop-oled-display]  |
| Ethernet Cables         |   5   | $10        | [Amazon][amz-ethernet-cable]   |
| Gigabit Switch (5 port) |   1   | $14        | [Amazon][amz-switch]           |
| USB Cables (6 in)       |   5   | $8         | [Amazon][amz-usb-hub]          |
| USB Hub (4 Ports)       |   1   | $15        | [Amazon][amz-usb-cables]       |
| ----------------------- | ----- | ---------- | ------------------------------ |
| Total                   |       | ~$400      |                                |

<!-- -->
[raspberry-pi-official]: https://www.raspberrypi.org/
[pishop-raspberry-pi]: https://www.pishop.us/product/raspberry-pi-4-model-b-4gb/
[pishop-large-sd-card]: https://www.pishop.us/product/microsd-card-ultra-128gb-class-10-a1-blank/
[pishop-oled-display]: https://www.pishop.us/product/128x64-1-3inch-oled-display-hat-for-raspberry-pi/
[amz-ethernet-cable]: https://www.amazon.com/gp/product/B06XY9B4KP/
[amz-switch]: https://www.amazon.com/gp/product/B0863M7C1L/
[amz-usb-hub]: https://www.amazon.com/gp/product/B07L32B9C2/
[amz-usb-cables]: https://www.amazon.com/gp/product/B08LL1SVZD/
