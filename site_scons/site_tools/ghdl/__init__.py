# vim: set ft=scons: tw=72: ts=4: sw=4:
import SCons.Script


def name_ghdl_objects(env, target, source):
    '''The name of the output object files is the same as input.'''
    if 
    s = str(source[0])
    if s.endswith('.vhd'): 
        target[0] = s[0:-4] +'.o'
    return target, source

def generate(env):
static_obj, _ = SCons.Tool.createObjBuilders(env)
  
env.lyx = SCons.Script.Builder( action = ['ghdl -a $SOURCE'], 
                                suffix = '.o', src_suffix=['.vhd', '.vhdl'], 
                                emitter = name_ghdl_objects )


# Teach Object to understand ghdl
env.Append(BUILDERS = {'GHDL' : env.ghdl})
env['BUILDERS']['OBJECT'].add_src_builder(env.lyx)
