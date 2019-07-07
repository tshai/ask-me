<%@ Page Language="C#" Trace="false" %>

<%@ Import Namespace="Entities" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Collections.Generic" %>
<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.ExpiresAbsolute = DateTime.Now;
        Response.AddHeader("pragma", "no-cache");
        Response.AddHeader("cache-control", "private");
        Response.CacheControl = ("no-cache");
        Response.Cache.SetCacheability(HttpCacheability.NoCache);

        List<int> supplierList = new List<int>();
        using (var db = new Entities())
        {
            supplierList = (from a in db.OnlineUsers where a.Online != 0 select a.SupplierID).ToList();
            //var q = from a in db.new_models where a.online != 0 && a.isQA==1 select a;
        }
        foreach (var item in supplierList)
        {
            camCheck.checkStauts(item);
        }

        //errors.WriteErrorLog(DateTime.Now.ToString());
        Response.Write("success");


        databaseCon.ExecuteNonQuerySql("UPDATE Setting SET WindowsServiceLastUpdate = GETDATE()");
        //databaseCon.ExecuteNonQuerySql("update ChatTimeUse set TimeUse=DATEDIFF(S,datein,GETDATE())*SupplierDiscount where CloseDiscount=0 and SupplierDiscount<>0");
        //databaseCon.ExecuteNonQuerySql("update ChatTimeUse set TimeUse=DATEDIFF(S,datein,GETDATE())*SupplierDiscount where SessionStatus=1 and SupplierDiscount<>0");
        databaseCon.ExecuteNonQuerySql("update ChatTimeUse set TimeUse=0,IsAnswer=2 where SessionStatus=1 and IsAnswer=0 and datediff(second,AnswerDateIn,dateout)>29");

    }


</script>
