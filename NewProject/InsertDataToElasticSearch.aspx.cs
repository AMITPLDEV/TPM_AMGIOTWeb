using MongoDB.Driver.Core.Configuration;
using Nest;
using NewProject.Model;
using OfficeOpenXml;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NewProject
{
    public partial class InsertDataToElasticSearch : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void lnkbtnImportFile_Click(object sender, EventArgs e)
        {
            int success = 0;
            string APP_PATH = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location);
            DataTable dtProdOrder = new DataTable();
            if (fileprodOrder.HasFile)
            {
                string fileName = fileprodOrder.FileName;
                if (Path.GetExtension(fileName) != ".xlsx")
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "RecordsTextopenModaladded", "openWarningModal('Please choose a valid excel(.xlsx) file.');", true);
                    return;
                }
                else
                {
                    string savedFileName = "";
                    if (!Directory.Exists(Server.MapPath("ImportedFiles")))
                    {
                        Directory.CreateDirectory(Server.MapPath("ImportedFiles"));
                        savedFileName = Server.MapPath("ImportedFiles//" + fileName);

                    }
                    else
                    {
                        savedFileName = Server.MapPath("ImportedFiles//" + fileName);
                    }
                  
                    fileprodOrder.SaveAs(savedFileName);
                    List<TroubleshootingData1> list = GetDataTableFromFile(savedFileName);
                    if (list.Count > 0)
                    {
                        var uris = new Uri(ConfigurationManager.AppSettings["elasticsearchConnString"].ToString());
                        var settings = new Nest.ConnectionSettings(uris);
                        var client = new ElasticClient(settings);
                        var bulkIndexResponse = client.Bulk(b => b
                                            .Index("servicereport2")
                                            .IndexMany(list)
                                        );
                    }
                
                }

            }
        }
        private List<TroubleshootingData1> GetDataTableFromFile(string fileName)
        {
           // DataTable dtPartStation = new DataTable();
            List<TroubleshootingData1> list = new List<TroubleshootingData1>();
            TroubleshootingData1 data = null;
            using (var pck = new ExcelPackage())
            {
                using (var stream = File.OpenRead(fileName))
                {
                    pck.Load(stream);
                }
                var workBook = pck.Workbook;
                if (workBook != null)
                {
                    try
                    {
                        var worksheet = workBook.Worksheets[1];
                        //dtPartStation.Columns.Add("PartNumber");
                        //dtPartStation.Columns.Add("TaktTime");
                        //dtPartStation.Columns.Add("ThresholdTime");
                        //dtPartStation.Columns.Add("Line");
                        //dtPartStation.Columns.Add("Station");

                        int startRow = 2, tblColStart = 0;
                        int lastRow = GetLastUsedRow(worksheet);
                        for (var rowNum = startRow; rowNum <= lastRow; rowNum++)
                        {
                            //var wsRow = worksheet.Cells[rowNum, 2, rowNum, 6];
                            data = new TroubleshootingData1();
                            tblColStart = 0;
                            data.Region = worksheet.Cells[rowNum, 1].Text;
                            data.Customer = worksheet.Cells[rowNum, 2].Text;
                            data.Principal = worksheet.Cells[rowNum, 3].Text;
                            data.ModelName = worksheet.Cells[rowNum, 4].Text;
                            data.SlNo = worksheet.Cells[rowNum, 5].Text;
                            data.WarrantyStatus = worksheet.Cells[rowNum, 6].Text;
                            data.Category = worksheet.Cells[rowNum, 7].Text;
                            data.TotalMcBDHours = worksheet.Cells[rowNum, 8].Text;
                            data.Description = worksheet.Cells[rowNum, 9].Text;
                            data.ProblemDescription = worksheet.Cells[rowNum, 10].Text;
                            data.MainAssembly = worksheet.Cells[rowNum, 11].Text;
                            data.MainArea = worksheet.Cells[rowNum, 12].Text;
                            data.SubArea = worksheet.Cells[rowNum, 13].Text;
                            data.ProblemObserved = worksheet.Cells[rowNum, 14].Text;
                            data.Solution = worksheet.Cells[rowNum, 15].Text;
                            data.SolutionDescription = worksheet.Cells[rowNum, 16].Text;
                            data.ProbableReasons = worksheet.Cells[rowNum, 17].Text;
                            list.Add(data);
                        }
                    }
                    catch (Exception ex)
                    {
                        Logger.WriteDebugLog("Error while importing Part Station Information excel file : " + ex.Message);
                    }
                }
            }
            return list;
        }
        private static int GetLastUsedRow(ExcelWorksheet sheet)
        {
            var row = sheet.Dimension.End.Row;
            while (row >= 1)
            {
                var range = sheet.Cells[row, 1, row, sheet.Dimension.End.Column];
                if (range.Any(c => !string.IsNullOrEmpty(c.Text)))
                {
                    break;
                }
                row--;
            }
            return row;
        }
    }
}