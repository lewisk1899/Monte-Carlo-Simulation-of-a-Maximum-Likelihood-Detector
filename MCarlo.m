clc
sigma_set = {40, 30, 25, 20, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1.9, 1.8, 1.75, 1.6, 1.5, 1.25, 1, .9, .8, .7, .6, .5, .4, .3, .25};
[p_vs_sigma_squared, log_scale] = form_data_set(sigma_set)
graph(p_vs_sigma_squared, 'Variance (Sigma Squared)', 'Probability of Error', 'Probability of Error vs Variance')
graph(log_scale, 'Signal to Noise Ratio in dBs', 'Log Probability of Error', 'Log Probability of Error vs Signal to Noise Ratio in dBs')

function [p_vs_sigma_squared, log_scale] = form_data_set(sig_set)
    i = 1;
    p_vs_sigma_squared = [];
    log_scale = [];
    while i <= length(sig_set)
        sig_value = sig_set{i};
        display(sig_value)
        [data_point_for_p_vs_sigma_squared, data_point_for_log_scale] = MonteCarlo(sig_value);
        p_vs_sigma_squared = [p_vs_sigma_squared, data_point_for_p_vs_sigma_squared];
        log_scale = [log_scale, data_point_for_log_scale];
        i = i + 1;
    end
    display(p_vs_sigma_squared)
    display(log_scale)
end

function [data_point_for_p_vs_sigma_squared, data_point_for_log_scale] = MonteCarlo(sig_var)
    K_min = 10^6; % minimum number of errors
    K_e = 0; % number of errors
    L = 10^6; % maximum length of sequence
    k = 0; % bit counter
    no_error = 0;
    
    while K_e < K_min && k < L
        k = k + 1;
        % this is the transmitter block
        x = randi([0,1]);
        if x == 0
            x = -1;
        end
        % this is the channel block
        n = normrnd(0, sig_var);
        y = x + n; % add noise to input
        % this is the detector block
        x_hat = detector(y);
        if abs(x_hat - x) == 0
            % no error
            no_error = no_error + 1;
        else
            % error
            K_e = K_e + 1;
            disp("Error")
            disp("Number of errors:")
            disp(K_e)
        end
    end
    disp("Number of times ran:")
    disp(k)
    data_point_for_p_vs_sigma_squared = [sig_var^2, K_e/k]; % data point in the form of 1/_sigma^2, prob of error for that sigma
    data_point_for_log_scale = [10*log10(1/sig_var^2),log(K_e/k)]
end

function x_hat = detector(y)
    % ML detector
    % all symbols are equally likely
    euclidian_dist_for_symbol_1 = (y - 1)^2; % for symbol x_i = 1
    euclidian_dist_for_symbol_2 = (y + 1)^2; % for symbol x_i = -1
    if euclidian_dist_for_symbol_1 < euclidian_dist_for_symbol_2
        x_hat = 1;
    else 
        x_hat = -1;
    end
end

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
