using Microsoft.AspNet.Identity;
using SendGrid;
using SendGrid.Helpers.Mail;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Net.Mime;
using System.Threading.Tasks;
using System.Web;

namespace NewProject.Services
{
    public class EmailService : IIdentityMessageService
    {
        private string EmailFrom;
        private string EmailPassword;

        public EmailService()
        {
            EmailFrom = ConfigurationManager.AppSettings["EmailFrom"].ToString();
            EmailPassword = ConfigurationManager.AppSettings["EmailPassword"].ToString();
        }

        public async Task SendAsync(IdentityMessage message)
        {
            await SendEmailAsync(message);
        }

        private async Task SendEmailAsync(IdentityMessage message)
        {
            try
            {
                MailMessage email = new MailMessage(EmailFrom, message.Destination)
                {
                    Subject = message.Subject,
                    Body = message.Body,
                    IsBodyHtml = true
                };
                var mailClient = new SmtpClient("smtp.gmail.com", 587) { Credentials = new NetworkCredential(EmailFrom, EmailPassword), DeliveryFormat = SmtpDeliveryFormat.International, DeliveryMethod = SmtpDeliveryMethod.Network, EnableSsl = true };
                await mailClient.SendMailAsync(email);
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }
    }
}