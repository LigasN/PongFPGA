# TCL File Generated by Component Editor 18.1
# Sun Oct 18 23:00:24 CEST 2020
# DO NOT MODIFY


# 
# HDMIDriver_mono_1b "HDMIDriver monochromatic 1b" v1.0
# Norbert Ligas (with help from "Systemy embedded w FPGA") 2020.10.18.23:00:24
# HDMIDriver with monochromatic colors in 1b depth
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module HDMIDriver_mono_1b
# 
set_module_property DESCRIPTION "HDMIDriver with monochromatic colors in 1b depth"
set_module_property NAME HDMIDriver_mono_1b
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP HDMI
set_module_property AUTHOR "Norbert Ligas (with help from \"Systemy embedded w FPGA\")"
set_module_property ICON_PATH ../../Assets/HDMI_mono_1b.jpg
set_module_property DISPLAY_NAME "HDMIDriver monochromatic 1b"
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL HDMIDriver
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file HDMIDriver.vhd VHDL PATH HDMIDriver.vhd TOP_LEVEL_FILE
add_fileset_file LVDS.v VERILOG PATH LVDS.v
add_fileset_file TMDS.vhd VHDL PATH TMDS.vhd

add_fileset SIM_VERILOG SIM_VERILOG "" ""
set_fileset_property SIM_VERILOG TOP_LEVEL HDMIDriver
set_fileset_property SIM_VERILOG ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VERILOG ENABLE_FILE_OVERWRITE_MODE true
add_fileset_file HDMIDriver.vhd VHDL PATH HDMIDriver.vhd
add_fileset_file LVDS.v VERILOG PATH LVDS.v
add_fileset_file TMDS.vhd VHDL PATH TMDS.vhd

add_fileset SIM_VHDL SIM_VHDL "" ""
set_fileset_property SIM_VHDL TOP_LEVEL HDMIDriver
set_fileset_property SIM_VHDL ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VHDL ENABLE_FILE_OVERWRITE_MODE true
add_fileset_file HDMIDriver.vhd VHDL PATH HDMIDriver.vhd
add_fileset_file LVDS.v VERILOG PATH LVDS.v
add_fileset_file TMDS.vhd VHDL PATH TMDS.vhd


# 
# parameters
# 
add_parameter DISPLAY_RES_WIDTH INTEGER 640
set_parameter_property DISPLAY_RES_WIDTH DEFAULT_VALUE 640
set_parameter_property DISPLAY_RES_WIDTH DISPLAY_NAME DISPLAY_RES_WIDTH
set_parameter_property DISPLAY_RES_WIDTH TYPE INTEGER
set_parameter_property DISPLAY_RES_WIDTH UNITS None
set_parameter_property DISPLAY_RES_WIDTH ALLOWED_RANGES -2147483648:2147483647
set_parameter_property DISPLAY_RES_WIDTH HDL_PARAMETER true
add_parameter DISPLAY_RES_HEIGHT INTEGER 480
set_parameter_property DISPLAY_RES_HEIGHT DEFAULT_VALUE 480
set_parameter_property DISPLAY_RES_HEIGHT DISPLAY_NAME DISPLAY_RES_HEIGHT
set_parameter_property DISPLAY_RES_HEIGHT TYPE INTEGER
set_parameter_property DISPLAY_RES_HEIGHT UNITS None
set_parameter_property DISPLAY_RES_HEIGHT ALLOWED_RANGES -2147483648:2147483647
set_parameter_property DISPLAY_RES_HEIGHT HDL_PARAMETER true
add_parameter PX_FRONT_PORCH INTEGER 16
set_parameter_property PX_FRONT_PORCH DEFAULT_VALUE 16
set_parameter_property PX_FRONT_PORCH DISPLAY_NAME PX_FRONT_PORCH
set_parameter_property PX_FRONT_PORCH TYPE INTEGER
set_parameter_property PX_FRONT_PORCH UNITS None
set_parameter_property PX_FRONT_PORCH ALLOWED_RANGES -2147483648:2147483647
set_parameter_property PX_FRONT_PORCH HDL_PARAMETER true
add_parameter PX_SYNC_PULSE INTEGER 96
set_parameter_property PX_SYNC_PULSE DEFAULT_VALUE 96
set_parameter_property PX_SYNC_PULSE DISPLAY_NAME PX_SYNC_PULSE
set_parameter_property PX_SYNC_PULSE TYPE INTEGER
set_parameter_property PX_SYNC_PULSE UNITS None
set_parameter_property PX_SYNC_PULSE ALLOWED_RANGES -2147483648:2147483647
set_parameter_property PX_SYNC_PULSE HDL_PARAMETER true
add_parameter PX_BACK_PORCH INTEGER 48
set_parameter_property PX_BACK_PORCH DEFAULT_VALUE 48
set_parameter_property PX_BACK_PORCH DISPLAY_NAME PX_BACK_PORCH
set_parameter_property PX_BACK_PORCH TYPE INTEGER
set_parameter_property PX_BACK_PORCH UNITS None
set_parameter_property PX_BACK_PORCH ALLOWED_RANGES -2147483648:2147483647
set_parameter_property PX_BACK_PORCH HDL_PARAMETER true
add_parameter ROW_FRONT_PORCH INTEGER 10
set_parameter_property ROW_FRONT_PORCH DEFAULT_VALUE 10
set_parameter_property ROW_FRONT_PORCH DISPLAY_NAME ROW_FRONT_PORCH
set_parameter_property ROW_FRONT_PORCH TYPE INTEGER
set_parameter_property ROW_FRONT_PORCH UNITS None
set_parameter_property ROW_FRONT_PORCH ALLOWED_RANGES -2147483648:2147483647
set_parameter_property ROW_FRONT_PORCH HDL_PARAMETER true
add_parameter ROW_SYNC_PULSE INTEGER 2
set_parameter_property ROW_SYNC_PULSE DEFAULT_VALUE 2
set_parameter_property ROW_SYNC_PULSE DISPLAY_NAME ROW_SYNC_PULSE
set_parameter_property ROW_SYNC_PULSE TYPE INTEGER
set_parameter_property ROW_SYNC_PULSE UNITS None
set_parameter_property ROW_SYNC_PULSE ALLOWED_RANGES -2147483648:2147483647
set_parameter_property ROW_SYNC_PULSE HDL_PARAMETER true
add_parameter ROW_BACK_PORCH INTEGER 33
set_parameter_property ROW_BACK_PORCH DEFAULT_VALUE 33
set_parameter_property ROW_BACK_PORCH DISPLAY_NAME ROW_BACK_PORCH
set_parameter_property ROW_BACK_PORCH TYPE INTEGER
set_parameter_property ROW_BACK_PORCH UNITS None
set_parameter_property ROW_BACK_PORCH ALLOWED_RANGES -2147483648:2147483647
set_parameter_property ROW_BACK_PORCH HDL_PARAMETER true


