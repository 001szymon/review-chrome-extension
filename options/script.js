function saveOptions() {
  optionFromTextInputToLocalStorage('app_url', 'appUrl');
  optionFromTextInputToLocalStorage('app_token', 'appToken');
  setupPermissions();
}

function restoreOptions() {
  optionFromLocalStorageToTextInput('app_url', 'appUrl');
  optionFromLocalStorageToTextInput('app_token', 'appToken');
}

function optionFromTextInputToLocalStorage(inputName, storageKey) {
  var input = document.getElementsByName(inputName)[0];
  var value = input.value;
  if(!!value) {
    localStorage[storageKey] = value;
  }
}

function optionFromLocalStorageToTextInput(inputName, storageKey) {
  var value = localStorage[storageKey];
  var input = document.getElementsByName(inputName)[0];
  if(!!value) {
    input.value = value;
  }
}

function setupPermissions() {
  var appUrl = localStorage["appUrl"];
  if (!!appUrl) {
    addPermissionsForHost(appUrl);
  }
}

function addPermissionsForHost(host) {
  chrome.permissions.request({
    "origins": [
      host
    ]
  });
}

document.addEventListener('DOMContentLoaded', restoreOptions);
document.querySelector('#save').addEventListener('click', saveOptions);
