# TCL File Generated by Component Editor 18.1
# Tue Nov 03 18:20:28 CET 2020
# DO NOT MODIFY


# 
# HDMI_IMAGE_GEN_MONO_1b "HDMI image generator monochromatic 1b" v1.0
# Norbert Ligas 2020.11.03.18:20:28
# Generates image for HDMI, which looks like screensaver
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module HDMI_IMAGE_GEN_MONO_1b
# 
set_module_property DESCRIPTION "Generates image for HDMI, which looks like screensaver"
set_module_property NAME HDMI_IMAGE_GEN_MONO_1b
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP HDMI/ImageGenerators
set_module_property AUTHOR "Norbert Ligas"
set_module_property ICON_PATH ../../Assets/HDMI_mono_1b.jpg
set_module_property DISPLAY_NAME "HDMI image generator monochromatic 1b"
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL HDMIImageGenerator
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file HDMIImageGenerator.vhd VHDL PATH HDMIImageGenerator.vhd

add_fileset SIM_VERILOG SIM_VERILOG "" ""
set_fileset_property SIM_VERILOG TOP_LEVEL HDMIImageGenerator
set_fileset_property SIM_VERILOG ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VERILOG ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file HDMIImageGenerator.vhd VHDL PATH HDMIImageGenerator.vhd

add_fileset SIM_VHDL SIM_VHDL "" ""
set_fileset_property SIM_VHDL TOP_LEVEL HDMIImageGenerator
set_fileset_property SIM_VHDL ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VHDL ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file HDMIImageGenerator.vhd VHDL PATH HDMIImageGenerator.vhd


# 
# parameters
# 
add_parameter X_RES INTEGER 640 ""
set_parameter_property X_RES DEFAULT_VALUE 640
set_parameter_property X_RES DISPLAY_NAME X_RES
set_parameter_property X_RES TYPE INTEGER
set_parameter_property X_RES UNITS None
set_parameter_property X_RES ALLOWED_RANGES -2147483648:2147483647
set_parameter_property X_RES DESCRIPTION ""
set_parameter_property X_RES HDL_PARAMETER true
add_parameter Y_RES INTEGER 480 ""
set_parameter_property Y_RES DEFAULT_VALUE 480
set_parameter_property Y_RES DISPLAY_NAME Y_RES
set_parameter_property Y_RES TYPE INTEGER
set_parameter_property Y_RES UNITS None
set_parameter_property Y_RES ALLOWED_RANGES -2147483648:2147483647
set_parameter_property Y_RES DESCRIPTION ""
set_parameter_property Y_RES HDL_PARAMETER true
add_parameter REG_LEN INTEGER 200
set_parameter_property REG_LEN DEFAULT_VALUE 200
set_parameter_property REG_LEN DISPLAY_NAME REG_LEN
set_parameter_property REG_LEN TYPE INTEGER
set_parameter_property REG_LEN UNITS None
set_parameter_property REG_LEN ALLOWED_RANGES -2147483648:2147483647
set_parameter_property REG_LEN HDL_PARAMETER true
add_parameter VEL INTEGER 1 ""
set_parameter_property VEL DEFAULT_VALUE 1
set_parameter_property VEL DISPLAY_NAME VEL
set_parameter_property VEL TYPE INTEGER
set_parameter_property VEL UNITS None
set_parameter_property VEL ALLOWED_RANGES -2147483648:2147483647
set_parameter_property VEL DESCRIPTION ""
set_parameter_property VEL HDL_PARAMETER true


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

add_interface_port px_address px_x px_x Input 12
add_interface_port px_address px_y px_y Input 12


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

add_interface_port px_color px_color px_color Output 1

