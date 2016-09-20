" Title:   Vim library for vim-dn-help plugin
" Author:  DavidNebauer <davidnebauer[AT]hotkey[DOT]net[DOT]au>
" URL:     https://github.com/dnebauer/vim-dn-help

" CONTROL STATEMENTS:

" load only once                                                       {{{1
if exists('g:loaded_dn_help_util_autoload') | finish | endif
let g:loaded_dn_help_util_autoload = 1

" disable user's cpoptions                                             {{{1
let s:save_cpo = &cpoptions
set cpoptions&vim  "                                                   }}}1

" FUNCTIONS:

" dn_help#util#display()                                               {{{1
" does:   display custom help file
" params: nil
" return: nil
function! dn_help#util#display() abort

    " check that main help file exists                                 {{{2
    if !exists('s:help_main')
        let l:fp = expand('%:p:h') . '/dn-help-main.vim'
        if filereadable(l:fp)
            let s:help_main = l:fp
        else
            echoerr 'Cannot locate help file:'
            echoerr '  ' . l:fp
            return
        endif
    endif

    " display main help file in new buffer                             {{{2
    try
        update
        execute 'edit' s:help_main
    catch /^Vim\%((\a\+)\)\=:E32/
        " E32: No file name
        " tried to update buffer that has no file name
        echo "DnHelp: can't update unnamed buffer - save to file"
        return
    catch /^Vim\%((\a\+)\)\=:E37/
        " E37: No write since last change (add ! to override)
        " tried to create new buffer when current one has unsaved changes
        echo "DnHelp: can't open help while buffer has unsaved changes"
        return
    catch /^Vim\%((\a\+)\)\=:E/
        " all other errors
        echo "DnHelp: can't display help due to unexpected error"
        return
    endtry
    let s: = winbufnr(0)

    " set buffer-specific settings                                     {{{2
    "   - nomodifiable:     don't allow editing of this buffer
    "   - noswapfile:       we don't need a swapfile
    "   - buftype=nowrite:  buffer will not be written
    "   - bufhidden=delete: delete this buffer if it will be hidden
    "   - iabclear:         no abbreviations in insert mode
    setlocal nomodifiable
    setlocal noswapfile
    setlocal buftype=nowrite
    setlocal bufhidden=delete
    iabclear <buffer>

    " map 'q' to delete help buffer                                    {{{2
    nnoremap <buffer> <silent> q :bdelete!<CR>
                                                                     " }}}2

endfunction                                                          " }}}1

" CONTROL STATEMENTS:

" restore user's cpoptions                                             {{{1
let &cpoptions = s:save_cpo                                          " }}}1

" vim:fdm=marker:
