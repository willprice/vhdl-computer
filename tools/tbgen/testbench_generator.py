#! /usr/bin/env python2
# -*- coding: utf-8 -*-
# Do not remove the above line as it sets up python's default string type.
"""
Usage: tbgen.py <src_folder> <design_name>

    This is a very simple python script which, when given a module name, will generate
    a simple testbench for it and save the file to src/test/
"""

import os

from docopt import docopt

from tbgen.models import DUT
from tbgen.vhdl_template_generator import VHDLTemplateGenerator


class TestBenchGenerator(object):
    def __init__(self, dut, src="src"):
        self.src = src

        self.dut = DUT(dut, os.path.join(self.src, "rtl"))
        print("Creating testbench file: " + self.dut.name)
        self.tb = self.make_testbench()
        print self.tb.contents

    def make_testbench(self):
        template_generator = VHDLTemplateGenerator(self.dut, self.src)
        return template_generator.tb


def parse_arguments(arguments):
    return arguments['<src_folder>'], arguments['<design_name>']

def tbgen():
    arguments = docopt(__doc__)
    src, dut = parse_arguments(arguments)
    TestBenchGenerator(dut, src=src)

if __name__ == '__main__':
    tbgen()
