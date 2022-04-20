# Simulated IoT Device

## Steps for creating new console project
```
dotnet new console

dotnet add package Microsoft.Azure.Devices.Client --version 1.40.0
```

## Start simulated temperature device

Go to the IoT Hub, create new device and then copy device id and primary key to the variables in the Program.cs file.  
The hostname is on the overview page (IOTHUBNAME.azure-devices.net).

## References
[Azure IoT SDK](https://github.com/Azure/azure-iot-sdk-csharp)  
[Azure IoT libraries for .NET](https://docs.microsoft.com/de-de/dotnet/api/overview/azure/iot)  