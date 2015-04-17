$('.timeline-comment .form-actions button.btn-primary')
  .before("<button class='btn btn-danger'><span class='octicon octicon-x' aria-hidden='true'></span> Rejected</button>")
  .before("<button class='btn btn-success'><span class='octicon octicon-check' aria-hidden='true'></span> Accepted</button>")

commit = window.location.href.split("/")[6];
project = window.location.href.split("/")[4];

chrome.runtime.sendMessage({commit: commit, project: project}, function(r) { console.log(r); console.log(chrome.runtime.lastError); });
