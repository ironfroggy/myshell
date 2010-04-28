map @r :call RulerStr()<NL>0P

function! RulerStr()
  let columns = &columns
  let inc = 0
  let str = ""
  while (inc < columns)
    let inc10 = inc / 10 + 1
    let buffer = "."
    if (inc10 > 9)
      let buffer = ""
    endif
    let str = str . "....+..." . buffer . inc10
    let inc = inc + 10
  endwhile
  let str = strpart(str, 0, columns)
  let @@ = str
endfunction
