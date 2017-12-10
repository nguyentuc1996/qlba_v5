
var me = 'Hong';
me.avatar = "https://lh6.googleusercontent.com/-lr2nyjhhjXw/AAAAAAAAAAI/AAAAAAAARmE/MdtfUmC0M4s/photo.jpg?sz=48";

var you = 'Lan';
you.avatar = "https://a11.t26.net/taringa/avatares/9/1/2/F/7/8/Demon_King1/48x48_5C5.jpg";

function formatAMPM(date) {
    var hours = date.getHours();
    var minutes = date.getMinutes();
    var ampm = hours >= 12 ? 'PM' : 'AM';
    hours = hours % 12;
    hours = hours ? hours : 12; // the hour '0' should be '12'
    minutes = minutes < 10 ? '0'+minutes : minutes;
    var strTime = hours + ':' + minutes + ' ' + ampm;
    return strTime;
}            

//-- No use time. It is a javaScript effect.
function insertChat(who, text, time = 0){
    var control = "";
    var date = formatAMPM(new Date());
    
    if (who == "me"){
       
        control = '<div class="container box-message">' +
                        '<img class="img-circle" alt="user image" src="'+ me.avatar +'" />' +
                        '<p>'+text+'</p>'+
                        '<span class="time-right">'+date+'</span>'+
                        
                    '</div>'
    
    }else{
        control = '<div class="container box-message darker">' +
                        '<img alt="user image" class="right" src="'+ me.avatar +'" />' +
                        '<p>'+text+'</p>'+
                        '<span class="time-left">'+date+'</span>'+
                        
                    '</div>'
    }
    setTimeout(
        function(){                        
           $("#chat-box").append(control);

        }, time);
    
}

function resetChat(){
    $("#chat-content").empty();
}
function chat(){
    var text  = $("#chat-content").val();
    if (text!==""){
        insertChat("me", text);
        $(this).val('');
    }
}
//-- Clear Chat
resetChat();

//-- Print Messages
insertChat("me", "Hello Tom...", 0);  
insertChat("you", "Hi, Pablo", 1500);
insertChat("me", "What would you like to talk about today?", 3500);
// insertChat("you", "Tell me a joke",7000);
// insertChat("me", "Spaceman: Computer! Computer! Do we bring battery?!", 9500);
// insertChat("you", "LOL", 12000);


//-- NOTE: No use time on insertChat.