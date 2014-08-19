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

echo -e "--------------------[\e[01;34;37mBUILD RUNNING\e[0m]--------------------"

$FUSE -intstyle ise \
      -incremental \
      -lib secureip \
      -o $TOP_MODULE-isim.exe \
      -prj $MANIFEST $TOP_MODULE

if [ $? -eq 0 ]; then
    echo -e "--------------------[\e[01;32mBUILD SUCCESS\e[0m]--------------------"
else
    echo -e "--------------------[\e[01;31mBUILD  FAILED\e[0m]--------------------"
    exit
fi

echo -e "--------------------[\e[01;34;37mSIMULATE RUNNING\e[0m]--------------------"

SIMNAME="./$TOP_MODULE-isim.exe"
WAVESDB="$SIMNAME.wdb"

$SIMNAME -intstyle ise SIM_ARGS

if [ $? -eq 0 ]; then
    echo -e "--------------------[\e[01;32mSIMULATE SUCCESS\e[0m]--------------------"
    echo "Waves available at: $WAVESDB"
else
    echo -e "--------------------[\e[01;31mSIMULATE  FAILED\e[0m]--------------------"
    exit
fi

cd ..