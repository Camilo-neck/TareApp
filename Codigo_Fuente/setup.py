import sys
import os
from cx_Freeze import setup, Executable

# ADD FILES
files = ['Interface/']

# TARGET
target = Executable(
    script="main.py",
    base="Win32GUI",
    icon="Interface/images/icon.ico"
)

# SETUP CX FREEZE
setup(
    name = "SmoothTask",
    version = "1.0",
    description = "Tus tareas cada vez mas faciles.",
    author = "Camilo A. Cuello",
    options = {'build_exe' : {'include_files' : files}},
    executables = [target]
    
)