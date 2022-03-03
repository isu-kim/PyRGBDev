# distutils: language = c++

"""
@project : PyRGBDev
@author : Gooday2die
@date : 2022-03-03
@file : SDK.pyx
"""

import serial
import time

import wmi

class NoArduinoFound(Exception):
    """
    An exception for no Arduino Neopixel was found in this PC
    """
    pass

class NotConnectedError(Exception):
    """
    An error class for when the Arduino Neopixel is not detected and not connected,
    however, the user is trying to perform commands using Arduino.

    """
    pass

class InvalidRgbValueError(Exception):
    """
    An Error class for Invalid RGB Values.
    Example: ("AWD", 123, 123)
    Would raise this error
    """
    pass


class sdk:
    """
    A sdk class for Neopixel Wrappers
    """
    def __init__(self):
        """
        A initializer method for class sdk in All Neo Pixel Wrappers
        """
        self.com = None
        self.is_connected = False
        self.baudrate = 9600
        self.serial_object = None

    def __repr__(self):
        """
        A __repr__ method for representing current object.
        """
        return "ALL SDK"

    def _detect_arduino(self):
        """
        A method that detects which port arduino is using and BaudRate of that Serial port
        """
        self.com = None
        wmi_object = wmi.WMI()

        for x in wmi_object.query("SELECT * FROM Win32_SerialPort"): # This query takes some lot of time
            if "Arduino" in x.wmi_property('Description').value:
                self.com = x.wmi_property("DeviceId").value
                self.baudrate = x.wmi_property("MaxBaudRate").value

        if self.com is None:
            raise NoArduinoFound("No Arduino was found in this PC. Please check connection.")

    def connect(self, **kwargs):
        """
        A method for finding which port arduino is using and connecting via serial communication
        """
        self.is_connected = True  # set self.is_connected = True

        try:  # Try detecting which COM arduino is using
            self._detect_arduino()
        except NoArduinoFound as e:
            raise NotConnectedError(str(e))

        try:
            self.serial_object = serial.Serial(self.com, self.baudrate)
        except:
            self.is_connected = False  # set it false and raise error
            raise NoArduinoFound("Cannot connect Arduino using Serial")

    def disconnect(self):
        """
        A method for disconnecting Serial object that was connected
        """
        try:
            self.serial_object.close()
            self.is_connected = False
        except AttributeError:
            pass

    def get_all_device_information(self):
        """
        A method for getting all connected neopixel count
        """
        if not self.is_connected:
            raise NotConnectedError("Arduino is not Connected. Use connect() first.")
        pass

    def set_rgb(self, rgb_info):
        """
        A method for setting all neopixel color into one color
        """
        if not self.is_connected:
            raise NotConnectedError("Arduino is not Connected. Use connect() first.")
        pass
