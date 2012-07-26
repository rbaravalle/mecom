function createFit2(x,y)
%CREATEFIT Create plot of data sets and fits
%   CREATEFIT(X,Y)
%   Creates a plot, similar to the plot in the main Curve Fitting Tool,
%   using the data that you provide as input.  You can
%   use this function with the same data you used with CFTOOL
%   or with different data.  You may want to edit the function to
%   customize the code and this help message.
%
%   Number of data sets:  1
%   Number of fits:  2

% Data from data set "y vs. x":
%     X = x:
%     Y = y:
%     Unweighted

% Auto-generated by MATLAB on 12-Mar-2012 18:17:12

x1 = 0.0:0.01:3.2
x2 = 3.2:0.01:5.9
for i = 1:size(x1,2) y1(i) = -0.3576*x1(i)+5.994; end
for i = 1:size(x2,2) y2(i) = -1.127*x2(i)+8.519; end

% Set up figure to receive data sets and fits
f_ = clf;
figure(f_);
set(f_,'Units','Pixels','Position',[1 25 1440 711]);
% Line handles and text for the legend.
legh_ = [];
legt_ = {};
% Limits of the x-axis.
xlim_ = [Inf -Inf];
% Axes for the plot.
ax_ = axes;
set(ax_,'Units','normalized','OuterPosition',[0 0 1 1]);
set(ax_,'Box','on');
axes(ax_);
hold on;

% --- Plot data that was originally in data set "y vs. x"
x = x(:);
y = y(:);
h_ = line(x,y,'Parent',ax_,'Color',[0.333333 0 0.666667],...
    'LineStyle','none', 'LineWidth',1,...
    'Marker','.', 'MarkerSize',22);
xlim_(1) = min(xlim_(1),min(x));
xlim_(2) = max(xlim_(2),max(x));
%legh_(end+1) = h_;
%legt_{end+1} = 'log N(a) vs log a';

% Nudge axis limits beyond data limits
if all(isfinite(xlim_))
    xlim_ = xlim_ + [-1 1] * 0.01 * diff(xlim_);
    set(ax_,'XLim',xlim_)
else
    set(ax_, 'XLim',[-0.061463292576688977054, 6.2077925502455864049]);
end

% --- Create fit "Mayor"

% Apply exclusion rule "b"
if length(x)~=93
    error( 'GenerateMFile:IncompatibleExclusionRule',...
        'Exclusion rule ''%s'' is incompatible with ''%s''.',...
        'b', 'x' );
end
ex_ = false(length(x),1);
ex_([(1:22) (90:93)]) = 1;
ok_ = isfinite(x) & isfinite(y);
if ~all( ok_ )
    warning( 'GenerateMFile:IgnoringNansAndInfs',...
        'Ignoring NaNs and Infs in data.' );
end
ft_ = fittype('poly1');

% Fit this model using new data
if sum(~ex_(ok_))<2
    % Too many points excluded.
    error( 'GenerateMFile:NotEnoughDataAfterExclusionRule',...
        'Not enough data left to fit ''%s'' after applying exclusion rule ''%s''.',...
        'Mayor', 'b' );
else
    cf_ = fit(x(ok_),y(ok_),ft_,'Exclude',ex_(ok_));
end
% Alternatively uncomment the following lines to use coefficients from the
% original fit. You can use this choice to plot the original fit against new
% data.
%    cv_ = { -1.1266520814894391833, 8.5194995660081946909};
%    cf_ = cfit(ft_,cv_{:});

% Plot this fit
%h_ = plot(cf_,'fit',0.95);
%set(h_(1),'Color',[1 0 0],...
%    'LineStyle','-', 'LineWidth',2,...
%    'Marker','none', 'MarkerSize',6);
% Turn off legend created by plot method.
legend off;
% Store line handle and fit name for legend.
%legh_(end+1) = h_(1);
%legt_{end+1} = 'DF Mayor';

% --- Create fit "Menor"

% Apply exclusion rule "l"
if length(x)~=93
    error( 'GenerateMFile:IncompatibleExclusionRule',...
        'Exclusion rule ''%s'' is incompatible with ''%s''.',...
        'l', 'x' );
end
ex_ = true(length(x),1);
ex_([(1:22)]) = 0;
ok_ = isfinite(x) & isfinite(y);
if ~all( ok_ )
    warning( 'GenerateMFile:IgnoringNansAndInfs',...
        'Ignoring NaNs and Infs in data.' );
end
ft_ = fittype('poly1');

% Fit this model using new data
if sum(~ex_(ok_))<2
    % Too many points excluded.
    error( 'GenerateMFile:NotEnoughDataAfterExclusionRule',...
        'Not enough data left to fit ''%s'' after applying exclusion rule ''%s''.',...
        'Menor', 'l' );
else
    cf_ = fit(x(ok_),y(ok_),ft_,'Exclude',ex_(ok_));
end
% Alternatively uncomment the following lines to use coefficients from the
% original fit. You can use this choice to plot the original fit against new
% data.
%    cv_ = { -0.35755295334723025125, 5.9936665025545252661};
%    cf_ = cfit(ft_,cv_{:});

% Plot this fit
%h_ = plot(cf_,'fit',0.95);
%set(h_(1),'Color',[0.4 0.5 0],...
   % 'LineStyle','-', 'LineWidth',2,...
   % 'Marker','none', 'MarkerSize',6);
% Turn off legend created by plot method.
legend off;
% Store line handle and fit name for legend.
%legh_(end+1) = h_(1);
%legt_{end+1} = 'DF Menor';

% --- Finished fitting and plotting data. Clean up.



fitt = plot(x1,y1)
set(fitt,'Color',[1 0.0 0],...
    'LineStyle','-', 'LineWidth',2,...
    'Marker','none', 'MarkerSize',6);
legh_(end+1) = fitt;
legt_{end+1} = 'DF Menor';

fitt = plot(x2,y2)
set(fitt,'Color',[0 0 0],...
    'LineStyle','-', 'LineWidth',2,...
    'Marker','none', 'MarkerSize',6);
legh_(end+1) = fitt;
legt_{end+1} = 'DF Mayor';

hold off;
% Display legend
leginfo_ = {'Orientation', 'vertical', 'Location', 'NorthEast'};
h_ = legend(ax_,legh_,legt_,leginfo_{:});
set(h_,'Interpreter','none');
% Remove labels from x- and y-axes.
xlabel(ax_,'log a','fontsize',24,'fontweight','b');
ylabel(ax_,'log N(a)','fontsize',24,'fontweight','b');
