class this.NiceEventDispatcher

	# state transition cache
	@state_cache

	# gets called by JS response and generates JS events either dispatched immediatly
	# or later by another transition event
	@dispatch_event: (event_name, attrs, cached = false, transition_id = null) ->
		# create event
		evt = document.createEvent("Event")
		evt.initEvent(event_name,true,true);
		
		# add remaining arguments as event properties
		evt[key] = value for key, value of attrs

		if cached == true # is this state preloading?
			if !NiceEventDispatcher.state_cache?[transition_id]?
				NiceEventDispatcher.state_cache = new Object;
				NiceEventDispatcher.state_cache[transition_id] = []
				document.addEventListener "nice.state.CachedTransitionEvent", NiceEventDispatcher.dispatch_cached_transition_events, false

			NiceEventDispatcher.state_cache[transition_id].push evt
		else # dispatch
			document.dispatchEvent(evt)

	# launch cached state transition
	@dispatch_cached_transition_events: (event) ->
		if NiceEventDispatcher.state_cache?[event.transition_id]?

			# fire stored events
			document.dispatchEvent(evt) for evt in NiceEventDispatcher.state_cache[event.transition_id]
			
			# clean/reset
			NiceEventDispatcher.state_cache[event.transition_id] = null