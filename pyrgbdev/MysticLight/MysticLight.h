/**
 * @file: MysticLight.h
 * @author: Gooday2die (Isu Kim), edina00@naver.com
 * @date: 2022-03-02
 * @brief: Codes that implements all member functions and attributes in class MysticLight
 */

#ifndef MAIN_CPP_MAIN_H
#define MAIN_CPP_MAIN_H
#pragma once

#include "./includes/MysticLight_SDK.h"

#include <iostream>
#include <tchar.h>
#include <windows.h>
#include <assert.h>
#include <wtypes.h>
#include <list>


#ifdef _WIN64
#define MYSTICLIGHTDLL        _T("MysticLight_SDK_x64.dll")
#else
#define MYSTICLIGHTDLL        _T("MysticLight_SDK.dll")
#endif

typedef struct Device{
    const char* name; // The name of this current device
    int type; // The device type of this device
    int index;
}Device;

class MysticLight{
private:
    int deviceCount = 0;
    Device* deviceList = nullptr;

    HMODULE MysticLightModule = NULL;
    LPMLAPI_Initialize init = nullptr;
    LPMLAPI_GetDeviceInfo getDeviceInfo = nullptr;
    LPMLAPI_GetDeviceName getDeviceName = nullptr;
    LPMLAPI_GetErrorMessage getErrorMessage = nullptr;
    LPMLAPI_SetLedColor setLedColor = nullptr;
    LPMLAPI_SetLedBright setLedBright = nullptr;

public:
    MysticLight();
    int connect();
    int setDeviceRgb(int, int, int, int);
    int getDeviceCount();
    Device getDeviceInfo(int);

};

#endif //MAIN_CPP_MAIN_H
