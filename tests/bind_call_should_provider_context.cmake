function(bind_call_should_provide_context)
	obj_create(obj)


	function(testfunc)
		set(was_called true PARENT_SCOPE)
		set(ref ${this} PARENT_SCOPE)
	endfunction()

	obj_bindcall(${obj} testfunc)

	assert(was_called)
	assert(${ref} STREQUAL ${obj})
endfunction()