<%@ Page Language="C#" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        databaseCon.ExecuteNonQuerySql("update Users set ftoken='" + Request["token"].ToString() + "' where MainModelGuid='" + Request["MainModelGuid"].ToString() + "'");
    }
</script>
