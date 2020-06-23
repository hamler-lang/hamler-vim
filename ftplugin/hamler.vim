setlocal shiftwidth=2
setlocal tabstop=2
setlocal comments=s1fl:{-,mb:\ \ ,ex:-},:--\ \|,:--
setlocal commentstring=--%s
setlocal iskeyword+=?
setlocal include=^import
setlocal includeexpr=printf('%s.hm',substitute(v:fname,'\\.','/','g'))
