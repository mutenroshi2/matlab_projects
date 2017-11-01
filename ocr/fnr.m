function fnr(symbols, eqn)
ftr = fopen('eqnCode.m', 'r');
ftw = fopen('currEqn.m', 'a');
thesyms = straddchars(symbols, ' ');
while ~feof(ftr)
    s = fgetl(ftr);
    s = strrep(s, 'thesyms', thesyms);
    s = strrep(s, 'eqn', eqn);
    fprintf(ftw, '%s\n', s);
end
fclose(ftr);
fclose(ftw);