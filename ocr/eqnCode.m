clc;
syms thesyms
figure;
if(numel(symbols) > 1)
    if(funs_det)
        c1 = figure;
        ezplot(eqn, [-50, 50]);
    else
        c1 = figure;
%         ezplot(eqn, [-50, 50]);
        var = input(['Solve for ' straddchars(symbols,' or ') '?\n']);
        resultEqn = solve(eqn, var)
        rem_syms = symbols(symbols ~= char(var));
        sorter = [rem_syms, var];
        [sorter, sort_id] = sort(sorter(1,:));
        enter_vals = 0;
        enter_vals = input(['Do you want to enter values for other variables (' ...
            straddchars(rem_syms, ', ') ')? (1/0)\n']);
        if(enter_vals)
            for num_syms = 1 : length(rem_syms)
                value(num_syms) = input(['Enter value for ' ...
                    rem_syms(num_syms) ': \n']);
            end
            result = double(subs(resultEqn, sym(rem_syms), value));
            evalres = sprintf([char(var) ' = ' num2str(result') ', \t @ ' ...
                rem_syms ' = ' num2str(value') '\n']);
            fprintf(evalres);
            to_sort = [repmat(value, size(result, 1), 1), result];
            to_sort = to_sort(:, sort_id);
            figure(c1);
            ezplot(eqn, [-50, 50]);
            hold on;
            plot(to_sort(:, 1), to_sort(:, 2), 'ro');
            hold off;
            legend('eqn', evalres);
        end
    end
else
    resultEqn = solve(eqn);
    c1 = figure;
    ezplot(eqn);
    fprintf([symbols ' = ' num2str(double(resultEqn)') '\n']);
end