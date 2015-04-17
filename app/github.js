//$('.timeline-comment .form-actions button.btn-primary')
//  .before("<button class='btn btn-danger'><span class='octicon octicon-x' aria-hidden='true'></span> Rejected</button>")
//  .before("<button class='btn btn-success'><span class='octicon octicon-check' aria-hidden='true'></span> Accepted</button>")

commit = window.location.href.split("/")[6];
project = window.location.href.split("/")[4];

chrome.runtime.sendMessage({commit: commit, project: project}, function(r) {
  but = $('.timeline-comment .form-actions button.btn-primary');
  if (r && r.state == "accepted") {
    but.before("<div><span class='octicon octicon-thumbsup' aria-hidden='true'></span> Accepted</div>");
  } else if (r && r.state == "rejected") {
    but.before("<div><span class='octicon octicon-x' aria-hidden='true'></span> Rejected</div>");
  } else {
    but.before("<div class='btn-group' role='group'><button class='btn btn-link'><span class='octicon octicon-sync' aria-hidden='true'></span> Pending</button><button class='btn btn-danger'><span class='octicon octicon-x' aria-hidden='true'></span> Reject</button><button class='btn btn-success'><span class='octicon octicon-check' aria-hidden='true'></span> Accept</button></div>");
  };
  console.log(r);
  console.log(chrome.runtime.lastError);
});
