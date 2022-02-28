# Documents for pyrgbdev
This document is for all features within our library, `pyrgbdev`. Every Wrapper is designed with **polymorphism** in mind. Thus, you are able to expect similar behaviors from different SDK Wrappers. 

### Currently Supported SDK Wrappers
- Corsair
- Razer


## Walkthough with example (Single SDK Wrapper)
This example is made with `pyrgbdev.Corsair` for easy explanation. If you want a more technical and detailed explanation of each method and its parameters and return values, please check **Official Document of SDK Wrapper** below for more information.

### Importing Modules
You can import SDK Wrapper module by those two expressions in python
- `import pyrgbdev.Corsair`  (I will use this one for example)
- `from pyrgbdev import Corsair`

### Generating SDK Wrapper Object
You can generate a SDK Wrapper object by following expression. 
```
>>> c = pyrgbdev.Corsair.sdk()
>>> c
Corsair SDK
```

### Connecting SDK Wrapper Object
You MUST all `connect()` method of `sdk` class before performing any operations with SDK Wrapper object. This is to prevent unexpected behaviors due to not initializing SDK and executing commands at the first time. 
```
>>> c.connect()
True
```
If the SDK object is not connected, any python expressions using the sdk's methods will raise `SDKNotConnectedError`.
```
pyrgbdev.Corsair.SDKNotConnectedError: Cue SDK is not Connected. Use connect() first.
```

### Disconnecting SDK Wrapper Object
You can disconnect a SDK Wrapper by `disconnect()` method of `sdk` class when you are done using their SDK features. If you do not disconnect the SDK object, SDKs might think that our library is still usinig the SDK features. Thus unexpected behavior might occur. It is highly recommended to `disconnect()` before stopping the process.
```
>>> c.disconnect()
1
```


### Getting All Device Information
You can get all device information by using `get_all_device_information()` method from class `sdk`.
```
>>> c.get_all_device_information()
{'Mouse': [('GLAIVE RGB', 0)]}
```
### Getting All Connected Device Count
You can get all counts of all connected device by using `get_device_count()` method from class `sdk`.
```
>>> c.get_device_count()
1
```
### Getting Specific Device Information with Index
You can get specific device information with index. In our case, we will be using index `0` since we only have one device connected.
```
>>> c.get_device_information(0)
('GLAIVE RGB', 'Mouse')
```
If you have entered a wrong index, it will raise `InvalidDeviceIndexError`.
```
pyrgbdev.Corsair.InvalidDeviceIndexError: Invalid index : 3
```
### Setting a Device's RGB Value
You can simply call `set_rgb(rgb_value)` method in order to set device's rgb value. The `rgb_value` must be in `dict` object in order to set device colors. An example would be like following
```
>>> c.set_rgb({"Mouse": (255, 255, 0)}) # This will set mouse RGB yellow.
1
```
If you input wrong object not `int` object to the RGB `tuple` parameter, it will raise `InvalidRgbValueError` 
```
>>> c.set_rgb({"Mouse": ("255", 255, 0)})
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "pyrgbdev\Corsair\SDK.pyx", line 148, in pyrgbdev.Corsair.sdk.set_rgb
pyrgbdev.Corsair.InvalidRgbValueError
```
If you put wrong device type which is not supported, it will raise `InvalidDeviceType`
```
>>> c.set_rgb({"InvalidName": (255, 255, 0)})
InvalidDeviceType('Invalid Device Type : InvalidName')
```
Supported device names are following:
1. Mouse
2. Keyboard
3. Headset
4. MouseMat
5. HeadsetStand
6. Cooler
7. MemoryModule
8. Motherboard
9. GPU
10. ETC
11. ALL

### For documentations and how each parameters and return values are set, please check [here](https://github.com/gooday2die/PyRGBDev/blob/main/pyrgbdev/AbstractSDK/README.md) for more information.

## Walkthough with example (ALL SDK Wrapper)
This walkthrough is for ALL SDK wrapper which covers all SDKs. The ALL SDK controls all connected devices. 
### Importing Modules
You can import All SDK Wrapper module by those two expressions in python
- `import pyrgbdev.All`  (I will use this one for example)
- `from pyrgbdev import All`


### Generating SDK Wrapper Object
```
>>> a = pyrgbdev.All.sdk()
>>> a
ALL SDK
```
When the `sdk` object is being generated, it imports all necessary SDK Wrapper modules as well. For example, when `pyrgbdev.All.sdk()` is called, this imports `pyrgbdev.Corsair`, `pyrgbdev.Razer` as well. The importing process looks for installed DLLs in `System32` and opts out SDKs when a specific DLL for a SDK is not in `System32`. **So, if you have installed a SDK and it is recognized by All module, the highest chance would be DLL missing in `System32`**

### Connecting All SDK Wrappers
You MUST all `connect()` method of `sdk` class before performing any operations with SDK Wrapper object. This is to prevent unexpected behaviors due to not initializing SDK and executing commands at the first time. 
```
>>> a.connect()
```
If the SDK object is not connected, any python expressions using the sdk's methods will raise `SDKNotConnectedError`.

```
pyrgbdev.All.SDKNotConnectedError: ALL SDK is not Connected. Use connect() first.
```

### Disconnecting All SDK Wrappers
You can disconnect a SDK Wrapper by `disconnect()` method of `sdk` class when you are done using their SDK features. If you do not disconnect the SDK object, SDKs might think that our library is still usinig the SDK features. Thus unexpected behavior might occur. It is highly recommended to `disconnect()` before stopping the process.
```
>>> c.disconnect()
```

### Getting All Device Information
You can retrieve all connected devices using `get_all_device_information()` method.
```
>>> a.get_all_device_information()
{'Razer SDK': {'Mouse': [('DEATHADDER ELITE CHROMA', 0)]}, 'Corsair SDK': {'Mouse': [('GLAIVE RGB', 0)]}}
```

This will return a `dict` object containing all connected device information in `key` as SDK's name, and all connected devices in a `dict` as its `value`.

### Getting All Connected SDK Names
You can retrieve names of connected SDKs by using `get_connected_sdk_names()` method from class `sdk`
```
>>> a.get_connected_sdk_names()
['Razer SDK', 'Corsair SDK']
```
This will return `list` object containing `String` object that represents each SDK's names.

### Setting All Devices' RGB Value
You can simply call `set_rgb(rgb_value)` method in order to set device's rgb value. The `rgb_value` must be in `dict` object in order to set device colors. An example would be like following
```
>>> a.set_rgb({"ALL": (255, 255, 0)}) # This will All device RGB yellow.
```
If you input wrong object not `int` object to the RGB `tuple` parameter, it will raise `InvalidRgbValueError` 

```
>>> a.set_rgb({"ALL": ("255", 255, 0)})
pyrgbdev.All.InvalidRgbValueError: Invalid RGB Value : {'ALL': ('255', 255, 0)}
```

If you put wrong device type which is not supported, it will raise `InvalidDeviceType`
```
>>> a.set_rgb({"Hello!": (255, 255, 0)})
pyrgbdev.All.InvalidDeviceType: Invalid Device Type : Hello!
```