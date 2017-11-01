function nstr = straddchars(str, c)
nstr = [repmat([' ' c], 1, numel(str) - 1), ' '];
nstr(1 : 1 + numel(c) : end) = str;