using MongoDB.Bson;
using MongoDB.Driver;
using MongoDB.Driver.GridFS;
using NewProject.Model;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
//using System.Linq.Enumerable;

namespace NewProject.DataBaseAccess
{
   
    public class MongoDBAccess
    {
        private readonly static IMongoClient _MongoClient = null;
        private readonly static IMongoDatabase _MongoDatabase;
        private readonly static IMongoDatabase _MongoDatabaseEDoc;
        private static string mongoDBConnString = ConfigurationManager.AppSettings["mongoDBConnString"].ToString();
        static MongoDBAccess()
        {
            _MongoClient = new MongoClient(mongoDBConnString);
            _MongoDatabase = _MongoClient.GetDatabase(ConfigurationManager.AppSettings["mongoDBName"].ToString());
            _MongoDatabaseEDoc = _MongoClient.GetDatabase(ConfigurationManager.AppSettings["eDocMongoDBName"].ToString());
            // _MongoDatabase = _MongoClient.GetDatabase("AMGIOT");
            // _MongoDatabase = _MongoClient.GetDatabase("AMGIOT-R");
        }

        public static List<ListItem> getParameterListForMachines(BsonArray machineNames, string company, string plant)
        {
            List<ListItem> listItemList = new List<ListItem>();
            try
            {
               
                var match = new BsonDocument
                    {
                        {
                            //"$match", new BsonDocument
                            //{
                            //    { "MachineID" , new BsonDocument{
                            //        { "$in" ,machineNames }
                            //    }

                            //      //,
                            //    //  { "IsEnabledForGraph" , new BsonDocument{
                            //    //    { "$eq" ,1 }
                            //    //} }

                            //    }

                            //}

                            "$match", new BsonDocument
                                {
                                    { "MachineID" , new BsonDocument{
                                        { "$in" ,machineNames }
                                    }

                                    }  ,
                                      { "IsEnabledForGraph" , new BsonDocument{
                                        { "$eq" ,"1" }
                                    } },
                                  {
                                      "CompanyID", company
                                  },
                                  {
                                      "PlantID", plant
                                  }
                                }
                            }
                    };
                var project = new BsonDocument
                    {
                        {
                            "$project" ,new BsonDocument {

                                { "ParameterID" , "$ParameterID"},
                                { "_id" , 0 }
                            }
                        }
                    };
                var group = new BsonDocument
                    {
                        {
                            "$group" ,new BsonDocument {
                                {"_id" , "" },
                                {"distinct",new BsonDocument
                                {
                                    {"$addToSet" , "$$ROOT" }
                                } }
                            }
                        }
                    };
                var unwind = new BsonDocument
                    {
                        {
                            "$unwind" ,new BsonDocument {
                                {"path" , "$distinct" },
                                {"preserveNullAndEmptyArrays", false }
                            }
                        }
                    };
                var replaceRoot = new BsonDocument
                    {
                        {
                            "$replaceRoot" ,new BsonDocument {
                                {"newRoot" , "$distinct" }
                            }
                        }
                    };

                AggregateOptions aggregateOptions = new AggregateOptions { AllowDiskUse = true };
                PipelineDefinition<BsonDocument, BsonDocument> pipeline2 = new BsonDocument[]
                {
                       match,project,group,unwind,replaceRoot
                };
                IAsyncCursor<BsonDocument> result = _MongoDatabase.GetCollection<BsonDocument>("ProcessParameterMaster").Aggregate(pipeline2, aggregateOptions);
                var resultSet = IAsyncCursorExtensions.ToList<BsonDocument>(result);

                
                foreach (BsonDocument doc in resultSet)
                {
                    listItemList.Add(new ListItem(doc["ParameterID"].AsString, doc["ParameterID"].AsString));
                }

            }
            catch(Exception ex)
            {
                Logger.WriteErrorLog("Getting Parameters " + ex.Message);
            }
            return listItemList;
        }

        public static List<ListItem> getCoomomParameterListForMachines(BsonArray machineNames,string company,string plant)
        {
            List<ListItem> listItemList = new List<ListItem>();
            try
            {

                var match = new BsonDocument
                    {
                        {
                            //"$match", new BsonDocument
                            //{
                            //    { "MachineID" , new BsonDocument{
                            //        { "$in" ,machineNames }
                            //    } }
                            //}
                              "$match", new BsonDocument
                                {
                                    { "MachineID" , new BsonDocument{
                                        { "$in" ,machineNames }
                                    }

                                    }  ,
                                      { "IsEnabledForGraph" , new BsonDocument{
                                        { "$eq" ,"1" }
                                    } },
                                  {
                                      "CompanyID", company
                                  },
                                  {
                                      "PlantID", plant
                                  }
                                }
                        }
                    };
                var group = new BsonDocument
                    {
                        {
                            "$group" ,new BsonDocument {
                                {"_id" , "$ParameterID" },
                                {"MachineID",new BsonDocument
                                {
                                    {"$addToSet" , "$MachineID" }
                                } }
                            }
                        }
                    };
                var match1 = new BsonDocument
                    {
                        {
                            "$match", new BsonDocument
                            {
                                { "MachineID" , new BsonDocument{
                                    { "$all" ,machineNames }
                                } }
                            }
                        }
                    };

                AggregateOptions aggregateOptions = new AggregateOptions { AllowDiskUse = true };
                PipelineDefinition<BsonDocument, BsonDocument> pipeline2 = new BsonDocument[]
                {
                       match,group,match1
                };
                IAsyncCursor<BsonDocument> result = _MongoDatabase.GetCollection<BsonDocument>("ProcessParameterMaster").Aggregate(pipeline2, aggregateOptions);
                var resultSet = IAsyncCursorExtensions.ToList<BsonDocument>(result);


                foreach (BsonDocument doc in resultSet)
                {
                    listItemList.Add(new ListItem(doc["_id"].AsString, doc["_id"].AsString));
                }

            }
            catch (Exception ex)
            {

            }
            return listItemList;
        }
        public static List<string> getMachineID(string company, string plant)
        {
            List<string> listItemList = new List<string>();

            try
            {
                var match = new BsonDocument
{
{
"$match",new BsonDocument
{
{"CompanyID",company },
{"PlantID",plant }
}
}
};
                var project = new BsonDocument
{
{
"$project" ,new BsonDocument {

{ "MachineID" , "$MachineID"},
{ "_id" , 0 }
}
}
};
                var group = new BsonDocument
{
{
"$group" ,new BsonDocument {
{"_id" , "" },
{"distinct",new BsonDocument
{
{"$addToSet" , "$$ROOT" }
}
}
}
}
};
                var unwind = new BsonDocument
{
{
"$unwind" ,new BsonDocument {
{"path" , "$distinct" },
{"preserveNullAndEmptyArrays", false }
}
}
};
                var replaceRoot = new BsonDocument
{
{
"$replaceRoot" ,new BsonDocument {
{"newRoot" , "$distinct" }
}
}
};

                AggregateOptions aggregateOptions = new AggregateOptions { AllowDiskUse = true };
                PipelineDefinition<BsonDocument, BsonDocument> pipeline2 = new BsonDocument[]
                {
match,project,group,unwind,replaceRoot
                };
                IAsyncCursor<BsonDocument> result = _MongoDatabase.GetCollection<BsonDocument>("ProcessParameterMaster").Aggregate(pipeline2, aggregateOptions);
                var resultSet = IAsyncCursorExtensions.ToList<BsonDocument>(result);


                foreach (BsonDocument doc in resultSet)
                {
                    listItemList.Add(doc["MachineID"].AsString);
                }

            }
            catch (Exception ex)
            {
                Logger.WriteDebugLog("Machine ID: " + ex.Message);
            }
            return listItemList;
        }


        public static List<string> getSignatureId(string machine, BsonArray parameters)
        {
            List<string> listItemList = new List<string>();
            try
            {

                var match = new BsonDocument
                            {
                            {
                            "$match", new BsonDocument
                            {
                            { "MachineID" , machine},
                            { "ParameterID" , new BsonDocument{
                            { "$in" ,parameters }
                            } }
                            }
                            }
                            };
                var project = new BsonDocument
                                {
                                {
                                "$project" ,new BsonDocument {

                                { "SignatureID" , "$SignatureID"},
                                { "_id" , 0 }
                                }
                                }
                                };
                var group = new BsonDocument
                                {
                                {
                                "$group" ,new BsonDocument {
                                {"_id" , "" },
                                {"distinct",new BsonDocument
                                {
                                {"$addToSet" , "$$ROOT" }
                                } }
                                }
                                }
                                };
                var unwind = new BsonDocument
                            {
                            {
                            "$unwind" ,new BsonDocument {
                            {"path" , "$distinct" },
                            {"preserveNullAndEmptyArrays", false }
                            }
                            }
                            };
                var replaceRoot = new BsonDocument
                            {
                            {
                            "$replaceRoot" ,new BsonDocument {
                            {"newRoot" , "$distinct" }
                            }
                            }
                            };

                AggregateOptions aggregateOptions = new AggregateOptions { AllowDiskUse = true };
                PipelineDefinition<BsonDocument, BsonDocument> pipeline2 = new BsonDocument[]
                {
match,project,group,unwind,replaceRoot
                };
                IAsyncCursor<BsonDocument> result = _MongoDatabase.GetCollection<BsonDocument>("SignatureMaster").Aggregate(pipeline2, aggregateOptions);
                var resultSet = IAsyncCursorExtensions.ToList<BsonDocument>(result);


                foreach (BsonDocument doc in resultSet)
                {
                    listItemList.Add(doc["SignatureID"].AsString);
                }

            }
            catch (Exception ex)
            {

            }
            return listItemList;
        }

