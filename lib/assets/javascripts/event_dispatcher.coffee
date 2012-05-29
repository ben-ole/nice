this.dispatch_event = (event_name, attrs) ->
  # create event
  evt = document.createEvent("Event")
  evt.initEvent(event_name,true,true);
  # add remaining arguments as event properties
  evt[key] = value for key, value of attrs
  # dispatch
  document.dispatchEvent(evt)