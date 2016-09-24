function sayHiToNativeApp () {
    try {
        webkit.messageHandlers.callback.postMessage("Hi User.");
    } catch(err) {
        console.log('There was some problem sending message native app');
    }
}


function setText(message) {
    document.getElementsByClassName("title")[0].innerHTML = message;

    sayHiToNativeApp();

}