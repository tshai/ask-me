<%@ Control Language="C#" ClassName="chatCLeora2" %>

<script runat="server">
    string displayControles;
    protected void Page_Load(object sender, EventArgs e)
    {
        displayControles = "block";
    }
</script>
<script src="js2018/adapter.js"></script>
<script src="js2018/sfc.js"></script>



<asp:Panel ID="PanelEncJS" runat="server">
<%--    <script>
        var _$_72b4 = ["hide", "#their-video", "show", "#preloaderImage", "#divSize", "#seroundUserVideo", "#activateMedia", "#closeMedia", "#my-video", "toggle"]; getPeer(); var openCamera = 0; function myVideoToggle(_0xD370) { $(_$_72b4[1])[_$_72b4[0]](); $(_$_72b4[3])[_$_72b4[2]](); if (_0xD370 == 1) { $(_$_72b4[4])[_$_72b4[2]](); $(_$_72b4[5])[_$_72b4[2]](); $(_$_72b4[6])[_$_72b4[0]](); openCamera = openCamera + 1 }; if (_0xD370 == 0) { $(_$_72b4[4])[_$_72b4[0]](); $(_$_72b4[5])[_$_72b4[0]](); $(_$_72b4[6])[_$_72b4[0]](); $(_$_72b4[7])[_$_72b4[0]](); openCamera = openCamera + 1 }; if ($(_$_72b4[8])[_$_72b4[0]]()) { $(_$_72b4[8])[_$_72b4[2]]() } else { $(_$_72b4[8])[_$_72b4[0]]() } } function changeDivSize() { $(_$_72b4[5])[_$_72b4[9]]() }
    </script>--%>


</asp:Panel>

<asp:Panel ID="PanelNonEncJS" runat="server">
    <script>
        //getPeer();
        var openCamera = 0;
        function myVideoToggle(x) {
            $("#their-video").hide();
            $("#preloaderImage").show();
            continueShowImages
            if (x == 1) {
                $("#topVideo5").show();
                continueShowImages = 1;
                $("#divSize").show();
                $("#seroundUserVideo").show();
                $("#activateMedia").hide();
                $(".chooseCam").hide();
                //$("#closeMedia").show();
                openCamera = openCamera + 1;
            }
            if (x == 0) {
                $("#divSize").hide();
                $("#seroundUserVideo").hide();
                $("#activateMedia").hide();
                $(".chooseCam").hide();
                $("#closeMedia").hide();
                openCamera = openCamera + 1;

            }
            if ($("#my-video").hide()) {
                $("#my-video").show();
            }
            else {
                $("#my-video").hide();
            }
            //$("#my-video").toggle();
        }
        function changeDivSize() {
            $("#seroundUserVideo").toggle();
        }
        function replaceCam() {
            var select = document.getElementById("videoSource");
            var newValue = Math.abs(select.selectedIndex - 1);
            select.selectedIndex = newValue
            alert(newValue)
        }

        //function openCameraComputer()
        //{



        //    $("#activateMedia").click();
        //}
    </script>


</asp:Panel>
<style>
    .b2{
        display:table;
        height:30px !important;
        vertical-align:middle;
        width:49% !important;
    }
</style>
<link href="chatCLeora2IOS2018.css" rel="stylesheet" />
<div id="speedError" style="background-color: yellow; width: 100%; text-align: center; color: #111; height: 100px; line-height: 100px; display: none">
    קיימת בעיית מהירות<a href="chatC.aspx">
    במידה והתמונה תקועה לחץ כאן</a>

</div>
<div id="mainDiv" style="display: block" class="videoTagNew">
    <%--            <div id="topLine"></div>--%>

    <div id="videoArea">
        <%--                <img src="../../new_waiting_list/chat_application/preloader.gif" visible="false" id="preloaderImage"/>--%>
        <video id="their-video" autoplay playsinline controls style="width: 100%">their video</video>

    </div>




    <div id="video-container">
        <div id="seroundUserVideo" style="display:block">

<%--            <video id="my-video"  autoplay muted playsinline poster="/media/images/yourCameraBlocked.png"></video>--%>
            
            <video id="my-video"  autoplay muted playsinline ></video>
        </div>
        <label id="divSize" onclick="changeDivSize()" style="display: none; text-align: center">-</label>
        <%--                המצלמה שלי--%>
    </div>
    <div class="openCam">
        <div>
            <div id="step1" runat="server">
                <%--                        <p>click allow</p>--%>
                <div id="step1-error">
                   <%-- <label id="activateMedia" onclick="myVideoToggle(1)">--%>
                     <label id="activateMedia">
                        <img src="video-camera.png" style="display:none" /></label></div>

                <div id="step1-error1">
                    <label hidden id="closeMedia" class="button" onclick="myVideoToggle(0)" style="width: 150px">סגור מצלמה ומיקרופון</label></div>
            </div>
        </div>
        <div id="step2" style="display: none">
            <p>my id: <span id="my-id">...</span></p>
            <p>
                <span id="subhead">make a call</span><br />
                <input type="text" placeholder="call user id..." id="callto-id" />
                <a href="#" id="make-call">call</a>
            </p>
        </div>
        <div id="step3" style="display: none">
            <p><a href="#" id="end-call"></a></p>
        </div>
    </div>
    <div style="display: <%=displayControles%>" class="chooseCam">
        <label for="audioSource" style="display: none">Audio input source: </label>
        <select id="audioSource" style="display: none"></select>
        <label for="audioOutput" style="display: none">Audio output destination: </label>
        <select id="audioOutput" style="display: none"></select>
        <ul class="chooseCameraUL">
            <li style="display:none">
                <label for="videoSource">מצלמה: </label>
            </li>
            <li style="display:none">
                <select id="videoSource"></select>
            </li>
            <li style="background-color: #037992;" class="b2">
                 <label onclick="openCameraComputer()" style="cursor: pointer;display:none">פתח מצלמה</label>
                    <label id="openCam" style="cursor:pointer">פתח מצלמה/מיקרופון</label>
                   
<%--                <label onclick="openCameraComputer()" style="cursor: pointer">פתח מצלמה</label>--%>
            </li>
             <li style="background-color:#990000;display:none" class="b2">
                  <label id="openMic" style="cursor:pointer">שיחת שמע</label>
                  </li>
                         <li style="background-color:#03927e;" class="b2">
                  <label id="closeDevice" style="cursor:pointer;">סגור מצלמה/מיקרופון</label>
                  </li>
<%--            <li style="background-color: #990000;" id="closeChat">
                <label onclick="disconnectUser()" style="cursor: pointer">סיים שיחה</label>
            </li>--%>
        </ul>



        <%--   <div onclick="replaceCam()">replaceCam</div>--%>
    </div>
<%--    <script src="customerMain?ver=5.<%=Session["jsASPXVer"]%>"></script>--%>
    <asp:Panel ID="Panel3" runat="server" Visible="false">
        <script src="js/main3a.js?ver=<%=Session["jsVer"].ToString()%>"></script>
    </asp:Panel>
</div>

