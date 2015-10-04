chrome.storage.sync.get('ticketid', function(items) {
    var url = 'https://www.veilduck.com/status.html';
    document.getElementById("link").href = url;
    window.location.href = url;
});
