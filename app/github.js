commit = window.location.href.split("/")[6];
project = window.location.href.split("/")[4];

chrome.runtime.sendMessage({commit: commit, project: project});

chrome.runtime.onMessage.addListener(
  function(r, sender, sendResponse) {
    but = $('.timeline-comment .form-actions button.btn-primary');
    if (r && r.state == "accepted") {
      but.before("<button class='btn btn-success disabled'><span class='octicon octicon-thumbsup' aria-hidden='true'></span> Accepted</button>");
    } else if (r && r.state == "rejected") {
      but.before("<button class='btn btn-danger disabled'><span class='octicon octicon-x' aria-hidden='true'></span> Rejected</button>");
    } else {
      but.before("<button class='btn btn-info disabled'><span class='octicon octicon-sync' aria-hidden='true'></span> Pending</button><button class='btn btn-danger'><span class='octicon octicon-x' aria-hidden='true'></span> Reject</button><button class='btn btn-success'><span class='octicon octicon-check' aria-hidden='true'></span> Accept</button>");
    };
    console.log({response: r});
    console.log({lastError: chrome.runtime.lastError});
});
