var localVideo;
var remoteVideo;
var yourConn;
var stream;
var name = 'בחור';
var chat = $.connection.chatHub2019;
$.connection.hub.qs = 'name=' + name + '&RndNumber=' + RndNumber.trim() + '&customerID=' + UserID.trim() + '&supplierID=' + SupplierID.trim() + '&whoSend=0&gid=1&guid=1';
$(document).ready(function () {
    localVideo = document.querySelector("video#my-video");
    remoteVideo = document.querySelector('#their-video');
    buildConnection();
});
function buildConnection() {
    try {
        window.RTCPeerConnection = window.RTCPeerConnection || window.mozRTCPeerConnection || window.webkitRTCPeerConnection;
        yourConn = new RTCPeerConnection(configuration);
        //yourConn = new RTCPeerConnection({ configuration, sdpSemantics: 'unified-plan' });
    }
    catch (err) {
        console.log("46" - err.toString());
    }


    //when a remote user adds stream to the peer connection, we display it 
    yourConn.ontrack = function (event) {//event listener
        remoteVideo.srcObject = event.streams[0];
        remoteVideo.onloadedmetadata = function () {

            remoteVideo.play();
        };
    };

    /// open my camera 27-1-19
    handleLogin('true', 1, function (x) {
        if (x === 'true') {
            //  chat.server.generic("wrtc", JSON.stringify({
            //    type: "cOVAC",
            //    name: "customer"
            //})).catch(function (err) {
            //    console.log("63" - err.toString());
            //});
        }
    });
    ///
    // Setup ice handling 
    yourConn.onicecandidate = function (event) {
        if (event.candidate) {
            chat.server.generic("wrtc", JSON.stringify({
                type: "candidate",
                candidate: event.candidate
            })).catch(function (err) {
                console.log("77" - err.toString());
            });
        }
    };
};

function handleLogin(success, type, callback) {
    if (success === false) {
        alert("Ooops...try a different username");
    } else {
        navigator.mediaDevices.getUserMedia({ video: true, audio: true })
            .then(function (myStream) {
                localVideo.srcObject = myStream;
                myStream.getTracks().forEach(track => yourConn.addTrack(track, myStream));
                callback('true');
            })
            .catch(function (err) {
                console.log(err.message);
            });
    }
}//type 1 mic and cam, type 2 only mic
//when somebody sends us an offer 
function handleOffer(offer, name) {
    console.log("239-handleOffer");
    try {
        window.RTCSessionDescription = window.RTCSessionDescription || window.mozRTCSessionDescription || window.webkitRTCSessionDescription;
        var RTCSessionDescription_ = new window.RTCSessionDescription(offer);
        yourConn.setRemoteDescription(RTCSessionDescription_);
    }
    catch (err) {
        logError("228-" + err.message);
        console.log("228-" + err.message);
    }


    //create an answer to an offer 
    yourConn.createAnswer(function (answer) {
        console.log("239-createAnswer");
        yourConn.setLocalDescription(answer);
        chat.server.generic("wrtc", JSON.stringify({
            type: "answer",
            answer: answer
        })).catch(function (err) {
            console.log("243-" + err.message);
        });

    }, function (error) {
        logError(err.message);
        alert("Error when creating an answer");
    });
}

function handleAnswer(answer) {
    try {
        window.RTCSessionDescription = window.RTCSessionDescription || window.mozRTCSessionDescription || window.webkitRTCSessionDescription;
        yourConn.setRemoteDescription(new window.RTCSessionDescription(answer));
        console.log("244-handleAnswer");
    }
    catch (err) {
        console.log("258-" + err.message);
    }

};

//when we got an ice candidate from a remote user 
function handleCandidate(candidate) {
    try {
        console.log("256-handleCandidate");
        window.RTCIceCandidate = window.RTCIceCandidate || window.mozRTCIceCandidate || window.webkitRTCIceCandidate;
        yourConn.addIceCandidate(new window.RTCIceCandidate(candidate));
    }
    catch (err) {
        console.log("270-" + err.message);
    }

};


chat.client.newMessage = function (message) {
    //console.log(message);

    if (IsJsonString(message) === true) {
        var data = JSON.parse(message);

        switch (data.type) {
            case "login":
                //console.log("login-304", message);
                handleLogin(data.success, 1);
                break;
            case "offer":
                //alert("ss");
                console.log("GET-offer", "offer");
                handleOffer(data.offer, data.name);
                break;
            case "answer":
                console.log("GET-answer", "answer");
                handleAnswer(data.answer);
                break;
            case "candidate":
                console.log("GET-candidate", "candidate");
                handleCandidate(data.candidate);
                break;
            case "leave":
                handleLeave();
                break;
            case "supplierAcceptChat":
                $("#waitForSuppliers").hide();
                return;
            case "conversation":
                if (data.name === "finishChat5643g6a-") {// employee finish chat
                    window.location.href = 'outCamera.aspx';
                }


                //handleLeave();
                break;

            default:
                break;
        }
        return;
    }

    if (message == "disconnectChat17" || message == "updateStatus743=1") {
        console.log("customerWs: " + Date());
        console.log(message);
        setTimeout(sendErrorToDB("customerws.aspx :" + message, 1), 2);
        setTimeout(window.location.assign("/users/chat/outCamera.aspx?348"), 1);
    }
    else if (message == "disconnectChat18") {
        $('#lessMinute').show();
    }

};
$.connection.hub.start().done(function () {
    chat.server.generic("Initialize", "Initialize").catch(function (err) {
        console.log("358-" + err.message);
    });


});

function myTimer() {
    chat.server.generic("update", "update248").catch(function (err) {
        console.log("366-" + err.message);
    });

}
var myVar = setInterval(myTimer, 3000);




