<%@ Page Title="" Language="C#" MasterPageFile="~/masters/controlPanelWhite.master" Inherits="CaltureCompanyLogin" %>

<script runat="server">
    string SupplierChatGuid;

    protected void Page_Load(object sender, EventArgs e)
    {
        SupplierChatGuid = SupplierAPI.getMainModelsByNum(int.Parse(Session["UserID"].ToString())).UserChatGuid.ToString();
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        #pluginBox {
            float: left;
            display: flex;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="pluginBox">
        <textarea id="codeToYourSite" cols="100" rows="20">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <iframe style="border: none;display: block;position: fixed;top: auto;left: auto;bottom: 24px;right: 24px;
        visibility: visible;z-index: 2147483647;max-height: 100vh;max-width: 100vw;transition: none 0s ease 0s;
     background: none transparent;opacity: 1;width: 500px;height: 400px;" 
        src="https://www.ask-me.app/companies/plugins/chatPlugin.aspx?SupplierChatGuid=<%=SupplierChatGuid %>" scrolling="no"></iframe>
</textarea>
        <div id="copy" onclick="copyToClipboard()">
            <i id="copyIcon" class="fa fa-copy" aria-hidden="true"></i>
            <i class='fa fa-check-square-o' aria-hidden='True' style="display: none; color: green;"></i>
        </div>
    </div>
    <%--Start ask-me tag--%>
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <iframe style="border: none;display: block;position: fixed;top: auto;left: auto;bottom: 24px;right: 24px;
        visibility: visible;z-index: 2147483647;max-height: 100vh;max-width: 100vw;transition: none 0s ease 0s;
     background: none transparent;opacity: 1;width: 500px;height: 400px;" 
        src="https://www.ask-me.app/companies/plugins/chatPlugin.aspx?SupplierChatGuid=c911bc77-b9e5-42ef-9aa9-10219b36522c" scrolling="no"></iframe>
    <%--End ask-me tag--%>

    <script type="text/javascript">
        function copyToClipboard() {
            var copyText = document.getElementById("codeToYourSite");
            copyText.select();
            document.execCommand("Copy");
            $(document).ready(function () {
                $('.fa-check-square-o').css('display', 'block');
            });
        }
    </script>
</asp:Content>

