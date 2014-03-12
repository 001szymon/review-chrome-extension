function saveOptions() {
  var appUrlInput = document.getElementsByName('app_url')[0];
  var appTokenInput = document.getElementsByName('app_token')[0];

  var appUrl = appUrlInput.value;
  var appToken = appTokenInput.value;

  if(!!appUrl) {
    localStorage["appUrl"] = appUrl;
  }
  if(!!appToken) {
    localStorage["appToken"] = appToken;
  }
}

function restoreOptions() {
  var appUrl = localStorage["appUrl"];
  var appToken = localStorage["appToken"];

  var appUrlInput = document.getElementsByName('app_url')[0];
  var appTokenInput = document.getElementsByName('app_token')[0];

  if(!!appUrl) {
    appUrlInput.value = appUrl;
  }
  if(!!appToken) {
    appTokenInput.value = appToken;
  }
}

document.addEventListener('DOMContentLoaded', restoreOptions);
document.querySelector('#save').addEventListener('click', saveOptions);
