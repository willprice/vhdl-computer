import os
import re
import jinja2

from tbgen.models import TB

TESTBENCH_TEMPLATE_NAME = "testbench.template.vhd"


class VHDLTemplateGenerator(object):
    def __init__(self, dut, src_path):
        self.context = {}
        self.dut = dut
        self.tb = TB(dut, src_path, None)

        self.load_template()
        self.substitute_template()
        contents = self.render_testbench()
        self.tb.contents = contents

    def load_template(self):
        path = os.path.dirname(os.path.realpath(__file__))
        env = jinja2.Environment(loader=jinja2.FileSystemLoader(os.path.join(path, 'templates')))
        self.tb_template = env.get_template('testbench.vhd')

    def substitute_template(self):
        self.context.update(
            dut=self.dut,
            tb=self.tb
        )

    def render_testbench(self):
        return self.tb_template.render(self.context)