<%@ Control Language="C#" ClassName="chatCLeora2" %>
<script runat="server">

    string displayControles;
    protected void Page_Load(object sender, EventArgs e)
    {
        displayControles = "block";
    }
</script>

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
<style>
    .b2{
        display:table;
        height:30px !important;
        vertical-align:middle;
        width:49% !important;
    }
    #their-video{
        width:350px;
    }
</style>
<link href="/chat/css/chatCLeora2IOS2018.css" rel="stylesheet" />
<div id="mainDiv" style="display: block" class="videoTagNew">

    <div id="videoArea">
        <video id="their-video" autoplay playsinline controls >their video</video>
    </div>




    <div id="video-container">
        <div id="seroundUserVideo" style="display:block">
       
            <video id="my-video"  autoplay muted playsinline ></video>
        </div>
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
                    <label id="openCam" style="cursor:pointer" onclick="openCamera1()">פתח מצלמה/מיקרופון</label>
                   
<%--                <label onclick="openCameraComputer()" style="cursor: pointer">פתח מצלמה</label>--%>
            </li>
             <li style="background-color:#990000;display:none" class="b2">
                  <label id="openMic" style="cursor:pointer">שיחת שמע</label>
                  </li>
                         <li style="background-color:#03927e;" class="b2">
                  <label id="closeDevice" style="cursor:pointer;" onclick="closeCamera1()">סגור מצלמה/מיקרופון</label>
                  </li>
            <label onclick="closeMedia()">close media</label>
<%--            <li style="background-color: #990000;" id="closeChat">
                <label onclick="disconnectUser()" style="cursor: pointer">סיים שיחה</label>
            </li>--%>
        </ul>



        <%--   <div onclick="replaceCam()">replaceCam</div>--%>
    </div>
</div>

