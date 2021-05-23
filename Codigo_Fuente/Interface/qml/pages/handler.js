WorkerScript.onMessage = function(message, func) {
    if(message.run === true && func != undefined) {
        func()
    }
    WorkerScript.sendMessage({run : false});
}