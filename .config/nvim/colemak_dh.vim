" " === EasyMotion ===
"  
" " <leader> is <space>
" let mapleader = " "
" " " normal easymotion commands e.g., <leader>w ...{label}
" " nmap <Leader> <Plug>(easymotion-prefix)
" " " easymotion 2-char search: s{char}{char} ...{label}
" " nmap s <Plug>(easymotion-overwin-f2)
"  
"  
" " === Colemak Mod-DHM ===
"  
" "Colemak mnei(hjkl) t(i) <C-n>(f) <C-e>(e)
" noremap m h|        "move Left
" noremap n gj|       "move Down
" noremap e gk|       "move Up
" noremap i l|        "move Right
" noremap t i|        "(t)ype           replaces (i)nsert
" noremap T I|        "(T)ype at bol    replaces (I)nsert
" noremap E e|        "end of word      replaces (e)nd
" noremap h n|        "next match       replaces (n)ext
" noremap k N|        "previous match   replaces (N) prev
" noremap <C-m> m|    "mark             replaces (m)ark
"  
" noremap <C-n> <C-f>| "Page down
" noremap <C-e> <C-b>H| "Page up, cursor up
"  
" " " make easymotion match the new mnei(hjkl) motions
" " map <Leader>m <Plug>(easymotion-linebackward)
" " map <leader>n <Plug>(easymotion-j)
" " map <leader>e <Plug>(easymotion-k)
" " map <Leader>i <Plug>(easymotion-lineforward)
"  
" " below: not remapping, just fixing sequences:
" " fix (i)nner and (t)ill, e.g. (c)hange (i)n (w)ord
" nnoremap ci ci|
" nnoremap di di|
" nnoremap vi vi|
" nnoremap yi yi|
" nnoremap ct ct|
" nnoremap dt dt|
" nnoremap vt vt|
" nnoremap yt yt|