        public static List<ProcessParameterDashboardAlarmDetails> getAlarmLiveDetails(BsonArray machineNames,string company,string plant)
        {
            List<ProcessParameterDashboardAlarmDetails> machinesAlarmData = new List<ProcessParameterDashboardAlarmDetails>();

            PipelineDefinition<BsonDocument, BsonDocument> query = null;
            try
            {
               // Logger.WriteDebugLog("Machine Pass Count : " + machineNames.Count);
                //var match = new BsonDocument
                //    {
                //        {

                //            "$match", new BsonDocument
                //                {
                //                    { "MachineID" , new BsonDocument{
                //                        { "$in" ,machineNames }
                //                    } },

                //                    {
                //                    "Company",company
                //                },
                //                    {
                //                    "PlantID",plant
                //                }


                //                }
                //            }
                //    };
                var machineMatch = new BsonDocument
                {
                     { "MachineID" , new BsonDocument{
                                        { "$in" ,machineNames }
                                    } }
                };
                var companyMatch = new BsonDocument
                {
                     { "CompanyID" , company}
                };
                var plantMatch = new BsonDocument
                {
                     { "PlantID" , plant}
                };
                BsonArray matcharray = new BsonArray();
                matcharray.Add(machineMatch);
                matcharray.Add(companyMatch);
                matcharray.Add(plantMatch);

                //BsonDocument finalMatch = new BsonDocument();
                //finalMatch.Add(new BsonElement(data.Key, matcharray));
               
             
                var match = new BsonDocument
                    {
                        {

                            "$match", new BsonDocument
                                {
                                {
                                       "$and",matcharray
                                }
                                }
                            }
                    };
                var project = new BsonDocument
                    {
                        {
                            "$project" ,new BsonDocument {

                                { "Message" , "$Message"},
                               // { "AlarmTime" , "$AlarmTime"},
                                { "MachineID" , "$MachineID"},
                                { "_id" , 0 }
                            }
                        }
                    };
                var group = new BsonDocument
                    {
                        {
                            "$group" ,new BsonDocument {
                                {"_id" , "" },
                                {"distinct",new BsonDocument
                                {
                                    {"$addToSet" , "$$ROOT" }
                                } }
                            }
                        }
                    };
                var unwind = new BsonDocument
                    {
                        {
                            "$unwind" ,new BsonDocument {
                                {"path" , "$distinct" },
                                {"preserveNullAndEmptyArrays", false }
                            }
                        }
                    };
                var replaceRoot = new BsonDocument
                    {
                        {
                            "$replaceRoot" ,new BsonDocument {
                                {"newRoot" , "$distinct" }
                            }
                        }
                    };

                var sort = new BsonDocument
                    {
                        {
                            "$sort" ,new BsonDocument {
                                {"AlarmTime" , -1 }

                            }
                        }
                    };

                var projectToDisplay = new BsonDocument
                    {
                        {
                            "$project" ,new BsonDocument {
                                {"Message" , 1 },
                                 { "MachineID" , 1}
                            }
                        }
                    };

                AggregateOptions aggregateOptions = new AggregateOptions { AllowDiskUse = true };
                PipelineDefinition<BsonDocument, BsonDocument> pipeline2 = new BsonDocument[]
                {
                       match,sort,project,group,unwind,replaceRoot,projectToDisplay
                };
                query = pipeline2;
                IAsyncCursor<BsonDocument> result = _MongoDatabase.GetCollection<BsonDocument>("AlarmLiveTransaction").Aggregate(pipeline2, aggregateOptions);
                var dataset = IAsyncCursorExtensions.ToList<BsonDocument>(result);


                var distinctMachineIDs = dataset.Select(x => x["MachineID"]).Distinct().ToList();

                ProcessParameterDashboardAlarmDetails machineAlarmData = null;
                foreach (string machine in distinctMachineIDs)
                {
                    machineAlarmData = new ProcessParameterDashboardAlarmDetails();
                    machineAlarmData.MachineID = machine;
                    List<AlarmDetails> alarmDatas = new List<AlarmDetails>();
                    AlarmDetails alarmData = null;
                    int slNo = 1;
                    foreach (var item in dataset)
                    {
                        if (machine == item["MachineID"].ToString())
                        {
                            if (slNo < 11)
                            {
                                alarmData = new AlarmDetails();
                                alarmData.AlarmMsg = slNo + ". " + item["Message"].ToString();
                                alarmDatas.Add(alarmData);
                                slNo++;
                            }
                            else
                            {
                                break;
                            }
                        }
                    }
                    machineAlarmData.alarmDetails = alarmDatas;
                    machinesAlarmData.Add(machineAlarmData);
                }
               // Logger.WriteDebugLog("Total Alarm Machine Coutnt : " + machinesAlarmData.Count);
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("Getting Alarm Live Details " + ex.Message + "-------Query : " + query);
            }
            return machinesAlarmData;
        }

