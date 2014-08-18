# -*- coding: utf-8 -*-
import os


def file_exists(file_name):
    return os.path.isfile(file_name)

def indent_string(string, indent_size=3):
    return string.replace("\n", "\n" + " " * indent_size)
