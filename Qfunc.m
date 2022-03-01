clc
clearvars
sig_set = {40, 30, 25, 20, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1.9, 1.8, 1.75, 1.6, 1.5, 1.25, 1, .9, .8, .7, .6, .5, .4, .3, .25};
data = collect_data(sig_set);
graph(data, 'SNR in dBs', 'Log Probality of Error', 'Q-Function Results')
function graph(datapoints, x_label, y_label, graph_title)
    display(datapoints)
    x = [];
    y = [];
    i = 1;
    while i <= length(datapoints) - 1
        new_x = (datapoints)
        x = [x, datapoints(i)];
        y = [y, datapoints(i+1)]
        i = i + 2;
    end
    plot(x,y,'LineWidth',2.0)
    xlabel(x_label)
    ylabel(y_label)
    set(gcf,'color','w');
    set(gca,'Color','w');
    title(graph_title)
end

function data = collect_data(sig_set)
    i = 1;
    data = []
    while i <= length(sig_set) - 1
        x = sig_set{i};
        display(x)
        data = [data, [10*log10(1/sig_set{i}^2), log10(qfunc(sqrt(1/(.5*sig_set{i}))))]];
        i = i + 1;
    end
end
