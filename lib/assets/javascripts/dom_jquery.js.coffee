# insert element after referencing node
this.insert_after = (new_node, reference_node_ref) ->
  $(reference_node_ref).after(new_node)

# insert element at first position inside referencing node
this.insert_inside = (new_node, reference_node_ref) ->
  $(reference_node_ref).prepend(new_node)

# remove all elements which are not of current state and all elements
# which are of current state and secondly annotated to be always updated.
this.remove_state_elements = (curr_state) ->
  $("[data-state]").not("[data-state~='#{curr_state}']").remove()
  $("[data-state~='#{curr_state}'][data-state-update!='no']").remove()