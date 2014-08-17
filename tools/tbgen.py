#! /usr/bin/python
"""
Usage: tbgen.py <design_name>

    This is a very simple python script which, when given a module name, will generate
    a simple testbench for it and save the file to src/test/
"""

import sys
import os
import re
from docopt import docopt

TESTBENCH_TEMPLATE_NAME = "testbench.template.vhd"


class TestBenchGenerator(object):
    def __init__(self, dut):
        self.dut_module_name = dut
        self.tb_module_name     = self.get_tb_module_name()
        self.tb_file_name       = self.get_tb_file_name()
        self.dut_file_name      = self.get_dut_file_name()
        self.template_file_name = self.get_template_file_name()
        self.tb_contents = ""

        self.check_environment()
        print("Creating testbench file: " + self.tb_file_name)
        self.make_testbench()

    def make_testbench(self):
        self.load_template()
        self.load_dut_file()
        self.substitute_tb_module_name()
        self.substitute_tb_filename()
        self.substitute_port_contents()
        self.write_testbench()

    def load_dut_file(self):
        with open(self.dut_file_name, "r") as dut_file:
            self.dut_file_contents = dut_file.read()

    def substitute_tb_module_name(self):
        self.tb_contents = self.tb_contents.replace("<TB_MODULE_NAME>", self.tb_module_name)

    def substitute_tb_filename(self):
        self.tb_contents = self.tb_contents.replace("<FILENAME>", self.tb_module_name + ".vhd")

    def substitute_port_contents(self):
        ports_re = r"entity %s .*end entity %s;" % (self.dut_module_name, self.dut_module_name)
        component_ports_found = re.search(ports_re, self.dut_file_contents, re.S | re.I)
        component_ports = component_ports_found.group().replace("entity", "component")
        component_declaration = component_ports.replace("\n", "\n   ")
        self.tb_contents = self.tb_contents.replace("<DUT_COMPONENT>", component_declaration)

    def load_template(self):
        with open(self.template_file_name, "r") as template_file:
            self.tb_contents = template_file.read()
        template_file.close()

    def test_bench_exists(self):
        return file_exists(self.tb_file_name)

    def design_doesnt_exist(self):
        return not file_exists(self.dut_file_name)

    def template_doesnt_exist(self):
        return not file_exists(self.template_file_name)


    def get_tb_module_name(self):
        return self.dut_module_name + "_tb"

    def get_tb_file_name(self):
        return os.path.join("src", "test", self.tb_module_name + ".vhd")

    def get_dut_file_name(self):
        return os.path.join("src", "rtl", self.dut_module_name + ".vhd")

    def get_template_file_name(self):
        return os.path.join("src", TESTBENCH_TEMPLATE_NAME)

    def check_environment(self):
        if self.test_bench_exists():
            raise TestBenchAlreadyExistsError("The testbench file '%s' already exists!" % self.tb_file_name)

        if self.design_doesnt_exist():
            raise DesignUnderTestAlreadyExistsError("The dut file '%s' does not exist!" % self.dut_file_name)

        if self.template_doesnt_exist():
            raise TemplateDoesNotExistError("The template file '%s' does not exist!" % self.template_file_name)

    def write_testbench(self):
        with open(self.tb_file_name, "w") as tb_file:
            tb_file.write(self.tb_contents)


class TestBenchAlreadyExistsError(Exception):
    pass


class DesignUnderTestAlreadyExistsError(Exception):
    pass


class TemplateDoesNotExistError(Exception):
    pass


def file_exists(file_name):
    return os.path.isfile(file_name)

def parse_arguments(arguments):
    return arguments['<design_name>']


if __name__ == "__main__":
    arguments = docopt(__doc__)
    dut = parse_arguments(arguments)
    TestBenchGenerator(dut)

else:
    print("Imported:" + __name__)