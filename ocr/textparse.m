function [funs_det, symbols, str] = textparse(str)
str = str(not(isstrprop(str, 'wspace')));
str = char(strrep(str, 'O', '0'));
l = find(isletter(str(2 : end)) == 1) + 1;
for i = 1 : length(l)
    if (isstrprop(str(l(i) - 1), 'alphanum') || str(l(i) - 1) == ')')
        str(l(i) : end + 1) = ['*' str(l(i) : end)];
        l = l + 1;
    end
end
old = {'><'; '>('; ')'''; '='; ':'; '"'; 's*i*n'; 'c*o*s'; 't*a*n'; 'e*x*p'};
funs = {'sin'; 'cos'; 'tan'; 'exp'};
new = [{'x'; 'y'; 'y'; '=='; '=='; '^'}; funs];
for i = 1 : length(old)
    str = char(strrep(str, old(i), new(i)));
end
temp = regexprep(str, funs, '');
funs_det = (numel(temp) < numel(str));
symbols = char(unique(temp(isletter(temp))));