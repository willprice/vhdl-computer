# -*- coding: utf-8 -*-
# Necessary imports for pypeg2
from __future__ import unicode_literals, print_function
from pypeg2 import *


class DUTParser(object):
    def __init__(self, dut):
        self.dut = dut

    def parse(self):
        pass


class Direction(Keyword):
    grammar = Enum(Keyword('in'), Keyword('out'), Keyword('inout'), Keyword('buffer'))

# TODO: WE will eventually need to parse the file to pick up custom types etc and dynamically
#       generate this class.
class Type(Keyword):
    grammar = Enum(Keyword('std_logic'), Keyword('bit'), Keyword('std_logic_vector'))

class Parameter(Plain):
    grammar = name(), ':', attr('direction', Direction), attr('type', Type)

class Parameters(List):
    grammar = Parameter, maybe_some(";", Parameter)

class Entity(Plain):
    grammar = "entity", name(), "is", "port", "(", attr('port', Parameters), ")", ";", "end", "entity", name(), ";"



example_dut = """
 entity ff_dtype is port(
      clk    : in std_logic;
      data   : in std_logic;
      reset  : in std_logic;
      q      : buffer std_logic;
      not_q  : buffer std_logic
   );
end entity ff_dtype;"""

if __name__ == '__main__':
    entity = parse(example_dut, Entity)
    for sig in entity.port:
        print(sig.name)
