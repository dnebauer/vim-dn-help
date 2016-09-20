" Function:    Vim custom help plugin
" Last Change: 2016-09-21
" Maintainer:  David Nebauer <david@nebauer.org>

" 1.  CONTROL STATEMENTS                                               {{{1

" only load once                                                       {{{2
if exists('b:loaded_dn_help_plugin') | finish | endif
let b:loaded_dn_help_plugin = 1

" ignore user cpoptions                                                {{{2
let s:save_cpo = &cpoptions
set cpoptions&vim  "                                                   }}}2

" 2.  DISPLAY HELP                                                     {{{1

" F1                                                                   {{{2
nmap <unique> <silent> <F1> :call dn_help#util#display()<CR>
imap <unique> <silent> <F1> <Esc>:call dn_help#util#display()<CR>

" \dh                                                                  {{{2
nmap <unique> <silent> <LocalLeader>dh :call dn_help#util#display()<CR>
imap <unique> <silent> <LocalLeader>dh <Esc>:call dn_help#util#display()<CR>

" 5.  CONTROL STATEMENTS                                               {{{1

" restore user's cpoptions                                             {{{2
let &cpoptions = s:save_cpo
unlet s:save_cpo                                                     " }}}2
                                                                     " }}}1
" vim:fdm=marker:
