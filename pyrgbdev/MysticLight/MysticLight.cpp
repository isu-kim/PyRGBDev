/**
 * @file: MysticLight.cpp
 * @author: Gooday2die (Isu Kim), edina00@naver.com
 * @date: 2022-03-02
 * @brief: Codes that implements all member functions and attributes in class MysticLight
 */

/**
 * A member function for class MysticLight for connecting SDK.
 * This loads DLL and gets process address to the service and then saves all each process address to the attributes
 * for future use.
 * @return returns
 *        1 if all functions from GetProcAddress was loaded successfully,
 *        0 if any of those functions from GetProcAddress failed to load,
 *        -1 if already connected
 *        -2 if loading dll was not successful.
 */
int MysticLight::connect() {
    if (MysticLightModule == nullptr){ // check if DLL was already loaded
        MysticLightModule = LoadLibrary(MYSTICLIGHTDLL);
        if (MysticLightModule == nullptr){
            init = reinterpret_cast<LPMLAPI_Initialize>(GetProcAddress(MysticLightModule, "MLAPI_Initialize"));
            getDeviceInfo = reinterpret_cast<LPMLAPI_GetDeviceInfo>(GetProcAddress(MysticLightModule, "LPMLAPI_GetDeviceInfo"));
            getDeviceName = reinterpret_cast<LPMLAPI_GetDeviceName>(GetProcAddress(MysticLightModule, "LPMLAPI_GetDeviceName"));
            getErrorMessage = reinterpret_cast<LPMLAPI_GetErrorMessage>(GetProcAddress(MysticLightModule, "LPMLAPI_GetErrorMessage"));
            setLedColor = reinterpret_cast<LPMLAPI_SetLedColor>(GetProcAddress(MysticLightModule, "LPMLAPI_SetLedColor"));
            setLedBright = reinterpret_cast<LPMLAPI_SetLedBright>(GetProcAddress(MysticLightModule, "LPMLAPI_SetLedBright"));
            return (init && getDeviceInfo && getErrorMessage && setLedColor && setLedBright);
            // returns 1 if everything was set successfully, returns 0 if anything was not set successfully.
        }else{ // If DLL loading was not successful, return -2
            return -2;
        }
    }else{ // If it was already loaded, return -1 as return value
        return -1;
    }
}
