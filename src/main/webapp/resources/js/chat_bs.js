$(function() {
    'use strict';
    console.log("adasdasddddddddddddddd==");
    var topic = parseInt($("#bacsi").val())*65536+parseInt($("#benhnhan").val());
    console.log(topic);
	client = Stomp.over(new SockJS('/chat'));
	client.connect({}, function (frame) {
	    setConnected(true);
	    
	    var topic = parseInt($("#bacsi").val())*65536+parseInt($("#benhnhan").val());
	    console.log(topic);
	    client.subscribe('/topic/messages/'+topic.toString(), function (message) {
		showMessage(JSON.parse(message.body));
	    });
	});

    var client;

    function showMessage(mesg)
    {
    	if (mesg.nguoiGui==1){
    		$('#messages').append('<tr>' +
    			      '<td> Bác sĩ ' + mesg.maBacSi + ': </td>' +
    				      '<td>' + mesg.traLoi + '</td>' +

    				      '</tr>');
    	}else{
    		$('#messages').append('<tr>' +
    			      '<td> Bệnh nhân ' + mesg.maBenhNhan + ' :</td>' +
    				      '<td>' + mesg.traLoi + '</td>' +

    				      '</tr>');
    	}

    	console.log("this is message"+mesg)
    }

    function setConnected(connected) {
	$("#connect").prop("disabled", connected);
	$("#disconnect").prop("disabled", !connected);
	$('#benhNhan').prop('disabled', connected);
	$('#text').prop('disabled', !connected);
	if (connected) {
	    $("#conversation").show();
	    $('#text').focus();
	}
	else $("#conversation").hide();
	$("#messages").html("");
    }

    $("form").on('submit', function (e) {
	e.preventDefault();
    });

    $('#benhNhan').on('blur change keyup', function(ev) {
	$('#connect').prop('disabled', $(this).val().length == 0 );
    });
    $('#connect,#disconnect,#text').prop('disabled', true);

    $('#connect').click(function() {
    	var topic = parseInt($("#bacSi").val())*65536+parseInt($("#benhNhan").val());
	    console.log(topic);
	client = Stomp.over(new SockJS('/chat'));
	client.connect({}, function (frame) {
	    setConnected(true);
	    
	    var topic = parseInt($("#bacSi").val())*65536+parseInt($("#benhNhan").val());
	    console.log(topic);
	    client.subscribe('/topic/messages/'+topic.toString(), function (message) {
		showMessage(JSON.parse(message.body));
	    });
	});
    });

    $('#disconnect').click(function() {
	if (client != null) {
	    client.disconnect();
	    setConnected(false);
	}
	client = null;
    });

    $('#send').click(function() {
    console.log($("#bacsi").val());
    console.log($("#benhnhan").val());
    console.log($("#nguoigui").val());
	var topic = parseInt($("#bacsi").val())*65536+parseInt($("#benhnhan").val());
	console.log(topic);
	client.send("/app/chat/" + topic.toString(), {}, JSON.stringify({
	    maBenhNhan: parseInt($("#benhnhan").val()),
	    maBacSi: parseInt($("#bacsi").val()),
	    traLoi: $('#text').val(),
	    nguoiGui:$('#nguoigui').val(),
	}));
	$('#text').val("");
    });
});