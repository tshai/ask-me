<%@ Control Language="VB" ClassName="popMessage" %>

<script runat="server">
    Function requestUrl()
        Try
            Dim Result = If(Request.RawUrl.Contains("message=" + Request("message") + "&"), "&", "")
            Return Result
        Catch ex As Exception

        End Try
    End Function
</script>
<script>
    function refreshThisPage(refreshUrl) {
        window.location.href = refreshUrl;
        return;
    }
</script>
<link href="/media/css/model.css" rel="stylesheet" />
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- ui-dialog -->
<%--    <asp:Panel ID="Panel2" runat="server" Visible="false">--%>
<!-- Modal -->
<%--<div class="modal fade" id="myModal" role="dialog" style="direction: rtl; text-align: right">--%>
<div class="modal fade" id="myModal" role="dialog">
    <div class="wrapper">

        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title"><%=Resources.Resources.SystemMessage%></h4>
                </div>
                <div class="modal-body">
                    <p>
                        <h3>
                            <asp:Label ID="modelMessage" runat="server" Text="Label"></asp:Label></h3>
                    </p>
                </div>
                <div class="modal-footer">
                    <label class="smallButton" data-dismiss="modal" onclick="refreshThisPage('<%=Request.RawUrl.Replace("message=" + Request("message") + requestUrl(), "") %>')"><%=Resources.Resources.Close%></label>
                </div>
            </div>
        </div>
    </div>
</div>
<%--</asp:Panel>--%>
<!-- ui-dialog -->
