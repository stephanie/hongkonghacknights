ready = ->
  var now = new Date();

  //put all HKHK dates in array and cycle through them
  dates = ["March 12", "March 27", "April 10", "April 24", "May 8", "May 22", "June 12", "June 26", "July 10", "July 24", "August 14", "August 24"]

  var last_event = new Date( dates[0] + ", 2014" );

  if (now > last_event) {
    $( "#event-date" ).html( dates[1] );
  }

$(document).ready(ready)
