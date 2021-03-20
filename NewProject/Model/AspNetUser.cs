namespace NewProject.Model
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class AspNetUser
    {
        public string Id { get; set; }

        [StringLength(50)]
        public string CorporateID { get; set; }

        [StringLength(50)]
        public string IOTID { get; set; }

        [StringLength(100)]
        public string Name { get; set; }

        [Required]
        [StringLength(256)]
        public string UserName { get; set; }

        [StringLength(200)]
        public string Address { get; set; }

        [StringLength(256)]
        public string Email { get; set; }

        public bool EmailConfirmed { get; set; }

        public string PasswordHash { get; set; }

        public string SecurityStamp { get; set; }

        public string PhoneNumber { get; set; }

        public bool PhoneNumberConfirmed { get; set; }

        public bool TwoFactorEnabled { get; set; }

        public DateTime? LockoutEndDateUtc { get; set; }

        public bool LockoutEnabled { get; set; }

        public int AccessFailedCount { get; set; }

        public byte[] UserImage { get; set; }

        public DateTime? EffectiveFromDate { get; set; }

        public DateTime? EffectiveToDate { get; set; }

        public DateTime? UpdatedTS { get; set; }

        [StringLength(50)]
        public string UpdatedBy { get; set; }

        public bool? SyncedStatus { get; set; }

        public bool? IsGroupUser { get; set; }
    }
}
