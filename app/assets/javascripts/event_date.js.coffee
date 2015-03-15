### commenting out old coffeescript code
ready = ->
  now = new Date()

  #put all HKHK dates in array and cycle through them
  dates = ["March 12", "March 27", "April 10", "April 24", "May 7", "May 22", "June 12", "June 26", "July 10", "July 24", "August 14", "August 28"]

  for date in dates
    oldDate = new Date( date + ", 2014") 
    hkhk_event = new Date(oldDate.getFullYear(),oldDate.getMonth(),oldDate.getDate()+1)
    if(now > hkhk_event)
      index = dates.indexOf(date)
      dates.splice(index, 1)

  $('#event-date').html(dates[1])
  console.log "Welcome h4xr! Our next Hacknights is on " + dates[1] + "."

$(document).ready(ready)
###