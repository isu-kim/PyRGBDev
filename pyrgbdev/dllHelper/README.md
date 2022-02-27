# About DLL Helper
## Why is this needed?
Our library must have DLLs in order for each SDKs to work. There are some SDKs that sets their SDK dlls into `System32` folder, however some does not. If we do not have DLLs in `System32` the library cannot start each Wrappers. Thus we need a script that moves all necessary dlls into `System32` automatically. This `helper.bat` does the job. The process is like this
1. When the setup.py is called via `pip install pyrgbdev` or `pip install .`, it will use `subprocess` module in order to call the `helper.bat` with admin permission.
2. Then the `helper.bat` moves all dlls to `System32` using admin permission that was granted by user. 
3. After `setup.py` is done, the user can easily import modules using the dlls that we have just moved. 

If you would like to add more SDK dlls into `System32` please move your dll in this directory. Them add a expression in the `helper.bat`.
```
xcopy %~dp0CUESDK.x64_2019.dll "C:\Windows\System32"
```
Replace `CUESDK.x64_2019.dll` with the SDK dll that you would like to move to `System32`. 

## DLLs
The `helper.bat` currently has those dlls avaiable.
- CUESDK.x64_2019.dll - for Corsair ICUE