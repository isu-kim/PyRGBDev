# distutils: language = c++

"""
The upper #distutils part MUST to on top of this code
This script is for ALL Wrappers for controlling all devices.
@project : pyrgbdev
@author : Gooday2die
@date : 2022-02-25
@file : SDK.pyx
"""

import pyximport
pyximport.install()

# We have to use pyximport since we will be importing sdks from each SDK.pyx
# If we do not have pyximport, we cannot use those sdks.

class NoAvailableSDKError(Exception):
    """
    A Exception class for no Available SDK found
    """
    pass

class SDKNotConnectedError(Exception):
    """
    A Error class for when sdk is not connected and use is trying to perform
    expressions which should be executed after sdk has been connected
    """
    pass

class InvalidRgbValueError(Exception):
    """
    An Error class for Invalid RGB Values.
    Example: ("AWD", 123, 123)
    Would raise this error
    """
    pass


class InvalidDeviceType(Exception):
    """
    An Error class for Invalid Device Type.
    Example: "InvalidDeviceType"
    Would raise this error
    """
    pass


class sdk:
    """
    A sdk class for ALL Wrappers
    """
    def __init__(self):
        """
        A initializer method for class sdk in All Wrappers
        """
        self.sdk_list = list()
        try:  # Try loading Razer SDK dll and the module
            from pyrgbdev.Razer import sdk as RazerSDK
            self.sdk_list.append(RazerSDK())  # add object for Razer
        except ImportError:
            pass

        try:  # Try loading Corsair SDK dll and the module
            from pyrgbdev.Corsair import sdk as CorsairSDK
            self.sdk_list.append(CorsairSDK())  # add object for Corsair
        except ImportError:
            pass

        self.is_connected = False

    def __repr__(self):
        """
        A __repr__ method for representing current object.
        """
        return "ALL SDK"

    def connect(self):
        """
        A method for connecting all sdks in sdk_list and removing those sdks which does not connect
        """
        for sdk_object in self.sdk_list:  # For all SDKs,
            try:  # Try connecting them
                sdk_object.connect()
            except:  # If any Exceptions occur that means that the connection was invalid.
                # Yes, I know using bare except is dumb :b
                self.sdk_list.remove(sdk_object)

        self.is_connected = True  # set self.is_connected = True

        if len(self.sdk_list) == 0:  # if there is no connected sdks in our sdk_list
            self.is_connected = False  # set it false and raise error
            raise NoAvailableSDKError("No Available SDK was found")

    def disconnect(self):
        """
        A method for disconnecting every sdks connected.
        """
        for sdk_object in self.sdk_list:
            sdk_object.disconnect()
        self.is_connected = False

    def get_connected_sdk_names(self):
        """
        A method for getting all connected sdk's names in list
        return: This returns a list of string objects that represent each SDK's names.
        """
        sdk_names = list()
        if not self.is_connected:
            raise SDKNotConnectedError("ALL SDK is not Connected. Use connect() first.")

        for sdk_object in self.sdk_list:
            sdk_names.append(str(sdk_object))
        return sdk_names

    def get_all_device_information(self):
        """
        A method for getting all device information in dictionary format.
        This will be returning connected devices in Dictionary in Keys with the sdk's names.
        Example:
        {'Razer SDK': {'Mouse': [('DEATHADDER ELITE CHROMA', 0)]}, 'Corsair SDK': {'Mouse': [('GLAIVE RGB', 0)]}}
        return: This returns a dictionary object that contains connected devices with keys as its sdk's names
        """
        if not self.is_connected:
            raise SDKNotConnectedError("ALL SDK is not Connected. Use connect() first.")

        all_devices = dict()
        for sdk in self.sdk_list:
            all_devices[str(sdk)] = sdk.get_all_device_information()

        return all_devices

    def set_rgb(self, rgb_info):
        """
        A method for setting all device's color into one color.
        the rgb_info in dictionary type
        The dictionary should contain device type as its key and its rgb values in tuple as values.
        Example:
        {"Mouse": (0, 0, 255)}
        :param rgb_info: the rgb_information to set
        :return: returns True if successful, False if failure.
        """
        if not self.is_connected:
            raise SDKNotConnectedError("ALL SDK is not Connected. Use connect() first.")
        try:  # try setting values
            for sdk in self.sdk_list:
                sdk.set_rgb(rgb_info)
        except Exception as e:  # if exception happens, raise exception
            if "Invalid Device Type" in str(e):
                raise InvalidDeviceType(str(e))
            elif "Invalid RGB Value" in str(e):
                raise InvalidRgbValueError(str(e))
            else:
                raise e
