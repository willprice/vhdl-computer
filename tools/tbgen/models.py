# -*- coding: utf-8 -*-
import os
import re

from tbgen.util import file_exists, indent_string

class VhdlObject(object):
    pass

class TB(VhdlObject):
    """
    First should be instantiated and the the attribute `contents` set to that of the TB.
    Once that is done you can `write_testbench()` on it.
    """
    def __init__(self, dut, dir_path, contents, suffix="_tb"):
        self.dut = dut
        self.name = self.generate_name(suffix)
        self.file_name = self.name + ".vhd"
        self.file_path = self.generate_file_path(dir_path)
        self.check()

    def generate_file_path(self, dir_path):
        return os.path.join(dir_path, "test", self.file_name)

    def generate_name(self, suffix):
        return self.dut.name + suffix

    def exists(self):
        return file_exists(self.file_path)

    def write_testbench(self):
        with open(self.file_path, "w") as file:
            file.write(self.contents)

    def check(self):
        if self.exists():
            raise TestBenchAlreadyExistsError("The testbench file '%s' already exists!" % self.tb_file_path)


class DUT(VhdlObject):
    def __init__(self, name, dir_path):
        self.name = name
        self.file_path = self.get_file_path(dir_path)
        self.contents = self.load()
        self.component = self.parse_components()

    def get_file_path(self, dir_path):
        return os.path.join(dir_path, self.name + ".vhd")

    def load(self):
        with open(self.file_path, "r") as dut_file:
            return dut_file.read()

    def parse_components(self):
        ports_re = "entity %s is.*end entity %s;" % (self.name, self.name)
        component_ports_found = re.search(ports_re, self.contents, flags=(re.DOTALL | re.IGNORECASE))
        if component_ports_found:
            component_ports = component_ports_found.group()
            component_ports = component_ports.replace("entity", "component")
            component_declaration = indent_string(component_ports)
            return component_declaration


class TestBenchAlreadyExistsError(Exception):
    pass
