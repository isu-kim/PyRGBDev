# Known Issues & Bugs
This page is for tracking bugs and issues that frequently happens when installing and using `pyrgbdev`. I have tested `pyrgbdev` in multiple devices, however there might be some missing devices. The solutions below are my solutions and those worked in mycase. Thus this might or might not work for your case. **If you have fundamental solution, please PR or let me know.**

### If you had a problem and had solved it yourself, feel free to add one here.

## Installation
This section is known issues and bugs when **installing** the library in your PC.
 
### `ERROR: Could not install packages due to an OSError: [Errno 2] No such file or directory:`

When installing `pyrgbdev`  with `pip install . ` or `pip install pyrgbdev`, sometimes there is an error that occurs during installation. Which is `ERROR: Could not install packages due to an OSError: [Errno 2] No such file or directory:` This is well known issue due to Window's limitation of directory string length. This [link](https://stackoverflow.com/questions/65980952/python-could-not-install-packages-due-to-an-oserror-errno-2-no-such-file-or) has some good information about it so please consider visiting the link. 

- **Solution 1**: Install the PyPeripheral using `pip install . --user` or `pip install pyrgbdev --user`. The `--user` option worked in my case

### `error: Microsoft Visual C++ 14.0 or greater is required. Get it with "Microsoft C++ Build Tools": https://visualstudio.microsoft.com/visual-cpp-build-tools/`  
When installing `pyrgbdev`  with `pip install . ` or `pip install pyrgbdev`, if you do not have any C++ compilers, the error above happens. Since `pyrgbdev` uses `cython`, the project itself has to be **compiled** by C++ compilers. 

- **Solution 1**: Please install`Microsoft C++ Build Tools` and install `C++` compiler.

## SDK Wrappers
This section is known issues and bugs for **SDK Wrappers**.
### `importError: DLL load failed while importing ...`
This error is due to missing DLLs when importing a SDK Wrapper. `pyrgbdev` uses dlls in order to communicate with SDK itself. Thus if the dll is missing, SDK Wrapper cannot import the dll and raises this error. I have made `dllhelper` for the issues, so please check [here](https://github.com/gooday2die/PyRGBDev/tree/main/pyrgbdev/dllHelper) fore more information. If the admin permission was not granted during installing this library, dlls would not be moved into the `System32` directory, so this error might occur.
- **Solution 1**: Find which dll is missing and put it in `c:\Windows\System32` folder.
- **Solution 2**: Find where python `site-packages` and `pyrgbdev` is located at and place dll in the same directory as `*.pyd` files exist.