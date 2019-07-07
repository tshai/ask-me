var localVideo;
var remoteVideo;
var yourConn;
var stream1='0';
var track;
var name = 'בחור';
//var chat = $.connection.chatHub;
var pc, sender;
var cont;
var Video = false;
var connection = new signalR.HubConnectionBuilder().withUrl("https://www.ask-me.app/Core/ChatHub2019V2").build();
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
        //remoteVideo.src = window.URL.createObjectURL(event);
        remoteVideo.srcObject = event.streams[0];
        //remoteVideo.addTrack = event.track;
        //remoteVideo.play();
        remoteVideo.onloadedmetadata = function () {

            remoteVideo.play();
        };
    };

    /// open my camera 27-1-19
    handleLogin('true', 2, function (x) {
        if (x === 'true') {
            //  chat.server.Generic("Wrtc", JSON.stringify({
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
            //message.put("type", "candidate");
            //message.put("label", iceCandidate.sdpMLineIndex);
            //message.put("id", iceCandidate.sdpMid);
            //message.put("candidate", iceCandidate.sdp);
            connection.invoke("Generic", "Wrtc", JSON.stringify({
                type: "candidate",
                candidate: event.candidate,
                sdpMLineIndex: event.candidate.sdpMLineIndex,
                sdpMid: event.candidate.sdpMid
            }), RndNumber.trim(), CustomerID, SupplierID, "0", "32E08B98-996B-4C5B-921A-35E43210FCB1").catch(function (err) {
                return console.error(err.toString());
            }).catch(function (err) {
                console.log("77" - err.toString());
            });





            //chat.server.Generic("Wrtc", JSON.stringify({
            //    type: "candidate",
            //    candidate: event.candidate
            //})).catch(function (err) {
            //    console.log("77" - err.toString());
            //});
        }
    };
};

function handleLogin(success, type, callback) {
    if (success === false) {
        alert("Ooops...try a different username");
    } else {
        //********************** 
        var cont;
        if (type === 1) {
            cont = { video: true, audio: true };
        }
        if (type === 2) {
            cont = { video: false, audio: true };
        }
        if (type === 3) {
            cont = {
                video: {

                    deviceId: 'sdfgd'
                },
                audio: {
                    deviceId: 'sdfgd',
                    sampleSize: 16,
                    channelCount: 2
                }
            };
        }

        //yourConn.removeTrack(yourConn.getSenders()[0]);
        if (stream1 != '0') {
            yourConn.removeStream(stream1);
        }
       
        navigator.mediaDevices.getUserMedia(

            cont
            //{ video: Video, audio: true }


        )
            .then(function (mysTREAM) {
                stream1 = mysTREAM;
                localVideo.srcObject = stream1;
                yourConn.addStream(stream1);
                //stream1.getTracks().forEach(track => yourConn.addTrack(track, stream1));
                //stream1.getTracks().forEach(function (track) {
                //    yourConn.addTrack(track, stream1);
                //});
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

        connection.invoke("Generic", "Wrtc", JSON.stringify({
            type: "answer",
            "sdp": answer.sdp
        }), RndNumber.trim(), CustomerID, SupplierID, "0", "32E08B98-996B-4C5B-921A-35E43210FCB1").catch(function (err) {
            return console.error(err.toString());
        }).catch(function (err) {
            console.log("243" - err.toString());
        });



        //chat.server.Generic("Wrtc", JSON.stringify({
        //    type: "answer",
        //    answer: answer
        //})).catch(function (err) {
        //    console.log("243-" + err.message);
        //});

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
        yourConn.addIceCandidate(new window.RTCIceCandidate(candidate)).catch(e => {
            console.log("Failure during addIceCandidate(): " + e.name);
        });

    }
    catch (err) {
        console.log("270-" + err.message);
        //yourConn.addIceCandidate(new window.RTCIceCandidate(candidate.candidate)).catch(e => {
    }

};


connection.on("SendMessage", function (message) {
    //console.log(message);
    if (IsJsonString(message) === true) {
        var data = JSON.parse(message);

        switch (data.type) {

            case "offer":
                //alert("ss");
                console.log("GET-offer", "offer");
                // handleOffer(data.offer, "offer");
                handleOffer(data, "offer");
                break;
            case "answer":
                console.log("GET-answer", "answer");
                handleAnswer(data.answer);
                break;
            case "candidate":
                console.log("GET-candidate", "candidate");
                handleCandidate(data);
                //handleCandidate(data.candidate);
                break;
            case "leave":
                handleLeave();
                break;
            case "supplierAcceptChat":
                $("#waitForSuppliers").hide();
                $("#ringTone")[0].pause();
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
    if (message === "Login") {
        //console.log("Login-304", message);
        //handleLogin(('true', 1);

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

});

connection.start().catch(function (err) {
    return console.error(err.toString());
}).then(() => {
    connection.invoke("Generic", "Initialize", "testMessage", RndNumber.trim(), CustomerID, SupplierID, "0", "32E08B98-996B-4C5B-921A-35E43210FCB1").catch(function (err) {
        return console.log(err.message);
    });
});


function myTimer() {
    connection.invoke("Generic", "Update", "update248", RndNumber.trim(), CustomerID, SupplierID, "0", "32E08B98-996B-4C5B-921A-35E43210FCB1").catch(function (err) {
        return console.log(err.message);
    });
    //chat.server.generic("update", "update248").catch(function (err) {off
    //    console.log("366-" + err.message);
    //});

}
var myVar = setInterval(myTimer, 3000);
//    .then(() => {
//    connection.invoke("GenericMessage", "Login", "Login", RndNumber.trim(), UserGuid.trim(), "0", "32E08B98-996B-4C5B-921A-35E43210FCB1").catch(function (err) {
//        return console.error(err.toString());
//    });
//});

//$.connection.hub.start().done(function () {
//    chat.server.Generic("Initialize", "Initialize").catch(function (err) {
//        console.log("358-" + err.message);
//    });


//});


function openCamera1() {
    window.RTCPeerConnection = window.RTCPeerConnection || window.mozRTCPeerConnection || window.webkitRTCPeerConnection;
    yourConn = new RTCPeerConnection(configuration);
    //yourConn.removeStream(stream);//remove the stream from the connection .the other user stop see 
    //if (stream1) {
    //    stream1.getTracks().forEach(function (track) { track.stop(); });//delete all stream.this will stop sending video to the local video tag 
    //}
    handleLogin('true', 1, function (x) {
        if (x == 'true') {
        connection.invoke("Generic", "Wrtc", "openCam", RndNumber.trim(), CustomerID, SupplierID, "0", "32E08B98-996B-4C5B-921A-35E43210FCB1").catch(function (err) {
            return console.log(err.message);
        });

        }
    });


}
function closeMedia() {
    console.log('Ending call');
    yourConn.close();
    //pc2.close();
    yourConn = null;
    //pc2 = null;
    //hangupButton.disabled = true;
    //callButton.disabled = false;

}
function closeCamera1() {



    yourConn.removeStream(stream1);//remove the stream from the connection .the other user stop see 
    if (stream1) {
        stream1.getTracks().forEach(function (track) { track.stop(); });//delete all stream.this will stop sending video to the local video tag 
    }
    handleLogin('true', 2, function (x) {
        if (x == 'true') {
            connection.invoke("Generic", "Wrtc", "closeCam", RndNumber.trim(), CustomerID, SupplierID, "0", "32E08B98-996B-4C5B-921A-35E43210FCB1").catch(function (err) {
                return console.log(err.message);
            });
        }
    });


}





