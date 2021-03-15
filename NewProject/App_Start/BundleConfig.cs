using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.UI;

namespace NewProject
{
    public class BundleConfig
    {
        // For more information on Bundling, visit https://go.microsoft.com/fwlink/?LinkID=303951
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/WebFormsJs").Include(
                            "~/Scripts/WebForms/WebForms.js",
                            "~/Scripts/WebForms/WebUIValidation.js",
                            "~/Scripts/WebForms/MenuStandards.js",
                            "~/Scripts/WebForms/Focus.js",
                            "~/Scripts/WebForms/GridView.js",
                            "~/Scripts/WebForms/DetailsView.js",
                            "~/Scripts/WebForms/TreeView.js",
                            "~/Scripts/WebForms/WebParts.js"));

            // Order is very important for these files to work, they have explicit dependencies
            bundles.Add(new ScriptBundle("~/bundles/MsAjaxJs").Include(
                    "~/Scripts/WebForms/MsAjax/MicrosoftAjax.js",
                    "~/Scripts/WebForms/MsAjax/MicrosoftAjaxApplicationServices.js",
                    "~/Scripts/WebForms/MsAjax/MicrosoftAjaxTimer.js",
                    "~/Scripts/WebForms/MsAjax/MicrosoftAjaxWebForms.js"));

            // Use the Development version of Modernizr to develop with and learn from. Then, when you’re
            // ready for production, use the build tool at https://modernizr.com to pick only the tests you need
            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                            "~/Scripts/modernizr-*"));


            bundles.Add(new ScriptBundle("~/bundles/masterjs").Include(
"~/js/bootstrap.min.js",
"~/js/jquery.validate.min.js",
"~/js/form-validation-script.js",
"~/Scripts/LoadingImgJs/JavaScriptUIBlocker.js"
));

            bundles.Add(new ScriptBundle("~/bundles/decompress").Include(
//"~/Scripts/zlib.min.js",
//"~/Scripts/Zlib/gzip.min.js",
//    "~/Scripts/inflate.min.js",

//"~/Scripts/rawinflate.min.js",
//  "~/Scripts/inflate_stream.min.js"
"~/Scripts/pako.inflate.js",
"~/Scripts/pako.min.js"

));
        }
    }
}