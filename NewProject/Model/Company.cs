namespace NewProject.Model
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Company")]
    public partial class Company
    {
        [StringLength(50)]
        public string Entity { get; set; }

        [Key]
        [Column(Order = 0)]
        [StringLength(50)]
        public string CompanyID { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(50)]
        public string CompanyName { get; set; }

        [StringLength(50)]
        public string ContactPerson { get; set; }

        public string Address1 { get; set; }

        public string Address2 { get; set; }

        [StringLength(50)]
        public string Place { get; set; }

        [StringLength(50)]
        public string State { get; set; }

        [StringLength(50)]
        public string Country { get; set; }

        [StringLength(50)]
        public string PIN { get; set; }

        [StringLength(50)]
        public string Phone1 { get; set; }

        [StringLength(50)]
        public string Phone2 { get; set; }

        [StringLength(50)]
        public string Email { get; set; }

        [Key]
        [Column(Order = 2)]
        public DateTime EffectiveFromDate { get; set; }

        public DateTime EffectiveToDate { get; set; }

        [StringLength(50)]
        public string AuthenticationMethod { get; set; }

        [StringLength(50)]
        public string TwoFactorAuthMethod { get; set; }
    }
}
