using System.Text;
using Microsoft.Azure.Devices.Client;
using Newtonsoft.Json;

var _random = new Random();
var _messageId = 0;

// See https://aka.ms/new-console-template for more information
Console.WriteLine("Hello HTW");

string deviceKey = "[DEVICEKEY]";
string deviceId = "[DEVICEID]";
string iotHubHostName = "[IOTHUBHOSTNAME]";
var deviceAuthentication = new DeviceAuthenticationWithRegistrySymmetricKey(deviceId, deviceKey);


DeviceClient deviceClient = DeviceClient.Create(iotHubHostName, deviceAuthentication, TransportType.Mqtt);

while (true)
{
    double currentTemperature = 20 + _random.NextDouble() * 15;
    double currentHumidity = 60 + _random.NextDouble() * 20;

    var telemetryData = new {
        messageId = _messageId++,
        deviceId = deviceId,
        temperature = currentTemperature,
        humidity = currentHumidity
    };

    string messageString = JsonConvert.SerializeObject(telemetryData);
    Message message = new Message(Encoding.ASCII.GetBytes(messageString));
    message.Properties.Add("temperatureAlert", (currentTemperature > 30) ? "true" : "false");

    await deviceClient.SendEventAsync(message);
    Console.WriteLine($"{DateTime.Now} > Sending message: {messageString}");

    await Task.Delay(2000);
}