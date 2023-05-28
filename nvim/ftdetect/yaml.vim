au BufRead,BufNewFile *.yaml call DetectGoHtmlTmpl()

function DetectGoHtmlTmpl()
    if search("{{") != 0
        set filetype=gohtmltmpl
    endif
endfunction
