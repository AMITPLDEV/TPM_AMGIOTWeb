using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NewProject.Model
{
    public class DTO
    {
    }
    public class ProcessParameterDashboardMachineData
    {
        public string MachineID { get; set; }
        public string CompanyID { get; set; }
        public string PlantID { get; set; }
        public List<string> ChartType { get; set; }
        public List<ProcessParameterData> parameterDetails { get; set; } = new List<ProcessParameterData>();
    }
    public class ProcessParameterData
    {
        public string Value { get; set; }
        public string ChartType { get; set; }
        public string HighValue { get; set; }
        public string LowValue { get; set; }
        public string TemplateType { get; set; }
        public string BackColor { get; set; }
        public string BackColorForReference { get; set; }
        public string HeaderName { get; set; }
        public string NextLineVisibility { get; set; }
        public string Template1Visibility { get; set; }
        public string Template2Visibility { get; set; }
        public string chartContainerID { get; set; }
        public string MachineID { get; set; }
        public string GraphHighLowVisibility { get; set; }
        public bool TrubleshootIconVisibility { get; set; }
        public string UpdatedTS { get; set; }
    }
    public class ProcessParameterTransactionMasterData
    {
        public ObjectId _id { get; set; }
        public string CompanyID { get; set; }
        public string PlantID { get; set; }
        public string MachineID { get; set; }
        public string ParameterID { get; set; }
        public string LowerWarningLimit { get; set; }
        public string UpperWarningLimit { get; set; }
        public string LowerErrorLimit { get; set; }
        public string UpperErrorLimit { get; set; }
        public string Unit { get; set; }
        public string IsEnabledForGraph { get; set; }
    }
    public class ProcessParameterMongoData
    {
        //public string _id { get; set; }
        //[BsonDateTimeOptions(Kind = DateTimeKind.Local)]
        //public DateTime? UpdatedTS { get; set; }
        //public string ParameterValue { get; set; }
        public ObjectId _id { get; set; }
        [BsonDateTimeOptions(Kind = DateTimeKind.Local)]
        public DateTime? CycleStart { get; set; }
        [BsonDateTimeOptions(Kind = DateTimeKind.Local)]
        public DateTime? CycleEnd { get; set; }
        [BsonDateTimeOptions(Kind = DateTimeKind.Local)]
        public DateTime? UpdatedTS { get; set; }
        [BsonDateTimeOptions(Kind = DateTimeKind.Local)]
        public DateTime? InsertedTS { get; set; }
        public string ParamterID { get; set; }
        public string ParameterValue { get; set; }
        public string MachineID { get; set; }
        public string CompanyID { get; set; }
        public string PlantID { get; set; }
    }
    public class ProcessParameterMasterData
    {
        public string Company { get; set; }
        public string Plant { get; set; }
        public string MachineID { get; set; }
        public string MachineType { get; set; }
        public string MTB { get; set; }
        public string MachineModel { get; set; }
        public string ParemeterID { get; set; }
        public string SourceType { get; set; }
        public string SourceAdd1 { get; set; }
        public string SourceAdd2 { get; set; }
        public string SourceDatatype1 { get; set; }
        public string SourceDatatype2 { get; set; }
        public string PollingFrequency { get; set; }
        public string DataGroup { get; set; }
        public string PollingType { get; set; }
        public string CycleFreqTime { get; set; }
        public string NoOfCycle { get; set; }
        public bool IsEnabled { get; set; }
        public bool ShouldNotBeDisabled { get; set; }
        public string CNCMake { get; set; }
        public string CNCModel { get; set; }
        public bool IsEnabledForDataRead { get; set; }
        public string UpperWarning { get; set; }
        public string LowerWarning { get; set; }
        public string UpperError { get; set; }
        public string LowerError { get; set; }
        public string Unit { get; set; }
        public string DeleteFlag { get; set; }
        public string Level { get; set; }
        public string ScreenName { get; set; }
        public string ID { get; set; }
        public bool IsDataType1Enabled { get; set; } //For PDF
        public bool IsDataType2Enabled { get; set; } //For PDF
        public string SrcDataType1PDF { get; set; } //For PDF
        public string SrcDataType2PDF { get; set; } //For PDF
    }
    public class LevelDashboardData
    {
        public string Month { get; set; }
        public string CompanyName { get; set; }
        public string PlantName { get; set; }
        public string Description { get; set; }
        public string CellName { get; set; }
        public string MachineName { get; set; }
        public string OEE { get; set; }
        public string QEffy { get; set; }
        public string AEffy { get; set; }
        public string PEffy { get; set; }
        public string QualityRate { get; set; }
        public string Revenue { get; set; }
        public string LossINR { get; set; }
        public string Attendance { get; set; }
        public string SafetyKPI { get; set; }
        public string AcceptedPart { get; set; }
        public string RejectCount { get; set; }
        public string pDate { get; set; }
    }
    public class DashboardLevelHistory
    {
        public string CompanyName { get; set; }
        public string PlantName { get; set; }
        public string CellName { get; set; }
        public string MachineName { get; set; }
        public string Frequency { get; set; }
        public string Date { get; set; }
    }
    public class MachineDocumentsData
    {
        public string L1 { get; set; }
        public string L2 { get; set; }
        public string L3 { get; set; }
        public string FileID { get; set; }
        public string MachineID { get; set; }
        public string MTB { get; set; }
        public string MTBSeialNumber { get; set; }
        public string ModelNumber { get; set; }
        public string FileName { get; set; }
        public string FileInBase64 { get; set; }
        public List<DocInBinary> DocumentInBytes { get; set; }
        public string Version { get; set; }
        public string UpdatedBy { get; set; }
        public string UpdatedTS { get; set; }
        public string FileExtension { get; set; }
        public string FileType { get; set; }
    }
    public class DocInBinary
    {
        public byte[] BinaryData { get; set; }
    }
    public class SignatureComparisionDetails
    {
        public ObjectId Id { get; set; }
        public string MachineID { get; set; }
        public string CompanyID { get; set; }
        public string PlantID { get; set; }
        public string ParameterID { get; set; }
        public string SignatureID { get; set; }
       // public string Seconds { get; set; }
       // public string SignatureValue { get; set; }
        public string Frequency { get; set; }
        public string ParameterValue { get; set; }
        [BsonDateTimeOptions(Kind = DateTimeKind.Local)]
        public DateTime? UpdatedDatetime { get; set; }
    }
    public class SignatureComparisionData
    {
        public string Company { get; set; }
        public string Plant { get; set; }
        public string MachineID { get; set; }
        public string ParameterID { get; set; }
        public string SignatureID { get; set; }
        public List<SignatureComparisionDetails> SignatureData { get; set; }
    }
    public class eDocumentData
    {
        public string MTB { get; set; }
        public string CNCMake { get; set; }
        public string CNCModel { get; set; }
        public string Model { get; set; }
        public string Category { get; set; }
        public string Subcategory { get; set; }
        public string Version { get; set; }
        public string Filename { get; set; }
        public string UpdatedBy { get; set; }
        public string UpdatedTS { get; set; }
        public string FileID { get; set; }
        public string CustomerName { get; set; }
        public string DateOfDispatchInString { get; set; }
        public string FileType { get; set; }
        [BsonDateTimeOptions(Kind = DateTimeKind.Local)]
        public DateTime? DateOfDispatchInDate { get; set; }
        public string CollectionName { get; set; }
        public string MachineModel { get; set; }
        public string MachineType { get; set; }
        public string MachineSlno { get; set; }
        public string Level { get; set; }
        public byte[] Document { get; set; }
    }
    public class SignatureComparisionChartData
    {
        public string ParameterID { get; set; }
        public List<SignatureComparisionChartMachineDetails> signatureComparisionChartMachineDetails { get; set; }
     
    }
    public class SignatureComparisionChartMachineDetails
    {
        public string CompanyID { get; set; }
        public string PlantID { get; set; }
        public string MachineID { get; set; }
        public List<double[]> data { get; set; }
        public List<Type> type { get; set; }
        public List<Plotline> plotLines { get; set; }
        public List<string> SignatureID { get; set; }
        public List<CycleInformationData> CycleData { get; set; }
    }
    public class plotLines
    {
        public string color { get; set; }
        public string dashStyle { get; set; }
        public int width { get; set; }
        public decimal value { get; set; }
    }
    public class ChartDetails
    {
        // public string ParameterName { get; set; }
        public List<string> XAxisValue { get; set; } = new List<string>();
        public List<double> YAxisValue { get; set; } = new List<double>();
    }
    public class Type
    {
        public double x { get; set; }
        public string text { get; set; }
        public string title { get; set; }
        public List<Styles> style { get; set; }
    }
    public class Plotline
    {
        public string color { get; set; }
        public double value { get; set; }
        public int width { get; set; }
        public List<XLabel> label { get; set; }
    }
    public class CycleInformationData
    {
        public string CycleStart { get; set; }
        public string CycleEnd { get; set; }
        //public List<double[]> CycleData { get; set; }
    }
    public class SignatureComparisionZoomChartData
    {
        public List<double[]> referenceData { get; set; }
        public List<double[]> actualData { get; set; }
    }
    public class ProcessParameterDashboardAlarmDetails
    {
        public string MachineID { get; set; }
        public List<AlarmDetails> alarmDetails { get; set; }

    }
    public class AlarmDetails
    {
        public string AlarmMsg { get; set; }
    }
    public class ProcessParameterDashboardTimeBarData
    {
        public List<double[]> data { get; set; }
    }
    public class TroubleshootingData
    {
        public string Region { get; set; }
        public string Customer { get; set; }
        public string Principal { get; set; }
        public string ModelName { get; set; }
        public string SlNo { get; set; }
        public string WarrantyStatus { get; set; }
        public string TotalMcBDHours { get; set; }
        public string Description { get; set; }
        public string MainAssembly { get; set; }
        public string MainArea { get; set; }
        public string SubArea { get; set; }
        public string Category { get; set; }
        public string ProbableReasons { get; set; }
        public string ProblemDesc { get; set; }
        public string SolutionDesc { get; set; }
        public string Solution { get; set; }
        public string ProblemObserved { get; set; }
    }
    public class TroubleshootingData1
    {
        public string Region { get; set; }
        public string Customer { get; set; }
        public string Principal { get; set; }
        public string ModelName { get; set; }
        public string SlNo { get; set; }
        public string WarrantyStatus { get; set; }
        public string TotalMcBDHours { get; set; }
        public string Description { get; set; }
        public string MainAssembly { get; set; }
        public string MainArea { get; set; }
        public string SubArea { get; set; }
        public string Category { get; set; }
        public string ProbableReasons { get; set; }
        public string ProblemDescription { get; set; }
        public string SolutionDescription { get; set; }
        public string Solution { get; set; }
        public string ProblemObserved { get; set; }
    }
    public class TroubleshootingChartData
    {
        public string name { get; set; }
        public double weight { get; set; }
        public string clickStatus { get; set; }
        // public string color { get; set; }
    }
    public class DataToSavePPReference
    {
        public DateTime UpdatedTS { get; set; }
        public string Value { get; set; }
        public string Frequency { get; set; }
    }
    public class ParameterWiseValidationData
    {
        public string Parameter { get; set; }
        public List<string> PolliFreq { get; set; }
    }
    public class SourceTypeWiseValidationData
    {
        public string SourceType { get; set; }
        public bool IsEnabled { get; set; }
        public List<string> SourceAdd1 { get; set; }
        public List<string> SourceAdd2 { get; set; }
        public List<string> SourceDataType1 { get; set; }
        public List<string> SourceDataType2 { get; set; }
        public List<string> DataType1Condition { get; set; }
        public List<string> DataType2Condition { get; set; }
    }
    public class AlarmHistoryData
    {
        public string AlarmNo { get; set; }
        public string Message { get; set; }
        public string LastSeen { get; set; }
        public string NoOfOccurences { get; set; }
        public string SlNo { get; set; }
        public string AlarmCause { get; set; }
        public string AlarmSolution { get; set; }
        public string Duration { get; set; }
        public string HoursLeft { get; set; }
        public string Time { get; set; }
    }
    public class ShiftData
    {
        public string Shiftname { get; set; }
        public string StartTime { get; set; }
        public string EndTime { get; set; }
    }
    public class AlarmHistoryDocData
    {
        public string FileID { get; set; }
        public string FileName { get; set; }
        public string FileInBase64 { get; set; }
        public string FileExtension { get; set; }
        public string FileType { get; set; }
    }

    public class CompanyGroupDetails
    {
        public string GroupID { get; set; }
        public string CorporateID { get; set; }
        public string GroupName { get; set; }
        public string CompanyID { get; set; }
        public string CompanyName { get; set; }
        public string ContactPerson { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public string Address { get; set; }
        public string State { get; set; }
        public string Place { get; set; }
        public string Country { get; set; }
        public string Pin { get; set; }
        public string EffectiveFromDate { get; set; }
        public string EffectiveToDate { get; set; }

        public string UserID { get; set; }
        public string Password { get; set; }

        public string NewOrEditParam { get; set; }
    }

    public class PlantLevelDetails
    {
        public string GroupID { get; set; }
        public string CompanyID { get; set; }

        public string PlantID { get; set; }
        public string ShopID { get; set; }
        public string CellID { get; set; }

        public string Description { get; set; } 
        public string Code { get; set; }
        public string Address { get; set; }
        public string Country { get; set; }
        public string Region { get; set; }
        public string GeoLocation { get; set; }
        public string City { get; set; }
        public string EffectiveFromDate { get; set; }
        public string EffectiveToDate { get; set; }

        public string CompanyAdmin { get; set; }

        public string NewOrEditParam { get; set; }
    }
    public class CellData
    {
        public string CompanyID { get; set; }
        public string PlantID { get; set; }
        public string CellId { get; set; }
        public string GroupID { get; set; }
        public string CellDesc { get; set; }
        public string GroupDesc { get; set; }
        public string UpdatedBy { get; set; }
        public string UpdatedTS { get; set; }
        public string EffectiveToDate { get; set; }

        public string EffectiveFromDate { get; set; }
    }
    public class MachineData
    {
        public string CompanyID { get; set; }
        public string MachineID { get; set; }
        public string IOTID { get; set; }
        public string InterfaceID { get; set; }
        public string MachineDisplayName { get; set; }
        public string MachineType { get; set; }
        public string MachineMTB { get; set; }
        public string MachineModel { get; set; }
        public string CNCMake { get; set; }
        public string CNCModel { get; set; }
        public string PLCMake { get; set; }
        public string PLCModel { get; set; }
        public string IPAddress { get; set; }
        public string IPPortNo { get; set; }
        public string Mchrrate { get; set; }
        public bool TPMTrakEnabled { get; set; }
        public bool MultiSpindleFlag { get; set; }
        public string DeviceType { get; set; }
        public string MachinewiseOwner { get; set; }
        public bool CriticalMachineEnabled { get; set; }
        public bool DAPEnabled { get; set; }
        public bool EthernetEnabled { get; set; }
        public bool Nto1Device { get; set; }
        public string DNCIP { get; set; }
        public string DNCIPPortNo { get; set; }
        public bool DNCTransferEnabled { get; set; }
        public bool ProgramFolderEnabled { get; set; }
        public string AutoSetupChangeDown { get; set; }
        public bool AGIEnabled { get; set; }
        public string OPCUAURL { get; set; }
        public string ControllerType { get; set; }
        public string SerialNumber { get; set; }
        public string OEETarget { get; set; }
        public bool EnablePartCountByMacro { get; set; }

        public string Protocol { get; set; }
        public string OPCUrl { get; set; }
        public bool OEEEnabled { get; set; }
        public bool CNCParamEnabled { get; set; }
        public bool EneryEnabled { get; set; }
        public bool DeviceEnabled { get; set; }

        public string UpdatedTS { get; set; }
        public string UpdatedBy { get; set; }

        public string SyncedStatus { get; set; }
        public string EffectiveFromDate { get; set; }
        public string EffectiveToDate { get; set; }
    }
    public class UserData
    {
        public string CorporateID { get; set; }
        public string CompanyID { get; set; }
        public string UserID { get; set; }
        public string Username { get; set; }
        public bool IsGroupUser { get; set; }
        public string IOTID { get; set; }
        public string Address { get; set; }
        public string Password { get; set; }
        public string Email { get; set; }
        public string MobileNo { get; set; }
        public byte[] UserImage { get; set; }
        public string UserImageInBase64 { get; set; }
        public string Role { get; set; }
        public bool IsEmployee { get; set; }
        public string EffectiveFromDate { get; set; }
        public string EffectiveToDate { get; set; }
        public string UpdatedBy { get; set; }
        public string UpdatedTS { get; set; }
        public string EmployeeID { get; set; }
    }

    public class LevelHeirarchyDetails
    {
        public string CompanyID { get; set; }
        public string PlantID { get; set; }
        public string KeyID { get; set; }
        public string KeyValue { get; set; }
        public string DisplayValue { get; set; }
        public string EffectiveFromDate { get; set; }
        public string EffectiveToDate { get; set; }
        public bool CheckOrUncheck { get; set; }

        public string Display { get; set; }
    }

    public class MachineAssignDetails
    {
        public string CompanyID { get; set; }
        public string MachineID { get; set; }
        public string PlantID { get; set; }
        public string ShopID { get; set; }
        public string CellID { get; set; }
        public string GroupID { get; set; }
        public string EffectiveFromDate { get; set; }
        public string EffectiveToDate { get; set; }
        public string CheckOrUncheck { get; set; }
        public string Type { get; set; }
    }

    public class RoleDetails
    {
        public string CompanyID { get; set; }
        public string RoleID { get; set; }
        public string RoleName { get; set; }
        public string EffectiveFromDate { get; set; }
        public string EffectiveToDate { get; set; }
        public string UpdatedBy { get; set; }
        public string UpdatedTS { get; set; }
        public string NewOrEditParam { get; set; }
    }
    public class UserRoleData
    {
        public string CheckOrUncheck { get; set; }
        public string RoleID { get; set; }
        public string UserID { get; set; }
        public string Value { get; set; }
        public string CompanyID { get; set; }
        public string Module { get; set; }
        public string Screen { get; set; }
        public List<UserRoleRightsData> UserRightValue { get; set; }
    }
    public class UserRoleRightsData
    {
        public string HeaderTemplateVisibility { get; set; }
        public string DataTemplateVisibility { get; set; }
        public string UserID { get; set; }
        public string RoleID { get; set; }
        public bool IsReadChecked { get; set; }
        public bool IsModifyChcked { get; set; }
        public bool IsNoneChacked { get; set; }
    }

    public class MenuShowHide
    {
        public string Module { get; set; }
        public string Screen { get; set; }
        public string Value { get; set; }
        public bool Visible { get; set; }
    }

    public class GroupData
    {
        public string Group { get; set; }
        public string IconVisibility { get; set; }
        public List<CompanyData> CompanyList { get; set; }
    }
    public class CompanyData
    {
        public string Company { get; set; }
        public string IconVisibility { get; set; }
        public List<PlantData1> PlantList { get; set; }
    }
    public class PlantData1
    {
        public string Group { get; set; }
        public string Company { get; set; }
        public string Plant { get; set; }
    }
}