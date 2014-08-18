
echo -e "--------------------[\e[01;34;37mBUILD RUNNING\e[0m]--------------------"

VHPCOMP=/opt/Xilinx/14.7/ISE_DS/ISE/bin/lin64/vhpcomp

$VHPCOMP -work work=build/work -intstyle ise -prj src/file_list.manifest

rm fuse.xmsgs

if [ $? -eq 0 ]; then
    echo -e "--------------------[\e[01;32mBUILD SUCCESS\e[0m]--------------------"
else
    echo -e "--------------------[\e[01;31mBUILD  FAILED\e[0m]--------------------"
fi