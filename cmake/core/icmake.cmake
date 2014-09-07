# spawns an interactive cmake session
# use @echo off and @echo on to turn printing of result off and on
# use quit or exit to terminate
# usage: cmake()
function(icmake)
  # outer loop loops untul quit or exit is input
  set(echo on)
  set(strict off)
  while(true)
    pwd()
    ans(pwd)
    echo_append("${pwd} icmake> ")
    set(cmd)
    # inner loop for reading multiline inputs (delimited by \)
    set(line "\\")
    set(first true)
    while("${line}" MATCHES ".*\\\\$")
      if(first)
        set(first false)
        set(line "")
      else()
        echo_append("        ")
      endif()

      read_line()
      ans(line)
      if("${line}" MATCHES ".*\\\\$")
        string_slice("${line}" 0 -2)
        ans(theline)
      else()
        set(theline "${line}")
      endif()
      set(cmd "${cmd}\n${theline}")

    endwhile()
    if("${line}" MATCHES "^(quit|exit)$")
      break()
    endif()

    if("${cmd}" MATCHES "@echo on")
      message("echo is now on")
      set(echo on)
      break()
    elseif("${cmd}" MATCHES "@echo off")
      message("echo is now off")
      set(echo off)
      break()
    elseif("${cmd}" MATCHES "@string off")
      message("strict is now off")
      set(strict off)
    elseif("${cmd}" MATCHES "@string on")
      message("strict is no on")
      set(strict on)
    else()
      # check if cmd is valid cmake
        #todo
      if(NOT strict)
        lazy_cmake("${cmd}")
        ans(cmd)
      endif()
      set_ans("${ANS}")
      eval_ref(cmd)
      ans(ANS)
      if(echo)
        json_print(${ANS})
      endif()
    endif()
  endwhile()
  return()
endfunction()