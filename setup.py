"""
@project : pyrgbdev
@author : Gooday2die
@date : 2022-02-24
@file : setup.py

Short message of setup.py from Gooday2die.
Most SDKs need DLL to work. Thus all those dlls must be in C:/Windows/System32.
This setup.py calls dllHelper/helper.bat to move all dlls into the right place.
Since xcopying something to system32 needs admin permission, this will request admin permission.
"""

import os
from setuptools import setup
from setuptools.extension import Extension
from Cython.Build import cythonize
import win32com.shell.shell as shell

current_dir = os.path.dirname(os.path.abspath(__file__))
batch_script = os.path.join(current_dir, 'pyrgbdev/dllHelper/helper.bat')

with open("README.md", "r", encoding="utf-8") as fh:  # Read README.md file for long_description
    long_description = fh.read()

ext_modules = [
    # Extension for Corsair
    Extension("pyrgbdev.Corsair",
              ["./pyrgbdev/Corsair/SDK.pyx"],
              include_dirs=["./pyrgbdev/Corsair/includes/"],
              libraries=["CUESDK.x64_2019"],
              library_dirs=['./pyrgbdev/Corsair/libs/'],
              language='c++',
              ),

    # Extension for Razer
    Extension("pyrgbdev.Razer",
              ["./pyrgbdev/Razer/SDK.pyx"],
              include_dirs=["./pyrgbdev/Razer/includes/"],
              ),

    # Extension for All
    Extension("pyrgbdev.All",
              ["./pyrgbdev/All/SDK.pyx"],
              ),
]

# General setup process
setup(
    name='pyrgbdev',
    version='1.0.5',
    description='A RGB Controlling Library for Python',
    long_description_content_type="text/markdown",
    long_description=long_description,
    url='https://github.com/gooday2die/pyrgbdev',
    author='Gooday2die',
    author_email='edina00@naver.com',
    license='MIT',
    classifiers=[
        'Environment :: Win32 (MS Windows)',
        'License :: OSI Approved :: MIT License',
        'Natural Language :: English',
        'Operating System :: Microsoft :: Windows',
        'Topic :: System :: Hardware',
    ],
    install_requires=["cython", "pywin32"],
    ext_modules=cythonize(ext_modules),
)

shell.ShellExecuteEx(lpVerb='runas', lpFile='cmd.exe', lpParameters='/c ' + batch_script)  # This calls dll batch file
