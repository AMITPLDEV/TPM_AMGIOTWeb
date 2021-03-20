using Google.Authenticator;
using Microsoft.AspNet.Identity;
using NewProject.Model;
using OtpNet;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;

namespace NewProject.Services
{
    public class TOTPAuthenticatorTokenProvider : IUserTokenProvider<ApplicationUser, string>
    {
        public Task<string> GenerateAsync(string purpose, UserManager<ApplicationUser, string> manager, ApplicationUser user)
        {
            return Task.FromResult((string)null);
        }

        public Task<bool> IsValidProviderForUserAsync(UserManager<ApplicationUser, string> manager, ApplicationUser user)
        {
            return Task.FromResult(user.IsTOTPAuthenticatorEnabled);
        }

        public Task NotifyAsync(string token, UserManager<ApplicationUser, string> manager, ApplicationUser user)
        {
            return Task.FromResult(true);
        }

        public Task<bool> ValidateAsync(string purpose, string token, UserManager<ApplicationUser, string> manager, ApplicationUser user)
        {
            bool valid = ValidateTwoFactorPIN(user.TOTPAuthenticatorSecretKey, token);
            return Task.FromResult(valid);
        }

        public bool ValidateTwoFactorPIN(string AuthenticatorSecretKey, string pin)
        {
            TwoFactorAuthenticator tfa = new TwoFactorAuthenticator();
            return tfa.ValidateTwoFactorPIN(AuthenticatorSecretKey, pin);
        }
    }
}