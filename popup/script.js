function appUrl(){
  return localStorage["appUrl"];
}

function appToken(){
  return localStorage["appToken"];
}

function apiUrl(){
  var host = appUrl();
  var token = appToken();
  return host + "/api/v1/review_check?token=" + token;
}

function getJSON(url, successCallback) {
  var xhr = new XMLHttpRequest();
  xhr.open("GET", url, true);
  xhr.onreadystatechange = function() {
    if (xhr.readyState == 4) {
      var resp = JSON.parse(xhr.responseText);
      successCallback(resp);
    }
  }
  xhr.send();
}

getJSON(apiUrl(), function(resp){
  document.getElementById('content').textContent = resp;
});
