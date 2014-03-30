function(map_transform result query)
	string(STRIP "${query}" query)
	string(FIND "${query}" "new" res)
	if(${res} EQUAL 0)

		string(SUBSTRING "${query}" 3 -1 query)
		json_deserialize(obj "${query}")

		function(map_select_visitor)
			list_isvalid(${current} islist)
			map_isvalid(${current} ismap)
			if(islist)
				ref_get(${current} values)
				set(transformed_values)
				foreach(value ${values})
					map_format(res "${value}")
					set(transformed_values "${transformed_values}" "${value}")
				endforeach()
				ref_set(${current} "${transformed_values}")
			elseif(ismap)
				map_keys(${current} keys)
				foreach(key ${keys})
					map_get(${current} value ${key})
					map_format(res "${value}")
					map_format(res "${value}")
					map_set(${current} ${key} "${res}")
				endforeach()
			endif()
		endfunction()
		map_graphsearch(${obj} VISIT map_select_visitor)

		set(${result} "${obj}" PARENT_SCOPE)
		return()
	endif()

	set(res)
	map_format(res "${query}")
	set(${result} ${res} PARENT_SCOPE)
endfunction()