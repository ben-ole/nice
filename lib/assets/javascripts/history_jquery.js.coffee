this.move_to_url = (url, title) ->
  history.pushState(null,title,url)
			
this.insert_or_update_back_listener = (url) ->
  # remove current existing back-binders
  $(window).unbind('popstate')
  $(window).bind('popstate', -> 
    xmlHttp = null
    xmlHttp = new XMLHttpRequest()
    xmlHttp.open('GET', url, false)
    xmlHttp.send(null)
    eval(xmlHttp.responseText)
  )