# 
# display items
# 


# 
# connection point clock
# 
add_interface clock clock end
set_interface_property clock clockRate 0
set_interface_property clock ENABLED true
set_interface_property clock EXPORT_OF ""
set_interface_property clock PORT_NAME_MAP ""
set_interface_property clock CMSIS_SVD_VARIABLES ""
set_interface_property clock SVD_ADDRESS_GROUP ""

add_interface_port clock clk clk Input 1


# 
# connection point px_address
# 
add_interface px_address conduit end
set_interface_property px_address associatedClock clock
set_interface_property px_address associatedReset ""
set_interface_property px_address ENABLED true
set_interface_property px_address EXPORT_OF ""
set_interface_property px_address PORT_NAME_MAP ""
set_interface_property px_address CMSIS_SVD_VARIABLES ""
set_interface_property px_address SVD_ADDRESS_GROUP ""

add_interface_port px_address px_x px_x Output 13
add_interface_port px_address px_y px_y Output 13


# 
# connection point hdmi_clk
# 
add_interface hdmi_clk clock end
set_interface_property hdmi_clk clockRate 0
set_interface_property hdmi_clk ENABLED true
set_interface_property hdmi_clk EXPORT_OF ""
set_interface_property hdmi_clk PORT_NAME_MAP ""
set_interface_property hdmi_clk CMSIS_SVD_VARIABLES ""
set_interface_property hdmi_clk SVD_ADDRESS_GROUP ""

add_interface_port hdmi_clk HDMI_clk clk Input 1


# 
# connection point hdmi
# 
add_interface hdmi conduit end
set_interface_property hdmi associatedClock clock
set_interface_property hdmi associatedReset ""
set_interface_property hdmi ENABLED true
set_interface_property hdmi EXPORT_OF ""
set_interface_property hdmi PORT_NAME_MAP ""
set_interface_property hdmi CMSIS_SVD_VARIABLES ""
set_interface_property hdmi SVD_ADDRESS_GROUP ""

add_interface_port hdmi output_clk output_clk Output 1
add_interface_port hdmi output_data output_data Output 3


# 
# connection point px_color
# 
add_interface px_color conduit end
set_interface_property px_color associatedClock clock
set_interface_property px_color associatedReset ""
set_interface_property px_color ENABLED true
set_interface_property px_color EXPORT_OF ""
set_interface_property px_color PORT_NAME_MAP ""
set_interface_property px_color CMSIS_SVD_VARIABLES ""
set_interface_property px_color SVD_ADDRESS_GROUP ""

add_interface_port px_color px_color px_color Input 1
