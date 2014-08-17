#! /usr/bin/python
"""
This is a very simple python script which, when given a module name, will generate
a simple testbench for it and save the file to src/test/
"""

import sys
import os
import getopt

def main():
    print("Simple Testbench Generator")

    # Retrieve the module name from the command line arguments list.
    if(len(sys.argv) < 2):
        print("No Module name Supplied!")
        sys.exit(1)

    dut_module_name = sys.argv[1]

    tb_module_name = dut_module_name+"_tb"
    tb_file_name = os.path.join("src","test",tb_module_name+".vhd")
    dut_file_name = os.path.join("src","rtl",dut_module_name+".vhd")
    template_file_name = os.path.join("src", "testbench_template.vhd")

    # Don't overwrite an existing file
    if(os.path.isfile(tb_file_name) == True):
        print("The testbench file '"+tb_file_name+"' Already exists!")
        return 1

    # Don't do anything if the DUT file doesnt exist.
    if(os.path.isfile(dut_file_name) == False):
        print("The dut file '"+tb_file_name+"' does not exist!")
        return 1

    # Don't do anything if the template file doesnt exist.
    if(os.path.isfile(template_file_name) == False):
        print("The template file '"+template_file_name+"' does not exist!")
        return 1

    print("Creating testbench file: "+tb_file_name)

    template_file = open(template_file_name, "r")
    tb_file = open(tb_file_name, "w")
    dut_file = open(dut_file_name, "r")

    to_write = template_file.read()
    template_file.close()

    to_write = to_write.replace("$tb_module_name$", tb_module_name)
    to_write = to_write.replace("@file", tb_module_name+".vhd")

    component_ports = ""
    component_declaration = "component "+dut_module_name+" is\n"
    component_declaration = component_declaration + component_ports+"\n   end component;"

    to_write = to_write.replace("$dut_component$", component_declaration)

    tb_file.write(to_write)

    return 0

if(__name__=="__main__"):
    result = main()
    if(result != 0):
        print("[ERROR]")
        sys.exit(1)
    else:
        print("[DONE]")

else:
    print("Imported:" + __name__)