        public static List<ProcessParameterDashboardAlarmDetails> getAlarmHistoryDetails(BsonArray machineNames, DateTime fromDate, DateTime toDate,string company,string plant)
        {
            List<ProcessParameterDashboardAlarmDetails> machinesAlarmData = new List<ProcessParameterDashboardAlarmDetails>();

            PipelineDefinition<BsonDocument, BsonDocument> query = null;
            try
            {

                var dateMatch = new BsonDocument
                {
                {
                "$match", new BsonDocument
                {
                { "$expr",new BsonDocument{
                { "$and",new BsonArray
                {
                new BsonDocument
                {
                { "$gte",new BsonArray
                {
                "$AlarmTime",new BsonDocument { { "$dateFromString",new BsonDocument { { "dateString", fromDate.ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss") } } } }
                } }
                },
                new BsonDocument
                {
                { "$lte",new BsonArray
                {
                "$AlarmTime",new BsonDocument { { "$dateFromString",new BsonDocument { { "dateString", toDate.ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss") } } } }
                } }
                }

                } } }
                }
                }
                }
                };
                var match = new BsonDocument
                    {
                        {

                            "$match", new BsonDocument
                                {
                                    { "MachineID" , new BsonDocument{
                                        { "$in" ,machineNames }
                                    }

                                    }

                                , {
                                    "CompanyID",company
                                },
                                    {
                                    "PlantID",plant
                                }
                                }
                            }
                    };
                var project = new BsonDocument
                    {
                        {
                            "$project" ,new BsonDocument {

                                { "AlarmMSG" , "$AlarmMSG"},
                               // { "AlarmTime" , "$AlarmTime"},
                                { "MachineID" , "$MachineID"},
                                { "_id" , 0 }
                            }
                        }
                    };
                var group = new BsonDocument
                    {
                        {
                            "$group" ,new BsonDocument {
                                {"_id" , "" },
                                {"distinct",new BsonDocument
                                {
                                    {"$addToSet" , "$$ROOT" }
                                } }
                            }
                        }
                    };
                var unwind = new BsonDocument
                    {
                        {
                            "$unwind" ,new BsonDocument {
                                {"path" , "$distinct" },
                                {"preserveNullAndEmptyArrays", false }
                            }
                        }
                    };
                var replaceRoot = new BsonDocument
                    {
                        {
                            "$replaceRoot" ,new BsonDocument {
                                {"newRoot" , "$distinct" }
                            }
                        }
                    };

                var sort = new BsonDocument
                    {
                        {
                            "$sort" ,new BsonDocument {
                                {"AlarmTime" , -1 }

                            }
                        }
                    };

                var projectToDisplay = new BsonDocument
                    {
                        {
                            "$project" ,new BsonDocument {
                                {"AlarmMSG" , 1 },
                                 { "MachineID" , 1}
                            }
                        }
                    };

                AggregateOptions aggregateOptions = new AggregateOptions { AllowDiskUse = true };
                PipelineDefinition<BsonDocument, BsonDocument> pipeline2 = new BsonDocument[]
                {
                    dateMatch, sort,  match,project,group,unwind,replaceRoot,projectToDisplay
                };
                query = pipeline2;
                IAsyncCursor<BsonDocument> result = _MongoDatabase.GetCollection<BsonDocument>("AlarmHistoryTransaction").Aggregate(pipeline2, aggregateOptions);
                var dataset = IAsyncCursorExtensions.ToList<BsonDocument>(result);


                var distinctMachineIDs = dataset.Select(x => x["MachineID"]).Distinct().ToList();

                ProcessParameterDashboardAlarmDetails machineAlarmData = null;
                foreach (string machine in distinctMachineIDs)
                {
                    machineAlarmData = new ProcessParameterDashboardAlarmDetails();
                    machineAlarmData.MachineID = machine;
                    List<AlarmDetails> alarmDatas = new List<AlarmDetails>();
                    AlarmDetails alarmData = null;
                    int slNo = 1;
                    foreach (var item in dataset)
                    {
                        if (machine == item["MachineID"].ToString())
                        {
                            if (slNo < 11)
                            {
                                alarmData = new AlarmDetails();
                                alarmData.AlarmMsg = slNo + ". " + item["AlarmMSG"].ToString();
                                alarmDatas.Add(alarmData);
                                slNo++;
                            }
                            else
                            {
                                break;
                            }
                        }
                    }
                    machineAlarmData.alarmDetails = alarmDatas;
                    machinesAlarmData.Add(machineAlarmData);
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("Getting Alarm History Details " + ex.Message + "-------Query : " + query);
            }
            return machinesAlarmData;
        }


        #region -------Process Parameter Graph View and List Of Vale-------------------------
        public static List<BsonDocument> getDataForListOfValues(string fromDate, double toDate, string machineName,string company,string plant)
        {
            string query = "";
            var dataset = new List<BsonDocument>();

            try
            {

                var filter = "{$and : [{ UpdatedTS: {$gte: ISODate('" + Util.GetDateTime(fromDate).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ") + "')} },{ UpdatedTS: {$lte: ISODate('" + Util.GetDateTime(fromDate).AddHours(toDate).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ") + "')} }, {MachineID : {$in : " + machineName + "}},  {CompanyID : '"+company +"' },{PlantID:'"+plant+"'}]}";
                //var filter = "{$and : [{ UpdatedTS: {$gte: ISODate('" + Util.GetDateTime(fromDate).AddHours(-toDate).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")  + "')} },{ UpdatedTS: {$lte: ISODate('" + Util.GetDateTime(fromDate).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ") + "')} }, {MachineID : {$in : " + machineName + "}},  {CompanyID : '" + company + "' },{PlantID:'" + plant + "'}]}";
                query = filter;
               dataset = _MongoDatabase.GetCollection<BsonDocument>("ProcessParameterTransaction").Find(filter).ToList();

            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("Getting Data For List Of Vlaue: " + ex.Message+ "---------  Query : "+ query);
            }
            return dataset;
        }

        public static List<BsonDocument> getMaxSignatureID(string machineID, string parameterID,string companyID,string plantID)
        {
         
            var dataset = new List<BsonDocument>();
            PipelineDefinition<BsonDocument, BsonDocument> query=null;
            try
            {


                var matchForSignatureID = new BsonDocument
                    {
                        {
                              "$match", new BsonDocument
                              {
                                  {
                                      "MachineID" , machineID
                                  },
                                  {
                                      "ParameterID",parameterID
                                  },
                                   {
                                      "CompanyID" , companyID
                                  },
                                  {
                                      "PlantID",plantID
                                  }
                              }
                        }
                    };

                var groupForSignatureID = new BsonDocument
                    {
                        {
                              "$group", new BsonDocument
                              {
                                  {
                                      "_id" , "$ParameterID"
                                  },
                                  {
                                      "SignatureID",new BsonDocument
                                      {
                                          {
                                              "$max","$SignatureID"
                                          }
                                      }
                                  }
                              }
                        }
                    };
                PipelineDefinition<BsonDocument, BsonDocument> pipelineForGetSignatureD = new BsonDocument[]
               {
                    matchForSignatureID, groupForSignatureID
               };
                query = pipelineForGetSignatureD;
                IAsyncCursor<BsonDocument> resultForSignatureID = _MongoDatabase.GetCollection<BsonDocument>("SignatureMaster").Aggregate(pipelineForGetSignatureD);
               dataset = IAsyncCursorExtensions.ToList<BsonDocument>(resultForSignatureID);

            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("Getting Max Signature ID : " + ex.Message + "---------  Query : " + query);
            }
            return dataset;
        }

        public static List<BsonDocument> getSignatureListToSave(string cycleStart,string cycleEnd, string machineID, string parameterID,double seconds,string companyID,string plantID)
        {
            PipelineDefinition<BsonDocument, BsonDocument> query = null;
            var dataset = new List<BsonDocument>();

            try
            {


                var dateMatch = new BsonDocument
                {
                {
                "$match", new BsonDocument
                {
                { "$expr",new BsonDocument{
                { "$and",new BsonArray
                {
                new BsonDocument
                {
                { "$gte",new BsonArray
                {
                "$UpdatedTS",new BsonDocument { { "$dateFromString",new BsonDocument { { "dateString", Util.GetDateTime(cycleStart).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss") } } } }
                } }
                },
                new BsonDocument
                {
                { "$lte",new BsonArray
                {
                "$UpdatedTS",new BsonDocument { { "$dateFromString",new BsonDocument { { "dateString", Util.GetDateTime(cycleEnd).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss") } } } }
                } }
                }

                } } }
                }
                }
                }
                };
                var match = new BsonDocument
                    {
                        {

                            "$match", new BsonDocument
                                {
                                    { "MachineID" , machineID

                                    },
                                {
                                    "CompanyID",companyID
                                },
                                 {
                                    "PlantID",plantID
                                }
                                }
                            }
                    };
                var project = new BsonDocument
                    {
                        {
                            "$project" ,new BsonDocument {


                                { "MachineID" , 1},
                                 { "UpdatedTS" , 1},
                                { parameterID , 1 }
                            }
                        }
                    };

                var facet = new BsonDocument
                    {
                        {


                        "$facet",new BsonDocument
                        {
                               {
                            "price", new BsonArray
                            {

                              new BsonDocument
                              {
                                  {


                                   "$bucketAuto", new BsonDocument
                                {

                                    {
                                         "groupBy", "$UpdatedTS"
                                    },
                                    {
                                        "buckets",seconds
                                    },
                                    {
                                        "output",new BsonDocument
                                        {
                                            {
                                                   "averageValue", new BsonDocument
                                                   {
                                                       {
                                                              "$avg", "$"+parameterID
                                                       }
                                                   }
                                            }

                                        }
                                    }

                                }

                                     }
                              }



                                }
                        }
                        }
                           }

                    };


                AggregateOptions aggregateOptions = new AggregateOptions { AllowDiskUse = true };
                PipelineDefinition<BsonDocument, BsonDocument> pipeline2 = new BsonDocument[]
                {
                    dateMatch, match, project,facet
                };
                query = pipeline2;
                IAsyncCursor<BsonDocument> result = _MongoDatabase.GetCollection<BsonDocument>("ProcessParameterTransaction").Aggregate(pipeline2);
                dataset = IAsyncCursorExtensions.ToList<BsonDocument>(result);

            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("Getting Signature List To Save : " + ex.Message + "---------  Query : " + query);
            }
            return dataset;
        }

        public static string saveSignatureDetailsForReference(List<SignatureComparisionDetails> masterList)
        {
            string query = "";
          
            string sucess = "";
            try
            {

                var collection = _MongoDatabase.GetCollection<SignatureComparisionDetails>("SignatureMaster");
                sucess = "Inserted";
                collection.InsertManyAsync(masterList).Wait();


            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("Save Signature Details : " + ex.Message + "---------  Query : " + query);
            }
            return sucess;
        }

        public static List<BsonDocument> getSignatureMaterDetailsWithFilter(string machineName, string parameterID, string signatureID,string companyid,string plantid)
        {
            string query = "";
            var dataset = new List<BsonDocument>();

            try
            {

                var filter = "{'MachineID':'" + machineName + "','ParameterID':{'$in':['" + parameterID + "']},'SignatureID':'" + signatureID + "','CompanyID':'" + companyid + "','PlantID':'" + plantid + "'}";
                query = filter;
                dataset = _MongoDatabase.GetCollection<BsonDocument>("SignatureMaster").Find(filter).ToList();


            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("Getting Signature Mater Details: " + ex.Message + "---------  Query : " + query);
            }
            return dataset;
        }

        public static List<SignatureComparisionDetails> getSignatureMasterDetails()
        {
            string query = "";
            List<SignatureComparisionDetails> signatureComparisionDetails = new List<SignatureComparisionDetails>();
            try
            {

                var filter = "{}";
                query = filter;
                signatureComparisionDetails = _MongoDatabase.GetCollection<SignatureComparisionDetails>("SignatureMaster").Find(filter).ToList();

            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("Getting SignatureComparision Master Details: " + ex.Message + "---------  Query : " + query);
            }
            return signatureComparisionDetails;
        }

        public static List<ProcessParameterTransactionMasterData> getProcessParameterMasterDetails()
        {
            string query = "";
            List<ProcessParameterTransactionMasterData> processParameterTransactionMasterDatas = new List<ProcessParameterTransactionMasterData>();
            try
            {

                var filter = "{}";
                query = filter;
                processParameterTransactionMasterDatas = _MongoDatabase.GetCollection<ProcessParameterTransactionMasterData>("ProcessParameterMaster").Find(filter).ToList();


            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("Getting Process Parameter Master Details: " + ex.Message + "---------  Query : " + query);
            }
            return processParameterTransactionMasterDatas;
        }


        #endregion

        #region ----- Process Parameter Dashboard-------
        public static List<ProcessParameterTransactionMasterData> getProcessParameterMasterDetailsWithFilter(string company, string plant, string machineID)
        {
            string query = "";
            List<ProcessParameterTransactionMasterData> processParameterTransactionMasterDatas = new List<ProcessParameterTransactionMasterData>();
            try
            {

                var filter = "{MachineID: {$in : " + machineID + "}, CompanyID: '"+ company+ "', PlantID:'"+ plant+ "'}";
                query = filter;
                processParameterTransactionMasterDatas = _MongoDatabase.GetCollection<ProcessParameterTransactionMasterData>("ProcessParameterMaster").Find(filter).ToList();

            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("Getting Process Parameter Master Details With Filter : " + ex.Message + "---------  Query : " + query);
            }
            return processParameterTransactionMasterDatas;
        }


        public static List<BsonDocument> getPPTroubleShootDetails(DateTime fromDate, DateTime toDate,BsonArray machineID, BsonDocument parameters,string company,string plant)
        {
            PipelineDefinition<BsonDocument, BsonDocument> query = null;
            var dataset = new List<BsonDocument>();
            try
            {

                var dateMatch = new BsonDocument
                {
                {
                "$match", new BsonDocument
                {
                { "$expr",new BsonDocument{
                { "$and",new BsonArray
                {
                new BsonDocument
                {
                { "$gte",new BsonArray
                {
                "$UpdatedTS",new BsonDocument { { "$dateFromString",new BsonDocument { { "dateString", fromDate.ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss") } } } }
                } }
                },
                new BsonDocument
                {
                { "$lte",new BsonArray
                {
                "$UpdatedTS",new BsonDocument { { "$dateFromString",new BsonDocument { { "dateString", toDate.ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss") } } } }
                } }
                }

                } } }
                }
                }
                }
                };
                //var match = new BsonDocument
                //                    {
                //                        {
                //                            "$match", new BsonDocument
                //                            {
                //                                {
                //                                    "MachineID",new BsonDocument
                //                                    {
                //                                        { "$in",machineID }
                //                                    }
                //                                }
                //                            }
                //                        }
                //                    };




                var machineMatch = new BsonDocument
                {
                     { "MachineID" , new BsonDocument{
                                        { "$in" ,machineID }
                                    } }
                };
                var companyMatch = new BsonDocument
                {
                     { "CompanyID" , company}
                };
                var plantMatch = new BsonDocument
                {
                     { "PlantID" , plant}
                };
                BsonArray matcharray = new BsonArray();
                matcharray.Add(machineMatch);
                matcharray.Add(companyMatch);
                matcharray.Add(plantMatch);

                //BsonDocument finalMatch = new BsonDocument();
                //finalMatch.Add(new BsonElement(data.Key, matcharray));


                var match = new BsonDocument
                    {
                        {

                            "$match", new BsonDocument
                                {
                                {
                                       "$and",matcharray
                                }
                                }
                            } };

                var group = new BsonDocument
                                    {
                                        {
                                            "$group" ,new BsonDocument {
                                                {"_id" , "$MachineID" },
                                                {"Parameters", new BsonDocument
                                                {
                                                    {"$mergeObjects" , parameters
                                                    }
                                                }
                                                }
                                            }
                                        }
                                };

                var replaceRoot = new BsonDocument
{
{
"$replaceRoot" ,new BsonDocument {
{"newRoot" , "$Parameters" }
}
}
};

                AggregateOptions aggregateOptions = new AggregateOptions { AllowDiskUse = true };
                PipelineDefinition<BsonDocument, BsonDocument> pipeline2 = new BsonDocument[]
                {
                                     dateMatch,  match,group, replaceRoot
                };
                query = pipeline2;
                IAsyncCursor<BsonDocument> result = _MongoDatabase.GetCollection<BsonDocument>("ProcessParameterTransaction").Aggregate(pipeline2);
                dataset = IAsyncCursorExtensions.ToList<BsonDocument>(result);

            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("Getting Process Parameter Trouble Shoot Details : " + ex.Message + "---------  Query : " + query);
            }
            return dataset;
        }
    //    public static Dictionary<string, ParameterListForMachine> deepCopyDic<TKey, TValue>(Dictionary<string, ParameterListForMachine> src)
    //where TValue : ICloneable
    //    {
    //        //Copies a dictionary with all of its elements
    //        //RETURN:
    //        //      = Dictionary copy
    //        Dictionary<string, ParameterListForMachine> dic = new Dictionary<string, ParameterListForMachine>();
    //        foreach (var item in src)
    //        {
    //            dic.Add(item.Key, (ParameterListForMachine)item.Value.Clone());
    //        }

    //        return dic;
    //    }

        public static Dictionary<string, ParameterListForMachine> deepCopyDic(Dictionary<string, ParameterListForMachine> src)
        {
            //Copies a dictionary with all of its elements
            //RETURN:
            //      = Dictionary copy
            Dictionary<string, ParameterListForMachine> dic = new Dictionary<string, ParameterListForMachine>();
            for (int i = 0; i < src.Count; i++)
            {
                dic.Add(src.ElementAt(i).Key, src.ElementAt(i).Value);
            }

            return dic;
        }

        //    public static Dictionary<TKey, TValue> deepCopyDic<TKey, TValue>(Dictionary<string, ParameterListForMachine> src)
        //where TValue : ICloneable
        //where TKey : ICloneable
        //    {
        //        return src.ToDictionary(i => (TKey)i.Key.Clone(), i => (TValue)i.Value.Clone());
        //    }
        public static List<BsonDocument> getPPLiveDataDetails(Dictionary<string, ParameterListForMachine> machineParmeterPair_Original,string company,string plant)
        {
            PipelineDefinition<BsonDocument, BsonDocument> query = null;
            var dataset = new List<BsonDocument>();
            try
            {
              


                Dictionary<string, ParameterListForMachine> machineParmeterPair_Clone = deepCopyDic(machineParmeterPair_Original);

                machineParmeterPair_Clone.Remove("CommonParameters");
                //------------------------------------------
                BsonDocument machinesName = new BsonDocument();
                BsonArray marray = new BsonArray();
                if (machineParmeterPair_Clone.Count <= 0)
                {
                    return dataset;
                }
                foreach (KeyValuePair<string, ParameterListForMachine> data in machineParmeterPair_Clone)
                {

                    BsonDocument parameters1 = new BsonDocument();
                    parameters1.Add(new BsonElement("CompanyID", "$CompanyID"));
                    parameters1.Add(new BsonElement("PlantID", "$PlantID"));
                    parameters1.Add(new BsonElement("MachineID", "$MachineID"));
                    parameters1.Add(new BsonElement("UpdatedTS", "$UpdatedTS"));
                   
                    for (int i = 0; i < data.Value.Parameters.Count; i++)
                    {
                        parameters1.Add(new BsonElement(data.Value.Parameters[i], "$" + data.Value.Parameters[i]));
                    }
                    var match1 = new BsonDocument
                                                    {
                                                        {
                                                            "$match", new BsonDocument
                                                            {
                                                                {
                                                                    "MachineID",data.Key
                                                                }
                                                            }
                                                        }
                                                    };



                    var group1 = new BsonDocument
                                                    {
                                                        {
                                                            "$group" ,new BsonDocument {
                                                                {"_id" , "$MachineID" },
                                                                {"Parameters", new BsonDocument
                                                                {
                                                                    {"$mergeObjects" , parameters1
                                                                    }
                                                                }
                                                                }
                                                            }
                                                        }
                                                };

                    var replaceRoot1 = new BsonDocument
                {
                {
                "$replaceRoot" ,new BsonDocument {
                {"newRoot" , "$Parameters" }
                }
                }
                };



                    BsonArray facetdata = new BsonArray();
                    facetdata.Add(match1);
                    facetdata.Add(group1);
                    facetdata.Add(replaceRoot1);

                    machinesName.Add(new BsonElement(data.Key, facetdata));
                    marray.Add("$" + data.Key);
                }

                var dateMatch = new BsonDocument
                {
                {
                "$match", new BsonDocument
                {
                { "$expr",new BsonDocument{
                { "$and",new BsonArray
                {
                new BsonDocument
                {
                { "$gte",new BsonArray
                {
                "$UpdatedTS",new BsonDocument { { "$dateFromString",new BsonDocument { { "dateString", DateTime.Now.AddHours(-8).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss") } } } }
                } }
                },
                new BsonDocument
                {
                { "$lte",new BsonArray
                {
                "$UpdatedTS",new BsonDocument { { "$dateFromString",new BsonDocument { { "dateString", DateTime.Now.ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss") } } } }
                } }
                }

                } } }
                }
                }
                }
                };

                var match = new BsonDocument
                {
                    {
                        "$match",new BsonDocument
                        {
                             {
                          "CompanyID",company
                    },
                    {
                        "PlantID",plant
                    }
                        }
                    }
                   
                };

                var facet = new BsonDocument
                {
                    {
                          "$facet",machinesName
                    }
                };

                var project = new BsonDocument
                {
                    {
                        "$project",new BsonDocument
                        {
                            {
                                 "data",new BsonDocument
                            {
                                {
                                       "$concatArrays",marray
                                }

                            }
                            }

                        }
                    }
                };

                var unwind = new BsonDocument
                {
                    {
                          "$unwind","$data"
                    }
                };

                var replaceRoot2 = new BsonDocument
                {
                {
                "$replaceRoot" ,new BsonDocument {
                {"newRoot" , "$data" }
                }
                }
                };
                //---------------------------------------------------


                AggregateOptions aggregateOptions = new AggregateOptions { AllowDiskUse = true };
                PipelineDefinition<BsonDocument, BsonDocument> pipeline2 = new BsonDocument[]
                {
                                         match,dateMatch,facet,project,unwind,replaceRoot2
                };
                query = pipeline2;
                IAsyncCursor<BsonDocument> resultSetFromMB = _MongoDatabase.GetCollection<BsonDocument>("ProcessParameterTransaction").Aggregate(pipeline2);
                 dataset = IAsyncCursorExtensions.ToList<BsonDocument>(resultSetFromMB);

            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("Getting Process Parameter Live Data Details : " + ex.Message + "---------  Query : " + query);
            }
            return dataset;
        }
        #endregion

        #region ------ eDoc Master -----
        public static List<eDocumentData> getCompanyLvlEdocData(string mtb)
        {
            List<eDocumentData> list = new List<eDocumentData>();
            try
            {
                var filter = "{'metadata.MTB':'" + mtb + "'}";
                var modelDetails = _MongoDatabaseEDoc.GetCollection<BsonDocument>("MTBLeveleDoc.files").Find(filter).ToList();
                eDocumentData data = null;
                foreach (var item in modelDetails)
                {
                    data = new eDocumentData();
                    data.FileID = item["_id"].ToString();
                    data.Filename = item["filename"].ToString();
                    data.UpdatedTS = item["uploadDate"].AsDateTime.ToString("dd-MM-yyyy");
                    BsonDocument metadata = item["metadata"].AsBsonDocument;
                    data.MTB = metadata["MTB"].ToString();
                    data.CNCMake = metadata["CNC Make"].ToString();
                    data.CNCModel = metadata["CNC Model"].ToString();
                    data.Category = metadata["L1"].ToString();
                    data.Subcategory = metadata["L2"].ToString();
                    // data.CustomerName = metadata["Customer Name"].ToString();
                    // data.DateOfDispatchInString = metadata["Date of Dispatch"].ToString();
                    data.Version = metadata["Version"].ToString();
                    data.FileType = metadata["Filetype"].ToString();
                    data.UpdatedBy = metadata["UpdatedBy"].ToString();
                    data.CollectionName = "MTBLeveleDoc";
                    if (metadata.Contains("Level"))
                    {
                        data.Level = metadata["Level"].ToString();
                    }
                    list.Add(data);
                }
            }
            catch (Exception ex)
            {
                Logger.WriteDebugLog("getCompanyLvlEdocData =" + ex.Message);
            }
            return list;
        }
        public static int uploadCompanyLvlEdocData(eDocumentData data)
        {
            int result = 0;
            try
            {
                var options = new GridFSUploadOptions()
                {
                    Metadata = new BsonDocument(){
                                     {"MTB", data.MTB},
                                        {"CNC Make", data.CNCMake},
                                        { "CNC Model", data.CNCModel},
                                         {"L1", data.Category},
                                        {"L2", data.Subcategory},
                                       // { "Customer Name", data.CustomerName},
                                       // {"Date of Dispatch",data.DateOfDispatchInDate },
                                        {"Version", data.Version},
                                        { "Filetype", data.FileType},
                                        {"UpdatedBy", data.UpdatedBy},
                                        {"Level", "MTB"},
                                }
                };
                GridFSBucketOptions op = new GridFSBucketOptions();
                op.BucketName = "MTBLeveleDoc";
                GridFSBucketOptions gridFsOption = new GridFSBucketOptions(op);
                IGridFSBucket bucket = new GridFSBucket(_MongoDatabaseEDoc, gridFsOption);
                var id = bucket.UploadFromBytes(data.Filename, data.Document, options);
            }
            catch (Exception ex)
            {
                Logger.WriteDebugLog("uploadModelLvlEdocData =" + ex.Message);
            }
            return result;
        }
        public static int deleteCompanyLvlEdocData(string id)
        {
            int result = 0;
            try
            {
                var filterFile = "{'_id':ObjectId('" + id + "')}";
                var filterChunk = "{'files_id': ObjectId('" + id + "')}";
                var chunkCollection = _MongoDatabaseEDoc.GetCollection<BsonDocument>("MTBLeveleDoc.chunks");
                chunkCollection.DeleteManyAsync(filterChunk).Wait();
                var fileCollection = _MongoDatabaseEDoc.GetCollection<BsonDocument>("MTBLeveleDoc.files");
                fileCollection.FindOneAndDelete(filterFile);
            }
            catch (Exception ex)
            {
                Logger.WriteDebugLog("deleteCompanyLvlEdocData =" + ex.Message);
            }
            return result;
        }
        public static List<eDocumentData> getModelLvlEdocData(string mtb, string model, BsonArray levelView)
        {
            List<eDocumentData> list = new List<eDocumentData>();
            try
            {
                var match = new BsonDocument
                    {
                        {
                            "$match", new BsonDocument
                            {
                                { "metadata.MTB" , mtb},
                                { "metadata.Machine Model" , model },
                                { "metadata.Level" , new BsonDocument{ { "$in" , levelView } }  }
                            }
                        }
                    };
                var unionWithPipeLine1 = new BsonDocument
                    {
                        {
                            "$match" ,new BsonDocument {
                                {"metadata.MTB" , mtb }
                            }
                        }
                    };
                var unionWith = new BsonDocument
                    {
                        {
                            "$unionWith", new BsonDocument
                            {
                                { "coll" , "MTBLeveleDoc.files"},
                                 { "pipeline" ,new BsonArray
                                { new BsonDocument
                                {
                                    {
                                    "$match" ,new BsonDocument {
                                {"metadata.MTB" , mtb },
                                 { "metadata.Level" , new BsonDocument{ { "$in" , levelView } }  }
                            }
                                    }
                                }
                                 }

                                }
                            }
                    } };
                PipelineDefinition<BsonDocument, BsonDocument> pipeline2 = new BsonDocument[]
               {
                       match,unionWith
               };
                //  filter = "{'metadata.MTB':'" + ddlMTBModelLvl.SelectedValue + "','metadata.Model':{'$in' : [" + modellist + "]}}";
                var modelDetails = _MongoDatabaseEDoc.GetCollection<BsonDocument>("ModelLeveleDoc.files").Aggregate(pipeline2).ToList();
                eDocumentData data = null;
                foreach (var item in modelDetails)
                {
                    data = new eDocumentData();
                    data.FileID = item["_id"].ToString();
                    data.Filename = item["filename"].ToString();
                    data.UpdatedTS = item["uploadDate"].AsDateTime.ToString("dd-MM-yyyy"); ;
                    BsonDocument metadata = item["metadata"].AsBsonDocument;
                    data.MTB = metadata["MTB"].ToString();
                    data.CNCMake = metadata["CNC Make"].ToString();
                    data.CNCModel = metadata["CNC Model"].ToString();
                    if (metadata.Contains("Machine Model"))
                    {
                        data.MachineModel = metadata["Machine Model"].ToString();
                    }
                    else
                    {
                        data.MachineModel = "";
                    }
                    if (metadata.Contains("Machine Type"))
                    {
                        data.MachineType = metadata["Machine Type"].ToString();
                    }
                    data.Category = metadata["L1"].ToString();
                    data.Subcategory = metadata["L2"].ToString();
                    // data.CustomerName = metadata["Customer Name"].ToString();
                    // data.DateOfDispatchInString = metadata["Date of Dispatch"].ToString();
                    data.Version = metadata["Version"].ToString();
                    data.FileType = metadata["Filetype"].ToString();
                    data.UpdatedBy = metadata["UpdatedBy"].ToString();
                    data.CollectionName = "ModelLeveleDoc";
                    if (metadata.Contains("Level"))
                    {
                        data.Level = metadata["Level"].ToString();
                    }
                    list.Add(data);
                }
            }
            catch (Exception ex)
            {
                Logger.WriteDebugLog("getModelLvlEdocData =" + ex.Message);
            }
            return list;
        }
        public static int uploadModelLvlEdocData(eDocumentData data)
        {
            int result = 0;
            try
            {
                var options = new GridFSUploadOptions()
                {
                    Metadata = new BsonDocument(){
                                        {"MTB", data.MTB},
                                        {"CNC Make", data.CNCMake},
                                        { "CNC Model", data.CNCModel},
                                        { "Machine Model", data.MachineModel},
                                        { "Machine Type", data.MachineType},
                                         {"L1", data.Category},
                                        {"L2", data.Subcategory},
                                       // { "Customer Name", data.CustomerName},
                                        //{"Date of Dispatch",data.DateOfDispatchInDate },
                                        {"Version", data.Version},
                                        { "Filetype", data.FileType},
                                        {"UpdatedBy", data.UpdatedBy},
                                        {"Level", "Model"},
                                        }
                };
                GridFSBucketOptions op = new GridFSBucketOptions();
                op.BucketName = "ModelLeveleDoc";
                GridFSBucketOptions gridFsOption = new GridFSBucketOptions(op);
                IGridFSBucket bucket = new GridFSBucket(_MongoDatabaseEDoc, gridFsOption);
                var id = bucket.UploadFromBytes(data.Filename, data.Document, options);
            }
            catch (Exception ex)
            {
                Logger.WriteDebugLog("uploadModelLvlEdocData =" + ex.Message);
            }
            return result;
        }
        public static int deleteModelLvlEdocData(string id)
        {
            int result = 0;
            try
            {
                var filterFile = "{'_id':ObjectId('" + id + "')}";
                var filterChunk = "{'files_id': ObjectId('" + id + "')}";
                var chunkCollection = _MongoDatabaseEDoc.GetCollection<BsonDocument>("ModelLeveleDoc.chunks");
                chunkCollection.DeleteManyAsync(filterChunk).Wait();
                var fileCollection = _MongoDatabaseEDoc.GetCollection<BsonDocument>("ModelLeveleDoc.files");
                fileCollection.FindOneAndDelete(filterFile);
            }
            catch (Exception ex)
            {
                Logger.WriteDebugLog("deleteModelLvlEdocData =" + ex.Message);
            }
            return result;
        }

        #region ---- Machine Level ----
        public static List<eDocumentData> getMachineLvlEdocData(string mtb, string model, string machineSlno, BsonArray levelView)
        {
            List<eDocumentData> list = new List<eDocumentData>();
            try
            {
                var match = new BsonDocument
                    {
                        {
                            "$match", new BsonDocument
                            {
                                { "metadata.MTB" , mtb},
                                { "metadata.Machine Model" , model },
                                 { "metadata.MachineSlNo" , machineSlno },
                                  { "metadata.Level" , new BsonDocument{ { "$in" , levelView } }  }
                            }
                        }
                    };
                var unionWith = new BsonDocument
                    {
                        {
                            "$unionWith", new BsonDocument
                            {
                                { "coll" , "ModelLeveleDoc.files"},
                                 { "pipeline" ,new BsonArray
                                {
                                     new BsonDocument
                                {
                                    {
                                    "$lookup" ,new BsonDocument {
                                                {"from" , "MachineLeveleDoc.files" },
                                                {"let" ,  new BsonDocument { { "filename1", "$filename" } } },
                                                 {"pipeline" , new BsonArray{
                                                       new BsonDocument
                                                       {
                                                           {"$match" , new BsonDocument{
                                                                        {"$expr" ,new BsonDocument{
                                                                                    {"$and" , new BsonArray{
                                                                                        new BsonDocument { { "$eq",new BsonArray { "$filename", "$$filename1" } } },
                                                                                        new BsonDocument { { "$eq",new BsonArray { "$metadata.MachineSlNo",                                                                                                        machineSlno}}},
                                                                                    } },
                                                                        } },
                                                           } },
                                                       },
                                                       new BsonDocument{

                                                            {"$project" , new BsonDocument { { "filename", 0 } ,{ "_id", 0 } } },
                                                       }
                                                 }
                                                },
                                                 {"as" , "filedata" },
                                             }
                                    }
                                },
                                 new BsonDocument
                                {
                                    {
                                    "$match" ,new BsonDocument {
                                                {"metadata.MTB" , mtb },
                                                {"metadata.Machine Model" , model },
                                                 { "metadata.Level" , new BsonDocument{ { "$in" , levelView } }  },
                                                 {"filedata" , new BsonDocument{ { "$eq" ,new BsonArray {} }} }
                                              }
                                     }
                                 }
                                }
                             }

                        }
                            }
                    };
                var unionWith2 = new BsonDocument
                    {
                        {
                            "$unionWith", new BsonDocument
                            {
                                { "coll" , "MTBLeveleDoc.files"},
                                 { "pipeline" ,new BsonArray
                                                        { new BsonDocument
                                                        {
                                                            {
                                                            "$match" ,new BsonDocument {{"metadata.MTB" , mtb }, { "metadata.Level", new BsonDocument { { "$in", levelView } } } }
                                                            }
                                                        }
                                                         }
                                }
                            }
                    } };
                PipelineDefinition<BsonDocument, BsonDocument> pipeline2 = new BsonDocument[]
               {
                       match,unionWith,unionWith2
               };
                var modelDetails = _MongoDatabaseEDoc.GetCollection<BsonDocument>("MachineLeveleDoc.files").Aggregate(pipeline2).ToList();

                eDocumentData data = null;
                foreach (var item in modelDetails)
                {
                    data = new eDocumentData();
                    data.FileID = item["_id"].ToString();
                    data.Filename = item["filename"].ToString();
                    data.UpdatedTS = item["uploadDate"].AsDateTime.ToString("dd-MM-yyyy");
                    BsonDocument metadata = item["metadata"].AsBsonDocument;
                    data.MTB = metadata["MTB"].ToString();
                    data.CNCMake = metadata["CNC Make"].ToString();
                    data.CNCModel = metadata["CNC Model"].ToString();
                    if (metadata.Contains("Machine Model"))
                    {
                        data.MachineModel = metadata["Machine Model"].ToString();
                    }
                    else
                    {
                        data.MachineModel = "";
                    }
                    if (metadata.Contains("Machine Type"))
                    {
                        data.MachineType = metadata["Machine Type"].ToString();
                    }
                    if (metadata.Contains("MachineSlNo"))
                    {
                        data.MachineSlno = metadata["MachineSlNo"].ToString();
                    }
                    data.Category = metadata["L1"].ToString();
                    data.Subcategory = metadata["L2"].ToString();
                    if (metadata.Contains("Customer Name"))
                    {
                        data.CustomerName = metadata["Customer Name"].ToString();
                    }
                    if (metadata.Contains("Date of Dispatch"))
                    {
                        data.DateOfDispatchInString = metadata["Date of Dispatch"].AsDateTime.ToString("dd-MM-yyyy");
                    }
                    if (metadata.Contains("Level"))
                    {
                        data.Level = metadata["Level"].ToString();
                    }
                    data.Version = metadata["Version"].ToString();
                    data.FileType = metadata["Filetype"].ToString();
                    data.UpdatedBy = metadata["UpdatedBy"].ToString();
                    data.CollectionName = "MachineLeveleDoc";
                    list.Add(data);
                }
            }
            catch (Exception ex)
            {
                Logger.WriteDebugLog("getMachineLvlEdocData =" + ex.Message);
            }
            return list;
        }
        public static int uploadMachineLvlEdocData(eDocumentData data)
        {
            int result = 0;
            try
            {
                var options = new GridFSUploadOptions()
                {
                    Metadata = new BsonDocument(){
                                     {"MTB", data.MTB},
                                        {"CNC Make", data.CNCMake},
                                        { "CNC Model", data.CNCModel},
                                        { "Machine Model", data.MachineModel},
                                        { "Machine Type", data.MachineType},
                                         { "MachineSlNo", data.MachineSlno},
                                         {"L1", data.Category},
                                        {"L2", data.Subcategory},
                                        { "Customer Name", data.CustomerName},
                                        {"Date of Dispatch",data.DateOfDispatchInDate },
                                        {"Version", data.Version},
                                        { "Filetype", data.FileType},
                                        {"UpdatedBy", data.UpdatedBy},
                                        {"Level", "Machine"},
                                }
                };
                GridFSBucketOptions op = new GridFSBucketOptions();
                op.BucketName = "MachineLeveleDoc";
                GridFSBucketOptions gridFsOption = new GridFSBucketOptions(op);
                IGridFSBucket bucket = new GridFSBucket(_MongoDatabaseEDoc, gridFsOption);
                var id = bucket.UploadFromBytes(data.Filename, data.Document, options);
            }
            catch (Exception ex)
            {
                Logger.WriteDebugLog("uploadModelLvlEdocData =" + ex.Message);
            }
            return result;
        }
        public static int deleteMachineLvlEdocData(string id)
        {
            int result = 0;
            try
            {
                var filterFile = "{'_id':ObjectId('" + id + "')}";
                var filterChunk = "{'files_id': ObjectId('" + id + "')}";
                var chunkCollection = _MongoDatabaseEDoc.GetCollection<BsonDocument>("MachineLeveleDoc.chunks");
                chunkCollection.DeleteManyAsync(filterChunk).Wait();
                var fileCollection = _MongoDatabaseEDoc.GetCollection<BsonDocument>("MachineLeveleDoc.files");
                fileCollection.FindOneAndDelete(filterFile);
            }
            catch (Exception ex)
            {
                Logger.WriteDebugLog("deleteMachineLvlEdocData =" + ex.Message);
            }
            return result;
        }
        #endregion

        public static byte[] getEDocFilesInByte(string fileId, string collectionName)
        {
            byte[] fileByte = null;
            try
            {
                ObjectId id = new ObjectId(fileId);
                GridFSBucketOptions op = new GridFSBucketOptions();
                op.BucketName = collectionName;
                Logger.WriteDebugLog("Download eDoc File: Before: " + DateTime.Now);
                GridFSBucketOptions gridFsOption = new GridFSBucketOptions(op);
                IGridFSBucket bucket = new GridFSBucket(_MongoDatabaseEDoc, gridFsOption);
                fileByte = bucket.DownloadAsBytes(id);
            }
            catch (Exception ex)
            {
                Logger.WriteDebugLog("getEDocFilesInByte =" + ex.Message);
            }
            return fileByte;
        }
        public static int deleteEdocData(string id, string collectionName)
        {
            int result = 0;
            try
            {
                var filterFile = "{'_id':ObjectId('" + id + "')}";
                var filterChunk = "{'files_id': ObjectId('" + id + "')}";
                var chunkCollection = _MongoDatabaseEDoc.GetCollection<BsonDocument>(collectionName + ".chunks");
                chunkCollection.DeleteManyAsync(filterChunk).Wait();
                var fileCollection = _MongoDatabaseEDoc.GetCollection<BsonDocument>(collectionName + ".files");
                fileCollection.FindOneAndDelete(filterFile);
            }
            catch (Exception ex)
            {
                Logger.WriteDebugLog("deleteEdocData =" + ex.Message);
            }
            return result;
        }
        #endregion

        #region ------Troubleshooting----
        public static List<eDocumentData> getTroubleshootingEdocuments(string mtb, BsonArray model)
        {
            List<eDocumentData> list = new List<eDocumentData>();
            try
            {
                var match = new BsonDocument
                    {
                        {
                            "$match", new BsonDocument
                            {
                                { "metadata.MTB" , mtb},
                                { "metadata.Machine Model" , new BsonDocument{
                                    { "$in" ,model }
                              }   }
                            }
                        }
                    };
                var unionWith = new BsonDocument
                    {
                        {
                            "$unionWith", new BsonDocument
                            {
                                { "coll" , "ModelLeveleDoc.files"},
                                 { "pipeline" ,new BsonArray
                                {
                                     new BsonDocument
                                {
                                    {
                                    "$lookup" ,new BsonDocument {
                                                {"from" , "MachineLeveleDoc.files" },
                                                {"let" ,  new BsonDocument { { "filename1", "$filename" } } },
                                                 {"pipeline" , new BsonArray{
                                                       new BsonDocument
                                                       {
                                                           {"$match" , new BsonDocument{
                                                                        {"$expr" ,new BsonDocument{
                                                                                    {"$and" , new BsonArray{
                                                                                        new BsonDocument { { "$eq",new BsonArray { "$filename", "$$filename1" } } }
                                                                                    } },
                                                                        } },
                                                           } },
                                                       },
                                                       new BsonDocument{

                                                            {"$project" , new BsonDocument { { "filename", 0 } ,{ "_id", 0 } } },
                                                       }
                                                 }
                                                },
                                                 {"as" , "filedata" },
                                             }
                                    }
                                },
                                 new BsonDocument
                                {
                                    {
                                    "$match" ,new BsonDocument {
                                                {"metadata.MTB" , mtb },
                                                {"metadata.Machine Model" ,  new BsonDocument{ { "$in" ,model } } },
                                                 {"filedata" , new BsonDocument{ { "$eq" ,new BsonArray {} }} }
                                              }
                                     }
                                 }
                                }
                             }

                        }
                            }
                    };
                var unionWith2 = new BsonDocument
                    {
                        {
                            "$unionWith", new BsonDocument
                            {
                                { "coll" , "MTBLeveleDoc.files"},
                                 { "pipeline" ,new BsonArray
                                                        { new BsonDocument
                                                        {
                                                            {
                                                            "$match" ,new BsonDocument {{"metadata.MTB" , mtb } }
                                                            }
                                                        }
                                                         }
                                }
                            }
                    } };
                PipelineDefinition<BsonDocument, BsonDocument> pipeline2 = new BsonDocument[]
               {
                       match,unionWith,unionWith2
               };
                var modelDetails = _MongoDatabaseEDoc.GetCollection<BsonDocument>("MachineLeveleDoc.files").Aggregate(pipeline2).ToList();

                eDocumentData data = null;
                foreach (var item in modelDetails)
                {
                    data = new eDocumentData();
                    data.FileID = item["_id"].ToString();
                    data.Filename = item["filename"].ToString();
                    BsonDocument metadata = item["metadata"].AsBsonDocument;
                    data.MTB = metadata["MTB"].ToString();
                    data.CNCMake = metadata["CNC Make"].ToString();
                    data.CNCModel = metadata["CNC Model"].ToString();
                    if (metadata.Contains("Machine Model"))
                    {
                        data.MachineModel = metadata["Machine Model"].ToString();
                    }
                    else
                    {
                        data.MachineModel = "";
                    }
                    if (metadata.Contains("Machine Type"))
                    {
                        data.MachineType = metadata["Machine Type"].ToString();
                    }
                    if (metadata.Contains("MachineSlNo"))
                    {
                        data.MachineSlno = metadata["MachineSlNo"].ToString();
                    }
                    data.Category = metadata["L1"].ToString();
                    data.Subcategory = metadata["L2"].ToString();
                    data.FileType = metadata["Filetype"].ToString();
                    data.CollectionName = "MachineLeveleDoc";
                    list.Add(data);
                }
            }
            catch (Exception ex)
            {
                Logger.WriteDebugLog("getTroubleshootingEdocuments = " + ex.Message);
            }
            return list;
        }
        #endregion

        #region ----- MachineDoc transaction ---
        public static List<eDocumentData> getMachineDocumentsDetails(BsonArray model, BsonArray machineSlno, BsonArray category, BsonArray subcategory, string fromDateIp, string toDateIp, string view)
        {
            List<eDocumentData> list = new List<eDocumentData>();
            try
            {
                DateTime fromDate, toDate;
                PipelineDefinition<BsonDocument, BsonDocument> pipeline2 = null;
                if (view == "nodate")
                {
                    var match = new BsonDocument
                    {
                        {
                            "$match", new BsonDocument
                            {
                                //{ "metadata.MTB" , mtb},
                                { "metadata.Machine Model" ,  new BsonDocument{ { "$in" , model } } },
                                { "metadata.MachineSlNo" ,  new BsonDocument{ { "$in" , machineSlno } }  },
                                { "metadata.L1" ,  new BsonDocument{ { "$in" , category } }  },
                                 { "metadata.L2" ,  new BsonDocument{ { "$in" , subcategory } }  }
                            }
                        }
                    };
                    string[] str = { };
                    var unionWith = new BsonDocument
                    {
                        {
                            "$unionWith", new BsonDocument
                            {
                                { "coll" , "ModelLeveleDoc.files"},
                                 { "pipeline" ,new BsonArray
                                {
                                     new BsonDocument
                                {
                                    {
                                    "$lookup" ,new BsonDocument {
                                                {"from" , "MachineLeveleDoc.files" },
                                                {"let" ,  new BsonDocument { { "filename1", "$filename" } } },
                                                 {"pipeline" , new BsonArray{
                                                       new BsonDocument
                                                       {
                                                           {"$match" , new BsonDocument{
                                                                        {"$expr" ,new BsonDocument{
                                                                                    {"$and" , new BsonArray{
                                                                                        new BsonDocument { { "$eq",new BsonArray { "$filename", "$$filename1" } } },
                                                                                        new BsonDocument { { "$in",new BsonArray { "$metadata.MachineSlNo", new BsonArray {  machineSlno  } } }},
                                                                                    } },
                                                                        } },
                                                           } },
                                                       },
                                                       new BsonDocument{

                                                            {"$project" , new BsonDocument { { "filename", 0 } ,{ "_id", 0 } } },
                                                       }
                                                 }
                                                },
                                                 {"as" , "filedata" },
                                             }
                                    }
                                },
                                 new BsonDocument
                                {
                                    {
                                    "$match" ,new BsonDocument {
                                                //{"metadata.MTB" , mtb },
                                                {"metadata.Machine Model" , model },
                                                {"metadata.L1" , category },
                                                {"metadata.L2" , subcategory },
                                                  {"filedata" , new BsonDocument{ { "$eq" ,new BsonArray {} }} }
                                              }
                                     }
                                 }
                                }
                             }

                           }
                        }
                    };
                    var unionWith2 = new BsonDocument
                    {
                        {
                            "$unionWith", new BsonDocument
                            {
                                { "coll" , "MTBLeveleDoc.files"},
                                 { "pipeline" ,new BsonArray
                                                        { new BsonDocument
                                                        {
                                                            {
                                                            "$match" ,new BsonDocument {
                                                                 { "metadata.L1" ,  new BsonDocument{ { "$in" , category } } },
                                                                 { "metadata.L2" ,  new BsonDocument{ { "$in" , subcategory } } }
                                                            }
                                                            }
                                                        }
                                                         }
                                }
                            }
                    } };
                    pipeline2 = new BsonDocument[]
                   {
                       match,unionWith ,unionWith2
                   };
                }
                else
                {
                    fromDate = Util.GetDateTime(fromDateIp);
                    toDate = Util.GetDateTime(toDateIp);
                    var match = new BsonDocument
                    {
                        {
                            "$match", new BsonDocument
                            {
                                //{ "metadata.MTB" , mtb},
                                { "metadata.Machine Model" ,  new BsonDocument{ { "$in" , model } } },
                                { "metadata.MachineSlNo" ,  new BsonDocument{ { "$in" , machineSlno } }  },
                                { "metadata.L1" ,  new BsonDocument{ { "$in" , category } }  },
                                 { "metadata.L2" ,  new BsonDocument{ { "$in" , subcategory } }  }
                            }
                        }
                    };
                    var dateMatch = new BsonDocument
                    {
                        {
                            "$match", new BsonDocument
                            {
                                { "$expr",new BsonDocument{
                                    { "$and",new BsonArray
                                            {
                                                    new BsonDocument
                                                    {
                                                        { "$gte",new BsonArray
                                                        {
                                                           "$uploadDate",new BsonDocument { { "$dateFromString",new BsonDocument { { "dateString", fromDate.ToString("yyyy-MM-ddTHH:mm:ss") } } } }
                                                        } }
                                            },
                                                     new BsonDocument
                                                    {
                                                        { "$lte",new BsonArray
                                                        {
                                                             "$uploadDate",new BsonDocument { { "$dateFromString",new BsonDocument { { "dateString", toDate.ToString("yyyy-MM-dd"+"T23:59:59") } } } }
                                                        } }
                                            }

                                } } }
                            }
                        }
                    }
                    };
                    string[] str = { };
                    var unionWith = new BsonDocument
                    {
                        {
                            "$unionWith", new BsonDocument
                            {
                                { "coll" , "ModelLeveleDoc.files"},
                                 { "pipeline" ,new BsonArray
                                {
                                     new BsonDocument
                                {
                                    {
                                    "$lookup" ,new BsonDocument {
                                                {"from" , "MachineLeveleDoc.files" },
                                                {"let" ,  new BsonDocument { { "filename1", "$filename" } } },
                                                 {"pipeline" , new BsonArray{
                                                       new BsonDocument
                                                       {
                                                           {"$match" , new BsonDocument{
                                                                        {"$expr" ,new BsonDocument{
                                                                                    {"$and" , new BsonArray{
                                                                                        new BsonDocument { { "$eq",new BsonArray { "$filename", "$$filename1" } } },
                                                                                        new BsonDocument { { "$in",new BsonArray { "$metadata.MachineSlNo", new BsonArray { machineSlno  } } }},
                                                                                    } },
                                                                        } },
                                                           } },
                                                       },
                                                       new BsonDocument{

                                                            {"$project" , new BsonDocument { { "filename", 0 } ,{ "_id", 0 } } },
                                                       }
                                                 }
                                                },
                                                 {"as" , "filedata" },
                                             }
                                    }
                                },
                                 new BsonDocument
                                {
                                    {
                                    "$match" ,new BsonDocument {
                                                //{"metadata.MTB" , mtb },
                                                {"metadata.Machine Model" , model },
                                                {"metadata.L1" , category },
                                                {"metadata.L2" , subcategory }
                                              }
                                     }
                                 },
                                 dateMatch
                                }
                             }

                        }
                            }
                    };
                    var unionWith2 = new BsonDocument
                    {
                        {
                            "$unionWith", new BsonDocument
                            {
                                { "coll" , "MTBLeveleDoc.files"},
                                 { "pipeline" ,new BsonArray
                                                        { new BsonDocument
                                                        {
                                                            {
                                                            "$match" ,new BsonDocument {
                                                                 { "metadata.L1" ,  new BsonDocument{ { "$in" , category } } },
                                                                 { "metadata.L2" ,  new BsonDocument{ { "$in" , subcategory } } },

                                                            }
                                                            }
                                                        },   dateMatch
                                                         }


                                }
                            }
                    } };
                    pipeline2 = new BsonDocument[]
                   {
                      dateMatch, match,unionWith ,unionWith2
                   };
                }
                var modelDetails = _MongoDatabaseEDoc.GetCollection<BsonDocument>("MachineLeveleDoc.files").Aggregate(pipeline2).ToList();
                eDocumentData data = null;
                foreach (var item in modelDetails)
                {
                    data = new eDocumentData();
                    data.FileID = item["_id"].ToString();
                    data.Filename = item["filename"].ToString();
                    data.UpdatedTS = item["uploadDate"].AsDateTime.ToString("dd-MM-yyyy");
                    BsonDocument metadata = item["metadata"].AsBsonDocument;
                    data.MTB = metadata["MTB"].ToString();
                    data.CNCMake = metadata["CNC Make"].ToString();
                    data.CNCModel = metadata["CNC Model"].ToString();
                    if (metadata.Contains("Machine Model"))
                    {
                        data.MachineModel = metadata["Machine Model"].ToString();
                    }
                    else
                    {
                        data.MachineModel = "";
                    }
                    if (metadata.Contains("Machine Type"))
                    {
                        data.MachineType = metadata["Machine Type"].ToString();
                    }
                    if (metadata.Contains("MachineSlNo"))
                    {
                        data.MachineSlno = metadata["MachineSlNo"].ToString();
                    }
                    data.Category = metadata["L1"].ToString();
                    data.Subcategory = metadata["L2"].ToString();
                    if (metadata.Contains("Customer Name"))
                    {
                        data.CustomerName = metadata["Customer Name"].ToString();
                    }
                    if (metadata.Contains("Date of Dispatch"))
                    {
                        data.DateOfDispatchInString = metadata["Date of Dispatch"].AsDateTime.ToString("dd-MM-yyyy");
                    }
                    data.Version = metadata["Version"].ToString();
                    data.FileType = metadata["Filetype"].ToString();
                    data.UpdatedBy = metadata["UpdatedBy"].ToString();
                    data.CollectionName = "MachineLeveleDoc";
                    list.Add(data);
                }
            }
            catch (Exception ex)
            {
                Logger.WriteDebugLog("getMachineDocumentsDetails = " + ex.Message);
            }
            return list;
        }
        #endregion

        #region ---- Alarm History------
        public static List<AlarmHistoryData> getCNCAlarmData(string company, string plant, string machine)
        {
            List<AlarmHistoryData> list = new List<AlarmHistoryData>();
            AlarmHistoryData data = null;
            try
            {
                ShiftData shiftData = DBAccess.getCurrentShiftDetails();
                DateTime fromTime = Util.GetDateTime(shiftData.StartTime);
                DateTime toTime = Util.GetDateTime(shiftData.EndTime);
                PipelineDefinition<BsonDocument, BsonDocument> pipeline = null;
                var match = new BsonDocument {
                    {"$match",new BsonDocument
                    {
                        {"$and",new BsonArray
                        {
                            new BsonDocument{{ "$expr",new BsonDocument {
                                                            { "$and",new BsonArray
                                                            {
                                                                new BsonDocument {
                                                                { "$gte",new BsonArray {"$AlarmTime",new BsonDocument {
                                                                   { "$dateFromString",new BsonDocument { { "dateString", "2019-01-29T13:38:52" } } }
                                                                } } } },
                                                                new BsonDocument {
                                                                { "$lte",new BsonArray {"$AlarmTime",new BsonDocument {
                                                                   { "$dateFromString",new BsonDocument { { "dateString", "2020-09-29T13:38:52" } } }
                                                                } } } }
                                                            } } } } },
                            new BsonDocument
                            {
                                {
                                    "$or",new BsonArray
                                    {
                                        new BsonDocument{{ "AlarmNo", new BsonDocument { { "$lte", "1150" } } } },
                                        new BsonDocument{{ "AlarmNo",new BsonDocument { { "$gt", "1172" } } } },
                                    }
                                }
                            },
                            new BsonDocument
                            {
                                {"MachineID",machine }
                            }
                        } } } }
                };
                //fromTime.ToString("yyyy-MM-ddTHH:mm:ss")
                //toTime.ToString("yyyy-MM-ddTHH:mm:ss")
                var group = new BsonDocument
                {
                    {"$group", new BsonDocument{{ "_id", new BsonDocument {
                                                                            { "AlarmNo","$AlarmNo" },
                                                                            { "MachineID", "$MachineID" },                                                                                     {"AlarmMSG","$AlarmMSG" } } },
                                                {
                                                    "MAX(AlarmTime)",new BsonDocument{{ "$max", "$AlarmTime" } }
                                                },
                                                {"COUNT(AlarmNo)",new BsonDocument{ { "$sum", 1 } } }

                }} };

                var sort = new BsonDocument { { "$sort", new BsonDocument { { "MAX(AlarmTime)", 1 } } } };
                var project = new BsonDocument { { "$project",new BsonDocument {{"MachineID","$_id.MachineID" },
                                                                                {"AlarmNo","$_id.AlarmNo" },
                                                                                {"AlarmMSG","$_id.AlarmMSG" },
                                                                                {"Last Seen","$MAX(AlarmTime)" },
                                                                                { "No Of Occurences","$COUNT(AlarmNo)"},
                                                                                { "_id", 0} } } };
                AggregateOptions aggregateOptions = new AggregateOptions { AllowDiskUse = true };
                pipeline = new BsonDocument[]
                {
                    match,group,sort,project
                };
                var dataset = _MongoDatabase.GetCollection<BsonDocument>("AlarmHistoryTransaction").Aggregate(pipeline, aggregateOptions).ToList();
                foreach (var item in dataset)
                {
                    data = new AlarmHistoryData();
                    data.AlarmNo = item["AlarmNo"].ToString();
                    data.Message = item["AlarmMSG"].ToString();
                    data.LastSeen = item["Last Seen"].AsDateTime.ToString("dd-MM-yyyy");
                    data.NoOfOccurences = item["No Of Occurences"].ToString();

                    list.Add(data);
                }
            }
            catch (Exception ex)
            {
                Logger.WriteDebugLog("getCNCAlarmData = " + ex.Message);
            }
            return list;
        }
        public static List<AlarmHistoryData> getCNCAlarmSolutionData(string company, string plant, string machine, string alarmNum)
        {
            List<AlarmHistoryData> list = new List<AlarmHistoryData>();
            AlarmHistoryData data = null;
            try
            {
                ShiftData shiftData = DBAccess.getCurrentShiftDetails();
                DateTime fromTime = Util.GetDateTime(shiftData.StartTime);
                DateTime toTime = Util.GetDateTime(shiftData.EndTime);
                string mtb = DBAccess.getMTBForMachine(company, plant, machine);
                PipelineDefinition<BsonDocument, BsonDocument> pipeline = null;
                var match = new BsonDocument
                {
                    {
                        "$match",new BsonDocument
                        {
                            {"metadata.MTB",mtb },
                            {"metadata.AlarmNo",alarmNum }
                        }
                    }
                };
                var project = new BsonDocument
                {
                    {"$project",new BsonDocument
                    {
                        {"metadata.Description", "$metadata.Description" },
                        {"metadata.Cause",  "$metadata.Cause" },
                        {"metadata.Solution", "$metadata.Solution" },
                        {"_id", 0 },
                    } }
                };
                var group = new BsonDocument
                {
                    { "$group",new BsonDocument
                                {
                                     { "_id","" },
                                     {"distinct",new BsonDocument{
                                            {"$addToSet","$$ROOT" }
                                        } }
                                }
                    }
                };
                var unwind = new BsonDocument
                {
                    {
                        "$unwind",new BsonDocument
                        {
                             {"path", "$distinct" },
                             {"preserveNullAndEmptyArrays", false }
                        }
                    }
                };
                var replaceroot = new BsonDocument
                {
                    {
                        "$replaceRoot",new BsonDocument
                        {
                            { "newRoot" , "$distinct"}
                        }
                    }
                };
                AggregateOptions aggregateOptions = new AggregateOptions { AllowDiskUse = true };
                pipeline = new BsonDocument[]
                {
                    match,project,group,unwind,replaceroot
                };
                var dataset = _MongoDatabase.GetCollection<BsonDocument>("CNCAndPreventiveAlarmMaster.files").Aggregate(pipeline, aggregateOptions).ToList();
                int slno = 1;
                foreach (var item in dataset)
                {
                    data = new AlarmHistoryData();
                    BsonDocument metadata = item["metadata"].AsBsonDocument;
                    // data.AlarmNo = metadata["AlarmNo"].ToString(); 
                    data.AlarmNo = alarmNum;
                    data.AlarmCause = metadata["Cause"].ToString();
                    data.AlarmSolution = metadata["Solution"].ToString();
                    data.SlNo = slno.ToString();
                    list.Add(data);
                    slno++;
                }
            }
            catch (Exception ex)
            {
                Logger.WriteDebugLog("getCNCAlarmSolutionData = " + ex.Message);
            }
            return list;
        }
        public static List<AlarmHistoryData> getPreventiveAlarmData(string company, string plant, string machine)
        {
            ShiftData shiftData = DBAccess.getCurrentShiftDetails();
            List<AlarmHistoryData> list = new List<AlarmHistoryData>();
            AlarmHistoryData data = null;
            try
            {
                DateTime fromTime = Util.GetDateTime(shiftData.StartTime);
                DateTime toTime = Util.GetDateTime(shiftData.EndTime);
                PipelineDefinition<BsonDocument, BsonDocument> pipeline = null;
                var match = new BsonDocument {
                    {"$match",new BsonDocument
                    {
                        {"$and",new BsonArray
                        {
                            new BsonDocument{{ "$expr",new BsonDocument {
                                                            { "$and",new BsonArray
                                                            {
                                                                new BsonDocument {
                                                                { "$gte",new BsonArray {"$AlarmTime",new BsonDocument {
                                                                   { "$dateFromString",new BsonDocument { { "dateString", "2019-03-29T13:38:52" } } }
                                                                } } } },
                                                                new BsonDocument {
                                                                { "$lte",new BsonArray {"$AlarmTime",new BsonDocument {
                                                                   { "$dateFromString",new BsonDocument { { "dateString", "2020-02-18T22:28:32" } } }
                                                                } } } }
                                                            } } } } },
                            new BsonDocument
                            {
                                {
                                    "$and",new BsonArray
                                    {
                                        new BsonDocument{{ "AlarmNo",new BsonDocument { { "$gte", "1150" } } } },
                                        new BsonDocument{{ "AlarmNo",new BsonDocument { { "$lte", "1172" } } } },
                                    }
                                }
                            },
                            new BsonDocument
                            {
                                {"MachineID",machine }
                            }
                        } } } }
                };
                //fromTime.ToString("yyyy-MM-ddTHH:mm:ss")
                //toTime.ToString("yyyy-MM-ddTHH:mm:ss")
                var group = new BsonDocument
                {
                    {"$group", new BsonDocument{{ "_id", new BsonDocument {
                                                                            { "AlarmNo","$AlarmNo" },
                                                                            { "MachineID", "$MachineID" },                                                                                     {"AlarmMSG","$AlarmMSG" } } },
                                                {
                                                    "MAX(AlarmTime)",new BsonDocument{{ "$max", "$AlarmTime" } }
                                                },
                                                {"COUNT(AlarmNo)",new BsonDocument{ { "$sum", 1 } } }

                }} };

                var sort = new BsonDocument { { "$sort", new BsonDocument { { "MAX(AlarmTime)", 1 } } } };
                var project = new BsonDocument { { "$project",new BsonDocument {{"MachineID","$_id.MachineID" },
                                                                                {"AlarmNo","$_id.AlarmNo" },
                                                                                {"AlarmMSG","$_id.AlarmMSG" },
                                                                                {"Last Seen","$MAX(AlarmTime)" },
                                                                                { "No Of Occurences","$COUNT(AlarmNo)"},
                                                                                { "_id",0} } } };
                AggregateOptions aggregateOptions = new AggregateOptions { AllowDiskUse = true };
                pipeline = new BsonDocument[]
                {
                    match,group,sort,project
                };
                var dataset = _MongoDatabase.GetCollection<BsonDocument>("AlarmHistoryTransaction").Aggregate(pipeline, aggregateOptions).ToList();
                foreach (var item in dataset)
                {
                    data = new AlarmHistoryData();
                    data.AlarmNo = item["AlarmNo"].ToString();
                    data.Message = item["AlarmMSG"].ToString();
                    data.LastSeen = item["Last Seen"].AsDateTime.ToString("dd-MM-yyyy");
                    data.NoOfOccurences = item["No Of Occurences"].ToString();

                    list.Add(data);
                }
            }
            catch (Exception ex)
            {
                Logger.WriteDebugLog("getPreventiveAlarmData = " + ex.Message);
            }
            return list;
        }
        public static List<AlarmHistoryDocData> getAlarmHistoryDocumentList(string alarmNo, string colName, string machineid, string company, string plant, string cncCause, string cncSolution, string mtb)
        {
            List<AlarmHistoryDocData> list = new List<AlarmHistoryDocData>();
            AlarmHistoryDocData data = null;
            try
            {

                var filter = "";
                if (cncCause == "" && cncSolution == "")
                {
                    filter = "{'metadata.AlarmNo':'" + alarmNo + "','metadata.MTB':'" + mtb + "'}";
                }
                else
                {
                    filter = "{'metadata.AlarmNo':'" + alarmNo + "','metadata.MTB':'" + mtb + "','metadata.Cause':'" + cncCause + "','metadata.Solution':'" + cncSolution + "'}";
                }

                var documentIdList = _MongoDatabase.GetCollection<BsonDocument>(colName + ".files").Find(filter).ToList();
                foreach (var fileObjId in documentIdList)
                {
                    data = new AlarmHistoryDocData();
                    data.FileID = fileObjId["_id"].ToString();
                    data.FileName = fileObjId["filename"].ToString();
                    list.Add(data);
                }
            }
            catch (Exception ex)
            {
                Logger.WriteDebugLog("getAlarmHistoryDocumentList = " + ex.Message);
            }
            return list;
        }
        public static byte[] getAlarmFilesInByte(string fileId, string collectionName)
        {
            byte[] fileByte = null;
            try
            {
                ObjectId id = new ObjectId(fileId);
                GridFSBucketOptions op = new GridFSBucketOptions();
                op.BucketName = collectionName;
                Logger.WriteDebugLog("Download eDoc File: Before: " + DateTime.Now);
                GridFSBucketOptions gridFsOption = new GridFSBucketOptions(op);
                IGridFSBucket bucket = new GridFSBucket(_MongoDatabase, gridFsOption);
                fileByte = bucket.DownloadAsBytes(id);
            }
            catch (Exception ex)
            {
                Logger.WriteDebugLog("getEDocFilesInByte =" + ex.Message);
            }
            return fileByte;
        }
        #endregion

        #region ---- Signature Comparison Master ----
        public static List<string> getSignatureId(string company, string plant, string machine, BsonArray parameters)
        {
            List<string> listItemList = new List<string>();
            try
            {

                var match = new BsonDocument
                            {
                            {
                            "$match", new BsonDocument
                            {
                            { "CompanyID" , company},
                            { "PlantID" , plant},
                            { "MachineID" , machine},
                            { "ParameterID" , new BsonDocument{
                            { "$in" ,parameters }
                            } }
                            }
                            }
                            };
                                            var project = new BsonDocument
                            {
                            {
                            "$project" ,new BsonDocument {

                            { "SignatureID" , "$SignatureID"},
                            { "_id" , 0 }
                            }
                            }
                            };
                                            var group = new BsonDocument
                            {
                            {
                            "$group" ,new BsonDocument {
                            {"_id" , "" },
                            {"distinct",new BsonDocument
                            {
                            {"$addToSet" , "$$ROOT" }
                            } }
                            }
                            }
                            };
                                            var unwind = new BsonDocument
                            {
                            {
                            "$unwind" ,new BsonDocument {
                            {"path" , "$distinct" },
                            {"preserveNullAndEmptyArrays", false }
                            }
                            }
                            };
                                            var replaceRoot = new BsonDocument
                            {
                            {
                            "$replaceRoot" ,new BsonDocument {
                            {"newRoot" , "$distinct" }
                            }
                            }
                            };

                AggregateOptions aggregateOptions = new AggregateOptions { AllowDiskUse = true };
                PipelineDefinition<BsonDocument, BsonDocument> pipeline2 = new BsonDocument[]
                {
                        match,project,group,unwind,replaceRoot
                };
                IAsyncCursor<BsonDocument> result = _MongoDatabase.GetCollection<BsonDocument>("SignatureMaster").Aggregate(pipeline2, aggregateOptions);
                var resultSet = IAsyncCursorExtensions.ToList<BsonDocument>(result);


                foreach (BsonDocument doc in resultSet)
                {
                    listItemList.Add(doc["SignatureID"].AsString);
                }

            }
            catch (Exception ex)
            {

            }
            return listItemList;
        }
        public static List<SignatureComparisionDetails> getSignatureComparisonMasterData(string company, string plant, string machineId, string parameters, string signatureid)
        {
            List<SignatureComparisionDetails> signatureComparisionDetails = new List<SignatureComparisionDetails>();
            try
            {
                var filter = "{}";

                if (signatureid == "All")
                {
                    filter = "{'CompanyID':'" + company + "','PlantID':'" + plant + "','MachineID': '" + machineId + "','ParameterID':{'$in' : [" + parameters + "]}}";
                }
                else
                {
                    filter = "{'CompanyID':'" + company + "','PlantID':'" + plant + "','MachineID': '" + machineId + "','SignatureID':'" + signatureid + "','ParameterID':{'$in' : [" + parameters + "]}}";
                }
                signatureComparisionDetails = _MongoDatabase.GetCollection<SignatureComparisionDetails>("SignatureMaster").Find(filter).ToList();
            }
            catch (Exception ex)
            {
                Logger.WriteDebugLog("getSignatureComparisonMasterData = " + ex.Message);
            }
            return signatureComparisionDetails;
        }
        public static int insertSignatureComparisonMasterData(List<SignatureComparisionDetails> masterList)
        {
            int result = 0;
            try
            {
                var collection = _MongoDatabase.GetCollection<SignatureComparisionDetails>("SignatureMaster");
                collection.InsertManyAsync(masterList).Wait();
            }
            catch (Exception ex)
            {
                Logger.WriteDebugLog("insertSignatureComparisonMasterData = " + ex.Message);
            }
            return result;
        }
        public static bool isSignatureIdDetailsExists(string company, string plant, string machine, string parameter, string signature)
        {
            bool isSignatureExist = false;
            try
            {
                var filter = "{'CompanyID':'" + company + "','PlantID':'" + plant + "','MachineID':'" + machine + "','ParameterID':'" + parameter + "','SignatureID':'" + signature + "'}";
                List<SignatureComparisionDetails> signatureComparisionDetails = new List<SignatureComparisionDetails>();
                signatureComparisionDetails = _MongoDatabase.GetCollection<SignatureComparisionDetails>("SignatureMaster").Find(filter).ToList();
                if (signatureComparisionDetails.Count > 0)
                {
                    isSignatureExist = true;
                }
            }
            catch (Exception ex)
            {
                Logger.WriteDebugLog("isSignatureIdDetailsExists = " + ex.Message);
            }
            return isSignatureExist;
        }
        public static int updateSignatureIdMasterData(string company, string plant, string machine, string parameter, string fromSignature, string toSignature)
        {
            int result = 0;
            try
            {
                var collection = _MongoDatabase.GetCollection<SignatureComparisionDetails>("SignatureMaster");
                var filter = "{'CompanyID':'" + company + "','PlantID':'" + plant + "','MachineID' : '" + machine + "','ParameterID' : '" + parameter + "','SignatureID' : '" + fromSignature + "'}";
                var update = "{ $set: { 'SignatureID': '" + toSignature + "'}}";
                collection.UpdateMany(filter, update);
            }
            catch (Exception ex)
            {
                Logger.WriteDebugLog("updateSignatureIdMasterData = " + ex.Message);
            }
            return result;
        }
        public static int updateSignatureFreqAndParameterMasterDataByID(string id, SignatureComparisionDetails master)
        {
            int result = 0;
            try
            {
                var collection = _MongoDatabase.GetCollection<SignatureComparisionDetails>("SignatureMaster");
                var filter = "{_id : ObjectId('" + id + "')}";
                var update = "{ $set: { 'Frequency': '" + master.Frequency + "', 'ParameterValue': '" + master.ParameterValue + "'}}";
                collection.UpdateMany(filter, update);
            }
            catch (Exception ex)
            {
                Logger.WriteDebugLog("updateSignatureFreqAndParameterMasterDataByID = " + ex.Message);
            }
            return result;
        }
        public static int deleteSignatureMasterData(string company, string plant, string machine, string parameter, string signature)
        {
            int result = 0;
            try
            {
                var collection = _MongoDatabase.GetCollection<SignatureComparisionDetails>("SignatureMaster");
                var filter = "{'CompanyID':'" + company + "','PlantID':'" + plant + "',MachineID: '" + machine + "',SignatureID: '" + signature + "',ParameterID: '" + parameter + "'}";
                collection.DeleteManyAsync(filter).Wait();
            }
            catch (Exception ex)
            {
                Logger.WriteDebugLog("deleteSignatureMasterData = " + ex.Message);
            }
            return result;
        }
        #endregion
    }
}