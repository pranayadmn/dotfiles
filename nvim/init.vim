" Expand <Tab> into fitting number of spaces.
set expandtab

" Turn off line wrap.
set nowrap

" Print the line number in front of each line.
set number

" Ignore case in search patterns.
set ignorecase

" Number of spaces to use for each step of (auto)indent.
set shiftwidth=4

" Override the 'ignorecase' option if the search pattern contains upper case characters.
set smartcase

" Do smart autoindenting when starting a new line.
set smartindent

" Number of spaces that a <Tab> in the file counts for.
set tabstop=4

" Enables 24-bit RGB color in the TUI.
set termguicolors

" Make <Home> and <End> keys smartly move to the beginning and end of lines.
nmap <silent><Home> :call smarthome#SmartHome('n')<cr>
nmap <silent><End> :call smarthome#SmartEnd('n')<cr>
imap <silent><Home> <C-r>=smarthome#SmartHome('i')<cr>
imap <silent><End> <C-r>=smarthome#SmartEnd('i')<cr>
vmap <silent><Home> <Esc>:call smarthome#SmartHome('v')<cr>
vmap <silent><End> <Esc>:call smarthome#SmartEnd('v')<cr>
