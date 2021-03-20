using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using Twilio;
using Twilio.Rest.Api.V2010.Account;

namespace NewProject.Services
{
    public class SmsService : IIdentityMessageService
    {
        private string twilio_sid;
        private string twilio_auth_token;

        public SmsService()
        {
            twilio_sid = "ACa2eca058bac23e94c9c9a3e3651ae6bf";
            twilio_auth_token = "7601932c8d2889319e6d6052b79fe037";
        }

        public Task SendAsync(IdentityMessage message)
        {
            string accountSid = Environment.GetEnvironmentVariable(twilio_sid);
            string authToken = Environment.GetEnvironmentVariable(twilio_auth_token);
            TwilioClient.Init(accountSid ?? twilio_sid, authToken ?? twilio_auth_token);
            var msg = MessageResource.Create(body: message.Body, from: new Twilio.Types.PhoneNumber("+16189364010"), to: new Twilio.Types.PhoneNumber(message.Destination));
            return Task.FromResult(msg.Sid);
        }
    }
}