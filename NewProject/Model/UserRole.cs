namespace NewProject.Model
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("UserRole")]
    public partial class UserRole
    {
        [Key]
        [Column(Order = 0)]
        [StringLength(50)]
        public string CompanyID { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(50)]
        public string Role { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(50)]
        public string Userid { get; set; }

        public int? IsEmployee { get; set; }

        [Key]
        [Column(Order = 3)]
        public DateTime EffectiveFromDate { get; set; }

        public DateTime EffectiveToDate { get; set; }

        public DateTime? UpdatedTS { get; set; }

        [StringLength(50)]
        public string UpdatedBy { get; set; }

        public bool? SyncedStatus { get; set; }

        [StringLength(50)]
        public string Employeeid { get; set; }
    }
}
