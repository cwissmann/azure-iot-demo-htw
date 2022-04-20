using IoTHubTrigger = Microsoft.Azure.WebJobs.EventHubTriggerAttribute;

using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Host;
using Microsoft.Azure.EventHubs;
using System.Text;
using System.Net.Http;
using Microsoft.Extensions.Logging;

namespace backend_function
{
    public class IotHubTrigger
    {
        private static HttpClient client = new HttpClient();
        
        [FunctionName("IotHubTrigger")]
        public void Run([IoTHubTrigger("messages/events", Connection = "IOT_EVENTHUB_ENDPOINT")]EventData message, ILogger log)
        {
            log.LogInformation($"C# IoT Hub trigger function processed a message: {Encoding.UTF8.GetString(message.Body.Array)}");
        }
    }
}