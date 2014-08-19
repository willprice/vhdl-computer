mkdir build
cd build

echo -e "--------------------[\e[01;34;37mSYNTAX CHECK RUNNING\e[0m]--------------------"

# Xilinx Progams
VHPCOMP=/opt/Xilinx/14.7/ISE_DS/ISE/bin/lin64/vhpcomp
FUSE=/opt/Xilinx/14.7/ISE_DS/ISE/bin/lin64/fuse

# File and config Paths
MANIFEST=../src/file_list.manifest
TOP_MODULE=$1
SIM_ARGS=$2

$VHPCOMP -work work=work \
         -intstyle ise \
         -prj $MANIFEST

if [ $? -eq 0 ]; then
    echo -e "--------------------[\e[01;32mSYNTAX CHECK SUCCESS\e[0m]--------------------"
else
    echo -e "--------------------[\e[01;31mSYNTAX CHECK  FAILED\e[0m]--------------------"
    exit
fi