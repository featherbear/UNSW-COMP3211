+++
categories = ["Labs"]
date = 2021-02-22T13:19:36Z
draft = true
hiddenFromHomePage = false
postMetaInFooter = false
title = "Vivado - Quick Start Notes"
[flowchartDiagrams]
enable = false
options = ""
[sequenceDiagrams]
enable = false
options = ""

+++
Using `Vivado 2020.2`

## Create A Project

* **\[Quick Start\] Create Project**
* Create an **RTL Project**
* Target Language: **VHDL**
* Simulator Language: **VHDL**
* Xilinx part: **xc7a100tftg256-3**

## Add VHDL Files

* **\[Flow Navigator\] \[Project Manager\] Add Sources**
* **Add or create design sources**
* To create a new file
  * **\[Create File\]**
  * Will automatically append `.vhd`
* To add an existing file
  * **\[Add Files\]**

## I/O Port Definitions

* Port Name - name of the port
* Direction - purpose of the port (either in / out / inout)
* Bus - whether or not the port has several wires

## Testbench

* **\[Flow Navigator\] \[Project Manager\] Add Sources**
* **Add or create simulation sources**