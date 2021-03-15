using OfficeOpenXml;
using OfficeOpenXml.Style;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;

namespace NewProject.HelperClass
{
    public class GenerateExcelReport
    {
        static readonly string appPath = HttpContext.Current.Server.MapPath("");

        #region "Get Report Template File Path"
        public static string GetReportPath(string reportName)
        {
            string src = string.Empty;
            if (HttpContext.Current.Session["Language"] == null)
                src = Path.Combine(appPath, "ExportTempaltes", reportName);
            else
            {
                if (HttpContext.Current.Session["Language"].ToString() != "en")
                    src = Path.Combine(appPath, "ExportTempaltes", reportName);
                else
                    src = Path.Combine(appPath, "ExportTempaltes", reportName);
            }
            return src;
        }


        #endregion
        public static string SafeFileName(string name)
        {
            StringBuilder str = new StringBuilder(name);
            foreach (char c in System.IO.Path.GetInvalidFileNameChars())
            {
                str = str.Replace(c, '_');
            }
            return str.ToString();
        }
        internal static void setWorkSheetSetting(ExcelWorksheet wksheet)        {            wksheet.PrinterSettings.Orientation = eOrientation.Landscape;            wksheet.PrinterSettings.FitToPage = true;            wksheet.PrinterSettings.FitToWidth = 1;            wksheet.PrinterSettings.FitToHeight = 0;

        }
        private static void DownloadMultipleFile(string fileName, byte[] byteArray)
        {
            try
            {
                HttpContext.Current.Response.Clear();
                HttpContext.Current.Response.Charset = "";
                HttpContext.Current.Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                HttpContext.Current.Response.AddHeader("Content-Disposition", "attachment; filename=\"" + Path.GetFileName(fileName) + "\"");
                HttpContext.Current.Response.OutputStream.Write(byteArray, 0, byteArray.Length);
                HttpContext.Current.Response.Flush();
                HttpContext.Current.Response.SuppressContent = true;
                HttpContext.Current.ApplicationInstance.CompleteRequest();
            }
            catch (Exception ex)
            {
                //ErrorSignal.FromCurrentContext().Raise(ex);
            }
        }

        internal static string generateProcessParameterListOfValuesReoprt(DataTable data)
        {
            string generated = "";
            try
            {
                string Filename = "ProcessParameterListOfValues.xlsx";
                string Source = GetReportPath(Filename);
                string Template = "ProcessParameterListOfValues" + DateTime.Now + ".xlsx";
                string destination = Path.Combine(appPath, "Temp", SafeFileName(Template));
                if (!File.Exists(Source))
                {
                    Logger.WriteDebugLog("ProcessParameterListOfValues Template not exists - " + Source);
                    generated = "TemplateNotFound";
                }
                else
                {
                    int rowStart=3;
                    int rowIncrement = 1;
                    int colStart = 1;
                    FileInfo newFile = new FileInfo(Source);
                    ExcelPackage Excel = new ExcelPackage(newFile, true);
                    //Excel.Workbook.Worksheets.Delete("Sheet1");
                    if (data.Rows.Count >0)
                    {
                        var workSheet = Excel.Workbook.Worksheets[1];
                        setWorkSheetSetting(workSheet);
                        string[] columnNames = data.Columns.Cast<DataColumn>()
                                   .Select(x => x.ColumnName)
                                   .ToArray();

                        workSheet.Cells[1, 1, 1, data.Columns.Count].Value = "Process Parameter List Of Values";
                        workSheet.Cells[1, 1, 1, data.Columns.Count].Merge = true;
                        workSheet.Cells[1, 1, 1, data.Columns.Count].Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                        workSheet.Cells[1, 1, 1, data.Columns.Count].Style.Font.Bold = true;
                        workSheet.Cells[1, 1, 1, data.Columns.Count].Style.Font.Size = 13;
                        workSheet.Cells[1, 1, 1, data.Columns.Count].Style.Fill.PatternType = ExcelFillStyle.Solid;
                        workSheet.Cells[1, 1, 1, data.Columns.Count].Style.Fill.BackgroundColor.SetColor(System.Drawing.Color.Yellow);

                        rowIncrement = rowIncrement + 2;
                        for (int i = 0; i < columnNames.Length; i++)
                        {
                            workSheet.Cells[rowIncrement, i + 1].Value = columnNames[i];
                            workSheet.Cells[rowIncrement, i + 1].Style.Font.Bold = true;
                            workSheet.Cells[rowIncrement, i + 1].Style.Font.Size = 12;
                            workSheet.Cells[rowIncrement, i + 1].Style.Fill.PatternType = ExcelFillStyle.Solid;
                            workSheet.Cells[rowIncrement, i + 1].Style.Fill.BackgroundColor.SetColor(System.Drawing.Color.Yellow);
                        }

                        rowIncrement++;
                        for (int i = 0; i < data.Rows.Count; i++)
                        {
                            for (int j = 0; j < data.Columns.Count; j++)
                            {
                                workSheet.Cells[rowIncrement, j + 1].Value = data.Rows[i][j];
                            }
                            rowIncrement++;
                        }
                        workSheet.Cells[1, 1, data.Rows.Count, data.Columns.Count].AutoFitColumns();
                        workSheet.Cells[rowStart, 1, data.Rows.Count, data.Columns.Count].Style.Border.Top.Style = OfficeOpenXml.Style.ExcelBorderStyle.Thin;
                        workSheet.Cells[rowStart, 1, data.Rows.Count, data.Columns.Count].Style.Border.Left.Style = OfficeOpenXml.Style.ExcelBorderStyle.Thin;
                        workSheet.Cells[rowStart, 1, data.Rows.Count, data.Columns.Count].Style.Border.Right.Style = OfficeOpenXml.Style.ExcelBorderStyle.Thin;
                        workSheet.Cells[rowStart, 1, data.Rows.Count, data.Columns.Count].Style.Border.Bottom.Style = OfficeOpenXml.Style.ExcelBorderStyle.Thin;
                        workSheet.Cells[rowStart, 1, data.Rows.Count, data.Columns.Count].Style.Border.Top.Color.SetColor(System.Drawing.Color.Black);
                        workSheet.Cells[rowStart, 1, data.Rows.Count, data.Columns.Count].Style.Border.Left.Color.SetColor(System.Drawing.Color.Black);
                        workSheet.Cells[rowStart, 1, data.Rows.Count, data.Columns.Count].Style.Border.Right.Color.SetColor(System.Drawing.Color.Black);
                        workSheet.Cells[rowStart, 1, data.Rows.Count, data.Columns.Count].Style.Border.Bottom.Color.SetColor(System.Drawing.Color.Black);

                        DownloadMultipleFile(destination, Excel.GetAsByteArray());
                        generated = "Generated";

                    }
                    else
                    {
                        generated = "DataNotFound";
                    }
                  
                   
                }
            }
            catch (Exception ex)
            {
                generated = "Error";
                Logger.WriteErrorLog(ex.Message);
            }
            return generated;
        }

    }
}   