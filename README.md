# FPGA Graphics Adapter

Multi-mode graphics adapter for 8 bit computers using a Cyclone 3 FPGA.

| Mode | Type | Resolution |
| ------ | ------ | ------ |
| 1 | Mono Text | 80x30 |
| 1 | Color Text | 80x30 |
| 2 | Lowres Mono Bitmap | 160x120 |
| 3 | Medres Mono Bitmap | 320x240 |
| 4 | (WIP) Hires Mono Bitmap | 640x480 |
| 5 | Lowres Color Bitmap | 160x120 |
| 6 | (WIP) Medres Color Bitmap | 320x240 |



Registers:

| Register | Name | Description |
| ------ | ------ | ------ |
| 0 | Mode | Graphics mode. See above. |
| 1 | Data | Data to be written to screen memory. Written immediately |
| 2 | Status | Unused (WIP) |
| 3 | Low Address | Low 8 bits of address. Typically X position |
| 4 | High Address | High 8 bits of address. Typically Y position |
| 5 | Command | Command to be executed. Excecuted immediately. |


Commands:

| Command | Name | Description |
| ------ | ------ | ------ |
| 0 | No Command | No command |
| 1 | Clear all | Clears all memory. Takes some time (400 us approx) |
| 2 | Clear part | Clears memory from 0 to address in 3,4 (WIP) |

Data written to register 1 is immediately written to screen memory at the address
in registers 3 and 4. When writing data, make sure the address is set before you
write the data. Commands work the same way with register 5. 