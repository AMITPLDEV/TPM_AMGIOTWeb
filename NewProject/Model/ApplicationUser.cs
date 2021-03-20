using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using System.Web;

namespace NewProject.Model
{
    public class ApplicationUser : IdentityUser
    {
        public string CorporateID { get; set; }
        public string Name { get; set; }
        public string IOTID { get; set; }
        public string Address { get; set; }
        public byte[] UserImage { get; set; }
        public DateTime EffectiveFromDate { get; set; }
        public DateTime EffectiveToDate { get; set; }
        public DateTime? UpdatedTS { get; set; }
        public string UpdatedBy { get; set; }
        public bool? SyncedStatus { get; set; }
        public bool? IsGroupUser { get; set; }
        public bool IsTOTPAuthenticatorEnabled { get; set; }
        public string TOTPAuthenticatorSecretKey { get; set; }

        public ClaimsIdentity GenerateUserIdentity(ApplicationUserManager manager)
        {
            var userIdentity = manager.CreateIdentity(this, DefaultAuthenticationTypes.ApplicationCookie);
            userIdentity.AddClaim(new Claim("UserName", UserName));
            userIdentity.AddClaim(new Claim("Email", Email));
            return userIdentity;
        }

        public Task<ClaimsIdentity> GenerateUserIdentityAsync(ApplicationUserManager manager)
        {
            return Task.FromResult(GenerateUserIdentity(manager));
        }
    }
}