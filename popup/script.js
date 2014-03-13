function appUrl(){
  return localStorage["appUrl"];
}

function appToken(){
  return localStorage["appToken"];
}

function apiUrl(){
  var host = appUrl();
  if (host[host.length-1] !== '/') {
    host = host +'/';
  }
  var token = appToken();
  return host + "api/v1/review_check?token=" + token;
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

function print(elId, text) {
  document.getElementById(elId).textContent = text;
}

getJSON(apiUrl(), function(resp){
  print('project_name', resp["project"]["name"]);
  print('deadline', resp["deadline"]);
  print('not_reviewed', resp["commits"]["by_state"]["not_reviewed"]);
  print('auto_rejected', resp["commits"]["by_state"]["auto_rejected"]);
});
