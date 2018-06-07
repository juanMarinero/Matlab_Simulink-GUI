function SimPowerSystem_gettingstarted_31_gui()
% Purpose:
% Each time that you change a parameter of thepowerliblibrary blocks, you
% have to restart the simulation to evaluate the state-space model and update
% the parameters of the nonlinear models. However, you can change any source
% parameter (Magnitude, Frequency, or Phase) during the simulation.
% In this case we try to do a not allowed thing: update the capacitance of a condensator
% stopping and restarting the simulation. No error.
% Value can be modified by slider and/or input text.
% Slider limits are changeable
% Plot limits are changeable
% since version 30: position chekbox and slider are units and no pixel defined (to make
% gui bigger or smaller carrys no visual problem)
% since version 30: position plot properties in the gui self
% since version 31: scopes plotable are those who 


% load simulink default file, block to change value, scope,...
handles = to_change_programmatly();

% position GUI objects
handles = Objects_position(handles);
% build initials GUI objects
handles = Objects_build(handles);


handles = pushbutton_simbrowse_auxiliar(handles);


% Make the UI visible.
set(handles.f,'Visible','on'); % f.Visible = 'off'; in Matlab R2014b and later

% handles
end

function handles = to_change_programmatly()
handles = load_simulalink_default();
handles = sliderXY_defaultvalues(handles);
end
% ************ to_change_programmatly ************
function handles = load_simulalink_default()
% default simulink file
% FileName = 'flujoactivo_simulink_copys';'Park_copys'; % relative path from pwd
% filePattern = fullfile(pwd, FileName); % absolut path (C:\Users\...)
% addpath(filePattern)

handles.modelname = 'simulinkModel_08';

handles.wokspace_variables_file = 'simulinkModel_08_default_values';
simulink_constances(handles);

handles.workspace_calculus_file = 'simulinkModel_08_calculus.m';

% % default output signal to plot
% handles.signal2plot_output_number = 7; % should be 1

% default scope signal to plot
handles.signal2plot_scope_input = 1; % should be 1

% % default signal2plot_workspace_edit_timename
% handles.signal2plot_workspace_timename = 'tout';
% % default signal2plot_workspace_edit_signalname
% handles.signal2plot_workspace_signalname = 'yout(:,8).*sin(2*pi*yout(:,7).*tout)';



% default scope
handles.scope_name = 'Scope';

% default scope time
handles.edit_scope_TimeSpan_value = .6; % changeable

% axes_x_limit and text_axes_x_limit defaults
handles.axes_x_limit_min_value = 0;
handles.axes_x_limit_max_value = handles.edit_scope_TimeSpan_value;

% simulink StopTime
handles.modelname_StopTime = num2str(handles.edit_scope_TimeSpan_value);

% default workspace or block to change value of properties; and its property
% 01
% default scope block to change value of properties; and its property
% handles.slider01_workspace_name =  'freq(1)';
% handles.sliderXY_totalnumber = 1;

% handles.slider01_workspace_name =  'kP_Ired_ref';
% handles.slider02_workspace_name =  'kI_Ired_ref';
% handles.sliderXY_totalnumber = 2;


handles.sliderXY_number = 1; % unchangeble % it load only before 1st build of slide function
handles.sliderXY_totalnumber = 1;

handles.lines_properties = regexprep(...
    sprintf('''LineStyle '','' - '','' linewidth '', .5 ,'' Marker '','' none '','' MarkerSize '', 6 '),...
    ' ', ''); % replace empty character
end
% ************ simulink constances ************
function simulink_constances(handles)
if exist(handles.wokspace_variables_file,'file')
    % run MATLAB script
    run(handles.wokspace_variables_file);
    
    % assign variables to 'base' workspace
    variables_list = who; % variables of current workspace (in this case the function workspace)
    N_notfromwokspace_variables_file = length(variables_list);
    if N_notfromwokspace_variables_file > 0
        for k_notfromwokspace_variables_file = 1 : N_notfromwokspace_variables_file
            var = char(variables_list(k_notfromwokspace_variables_file));
            % to workspace
            assignin ('base' , var , eval(var));
        end
    end
end
end
% ************ sliderXY_defaultvalues ************
function handles = sliderXY_defaultvalues(handles)
handles.sliderXY_min_value_default = 1e-3;
handles.sliderXY_max_value_default = 50;
handles.sliderXY_value_default = 25;
end

% ************ position of GUI Objects ************
function handles = Objects_position(handles)

handles.gui_position = [0,0,900,600];

handles.axes_position = [...
    handles.gui_position(1) + 70 ,...
    handles.gui_position(2) + 90 ,...
    400 ,...
    0];
handles.axes_position(4) =  handles.gui_position(4) - handles.axes_position(1) - 40;
handles.axes_x_limit_position = [...
    10 ,...
    0 ,...
    30  ,...
    20];
handles.axes_x_limit_text_position = [...
    handles.axes_x_limit_position(1) + handles.axes_x_limit_position(3) + 5,...
    handles.axes_x_limit_position(2) ,...
    handles.axes_x_limit_position(3) + 20,...
    handles.axes_x_limit_position(4)];

handles.pushbutton_simbrowse_position = [...
    handles.axes_position(1) + handles.axes_position(3) + 10 ,...
    0,...
    50 ,...
    30];
handles.pushbutton_simbrowse_position(2) = handles.axes_position(2) + handles.axes_position(4) - handles.pushbutton_simbrowse_position(4);

handles.pushbutton_workspacebrowse_position = handles.pushbutton_simbrowse_position;
handles.pushbutton_workspacebrowse_position(1) = 0 + handles.pushbutton_simbrowse_position(1) + handles.pushbutton_simbrowse_position(3);

handles.pushbutton_calculusbrowse_position = handles.pushbutton_workspacebrowse_position;
handles.pushbutton_calculusbrowse_position(1) = 0 + handles.pushbutton_workspacebrowse_position(1) + handles.pushbutton_workspacebrowse_position(3);

handles.pushbutton_start_position = handles.pushbutton_simbrowse_position;
handles.pushbutton_start_position(2) = handles.pushbutton_simbrowse_position(2) - handles.pushbutton_simbrowse_position(4);

handles.pushbutton_stop_position = handles.pushbutton_start_position;
handles.pushbutton_stop_position(1) = 0 + handles.pushbutton_start_position(1) + handles.pushbutton_start_position(3);

handles.pushbutton_add_sliderXY_position = handles.pushbutton_stop_position;
handles.pushbutton_add_sliderXY_position(1) = 0 + handles.pushbutton_stop_position(1) + handles.pushbutton_stop_position(3);


handles = signal2plot_position(handles);

end
% ************ build GUI Objects ************
function handles = Objects_build(handles)
%  Create and then hide the UI as it is being constructed.
handles.f = figure('Visible','off','Position',handles.gui_position);

% Assign the a name to appear in the window title. % f.Name = 'Simple GUI'; in Matlab R2014b and later
set(handles.f,...
    'Units','normalized'); % Change units to normalized so components resize automatically.

% Move the window to the west/center/... of the screen.
movegui(handles.f,'west')


% ************ pushbutton_simbrowse ************
handles.pushbutton_simbrowse = uicontrol('Style','pushbutton',...
    'String','Simulink',...
    'Position',handles.pushbutton_simbrowse_position);
% ************ pushbutton_workspacebrowse ************
handles.pushbutton_workspacebrowse = uicontrol('Style','pushbutton',...
    'String','Variables',...
    'Position',handles.pushbutton_workspacebrowse_position);
% ************ pushbutton_calculusbrowse ************
handles.pushbutton_calculusbrowse = uicontrol('Style','pushbutton',...
    'String','Calculus',...
    'Position',handles.pushbutton_calculusbrowse_position);
% ************ pushbutton_start ************
handles.pushbutton_start = uicontrol('Style','pushbutton',...
    'String','Start',...
    'Position',handles.pushbutton_start_position);
% ************ pushbutton_stop ************
handles.pushbutton_stop = uicontrol('Style','pushbutton',...
    'String','Stop',...
    'Position',handles.pushbutton_stop_position);
% Turn off the Stop button
set(handles.pushbutton_stop,'Enable','off');
% ************ pushbutton_add_sliderXY ************
handles.pushbutton_add_sliderXY = uicontrol('Style','pushbutton',...
    'String','+',...
    'Position',handles.pushbutton_add_sliderXY_position);


% ************ axes ************
handles.axes = axes('Units','pixels','Position',handles.axes_position);
set(handles.axes,'Units','normalized'); % Change units to normalized so components resize automatically.

% ************ axes_x_limit and text_axes_x_limit************
% axes_x_limit_min_edit axes_x_limit_max_edit
uicontrol_vec = {'axes_x_limit_min' , 'axes_x_limit_max'};
strings = {'x lim min',...
    'x lim max'};
for k = 1 : length(uicontrol_vec)
    value = char(uicontrol_vec(k));
    value =  eval(['handles.',value,'_value']);
    aux = sprintf('uicontrol(''Style'',''edit'' , ''String'',value , ''Position'',handles.axes_x_limit_position + (k-1)*[80 0 0 0]);');
    eval(['handles.',char(uicontrol_vec(k)),'_edit', '=', aux]);
    
    uicontrol_vec(k) =  {[char(uicontrol_vec(k)),'_text']}; % axes_x_limit_min_text
    aux = sprintf('uicontrol(''Style'',''text'' , ''String'',eval([''strings(k)'']) , ''HorizontalAlignment'',''left'' , ''Position'',handles.axes_x_limit_text_position + (k-1)*[80 0 0 0]);');
    eval(['handles.',char(uicontrol_vec(k)), '=', aux]);
end

% ************ edit_lines_properties and text_lines_properties************
pos = get(handles.axes_x_limit_min_edit,'position');
handles.edit_lines_properties = uicontrol('Style','edit',...
    'String',char(handles.lines_properties),...
    'Position',pos + 2*[0 20 0 0]);
pos = get(handles.axes_x_limit_min_text,'position');
handles.text_lines_properties = uicontrol('Style','text',...
    'String','lines prop.',... % Line Properties
    'HorizontalAlignment','left',...
    'Position',pos + 2*[0 20 0 0]);

% ************ edit_scope_TimeSpan and text_edit_scope_TimeSpan************
pos = get(handles.axes_x_limit_max_edit,'position');
handles.edit_scope_TimeSpan = uicontrol('Style','edit',...
    'String',num2str(handles.edit_scope_TimeSpan_value),...
    'Position',pos + [0 20 0 0]);
pos = get(handles.axes_x_limit_max_text,'position');
handles.text_edit_scope_TimeSpan = uicontrol('Style','text',...
    'String','Scope TimeSpan',...
    'HorizontalAlignment','left',...
    'Position',pos + [0 20 60 0]);

% ************ edit_modelname_StopTime and text_edit_modelname_StopTime************
pos = get(handles.axes_x_limit_max_edit,'position');
handles.edit_modelname_StopTime = uicontrol('Style','edit',...
    'String',num2str(handles.modelname_StopTime),...
    'Position',pos + 2*[0 20 0 0]);
pos = get(handles.axes_x_limit_max_text,'position');
handles.text_edit_modelname_StopTime = uicontrol('Style','text',...
    'String','StopTime simulation',...
    'HorizontalAlignment','left',...
    'Position',pos + [0 2*20 60 0]);

end


% ************ find_uicontrols ************
function handles = find_uicontrols(handles)
fieldnames_handles = fieldnames(handles);
% handles
% class(handles.sliderXY_uipanel)
uicontrol_names = {};
uipanel_names = {};
cont_uicontrol = 1;
cont_uipanel = 1;
for k = 1 : length(fieldnames_handles)
    aux = class(eval(['handles.',char(fieldnames_handles(k))]));
    if strcmp( aux, 'matlab.ui.control.UIControl')
        uicontrol_names(cont_uicontrol) = fieldnames_handles(k);
        cont_uicontrol = cont_uicontrol + 1;
    elseif strcmp( aux, 'matlab.ui.container.Panel')
        uipanel_names(cont_uipanel) = fieldnames_handles(k);
        cont_uipanel = cont_uipanel + 1;
    end
end
% strings'
handles.uicontrol_names = uicontrol_names;
handles.uipanel_names = uipanel_names;
end
% ************ normalize_GUI ************
function handles = normalize_GUI(handles)
strings = [{'f'} , handles.uicontrol_names , handles.uipanel_names];
for k = 1 : length(strings)
    % Change units to normalized so components resize automatically.
    set(eval(['handles.',char(strings(k))]),'Units','normalized'); % set(handles.f,'Units','normalized'); % f.Units = 'normalized'; in Matlab R2014b and later
end
end
% ************ set and update_thecallbacks ************
function handles = update_thecallbacks(handles)
strings = handles.uicontrol_names;
uicontrol_sliderXY_names = {};
uicontrol_sliderXY_position_names = {};
cont = 1;
prefix = 'slider';
N = length(prefix);
prefix_full = 'sliderXY';
M = length(prefix_full);
for k = 1 : length(strings)
    aux = char(strings(k));
    
    %     callback_name = get(eval(['handles.',char(strings(k))]),'Callback');
    %     if ~isempty(callback_name)
    %         set(eval(['handles.',aux]),...
    %             'Callback',callback_name);
    % %         if strcmp('plot_select_checkbox01',aux)
    % %             www=callback_name{1}
    % %         end
    %     end
    
    
    if length(aux)>=N && strcmp(aux(1:N),prefix) % && strcmp(aux(N+1:M), num2str(handles.sliderXY_number, '%02i') )
        uicontrol_sliderXY_callback_name = {sprintf('%s%s', prefix_full, aux(M+1:end))};
        uicontrol_sliderXY_names(cont) = {sprintf('%s%s', prefix, aux(N+1:end))};
        uicontrol_sliderXY_position_names(cont) = {sprintf('%s%s_position', prefix_full , aux(M+1:end))};
        
        aux = sprintf('{@%s_Callback, handles}', char(uicontrol_sliderXY_callback_name));
        set(eval(['handles.',char(strings(k))]),'Callback',eval(aux));
        % set(handles.sliderXY,'Callback',{@sliderXY_Callback, handles});
        
        cont = cont + 1;
    elseif length(aux)>=length('plot_select_checkbox') && strcmp(aux(1:length('plot_select_checkbox')),'plot_select_checkbox')
        aux = sprintf('{@plot_select_checkboxXY_Callback, handles}');
        set(eval(['handles.',char(strings(k))]),'Callback',eval(aux));
        % set(handles.sliderXY,'Callback',{@sliderXY_Callback, handles});
    else
        aux = [sprintf('{@') , aux , sprintf('_Callback, handles}')];
        set(eval(['handles.',char(strings(k))]),'Callback',eval(aux));
        % set(handles.sliderXY,'Callback',{@sliderXY_Callback, handles});
    end
end

handles.uicontrol_sliderXY_names = uicontrol_sliderXY_names;
handles.uicontrol_sliderXY_position_names = uicontrol_sliderXY_position_names;
end


% ************ pushbutton_simbrowse ************
function  handles = pushbutton_simbrowse_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_simbrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[input_file,pathname] = uigetfile( ...
    {'*mdl','mdl Files (*.mdl)';...
    '*.*', 'All Files (*.*)'}, ...
    'Select files', ...
    'MultiSelect', 'on');
if pathname == 0
    return
end

addpath(pathname)
cd(pwd)
handles.modelname = input_file(1:(end-4)); % without '.mdl'


handles = pushbutton_simbrowse_auxiliar(handles);
end
function  handles = pushbutton_simbrowse_auxiliar(handles)
if isfield(handles,'modelname')
    if exist(handles.modelname,'file')
        
        % load simulink and change some propertys like in Scope DataLoggingVariableName = 'ScopeData';
        handles = load_simulink(handles);
        
        % if no valid .mdl file was selected or noone ever before selected
        if ~isfield(handles,'signal2plot_output_popmenu')
            % signal2plot uicontols
            handles = signal2plot_build(handles);
            
            % slider uicontrols
            for k = 1 : handles.sliderXY_totalnumber
                handles.sliderXY_number = k;
                
                % position sliderXY objects
                handles = sliderXY_all_position(handles);
                
                % build sliderXY object
                handles = sliderXY_all_build(handles);
                
                % reajust sliders of defaults variables inserted
                try
                    hObject = eval(['handles.slider', num2str(handles.sliderXY_number, '%02i'), '_workspace_name_edit']);
                    handles = sliderXY_workspace_name_edit_Callback(hObject, [], handles);
                catch
                end
                % values default needed for variable changeable in sliderXY
                % handles = sliderXY_defaultvalues(handles); which is in to_change_programmatly(handles);
            end
            
        end
        
        % update scope list, blocks list,...
        handles = signal2plot_update(handles);
        
        set(handles.pushbutton_workspacebrowse,'Enable','on');
        set(handles.pushbutton_calculusbrowse,'Enable','on');
        set(handles.pushbutton_start,'Enable','on');
    else
        set(handles.pushbutton_workspacebrowse,'Enable','off');
        set(handles.pushbutton_calculusbrowse,'Enable','off');
        set(handles.pushbutton_start,'Enable','off');
    end
end
% find uicontrols in handles
handles = find_uicontrols(handles);
% normalize Units in uicontrols and uipanels
handles = normalize_GUI(handles);

% send handle updated to callbacks
handles = update_thecallbacks(handles);
end
% ************ pushbutton_workspacebrowse ************
function  handles = pushbutton_workspacebrowse_Callback(hObject, eventdata, handles)
[input_file,pathname] = uigetfile( ...
    {'*m','mdl Files (*.m)';...
    '*.*', 'All Files (*.*)'}, ...
    'Select files', ...
    'MultiSelect', 'on');
if pathname == 0
    return
end

addpath(pathname)
cd(pwd)
handles.wokspace_variables_file = input_file;

simulink_constances(handles);
end
% ************ pushbutton_calculusbrowse ************
function  handles = pushbutton_calculusbrowse_Callback(hObject, eventdata, handles)
[input_file,pathname] = uigetfile( ...
    {'*m','mdl Files (*.m)';...
    '*.*', 'All Files (*.*)'}, ...
    'Select files', ...
    'MultiSelect', 'on');
if pathname == 0
    return
end

addpath(pathname)
cd(pwd)
handles.workspace_calculus_file = input_file;

handles = update_thecallbacks(handles);
end
% ************ pushbutton_start ************
function handles = pushbutton_start_Callback(hObject, eventdata, handles)
handles = simulation(handles);
end
% ************ pushbutton_stop ************
function handles = pushbutton_stop_Callback(hObject, eventdata, handles)
% Turn on the Start button
set(handles.pushbutton_start,'Enable','on');
% Turn off the Stop button
set(handles.pushbutton_stop,'Enable','off');

% stop simulation
set_param(handles.modelname,'SimulationCommand','stop');

% get outputs of simulation
handles = output_simulink(handles);

% uicontrol select plot
N = handles.plot_totalnumber;
if N == 1
    handles = select_plot_build(handles);
end
handles = select_plot_update(handles);

% plot in gui axes
handles = print_plot(handles);

handles = find_uicontrols(handles);% we added a checkbox uicontrol new
handles = update_thecallbacks(handles);
end
% ************ pushbutton_add_sliderXY ************
function handles = pushbutton_add_sliderXY_Callback(hObject, eventdata, handles)
handles.sliderXY_number = str2num(get(hObject,'Tag'));

handles.sliderXY_totalnumber = handles.sliderXY_totalnumber + 1;
handles.sliderXY_number = handles.sliderXY_totalnumber;

% position sliderXY objects
handles = sliderXY_all_position(handles);
% build sliderXY object
handles = sliderXY_all_build(handles);

% default values
k = handles.sliderXY_number;
name = sprintf('var_%s',num2str(k, '%02i'));
value = '0';
eval(['handles.slider', num2str(k, '%02i'), '_workspace_name = name;']);
eval(['handles.slider', num2str(k, '%02i'), '_value = value;']);

assignin ('base',...
    eval(sprintf('handles.slider%s_workspace_name',num2str(k, '%02i'))),...
    eval(['str2num(handles.slider',num2str(k, '%02i'),'_value)']));

handles = update_thecallbacks(handles);
end


% ************ load_simulalink ************
function handles = load_simulink(handles)
% load simulink and change some propertys like in Scope DataLoggingVariableName = 'ScopeData';
% get name of block to change value

%  load simulink file
load_system(handles.modelname);

% time limit
set_param(handles.modelname, 'StopTime', handles.modelname_StopTime)


% ************ input ************
aux = find_system(handles.modelname, ...
    'SearchDepth',1,...
    'BlockType','Inport');
N = length(handles.modelname) + 2;
string_input_popmenu = {};
for k = 1 : length(aux)
    aux2 = char(aux(k));
    string_input_popmenu(k) = {aux2(N:end)};
end
handles.modelname_inputnames = string_input_popmenu;

% set inputs from variables in workspace
% 'sim' command cannot be stopped before it ends, but we need set_param(handles.modelname,'SimulationCommand','stop');
% to be affected as soon as stop pushbottom is pressed, so sim(...,inputs,...) is not an option
% https://es.mathworks.com/videos/configuration-parameters-list-view-107095.html
if ~isempty(string_input_popmenu)
    set_param(handles.modelname,'LoadExternalInput','on'); % default names are 't' for time and matrix 'u' which is column is an input array
else
    set_param(handles.modelname,'LoadExternalInput','off'); % default names are 't' for time and matrix 'u' which is column is an input array
end

% ************ output ************
aux = find_system(handles.modelname, ...
    'SearchDepth',1,...
    'BlockType','Outport');
N = length(handles.modelname) + 2;
string_output_popmenu = {};
for k = 1 : length(aux)
    aux2 = char(aux(k));
    string_output_popmenu(k) = {aux2(N:end)};
end
handles.modelname_outputnames = string_output_popmenu;

% points outputed
set_param(handles.modelname,'LimitDataPoints','off');

% outputs blocks
set_param(handles.modelname,'SaveTime','on');
set_param(handles.modelname,'SaveOutput','on');


% ************ scope ************
aux = find_system(handles.modelname, ...
    'FollowLinks','On', ...
    'LookUnderMasks','All', ...
    'Regexp', 'On', ...
    'BlockType','Scope');
N = length(handles.modelname) + 2;
string = {};
for k = 1 : length(aux)
    aux2 = char(aux(k));
    string(k) = {aux2(N:end)};
end
handles.modelname_scopenames = string;
handles = load_simulink_scope(handles);

save_system(handles.modelname);
end
function handles = load_simulink_scope(handles)

string = {};
scopenames = handles.modelname_scopenames;
L = length(scopenames);
if L > 0 % if there is at least 1 scope in simulink
       
    % Scope properties
    for k = 1 : L
        % Scope get properties
        handles.scope_structure  = get_param(sprintf('%s/%s',handles.modelname,char(scopenames(k))),'ScopeConfiguration');
        
        
        % if k == value
        %     handles.scope_structure.Visible = true; % open scope as doble click on it
        % end
        
        % Scope: visual
         handles.scope_structure.AxesScaling = 'Auto';
        handles.scope_structure.MaximizeAxes = 'Off';
        handles.scope_structure.ShowLegend = true;
        handles.scope_structure.TimeSpan = num2str(handles.edit_scope_TimeSpan_value);
        aux = str2num(handles.scope_structure.NumInputPorts);
        if aux <= 4
        handles.scope_structure.LayoutDimensions = [aux , 1]; 
        end

        
        % Scope: data saved from scope
        handles.scope_structure.DataLoggingLimitDataPoints = false;
        % handles.scope_structure.DataLogging = true; % true in version 30 and before
        handles.scope_structure.DataLoggingSaveFormat = 'StructureWithTime';
        try
            aux = strrep(char(scopenames(k)), '/', '__'); % 'strrep' find and replace substring
            handles.scope_structure.DataLoggingVariableName = sprintf('ScopeData_%s',aux);
        catch % length(aux) is too large
            handles.scope_structure.DataLoggingVariableName = sprintf('ScopeData_%s',num2str(k,'%02i'));
        end
        
        if handles.scope_structure.DataLogging == 1 % true
            if ~exist('cont'), cont = 0; end
            cont = cont + 1;
            string(cont) = scopenames(k);
        end
    end
    handles.modelname_scopenames = string; %overwrite
    
    clear scopenames;
    scopenames = string;
    if ~isempty(scopenames)
    if isfield(handles,'scope_name')
        aux = handles.scope_name;
        value = find(strcmp(aux , scopenames));
        if isempty(value)            
            handles.scope_name = char(scopenames(1));
            value = 1;
        end
    else
        handles.scope_name = char(scopenames(1));
        value = 1;
    end
    end
    
end
% if no scopes o no scopes con Datalogging % since version 31
if L == 0 || length(handles.modelname_scopenames)==0
    set(handles.edit_scope_TimeSpan,'Enable','off');
    set(handles.text_edit_scope_TimeSpan,'Enable','off');
end

end
% ************ find all blocks of simulink ************
function handles = simulink_blocks_names(handles)
% find all blocks of simulink
% aux = find_system(handles.modelname,'Type','Block');
aux = find_system(handles.modelname, ...
    'FollowLinks','On', ...
    'LookUnderMasks','All', ...
    'Regexp', 'On', ...
    'Type','Block');
N = length(handles.modelname) + 2;
cont = 1;
for k = 1 : length(aux)
    % make char without root of its simulink file
    aux2 = char(aux(k));
    aux(k) = {aux2(N:end)};
    
    % only blocks modificables (e.g. Scope has no DialogParameters)
    string = get_param(...
        sprintf('%s/%s',char(handles.modelname),char(aux(k))),...
        'DialogParameters');
    if ~isempty(string)  % isempty(fieldnames(string))
        % There are two kinds of emptiness for structs: (do not delete)
        % 1. S = struct() => no fields
        % isempty(S) is FALSE, because S is a [1 x 1] struct without fields
        % 2. S = struct('Field1', {}) => fields, but no data
        % isempty(S) is TRUE, because S is a [0 x 0] struct with fields
        % "isempty(fieldnames())" consider both.
        aux3(cont) = aux(k);
        cont = cont + 1;
    end
end
handles.modelname_blocknames = aux3;
end
% ************ find all properties of a block of simulink ************
function handles = simulink_block_properties_names(handles)
% block_property depends on block_name
aux = get(eval(sprintf('handles.slider%s_block_name_popupmenu',num2str(handles.sliderXY_number, '%02i'))), 'Value');
string = get(eval(sprintf('handles.slider%s_block_name_popupmenu',num2str(handles.sliderXY_number, '%02i'))), 'String');
aux = get_param(...
    sprintf('%s/%s',char(handles.modelname),char(string(aux))),...
    'DialogParameters');
fieldnames_array = fieldnames(aux);
handles.modelname_blockpropertiesnames = fieldnames_array;
end


% ************ simulation ************
function handles = simulation(handles)
% handles

% Turn off the Start button
set(handles.pushbutton_start,'Enable','off');
% Turn on the Stop button
set(handles.pushbutton_stop,'Enable','on');

% status of simulation (pause,stop,...)
% flag = get_param(handles.modelname,'SimulationStatus')

% stop simulation
set_param(handles.modelname,'SimulationCommand','stop');

% set values in their respective block of simulink or workspace variable
for k = 1 : handles.sliderXY_totalnumber
    
    % check: (do not delete)
    % a = eval(char(sprintf('handles.slider%s_block_name',num2str(k, '%02i'))));
    % b = eval(char(sprintf('handles.slider%s_block_property',num2str(k, '%02i'))));
    % c = eval(char(sprintf('handles.slider%s_value',num2str(k, '%02i'))));
    % whos a, whos b, whos c
    % [a b c]
    
    value = eval(['handles.slider', num2str(k, '%02i'), '_value']);
    if isnumeric(value)
        eval(['handles.slider', num2str(k, '%02i'), '_value = num2str(value);']);
    end
    
    if get(eval(sprintf('handles.slider%s_block_radiobutton',num2str(k, '%02i'))) ,'value')
        % change values in desired block
        aux = sprintf('%s/%s',...
            char(handles.modelname),...
            char(eval(char(sprintf('handles.slider%s_block_name',num2str(k, '%02i'))))));
        
        set_param(aux,...
            eval(char(sprintf('handles.slider%s_block_property',num2str(k, '%02i')))) ,...
            eval(char(sprintf('handles.slider%s_value',num2str(k, '%02i')))));
    else
        % to check every iteration:
        % x(k)=eval(['str2num(handles.slider',num2str(k, '%02i'),'_value)'])
        
        % change values in desired workspace variable (or cell of variable)
        % e.g. evalin ('base','freq(2)=250')
        name = eval(sprintf('handles.slider%s_workspace_name',num2str(k, '%02i')));
        if ~isempty(name) % e.g. no default workspace variable
            value = eval(['str2num(handles.slider',num2str(k, '%02i'),'_value)']);
            assignin ('base' , 'expresion' , sprintf('%s = %.16f;',name,value));
            
            % "%.16f" is really important and no just "%f" cause: 'If precision is not specified, it defaults to 6.'
            % so whith %f 1e-6 is fine, but 1e-7 is equal to zero, underflow!!
            % https://es.mathworks.com/help/matlab/matlab_prog/formatting-strings.html#bq05n1r-1
            % biggest precision  matlab
            % comprobate value is right: 
            % evalin ('base', 'expresion');
            
            evalin ('base', 'eval(expresion)');
            evalin( 'base', 'clear expresion;');
        end
        
        % if we just change value of a cell of a matrix, we must use evalin, no assignin
        % assignin ('base',...
        %     eval(sprintf('handles.slider%s_workspace_name',num2str(k, '%02i'))),...
        %     eval(['str2num(handles.slider',num2str(k, '%02i'),'_value)']));
        % e.g. in handles.sliderXY_workspace_name: simulink_constances_AC_current_source_freq
        
        %     set_param(handles.modelname,'SimulationCommand','WriteDataLogs')
        %     set_param(handles.modelname,'SimulationCommand','update')
    end
end

% calculate inputs to simulink
handles = simulation_calculus_inputs(handles);

% set_param(handles.modelname,'LoadExternalInput','on'); % default names are 't' for time and matrix 'u' which is column is an input array
if strcmp(get_param(handles.modelname,'LoadExternalInput') , 'on')
    t = handles.time;
    assignin ('base', 't', t);
    if length(handles.modelname_inputnames) > 0
        u = handles.signal_input;
        assignin ('base', 'u', u);
    end
end

% paramNameValStruct.DstWorkspace = 'base';'current'; % save Scope to wokspace in path of GUI file % https://es.mathworks.com/matlabcentral/answers/9945-export-data-from-simulink-to-workspace-when-using-sim-command

tic

% start simulation
set_param(handles.modelname,'SimulationCommand','start');

% handles is changed (e.g. handles.sliderXY_value), so all callbacks must actualice it
set(handles.pushbutton_stop,'Callback',{@pushbutton_stop_Callback, handles});


% evey 1 seconds check if simulation finalized
while ~strcmp(get_param(handles.modelname, 'SimulationStatus'), 'stopped')
    % wait until model is stopped
    pause(1);
end
aux = get(handles.pushbutton_stop,'Enable');
if strcmp(aux,'on')
    % 1: simulation finalized beacuse it simulated in time handles.modelname_StopTime
    handles = pushbutton_stop_Callback([], [], handles);
    
    % else
    % 2: simulation finalized beacuse stop buttom was pressed
    % do nothing, stop time callback is already called
end

load gong.mat;
sound(y);

toc
end
function handles = simulation_calculus_inputs(handles)
if exist(handles.workspace_calculus_file,'file')
    % run MATLAB script
    run(handles.workspace_calculus_file);
end
end

% ************ output_simulink ************
function handles = output_simulink(handles)
% counter of plots
if ~isfield(handles,'plot_totalnumber')
    handles.plot_totalnumber = 1;
else
    handles.plot_totalnumber = handles.plot_totalnumber + 1;
end
N = handles.plot_totalnumber;
handles.plot_col = hsv(N);


% ************ output ************
L = length(handles.modelname_outputnames);
if L > 0
    t = get_param(handles.modelname,'TimeSaveName');
    % get data from workspace
    t = evalin('base', t);
    
    y = get_param(handles.modelname,'OutputSaveName');
    % get data from workspace
    y = evalin('base', y);
    for k = 1 : L
        eval(['y_aux = y(:,', num2str(k) ,');']);
        eval([sprintf('handles.y_output_plot%s_channel%s',num2str(N,'%02i'),num2str(k,'%02i')), ' = y_aux ; ']);
        eval([sprintf('handles.x_output_plot%s_channel%s',num2str(N,'%02i'),num2str(k,'%02i')), ' = t ; ']);
    end
end
clear t y y_aux


% ************ scope ************
scopenames = handles.modelname_scopenames;
L = length(scopenames);
if L > 0
    for k = 1 : L
        % ScopeData = evalin('base',sprintf('ScopeData_%s',num2str(k,'%02i'))); % before version 31
        
        aux = strrep(char(scopenames(k)), '/', '__'); % 'strrep' find and replace substring
        ScopeData = evalin ('base',sprintf('ScopeData_%s',aux)); % since version 31 
        
        % get data from workspace
        t = ScopeData.time;
        
        % Scope get properties
        handles.scope_structure  = get_param(sprintf('%s/%s',handles.modelname,char(scopenames(k))),'ScopeConfiguration');
        % char(scopenames(k))
        % x=handles.scope_structure.NumInputPorts
        
        G = str2num(handles.scope_structure.NumInputPorts);
        for g = 1 : G
            y_aux_B = eval(sprintf('ScopeData.signals(%s).values',num2str(g)))  ; %handles.ScopeData.signals(2).values';
            B = ScopeData.signals(g).dimensions;
            eval([sprintf('handles.signal2plot_scope_popmenu_bus_string_scope%s_channel%s',num2str(k,'%02i'),num2str(g,'%02i')), ' = B; ']);
            for b = 1 : B
                y_aux = y_aux_B(:,b);
                eval([sprintf('handles.y_scope_plot%s_scope%s_channel%s_bus%s',num2str(N,'%02i'),num2str(k,'%02i'),num2str(g,'%02i'),num2str(b,'%02i')), ' = y_aux ; ']);
            end
        end
        eval([sprintf('handles.x_scope_plot%s_scope%s',num2str(N,'%02i'),num2str(k,'%02i')), ' = t ; ']);
    end
end
clear t y_aux y_aux_B


% ************ input ************
L = length(handles.modelname_inputnames);
if L > 0
    % set_param(handles.modelname,'LoadExternalInput','on');
    % default names are 't' for time and matrix 'u' which is column is an input array
    % input time from workspace
    t = evalin('base', 't');
    
    % input block
    % get data from workspace
    y = evalin('base', 'u');
    for k = 1 : L
        eval(['y_aux = y(:,', num2str(k) ,');']);
        eval([sprintf('handles.y_input_plot%s_channel%s',num2str(N,'%02i'),num2str(k,'%02i')), ' = y_aux ; ']);
        eval([sprintf('handles.x_input_plot%s_channel%s',num2str(N,'%02i'),num2str(k,'%02i')), ' = t ; ']);
    end
end
clear t y y_aux


% ************ workspace ************
% time
% get data from workspace
t = evalin('base', handles.signal2plot_workspace_timename);
eval([sprintf('handles.x_workspace_plot%s',num2str(N,'%02i')), ' = t ; ']);

% workspace: any variable of length of time
% get data from workspace
y = evalin('base', handles.signal2plot_workspace_signalname);
eval([sprintf('handles.y_workspace_plot%s',num2str(N,'%02i')), ' = y ; ']);
clear t y

end
% ************ print_plot ************
function handles = print_plot(handles)


if get(handles.signal2plot_output_radiobutton ,'value')
    channel = handles.signal2plot_output_number;
    choosen = 'output';
elseif get(handles.signal2plot_scope_radiobutton ,'value')
    handles.scope_name;
    channel = handles.signal2plot_scope_input;
    choosen = 'scope';
    scopenumber = get(handles.signal2plot_scope_popmenu_scopename, 'value');
    bus = handles.signal2plot_scope_bus;
elseif get(handles.signal2plot_input_radiobutton ,'value')
    channel = handles.signal2plot_input_number;
    choosen = 'input';
elseif get(handles.signal2plot_workspace_radiobutton ,'value')
    choosen = 'workspace';
else
    error('No output to plot. Choose one.')
end


% zoom part 1 of 2
zoom_limints = get(gca,{'xlim','ylim'});  % Get axes limits (cause of zoom)

N = handles.plot_totalnumber;
cont = 0;
for k = 1 : N
    if get(eval(sprintf('handles.plot_select_checkbox%s', num2str(k, '%02i'))),'value')
        cont = cont + 1;
        
        % handles.plot01 = plot( x(:,k) , y(:,k), 'Color',col(k,:) );
        % fieldnames(handles.plot01) % do not delete
        % fieldnames(handles.axes) % do not delete
        
        if strcmp(choosen,'output') || strcmp(choosen,'input')
            x = eval([sprintf('handles.x_%s_plot%s_channel%s',choosen,num2str(k,'%02i'),num2str(channel,'%02i')), ';']);
            y = eval([sprintf('handles.y_%s_plot%s_channel%s',choosen,num2str(k,'%02i'),num2str(channel,'%02i')), ';']);
        elseif strcmp(choosen,'scope')
            x = eval([sprintf('handles.x_%s_plot%s_scope%s',choosen,num2str(k,'%02i'),num2str(scopenumber,'%02i')), ';']);
            try
                y = eval([sprintf('handles.y_%s_plot%s_scope%s_channel%s_bus%s',choosen,num2str(k,'%02i'),num2str(scopenumber,'%02i'),num2str(channel,'%02i'),num2str(bus,'%02i')), ';']);
            catch
                handles.signal2plot_scope_bus = 1;
                bus = handles.signal2plot_scope_bus;
                y = eval([sprintf('handles.y_%s_plot%s_scope%s_channel%s_bus%s',choosen,num2str(k,'%02i'),num2str(scopenumber,'%02i'),num2str(channel,'%02i'),num2str(bus,'%02i')), ';']);
                % update handles.signal2plot_scope_popmenu_busnumber
                set(handles.signal2plot_scope_popmenu_bus,'Value',handles.signal2plot_scope_bus);
                handles = signal2plot_scope_popmenu_bus_Callback(handles.signal2plot_scope_popmenu_bus, [], handles);
            end
        elseif strcmp(choosen,'workspace')
            try
                x = eval([sprintf('handles.x_%s_plot%s',choosen,num2str(k,'%02i')), ';']);
                y = eval([sprintf('handles.y_%s_plot%s',choosen,num2str(k,'%02i')), ';']);
            catch
                x = [0 0];
                y = [0 0];
            end
        end
        
        
        plot( x , y,... % h_plot(cont)=plot(
            'Color',handles.plot_col(k,:),...
            'LineWidth',1);
        if cont == 1
            hold on
        end
        
        % limits & zoom
        if cont == 1
            y_max = -Inf;            
            x_max = -Inf;
            y_min = -Inf; 
            x_min = +Inf;
            x_max = max (x_max , max(x));
            x_min = min (x_min , min(x));
        end
        y_max = max (y_max , max(y));
        y_min = min (y_min , min(y));
        
        if isfield(handles,'legendStr')
            L = length(handles.legendStr);
        else
            L = 0;
        end
        if (k == N) && (N > L) % plot_select_checkboxXY_Callback muss no create new legend
            % legend
            Str = {};
            M = handles.sliderXY_totalnumber;
            for h = 1 : M
                value = eval(char(sprintf('handles.slider%s_value',num2str(h, '%02i'))));
                
                if get(eval(sprintf('handles.slider%s_block_radiobutton',num2str(h, '%02i'))) ,'value')
                    % changed values in desired block
                    block_name = char(eval (sprintf('handles.slider%s_block_name',num2str(h,'%02i'))));
                    block_property = eval (sprintf('handles.slider%s_block_property',num2str(h,'%02i')));
                    aux = sprintf('%s / %s = %s', block_name , block_property , value);
                else
                    % changed values in desired workspace variable
                    workspace_name = char(eval (sprintf('handles.slider%s_workspace_name',num2str(h,'%02i'))));
                    aux = sprintf('%s = %s', workspace_name , value);
                end
                
                if h == 1
                    Str = sprintf('plot %i: %s ', k, aux);
                else
                    Str = sprintf('%s ; %s', char(Str) , aux);
                end
            end
            handles.legendStr(N) = {Str};
            if ~exist('legendStr','var')
                legendStr(1) = {Str};
            else
                legendStr(cont) = {Str};
            end
        else
            % legend
            legendStr(cont) = handles.legendStr(k);
        end
        if (N > L) % plot_select_checkboxXY_Callback muss no change plot_select_checkbox%s_name
            set(eval(sprintf('handles.plot_select_checkbox%s_name',num2str(k, '%02i'))),...
                'String',sprintf('plot %i ', k));
        end
    else
    end
end
hold off

if cont > 0
    % legend
    hleg = legend(legendStr,'Location','Best');% legend(h_plot,legendStr,'Location','Best');
    set(hleg,'FontSize',8,'FontWeight','bold', 'Interpreter', 'none')
    
    % limits
    try % e.g. a bode is ploted in this guide unintencioned, limits get error
        if N == 1
            if x_max > handles.axes_x_limit_min_value
                handles.axes_x_limit_max_value = x_max;
                handles = axes_x_limit_max_edit_Callback([], [], handles);
            end
        end
        if handles.axes_x_limit_min_value < handles.axes_x_limit_max_value &&...
                ~isinf(handles.axes_x_limit_max_value)
            set(handles.axes,'XLim', [handles.axes_x_limit_min_value , handles.axes_x_limit_max_value] );
        end
        axis on;
    catch
    end
    
else
    plot([0,1],[0,1],'LineStyle','none');
    text(0.5, 0.5, sprintf('NO\n PLOTS'), 'FontSize',50, 'Color','k', ...
        'HorizontalAlignment','Center', 'VerticalAlignment','Middle');
    axis off;
end

% plot properties
handles = edit_lines_properties_Callback(handles.edit_lines_properties, [], handles);

% zoom part 2 of 2
if N > 1
    try
    set(gca,{'xlim','ylim'},[{get(handles.axes,'XLim')},{[y_min y_max]}])
    zoom reset % remembers the current zoom setting as the initial zoom setting. Later calls to zoom out, or double-clicks when interactive zoom mode is enabled, will return to this zoom level.
    set(gca,{'xlim','ylim'},zoom_limints)
    catch
    end
end

% beacuase this function is last to be executed in: plot_select_checkboxXY_Callback and pushbutton_stop_Callback. We only update calls here.
% send handle updated to callbacks
handles = update_thecallbacks(handles);

end

% ************ plot_select_checkboxXY ************
function handles = select_plot_build(handles)
N = handles.plot_totalnumber;

% panel sublevel 0: select_plot_uipanel
% position in absolutes units)
% update
handles.pushbutton_calculusbrowse_position = get(handles.pushbutton_calculusbrowse,'Position');
handles.gui_position = [0 0 1 1];%get(handles.f,'Position');
handles.pushbutton_simbrowse_position = get(handles.pushbutton_simbrowse,'Position');
handles.plot_select_uipanel_position(1) = handles.pushbutton_calculusbrowse_position(1) + handles.pushbutton_calculusbrowse_position(3);
handles.plot_select_uipanel_position(3) = handles.gui_position(3) - (handles.pushbutton_simbrowse_position(1) + 3*handles.pushbutton_simbrowse_position(3));
height_total = 0;
handles.plot_select_uipanel_position(4) = 0;
handles.plot_select_uipanel_position(2) = handles.pushbutton_calculusbrowse_position(2);

aux = sprintf('uipanel(''Parent'',handles.f, ''Units'',''normalized'',''Position'',handles.plot_select_uipanel_position)');
eval(['handles.plot_select_uipanel =', aux ,';']);

handles.plot_select_checkboxXY_position = [0,0,0,0];
handles.plot_select_checkboxXY_name_position = [0,0,0,0];

end
function handles = select_plot_update(handles)
N = handles.plot_totalnumber;

row_total = 5;
column_total = 4;

height_total = min(N,row_total) * 1/row_total * (2* handles.pushbutton_calculusbrowse_position(4)) ;
handles.plot_select_uipanel_position(4) = height_total;
handles.plot_select_uipanel_position(2) = (handles.pushbutton_simbrowse_position(2) + handles.pushbutton_simbrowse_position(4)) - height_total;
set(handles.plot_select_uipanel , 'Units','normalized', 'Position', handles.plot_select_uipanel_position);

aux = sprintf('uicontrol(handles.plot_select_uipanel, ''Style'',''checkbox'', ''Units'',''normalized'', ''Position'',handles.plot_select_checkboxXY_position, ''Value'',1, ''Tag'',''%s'')',...
    num2str(N, '%02i'));
eval([sprintf('handles.plot_select_checkbox%s', num2str(N, '%02i')), ' = ', aux ,';']);
set(eval(sprintf('handles.plot_select_checkbox%s', num2str(N, '%02i'))),'Callback',{@plot_select_checkboxXY_Callback, handles});

aux = sprintf('uicontrol(handles.plot_select_uipanel, ''Style'',''text'', ''Fontsize'',7 ,''HorizontalAlignment'',''left'' , ''Units'',''normalized'', ''Position'',handles.plot_select_checkboxXY_name_position, ''String'',{''''}, ''Tag'',''%s'')',...
    num2str(N, '%02i'));
eval([sprintf('handles.plot_select_checkbox%s_name', num2str(N, '%02i')), ' = ', aux ,';']);

% find uicontrols in handles
handles = find_uicontrols(handles);
% normalize Units in uicontrols and uipanels
handles = normalize_GUI(handles);
% find_uicontrols(handles); also is needed to update_thecallbacks(handles); in future commands

pos(3) = .05;
pos2(3) = fix(10/column_total)/10 - pos(3);
for k = 1 : N
    
    %  checkbox of plot
    pos(4) = (1/N)*(N<=row_total) + (1/row_total)*(N>row_total);
    
    pos(1) = fix((k-1)/row_total)*(.05 + pos(3)+pos2(3));
    if k <= row_total && N <= row_total
        pos(2) = (N - k) / N;
    else
        pos(2) = (row_total - (k - row_total*(fix((k-1)/row_total)))) /...
            row_total;
    end
    
    set(eval(sprintf('handles.plot_select_checkbox%s',num2str(k, '%02i'))),...
        'Position',pos);
    
    %  name of checkbox of plot
    pos2(1) = pos(1) + pos(3);
    pos2(2) = pos(2);
    pos2(4) = pos(4);
    set(eval(sprintf('handles.plot_select_checkbox%s_name',num2str(k, '%02i'))),...
        'Position',pos2);
end
end
function handles = plot_select_checkboxXY_Callback(hObject, eventdata, handles)
N = str2num(get(hObject,'Tag'));
value   = get(hObject,'value');
set(eval(sprintf('handles.plot_select_checkbox%s', num2str(N, '%02i'))),'value',value);

handles = print_plot(handles);
end


% ************ axes_x_limit_min_edit_Callback ************
function handles = axes_x_limit_min_edit_Callback(hObject, eventdata, handles)
% read value written
aux = get(hObject , 'String');
if ~isempty(aux) && str2num(aux) >= 0 && handles.axes_x_limit_max_value > str2num(aux)
    handles.axes_x_limit_min_value = str2num(aux);
    % reajust plot x limits
    aux = get(handles.axes,'XLim');
    set(handles.axes,'XLim', [handles.axes_x_limit_min_value , aux(2)] );
end
% print value (if inserted value is valid print it, otherwise print the one before)
set(handles.axes_x_limit_min_edit,'String',num2str(handles.axes_x_limit_min_value))

handles = update_thecallbacks(handles);
end
% ************ axes_x_limit_max_edit_Callback ************
function handles = axes_x_limit_max_edit_Callback(hObject, eventdata, handles)
% read value written
aux = get(hObject , 'String');
if ~isempty(aux) && handles.axes_x_limit_min_value < str2num(aux)
    handles.axes_x_limit_max_value = str2num(aux);
    % reajust plot x limits
    aux = get(handles.axes,'XLim');
    set(handles.axes,'XLim', [aux(1) , handles.axes_x_limit_max_value] );
end
% print value (if inserted value is valid print it, otherwise print the one before)
set(handles.axes_x_limit_max_edit,'String',num2str(handles.axes_x_limit_max_value))
handles = update_thecallbacks(handles);
end
% ************ edit_scope_TimeSpan_Callback ************
function handles = edit_scope_TimeSpan_Callback(hObject, eventdata, handles)
% read value written
aux = get(hObject , 'String');
if ~isempty(aux) && str2num(aux) > 0
    handles.edit_scope_TimeSpan_value = str2num(aux);
    
    % Scope set properties
    handles = load_simulink_scope(handles);
end
% print value (if inserted value is valid print it, otherwise print the one before)
set(handles.edit_scope_TimeSpan,'String',aux)
handles = update_thecallbacks(handles);
end
% ************ edit_modelname_StopTime_Callback ************
function handles = edit_modelname_StopTime_Callback(hObject, eventdata, handles)
% read value written
aux = get(hObject , 'String');
if ~isempty(aux) && str2num(aux) > 0
    % time limit
    handles.modelname_StopTime = aux;
    if exist(handles.modelname,'file')
        set_param(handles.modelname, 'StopTime', handles.modelname_StopTime);
        save_system(handles.modelname);
    end
end
% print value (if inserted value is valid print it, otherwise print the one before)
set(handles.edit_modelname_StopTime,'String',aux)
handles = update_thecallbacks(handles);
end
% ************ edit_lines_properties_Callback ************
function handles = edit_lines_properties_Callback(hObject, eventdata, handles)
% read value written
aux = get(hObject , 'String'); % 'LineStyle','none'
aux = regexprep(char(aux),' ', ''); % replace empty character
try
    assignin ('base' , 'expresion' , sprintf('expresion_h = get(gca,''children'');'));
    evalin ('base', 'eval(expresion);');
    evalin( 'base', 'clear expresion;');
    
    assignin ('base' , 'expresion' , sprintf('set(expresion_h(:),%s);',aux));
    evalin ('base', 'eval(expresion);');
    evalin( 'base', 'clear expresion expresion_h;');
    handles.lines_properties = aux;
end
% print value (if inserted value is valid print it, otherwise print the one before)
set(handles.edit_lines_properties,'String',handles.lines_properties);

handles = update_thecallbacks(handles);
end

% ************ signal2plot ************
function handles = signal2plot_position(handles)
% signal2plot uipanels
width = 250;
handles.signal2plot_uipanel_position = [...
    handles.axes_position(1) + handles.axes_position(3) - width,...
    handles.axes_x_limit_position(2),...
    width,...
    70];
handles.signal2plot_output_uipanel_position = [...
    0,...
    0,...
    .5,...
    .5];
handles.signal2plot_scope_uipanel_position = [...
    0,...
    .5,...
    .5,...
    .5];
handles.signal2plot_input_uipanel_position = [...
    .5,...
    0,...
    .5,...
    .5];
handles.signal2plot_workspace_uipanel_position = [...
    .5,...
    .5,...
    .5,...
    .5];

% signal2plot_output
aux = .1;
handles.signal2plot_output_radiobutton_position = [...
    .01,...
    aux,...
    .2,...
    (1-(aux*2))];
handles.signal2plot_output_popmenu_position = [...
    handles.signal2plot_output_radiobutton_position(1) + handles.signal2plot_output_radiobutton_position(3),...
    handles.signal2plot_output_radiobutton_position(2),...
    0,...
    .5];
handles.signal2plot_output_popmenu_position(3) = 1 - (handles.signal2plot_output_popmenu_position(1));
handles.signal2plot_output_text_position = [...
    handles.signal2plot_output_popmenu_position(1),...
    handles.signal2plot_output_popmenu_position(2) + handles.signal2plot_output_popmenu_position(4),...
    handles.signal2plot_output_popmenu_position(3) ,...
    1 - ((handles.signal2plot_output_popmenu_position(2) +  handles.signal2plot_output_popmenu_position(4)))];

% signal2plot_input
handles.signal2plot_input_radiobutton_position = handles.signal2plot_output_radiobutton_position;
handles.signal2plot_input_popmenu_position = handles.signal2plot_output_popmenu_position;
handles.signal2plot_input_text_position = handles.signal2plot_output_text_position;

% signal2plot_workspace
handles.signal2plot_workspace_radiobutton_position = handles.signal2plot_output_radiobutton_position;
% Time variable is needed to be selected e.g. because time input to simulink is not necesarry
% the same as time output of simulink. Signals to plot can be of any (inputed o outputed).
handles.signal2plot_workspace_edit_timename_position = handles.signal2plot_output_popmenu_position;
handles.signal2plot_workspace_edit_timename_position(3) =  .5 * handles.signal2plot_workspace_edit_timename_position(3);
handles.signal2plot_workspace_edit_signalname_position = handles.signal2plot_workspace_edit_timename_position;
handles.signal2plot_workspace_edit_signalname_position(1) = handles.signal2plot_workspace_edit_signalname_position(1) + handles.signal2plot_workspace_edit_signalname_position(3);
handles.signal2plot_workspace_text_timename_position = handles.signal2plot_output_text_position;
handles.signal2plot_workspace_text_timename_position(3) = .5 * handles.signal2plot_workspace_text_timename_position(3);
handles.signal2plot_workspace_text_signalname_position = handles.signal2plot_workspace_text_timename_position;
handles.signal2plot_workspace_text_signalname_position(1) = handles.signal2plot_workspace_text_signalname_position(1) + handles.signal2plot_workspace_text_signalname_position(3);

% signal2plot_scope
handles.signal2plot_scope_radiobutton_position = handles.signal2plot_output_radiobutton_position;
pos = handles.signal2plot_workspace_edit_timename_position;
width = pos(3)*2/3;
pos(3) = width;
handles.signal2plot_scope_popmenu_scopename_position = pos;
pos(1) = pos(1) + pos(3);
handles.signal2plot_scope_popmenu_input_position = pos;
pos(1) = pos(1) + pos(3);
handles.signal2plot_scope_popmenu_bus_position = pos;
pos = handles.signal2plot_workspace_text_timename_position;
pos(3) = width;
handles.signal2plot_scope_text_scopename_position = pos;
pos(1) = pos(1) + pos(3);
handles.signal2plot_scope_text_input_position = pos;
pos(1) = pos(1) + pos(3);
handles.signal2plot_scope_text_bus_position = pos;
end
function handles = signal2plot_build(handles)

% ************ signal2plot uipanels ************
handles.signal2plot_uipanel = uipanel('Parent',handles.f,...
    'BackgroundColor','white',...
    'Units','Pixels','Position',handles.signal2plot_uipanel_position);
handles.signal2plot_output_uipanel = uipanel('Parent',handles.signal2plot_uipanel,...
    'BackgroundColor','white',...
    'Units','Normalized','Position',handles.signal2plot_output_uipanel_position);
handles.signal2plot_scope_uipanel = uipanel('Parent',handles.signal2plot_uipanel,...
    'BackgroundColor','white',...
    'Units','Normalized','Position',handles.signal2plot_scope_uipanel_position);
handles.signal2plot_input_uipanel = uipanel('Parent',handles.signal2plot_uipanel,...
    'BackgroundColor','white',...
    'Units','Normalized','Position',handles.signal2plot_input_uipanel_position);
handles.signal2plot_workspace_uipanel = uipanel('Parent',handles.signal2plot_uipanel,...
    'BackgroundColor','white',...
    'Units','Normalized','Position',handles.signal2plot_workspace_uipanel_position);

% ************ signal2plot_output ************
handles.signal2plot_output_radiobutton = uicontrol(handles.signal2plot_output_uipanel,...
    'Style','radiobutton',...
    'Units','normalized', 'Position',handles.signal2plot_output_radiobutton_position,...
    'Value',0);
handles.signal2plot_output_popmenu = uicontrol( handles.signal2plot_output_uipanel,...
    'Style','popupmenu',...
    'Units','normalized', 'Position',handles.signal2plot_output_popmenu_position);
handles.signal2plot_output_text = uicontrol( handles.signal2plot_output_uipanel,...
    'Style','text',...
    'String',{'Output to plot'}, 'Fontsize', 6,...
    'Units','normalized', 'Position',handles.signal2plot_output_text_position );

% ************ signal2plot_scope ************
handles.signal2plot_scope_radiobutton = uicontrol(handles.signal2plot_scope_uipanel,...
    'Style','radiobutton',...
    'Units','normalized', 'Position',handles.signal2plot_scope_radiobutton_position,...
    'Value',0);
handles.signal2plot_scope_popmenu_scopename = uicontrol( handles.signal2plot_scope_uipanel,...
    'Style','popupmenu',...
    'Units','normalized', 'Position',handles.signal2plot_scope_popmenu_scopename_position);
handles.signal2plot_scope_popmenu_input = uicontrol( handles.signal2plot_scope_uipanel,...
    'Style','popupmenu',...
    'String',{'none'},...
    'Units','normalized', 'Position',handles.signal2plot_scope_popmenu_input_position);
handles.signal2plot_scope_popmenu_bus = uicontrol( handles.signal2plot_scope_uipanel,...
    'Style','popupmenu',...
    'String',{'1'},...
    'Units','normalized', 'Position',handles.signal2plot_scope_popmenu_bus_position);
handles.signal2plot_scope_bus = 1; % default bus selected is 1 (cause may be only 1)
handles.signal2plot_scope_text_scopename = uicontrol( handles.signal2plot_scope_uipanel,...
    'Style','text',...
    'String',{'Scope'}, 'Fontsize', 6,...
    'Units','normalized', 'Position',handles.signal2plot_scope_text_scopename_position );
handles.signal2plot_scope_text_input = uicontrol( handles.signal2plot_scope_uipanel,...
    'Style','text',...
    'String',{'Input'}, 'Fontsize', 6,...
    'Units','normalized', 'Position',handles.signal2plot_scope_text_input_position );
handles.signal2plot_scope_text_bus = uicontrol( handles.signal2plot_scope_uipanel,...
    'Style','text',...
    'String',{'Bus'}, 'Fontsize', 6,...
    'Units','normalized', 'Position',handles.signal2plot_scope_text_bus_position );

% ************ signal2plot_input ************
handles.signal2plot_input_radiobutton = uicontrol(handles.signal2plot_input_uipanel,...
    'Style','radiobutton',...
    'Units','normalized', 'Position',handles.signal2plot_input_radiobutton_position,...
    'Value',0);
handles.signal2plot_input_popmenu = uicontrol( handles.signal2plot_input_uipanel,...
    'Style','popupmenu',...
    'Units','normalized', 'Position',handles.signal2plot_input_popmenu_position);
handles.signal2plot_input_text = uicontrol( handles.signal2plot_input_uipanel,...
    'Style','text',...
    'String',{'input to plot'}, 'Fontsize', 6,...
    'Units','normalized', 'Position',handles.signal2plot_input_text_position );

% ************ signal2plot_workspace ************
handles.signal2plot_workspace_radiobutton = uicontrol(handles.signal2plot_workspace_uipanel,...
    'Style','radiobutton',...
    'Units','normalized', 'Position',handles.signal2plot_workspace_radiobutton_position,...
    'Value',0);
% Time variable is needed to be selected e.g. because time input to simulink is not necesarry
% the same as time output of simulink. Signals to plot can be of any (inputed o outputed).
handles.signal2plot_workspace_edit_timename = uicontrol( handles.signal2plot_workspace_uipanel,...
    'Style','edit',...
    'Units','normalized', 'Position',handles.signal2plot_workspace_edit_timename_position);
handles.signal2plot_workspace_edit_signalname = uicontrol( handles.signal2plot_workspace_uipanel,...
    'Style','edit',...
    'Units','normalized', 'Position',handles.signal2plot_workspace_edit_signalname_position);
handles.signal2plot_workspace_text_timename = uicontrol( handles.signal2plot_workspace_uipanel,...
    'Style','text',...
    'String',{'time'}, 'Fontsize', 6,... % Workspace time
    'Units','normalized', 'Position',handles.signal2plot_workspace_text_timename_position );
handles.signal2plot_workspace_text_signalname = uicontrol( handles.signal2plot_workspace_uipanel,...
    'Style','text',...
    'String',{'signal'}, 'Fontsize', 6,... % Workspace signal
    'Units','normalized', 'Position',handles.signal2plot_workspace_text_signalname_position );

end
function handles = signal2plot_update(handles)
% every time a simulink file is loaded it has it owns scope names, inputs and outputs

% ************ signal2plot output strings ************
string_output_popmenu = handles.modelname_outputnames;
if ~isempty(string_output_popmenu) % if there is at least 1 in simulink
    set(handles.signal2plot_output_popmenu,'String', handles.modelname_outputnames);
    set(findall(handles.signal2plot_output_uipanel, '-property', 'Enable'), 'Enable', 'on');
else
    set(handles.signal2plot_output_popmenu,'String', 'none');
    set(handles.signal2plot_output_popmenu,'Value', 1);
    set(findall(handles.signal2plot_output_uipanel, '-property', 'Enable'), 'Enable', 'off');
end


% ************ signal2plot scope strings ************
string_scope_popmenu = handles.modelname_scopenames;
if ~isempty(string_scope_popmenu) % if there is at least 1 in simulink
    set(handles.signal2plot_scope_popmenu_scopename ,...
        'String', handles.modelname_scopenames); % since version 31
        % 'String', handles.modelname_scopenames); % version 30 and before
    set(findall(handles.signal2plot_scope_uipanel, '-property', 'Enable'), 'Enable', 'on');
else
    set(handles.signal2plot_scope_popmenu_scopename, 'String', 'none');
    set(handles.signal2plot_scope_popmenu_scopename, 'Value', 1);
    set(findall(handles.signal2plot_scope_uipanel, '-property', 'Enable'), 'Enable', 'off');
end

% ************ signal2plot input strings ************
string_input_popmenu = handles.modelname_inputnames;
if ~isempty(string_input_popmenu) % if there is at least 1 in simulink
    set(handles.signal2plot_input_popmenu,'String', handles.modelname_inputnames);
    set(findall(handles.signal2plot_input_uipanel, '-property', 'Enable'), 'Enable', 'on');
else
    set(handles.signal2plot_input_popmenu,'String', 'none');
    set(handles.signal2plot_input_popmenu, 'Value', 1);
    set(findall(handles.signal2plot_input_uipanel, '-property', 'Enable'), 'Enable', 'off');
end


% ************ signal2plot default and update ************

% default for 'signal2plot_all_radiobutton(handles,pos);' function
% if there are no scopes, inputs or outputs then something must be plotted
pos = 4;


% ************ signal2plot_output ************
N = length(handles.modelname_outputnames);
if N > 0  % if there is at least 1 in simulink
    if isfield(handles,'signal2plot_output_number')
        aux = handles.signal2plot_output_number;
        value = find(1:N == aux);
        if ~isempty(value)
            pos = 1;
        else
            value = 1 ;
            handles.signal2plot_output_number = value;
        end
    else
        value = 1 ;
        handles.signal2plot_output_number = value;
    end
    set(handles.signal2plot_output_popmenu, 'value', value);
end

% ************ signal2plot_scope ************
list = handles.modelname_scopenames;
if ~isempty(list) % if there is at least 1 in simulink
    
    if isfield(handles,'scope_name')
        aux = handles.scope_name;
        value = find(strcmp(aux , list));
        if ~isempty(value)
            pos = 2;
        else
            value = 1 ;
            handles.scope_name = char(list(1));
        end
    else
        value = 1 ;
        handles.scope_name = char(list(1));
    end
    set(handles.signal2plot_scope_popmenu_scopename, 'value', value);
    handles = signal2plot_scope_update(handles);
    
    N = str2num(handles.scope_structure.NumInputPorts);
    if isfield(handles,'signal2plot_scope_input')
        aux = handles.signal2plot_scope_input;
        value = find (1:N == aux);
        if ~isempty(value)
            pos = 2;
        else
            value = 1 ;
            handles.signal2plot_scope_input = 1;
        end
    else
        value = 1 ;
        handles.signal2plot_scope_input = 1;
    end
    set(handles.signal2plot_scope_popmenu_input, 'value', value);
    
end

% ************ signal2plot_input ************
N = length(handles.modelname_inputnames);
if N > 0 % if there is at least 1 in simulink
    if isfield(handles,'signal2plot_input_number')
        aux = handles.signal2plot_input_number;
        value = find(1:N == aux);
        if ~isempty(value)
            pos = 3;
        else
            value = 1 ;
            handles.signal2plot_input_number = value;
        end
    else
        value = 1 ;
        handles.signal2plot_input_number = value;
    end
    set(handles.signal2plot_input_popmenu, 'value', value);
end

% ************ signal2plot_workspace ************
if isfield(handles,'signal2plot_workspace_signalname') && isfield(handles,'signal2plot_workspace_timename')
    set (handles.signal2plot_workspace_edit_signalname,'String',handles.signal2plot_workspace_signalname);
    set (handles.signal2plot_workspace_edit_timename,'String',handles.signal2plot_workspace_timename);
    pos = 4;
else
    % if there are no scopes, inputs or outputs then something must be plotted
    handles.signal2plot_workspace_signalname = '0';
    handles.signal2plot_workspace_timename = '0';
    set (handles.signal2plot_workspace_edit_signalname,'String','0');
    set (handles.signal2plot_workspace_edit_timename,'String','0');
end


% callback of signal2plot radiobutton to default enable uicontrol of no activate radiobutton
handles = signal2plot_all_radiobutton(handles,pos);
end
function handles = signal2plot_output_radiobutton_Callback(hObject, eventdata, handles)
value = get(hObject,'Value');

pos = 1;
handles = signal2plot_all_radiobutton(handles,pos);
end
function handles = signal2plot_scope_radiobutton_Callback(hObject, eventdata, handles)
value = get(hObject,'Value');

pos = 2;
handles = signal2plot_all_radiobutton(handles,pos);
end
function handles = signal2plot_input_radiobutton_Callback(hObject, eventdata, handles)
value = get(hObject,'Value');

pos = 3;
handles = signal2plot_all_radiobutton(handles,pos);
end
function handles = signal2plot_workspace_radiobutton_Callback(hObject, eventdata, handles)
value = get(hObject,'Value');

pos = 4;
handles = signal2plot_all_radiobutton(handles,pos);
end
function handles = signal2plot_all_radiobutton(handles,pos)
value = zeros (1,4);
enable_string = {'off' , 'off' , 'off' , 'off' };
value(pos) = 1;
enable_string(pos) = {'on'};

set(handles.signal2plot_output_radiobutton,'value',value(1));
set(handles.signal2plot_scope_radiobutton,'value',value(2));
set(handles.signal2plot_input_radiobutton,'value',value(3));
set(handles.signal2plot_workspace_radiobutton,'value',value(4));

% set enable to block of each signal2plot_uipanel
% do not change enable of radiobuttom determinated in load of simulink file
% (if there were no scopes, radiobuttom of signal2plot_scopes must keep enable off)
x.a1=findall(handles.signal2plot_output_uipanel, '-property', 'Enable');% y=findall(handles.signal2plot_output_uipanel, 'Style', 'radiobutton')
x.a2=findall(handles.signal2plot_scope_uipanel, '-property', 'Enable');
x.a3=findall(handles.signal2plot_input_uipanel, '-property', 'Enable');
x.a4=findall(handles.signal2plot_workspace_uipanel, '-property', 'Enable');
for g = 1: 4
    y = eval(sprintf('x.a%s',num2str(g)));
    for k = 1 : length(y)
        if  strcmp(y(k).Style,'radiobutton')
            y(k) = [];
        end
    end
    set(y, 'Enable', char(enable_string(g)));
end

end

function handles = signal2plot_output_popmenu_Callback(hObject, eventdata, handles)
handles.signal2plot_output_number = get(hObject,'Value');

if isfield(handles,'plot_totalnumber')
    if handles.plot_totalnumber > 0
        handles = print_plot(handles);
    end
end

handles = update_thecallbacks(handles);
end

function handles = signal2plot_scope_popmenu_bus_Callback(hObject, eventdata, handles)
handles.signal2plot_scope_bus = get(hObject,'Value');

if isfield(handles,'plot_totalnumber')
    if handles.plot_totalnumber > 0
        handles = print_plot(handles);
    end
end

handles = update_thecallbacks(handles);
end
function handles = signal2plot_scope_bus_update(handles)
scope_number = get(handles.signal2plot_scope_popmenu_scopename,'Value');
scope_input = get(handles.signal2plot_scope_popmenu_input,'Value');
try
    N = eval([sprintf('handles.signal2plot_scope_popmenu_bus_string_scope%s_channel%s%s_%s' , num2str(scope_number,'%02i') ,  num2str(scope_input,'%02i')), ';']);
catch
    N = 1;
end
for k = 1 : N
    string_scope_popmenu_bus{k} = num2str(k);
end
set(handles.signal2plot_scope_popmenu_bus,...
    'String',string_scope_popmenu_bus);
end
function handles = signal2plot_scope_popmenu_input_Callback(hObject, eventdata, handles)
handles.signal2plot_scope_input = get(hObject,'Value');

% change scope open and so on
% handles = load_simulink_scope(handles);

if isfield(handles,'plot_totalnumber')
    if handles.plot_totalnumber > 0
        handles = print_plot(handles);
    end
end

handles = signal2plot_scope_bus_update(handles);

handles = update_thecallbacks(handles);
end
function handles = signal2plot_scope_popmenu_scopename_Callback(hObject, eventdata, handles)
handles.scope_name = char(handles.modelname_scopenames(get(hObject,'Value')));

% actualize scope selected and all its properties
% handles = load_simulink_scope(handles);
%update signal2plot_scope_popmenu_input
handles = signal2plot_scope_update(handles);

% set new signalnumber (if there was another bigger than number of channels that new scope has)
handles.signal2plot_scope_input = 1;

if isfield(handles,'plot_totalnumber')
    if handles.plot_totalnumber > 0
        handles = print_plot(handles);
    end
end

handles = update_thecallbacks(handles);
end
function handles = signal2plot_scope_update(handles)
% Scope get properties
handles.scope_structure  = get_param(sprintf('%s/%s',handles.modelname,handles.scope_name),'ScopeConfiguration');
%update signal2plot_scope_popmenu_input
N = str2num(handles.scope_structure.NumInputPorts);
for k = 1 : N
    string_scope_popmenu_input{k} = num2str(k);
end
set(handles.signal2plot_scope_popmenu_input,...
    'String',string_scope_popmenu_input,...
    'Value',1);
end

function handles = signal2plot_input_popmenu_Callback(hObject, eventdata, handles)
handles.signal2plot_input_number = get(hObject,'Value');

if isfield(handles,'plot_totalnumber')
    if handles.plot_totalnumber > 0
        handles = print_plot(handles);
    end
end

handles = update_thecallbacks(handles);
end

function handles = signal2plot_workspace_edit_signalname_Callback(hObject, eventdata, handles)
% read value written
handles.signal2plot_workspace_signalname = char(get(hObject , 'String'));

if isfield(handles,'plot_totalnumber')
    if handles.plot_totalnumber > 0
        handles = print_plot(handles);
    end
end

handles = update_thecallbacks(handles);
end
function handles = signal2plot_workspace_edit_timename_Callback(hObject, eventdata, handles)
% read value written
handles.signal2plot_workspace_timename = char(get(hObject , 'String'));

if isfield(handles,'plot_totalnumber')
    if handles.plot_totalnumber > 0
        handles = print_plot(handles);
    end
end

handles = update_thecallbacks(handles);
end


% ************ position of sliderXY Objects ************
function handles = sliderXY_all_position(handles)
% ************ slider menu ************

% panel sublevel 0: sliderXY_global_uipanel
% position in absolutes units)
% update
set(handles.axes,'Units','Pixels');
handles.axes_position = get(handles.axes,'Position');
set(handles.axes,'Units','normalized');

set(handles.pushbutton_start,'Units','Pixels');
handles.pushbutton_start_position = get(handles.pushbutton_start,'Position');
set(handles.pushbutton_start,'Units','normalized');

set(handles.f,'Units','Pixels');
handles.gui_position = get(handles.f,'Position');
set(handles.f,'Units','normalized');

handles.sliderXY_global_uipanel_position(1) = handles.axes_position(1) + handles.axes_position(3) + 10;
handles.sliderXY_global_uipanel_position(3) = handles.gui_position(3) - (handles.axes_position(1) + handles.axes_position(3) + 10);
height_total = handles.sliderXY_totalnumber * 90;
handles.sliderXY_global_uipanel_position(4) = height_total;
handles.sliderXY_global_uipanel_position(2) = handles.pushbutton_start_position(2) - 10 - height_total;

% panel sublevel 1: sliderXY_uipanel
% position in absolutes units)
handles.sliderXY_uipanel_position = [...
    0,...
    0,...
    1,...
    1/handles.sliderXY_totalnumber];


if handles.sliderXY_number == 1
    
    % panel sublevel de sliderXY_uipanel_position: sliderXY_sliderandlimits_uipanel
    % position in relatives units to parent
    aux = .01;
    handles.sliderXY_sliderandlimits_uipanel_position = [
        aux,...
        aux,...
        .5,...
        (1-(aux*2))];
    % panel sublevel de sliderXY_uipanel_position: blockandworkspace
    % position in relatives units to parent
    handles.sliderXY_blockandworkspace_uipanel_position = [
        handles.sliderXY_sliderandlimits_uipanel_position(1) + handles.sliderXY_sliderandlimits_uipanel_position(3) + aux ,...
        handles.sliderXY_sliderandlimits_uipanel_position(2),...
        1 - (handles.sliderXY_sliderandlimits_uipanel_position(1) + handles.sliderXY_sliderandlimits_uipanel_position(3) + aux),...
        handles.sliderXY_sliderandlimits_uipanel_position(4)];
    
    % sublevel de sliderXY_sliderandlimits_uipanel
    % slider itself, edits and text_edits
    aux = .01;
    handles.sliderXY_position = [...
        aux,...
        .1,...
        (1-(aux*2)),...
        .3];
    handles.sliderXY_edit_position = [...
        handles.sliderXY_position(1),...
        handles.sliderXY_position(2) + handles.sliderXY_position(4) + aux,...
        .3,...
        .2];
    handles.sliderXY_edit_position_betweenwidth = (1 - ((handles.sliderXY_edit_position(3) + aux*2) * 3))/2;
    handles.sliderXY_text_position = [...
        handles.sliderXY_edit_position(1) ,...
        handles.sliderXY_edit_position(2) + handles.sliderXY_edit_position(4)  + aux,...
        handles.sliderXY_edit_position(3),...
        handles.sliderXY_edit_position(4)];
    
    % panel sublevel de sliderXY_blockandworkspace_uipanel: sliderXY_workspace_uipanel
    % position in relatives units to parent
    aux = .01;
    height = (1-(aux*2)*2)/2;
    handles.sliderXY_block_uipanel_position = [
        aux,...
        aux,...
        (1-(aux*2)),...
        height];
    
    % panel sublevel de sliderXY_blockandworkspace_uipanel: sliderXY_block_uipanel
    % position in relatives units to parent
    handles.sliderXY_workspace_uipanel_position = [...
        handles.sliderXY_block_uipanel_position(1),...
        handles.sliderXY_block_uipanel_position(2) +  handles.sliderXY_block_uipanel_position(4) + aux,...
        handles.sliderXY_block_uipanel_position(3),...
        height];
    
    
    % sublevel de sliderXY_block_uipanel
    % slider block and workspace
    aux = .1;
    handles.sliderXY_block_radiobutton_position = [...
        .01,...
        aux,...
        aux,...
        (1-(aux*2))];
    
    aux = .05;
    text_width = .3;
    text_height = .6;
    betweenwidth = 1 - 3*aux;
    handles.sliderXY_block_name_popupmenu_position = [...
        handles.sliderXY_block_radiobutton_position(1) + handles.sliderXY_block_radiobutton_position(3) + aux,...
        aux,...
        text_width,...
        text_height];
    handles.sliderXY_block_name_text_position = [...
        handles.sliderXY_block_name_popupmenu_position(1),...
        handles.sliderXY_block_name_popupmenu_position(2) + handles.sliderXY_block_name_popupmenu_position(4)  + aux,...
        handles.sliderXY_block_name_popupmenu_position(3) ,...
        1 - ((handles.sliderXY_block_name_popupmenu_position(2) +  handles.sliderXY_block_name_popupmenu_position(4) + aux) + aux)];
    handles.sliderXY_block_property_popupmenu_position = [...
        handles.sliderXY_block_name_popupmenu_position(1) + handles.sliderXY_block_name_popupmenu_position(3) + aux,...
        handles.sliderXY_block_name_popupmenu_position(2),...
        handles.sliderXY_block_name_popupmenu_position(3) ,...
        handles.sliderXY_block_name_popupmenu_position(4)];
    handles.sliderXY_block_property_text_position = [...
        handles.sliderXY_block_property_popupmenu_position(1),...
        handles.sliderXY_block_property_popupmenu_position(2) + handles.sliderXY_block_property_popupmenu_position(4)  + aux,...
        handles.sliderXY_block_name_popupmenu_position(3) ,...
        1 - ((handles.sliderXY_block_property_popupmenu_position(2) +  handles.sliderXY_block_property_popupmenu_position(4) + aux) + aux)];
    handles.sliderXY_block_property_string_popupmenu_position  = [...
        handles.sliderXY_block_property_popupmenu_position(1) + handles.sliderXY_block_property_popupmenu_position(3) + aux,...
        handles.sliderXY_block_property_popupmenu_position(2),...
        .1 ,...
        handles.sliderXY_block_property_popupmenu_position(4)];
    
    
    % sublevel de sliderXY_workspace_uipanel
    handles.sliderXY_workspace_radiobutton_position = handles.sliderXY_block_radiobutton_position;
    handles.sliderXY_workspace_name_edit_position = [...
        handles.sliderXY_block_name_popupmenu_position(1),...
        handles.sliderXY_block_name_popupmenu_position(2),...
        handles.sliderXY_block_property_string_popupmenu_position(1)+...
        handles.sliderXY_block_property_string_popupmenu_position(3)-...
        handles.sliderXY_block_name_popupmenu_position(1),...
        handles.sliderXY_block_name_popupmenu_position(4)];
    handles.sliderXY_workspace_name_text_position = [...
        handles.sliderXY_workspace_name_edit_position(1),...
        handles.sliderXY_workspace_name_edit_position(2) + handles.sliderXY_workspace_name_edit_position(4)  + aux,...
        handles.sliderXY_workspace_name_edit_position(3) ,...
        1 - ((handles.sliderXY_workspace_name_edit_position(2) +  handles.sliderXY_workspace_name_edit_position(4) + aux) + aux)];
    
end
end
% ************ build sliderXY ************
function handles = sliderXY_all_build(handles)
% ************ panels ************
if handles.sliderXY_number == 1
    aux = sprintf('uipanel(''Parent'',handles.f, ''BackgroundColor'',''white'', ''Units'',''Pixels'',''Position'',handles.sliderXY_global_uipanel_position)');
    eval(['handles.sliderXY_global_uipanel = ', aux ,';']);
else
    set(handles.sliderXY_global_uipanel,'Units','Pixels');
    set(handles.sliderXY_global_uipanel,'Position',handles.sliderXY_global_uipanel_position);
end

aux = sprintf('uipanel(''Parent'',handles.sliderXY_global_uipanel, ''BackgroundColor'',''white'', ''Units'',''Normalized'',''Position'',handles.sliderXY_uipanel_position)');
eval(['handles.slider', num2str(handles.sliderXY_number, '%02i'), '_uipanel =', aux ,';']);

aux = sprintf('uipanel(''Parent'',handles.slider%s_uipanel, ''BackgroundColor'',''b'', ''Units'',''Normalized'',''Position'',handles.sliderXY_sliderandlimits_uipanel_position)',...
    num2str(handles.sliderXY_number, '%02i') );
eval(['handles.slider', num2str(handles.sliderXY_number, '%02i'), '_sliderandlimits_uipanel =', aux ,';']);

aux = sprintf('uipanel(''Parent'',handles.slider%s_uipanel, ''BackgroundColor'',''b'', ''Units'',''Normalized'',''Position'',handles.sliderXY_blockandworkspace_uipanel_position)',...
    num2str(handles.sliderXY_number, '%02i') );
eval(['handles.slider', num2str(handles.sliderXY_number, '%02i'), '_blockandworkspace_uipanel =', aux ,';']);

aux = sprintf('uipanel(''Parent'',handles.slider%s_blockandworkspace_uipanel, ''BackgroundColor'',''white'', ''Units'',''Normalized'',''Position'',handles.sliderXY_block_uipanel_position)',...
    num2str(handles.sliderXY_number, '%02i') );
eval(['handles.slider', num2str(handles.sliderXY_number, '%02i'), '_block_uipanel =', aux ,';']);

aux = sprintf('uipanel(''Parent'',handles.slider%s_blockandworkspace_uipanel, ''BackgroundColor'',''white'', ''Units'',''Normalized'',''Position'',handles.sliderXY_workspace_uipanel_position)',...
    num2str(handles.sliderXY_number, '%02i') );
eval(['handles.slider', num2str(handles.sliderXY_number, '%02i'), '_workspace_uipanel =', aux ,';']);

% e.g., just for learning
% relatives coordenates (to parent) in Pixels:
% handles.sliderXY_uipanel_slider = uicontrol(handles.sliderXY_uipanel,'Style','slider','Units','Pixels','Position',[0 0 50 50]);
% relatives coordenates (to parent) in normalized Units:
% handles.sliderXY_uipanel_slider = uicontrol(handles.sliderXY_uipanel,'Style','slider','Units', 'normalized','Position',[.1 .55 .8 .3]);


% ************ sliderXY ************
% set values extrems and initial inputed programmatly for sliderXY
if ~isfield(handles,sprintf('slider%s_min_value',num2str(handles.sliderXY_number, '%02i')))
    eval(['handles.slider', num2str(handles.sliderXY_number, '%02i'), '_min_value = handles.sliderXY_min_value_default;']);
end
if ~isfield(handles,sprintf('slider%s_max_value',num2str(handles.sliderXY_number, '%02i')))
    eval(['handles.slider', num2str(handles.sliderXY_number, '%02i'), '_max_value = handles.sliderXY_max_value_default;']);
end
if ~isfield(handles,sprintf('slider%s_value',num2str(handles.sliderXY_number, '%02i')))
    eval(['handles.slider', num2str(handles.sliderXY_number, '%02i'), '_value = handles.sliderXY_value_default;']);
end

aux = sprintf('uicontrol( handles.slider%s_sliderandlimits_uipanel, ''Style'',''slider'', ''Units'',''normalized'', ''Position'',handles.sliderXY_position, ''Min'',handles.slider%s_min_value, ''Max'',handles.slider%s_max_value, ''Value'',handles.slider%s_value, ''Tag'',''%s'')',...
    num2str(handles.sliderXY_number, '%02i') , num2str(handles.sliderXY_number, '%02i') , num2str(handles.sliderXY_number, '%02i') , num2str(handles.sliderXY_number, '%02i')  , num2str(handles.sliderXY_number, '%02i') );

eval(['handles.slider', num2str(handles.sliderXY_number, '%02i'), '=', aux ,';']);


% ************ sliderXY_edit and text sliderXY ************
uicontrol_vec = {sprintf('slider%s_min_edit',num2str(handles.sliderXY_number, '%02i')) ,...
    sprintf('slider%s_edit',num2str(handles.sliderXY_number, '%02i')) ,....
    sprintf('slider%s_max_edit',num2str(handles.sliderXY_number, '%02i'))};
strings = {'slider min',...
    'value',...
    'slider max'};
for k = 1 : length(uicontrol_vec)
    value = char(uicontrol_vec(k));
    value =  num2str( eval(['handles.',value(1:(end-5)),'_value']), '%.3e');
    aux = sprintf('uicontrol(handles.slider%s_sliderandlimits_uipanel,''Style'',''edit'' , ''String'',value , ''Units'', ''normalized'', ''Position'',handles.sliderXY_edit_position + (k-1)*[handles.sliderXY_edit_position(3) + handles.sliderXY_edit_position_betweenwidth 0 0 0], ''Tag'',''%s'');',...
        num2str(handles.sliderXY_number, '%02i') , num2str(handles.sliderXY_number, '%02i'));
    eval(['handles.',char(uicontrol_vec(k)), '=', aux ,';']);
    
    value = char(uicontrol_vec(k));
    uicontrol_vec(k) =  {[value(1:(end-5)),'_text']};
    aux = sprintf('uicontrol(handles.slider%s_sliderandlimits_uipanel,''Style'',''text'' , ''String'',eval([''strings(k)'']) , ''Units'', ''normalized'', ''Position'', handles.sliderXY_text_position + (k-1)*[handles.sliderXY_edit_position(3) + handles.sliderXY_edit_position_betweenwidth 0 0 0], ''Tag'',''%s'');',...
        num2str(handles.sliderXY_number, '%02i') , num2str(handles.sliderXY_number, '%02i'));
    eval(['handles.',char(uicontrol_vec(k)), '=', aux ,';']);
end


% sublevel de sliderXY_block_uipanel:

% sliderXY_block_radiobutton
aux = sprintf('uicontrol(handles.slider%s_block_uipanel, ''Style'',''radiobutton'', ''Units'',''normalized'', ''Position'',handles.sliderXY_block_radiobutton_position, ''Value'',0, ''Tag'',''%s'')',...
    num2str(handles.sliderXY_number, '%02i') , num2str(handles.sliderXY_number, '%02i'));
eval(['handles.slider', num2str(handles.sliderXY_number, '%02i'), '_block_radiobutton =', aux ,';']);
if isfield(handles,sprintf('slider%s_block_name',num2str(handles.sliderXY_number, '%02i')))
    eval(sprintf('set(handles.slider%s_block_radiobutton,''Value'',1)',num2str(handles.sliderXY_number, '%02i')));
end

% find all blocks of simulink
handles = simulink_blocks_names(handles);

% sliderXY_block_name_popupmenu
aux = sprintf('uicontrol( handles.slider%s_block_uipanel, ''Style'',''popupmenu'', ''String'',handles.modelname_blocknames, ''Units'',''normalized'', ''Position'',handles.sliderXY_block_name_popupmenu_position, ''Tag'',''%s'')',...
    num2str(handles.sliderXY_number, '%02i') , num2str(handles.sliderXY_number, '%02i'));
eval(['handles.slider', num2str(handles.sliderXY_number, '%02i'), '_block_name_popupmenu =', aux ,';']);
if isfield(handles,sprintf('slider%s_block_name',num2str(handles.sliderXY_number, '%02i')))
    % set values inputed programmatly
    aux = eval(sprintf('handles.slider%s_block_name',num2str(handles.sliderXY_number, '%02i')));
    value = find(strcmp(aux,handles.modelname_blocknames));
    if isempty(value)
        value = 1;
    end
else
    % set values arbitrary
    value = 1;
    
    aux = handles.modelname_blocknames;
    eval(['handles.slider', num2str(handles.sliderXY_number, '%02i'), '_block_name = char(aux(value)) ;']);
end
eval(sprintf('set(handles.slider%s_block_name_popupmenu,''Value'',value)',num2str(handles.sliderXY_number, '%02i')));

% sliderXY_block_name_text
aux = sprintf('uicontrol( handles.slider%s_block_uipanel, ''Style'',''text'', ''String'',{''Block name''}, ''Fontsize'', 6, ''Units'',''normalized'', ''Position'',handles.sliderXY_block_name_text_position, ''Tag'',''%s'')', ...
    num2str(handles.sliderXY_number, '%02i') , num2str(handles.sliderXY_number, '%02i'));
eval(['handles.slider', num2str(handles.sliderXY_number, '%02i'), '_block_name_text =', aux ,';']);

% find all propertys of a block of simulink
handles = simulink_block_properties_names(handles);

% sliderXY_block_property_popupmenu
aux = sprintf('uicontrol( handles.slider%s_block_uipanel, ''Style'',''popupmenu'', ''String'',handles.modelname_blockpropertiesnames, ''Units'',''normalized'', ''Position'',handles.sliderXY_block_property_popupmenu_position, ''Tag'',''%s'')',...
    num2str(handles.sliderXY_number, '%02i') , num2str(handles.sliderXY_number, '%02i'));
eval(['handles.slider', num2str(handles.sliderXY_number, '%02i'), '_block_property_popupmenu =', aux ,';']);

if isfield(handles,sprintf('slider%s_block_property',num2str(handles.sliderXY_number, '%02i')))
    % set values inputed programmatly
    aux = eval(sprintf('handles.slider%s_block_property',num2str(handles.sliderXY_number, '%02i')));
    value = find(strcmp(aux,handles.modelname_blockpropertiesnames));
    if isempty(value)
        value = 1;
    end
else
    % set values arbitrary
    value = 1;
    
    aux = handles.modelname_blockpropertiesnames;
    eval(['handles.slider', num2str(handles.sliderXY_number, '%02i'), '_block_property = char(aux(value)) ;']);
end
eval(sprintf('set(handles.slider%s_block_property_popupmenu,''Value'',value)',num2str(handles.sliderXY_number, '%02i')));

% sliderXY_block_property_text
aux = sprintf('uicontrol(handles.slider%s_block_uipanel, ''Style'',''text'', ''String'',{''Block property''}, ''Fontsize'', 6, ''Units'',''normalized'', ''Position'',handles.sliderXY_block_property_text_position, ''Tag'',''%s'')',...
    num2str(handles.sliderXY_number, '%02i') , num2str(handles.sliderXY_number, '%02i'));
eval(['handles.slider', num2str(handles.sliderXY_number, '%02i'), '_block_property_text =', aux ,';']);

% sliderXY_block_property_string_popupmenu_build
handles = sliderXY_block_property_string_popupmenu_build(handles);


% sublevel de sliderXY_workspace_uipanel:

% sliderXY_workspace_radiobutton
aux = sprintf('uicontrol( handles.slider%s_workspace_uipanel, ''Style'',''radiobutton'', ''Units'',''normalized'', ''Position'',handles.sliderXY_workspace_radiobutton_position, ''Value'',  0  , ''Tag'',''%s'')',...
    num2str(handles.sliderXY_number, '%02i') , num2str(handles.sliderXY_number, '%02i'));
eval(['handles.slider', num2str(handles.sliderXY_number, '%02i'), '_workspace_radiobutton =', aux ,';']);
if isfield(handles,sprintf('slider%s_workspace_name',num2str(handles.sliderXY_number, '%02i')))
    eval(sprintf('set(handles.slider%s_workspace_radiobutton,''Value'',1)',num2str(handles.sliderXY_number, '%02i')));
end

% sliderXY_workspace_name_edit
aux = sprintf('uicontrol( handles.slider%s_workspace_uipanel, ''Style'',''edit'', ''Units'',''normalized'', ''Position'',handles.sliderXY_workspace_name_edit_position, ''Tag'',''%s'')', ...
    num2str(handles.sliderXY_number, '%02i') , num2str(handles.sliderXY_number, '%02i'));
eval(['handles.slider', num2str(handles.sliderXY_number, '%02i'), '_workspace_name_edit =', aux ,';']);

% sliderXY_workspace_name_text
aux = sprintf('uicontrol( handles.slider%s_workspace_uipanel, ''Style'',''text'', ''String'',{''Workspace variable''}, ''Fontsize'', 6, ''Units'',''normalized'', ''Position'',handles.sliderXY_workspace_name_text_position, ''Tag'',''%s'')', ...
    num2str(handles.sliderXY_number, '%02i') , num2str(handles.sliderXY_number, '%02i'));
eval(['handles.slider', num2str(handles.sliderXY_number, '%02i'), '_workspace_name_text =', aux ,';']);

if isfield(handles,sprintf('slider%s_workspace_name',num2str(handles.sliderXY_number, '%02i')))
    % set values inputed programmatly
    aux = eval(sprintf('handles.slider%s_workspace_name',num2str(handles.sliderXY_number, '%02i')));
    value = evalin('base',aux);
    if isempty(value)
        value = 1;
    end
    eval(sprintf('set(handles.slider%s_workspace_name_edit,''String'',handles.slider%s_workspace_name)',...
        num2str(handles.sliderXY_number, '%02i'),num2str(handles.sliderXY_number, '%02i')));
end


if handles.sliderXY_number == handles.sliderXY_totalnumber
    handles = sliderXY_all_build_update(handles);
end

% find uicontrols in handles
handles = find_uicontrols(handles);
% normalize Units in uicontrols and uipanels
handles = normalize_GUI(handles);
% send handle updated to callbacks
handles = update_thecallbacks(handles);

handles = sliderXY_block_radiobutton_Callback([], [], handles);
end
function handles = sliderXY_all_build_update(handles)
N = (handles.sliderXY_totalnumber - 1);
for k = 1 : N
    %  sliderXY_uipanel
    pos = get(eval(sprintf('handles.slider%s_uipanel',num2str(handles.sliderXY_totalnumber, '%02i'))) , 'Position');
    pos(2) = (N - k + 1) * 1 / (N + 1);
    set(eval(sprintf('handles.slider%s_uipanel',num2str(k, '%02i'))),...
        'Position',pos);
end
end
% ************ sliderXY_Callback ************
function handles = sliderXY_Callback(hObject, eventdata, handles)
handles.sliderXY_number = str2num(get(hObject,'Tag'));

aux  = get(hObject,'Value');
eval(['handles.slider', num2str(handles.sliderXY_number, '%02i'), '_value = aux;']);

set(eval(sprintf('handles.slider%s_edit',num2str(handles.sliderXY_number, '%02i'))),...
    'String',num2str(eval(sprintf('handles.slider%s_value',num2str(handles.sliderXY_number, '%02i'))), '%.3e' ));
handles = update_thecallbacks(handles);
end
% ************ sliderXY_edit_Callback ************
function handles = sliderXY_edit_Callback(hObject, eventdata, handles)
handles.sliderXY_number = str2num(get(hObject,'Tag'));

% read value written
aux = get(hObject , 'String');
if ~isempty(aux)
    eval(['handles.slider', num2str(handles.sliderXY_number, '%02i'), '_value = aux;']);
    % reajust handle and slider if value written exceeds currents limits of slider
    handles = sliderXY_value_reajust(hObject, eventdata, handles);
end
handles = update_thecallbacks(handles);
end
function handles = sliderXY_value_reajust(hObject, eventdata, handles)
min_string = sprintf('handles.slider%s_min_value', num2str(handles.sliderXY_number, '%02i'));
min = eval(min_string);
max_string = sprintf('handles.slider%s_max_value', num2str(handles.sliderXY_number, '%02i'));
max = eval(max_string);
selected = eval(sprintf('handles.slider%s_value', num2str(handles.sliderXY_number, '%02i')));
if ischar(selected)
    selected = str2num(selected);
end

% reajust handle and slider if value written exceeds currents limits of slider
if selected < min
    eval([min_string,'= selected ;'])
    min = eval(min_string);
elseif selected > max
    eval([max_string,'= selected ;'])
    max = eval(max_string);
end
set(eval(sprintf('handles.slider%s_min_edit', num2str(handles.sliderXY_number, '%02i'))),'String',num2str(min));
set(eval(sprintf('handles.slider%s', num2str(handles.sliderXY_number, '%02i'))),'Min',min);
set(eval(sprintf('handles.slider%s_max_edit', num2str(handles.sliderXY_number, '%02i'))),'String',num2str(max));
set(eval(sprintf('handles.slider%s', num2str(handles.sliderXY_number, '%02i'))),'Max',max);


set(eval(sprintf('handles.slider%s', num2str(handles.sliderXY_number, '%02i'))),'Value',selected);
% print value
set(eval(sprintf('handles.slider%s_edit',num2str(handles.sliderXY_number, '%02i'))),...
    'String',num2str(eval(sprintf('handles.slider%s_value',num2str(handles.sliderXY_number, '%02i'))), '%.3e' ));
end
function handles = sliderXY_limits_reajust(hObject, eventdata, handles)
min = sprintf('handles.slider%s_min_value', num2str(handles.sliderXY_number, '%02i'));
max = sprintf('handles.slider%s_max_value', num2str(handles.sliderXY_number, '%02i'));
selected = sprintf('handles.slider%s_value', num2str(handles.sliderXY_number, '%02i'));

% reajust handle and slider if value written exceeds currents limits of slider
aux = 0;
if eval([selected,'<', min ])
    eval([selected,'=', min ,';'])
    aux = 1;
elseif eval([selected,'>', max ])
    eval([selected,'=', max ,';'])
    aux = 1;
end
if aux
    set(eval(sprintf('handles.slider%s', num2str(handles.sliderXY_number, '%02i'))),'Value',eval([selected]));
    % print value
    set(eval(sprintf('handles.slider%s_edit',num2str(handles.sliderXY_number, '%02i'))),...
        'String',num2str(eval(sprintf('handles.slider%s_value',num2str(handles.sliderXY_number, '%02i'))), '%.3e' ));
end
end
function handles = sliderXY_min_edit_Callback(hObject, eventdata, handles)
handles.sliderXY_number = str2num(get(hObject,'Tag'));

min = sprintf('handles.slider%s_min_value', num2str(handles.sliderXY_number, '%02i'));
max = sprintf('handles.slider%s_max_value', num2str(handles.sliderXY_number, '%02i'));

% read value written
aux = get(hObject , 'String');
if ~isempty(aux) && (str2num(aux) < eval([max]))
    eval([min,'= str2num(aux);'])
    % reajust handle and slider if value written exceeds currents limits of slider
    handles = sliderXY_limits_reajust(hObject, eventdata, handles);
    % change slider limit
    set(eval(sprintf('handles.slider%s', num2str(handles.sliderXY_number, '%02i'))),'Min',eval(min));
end
% print value (if inserted value is valid print it, otherwise print the one before)
set(eval(sprintf('handles.slider%s_min_edit', num2str(handles.sliderXY_number, '%02i'))),...
    'String',num2str( eval(sprintf('handles.slider%s_min_value', num2str(handles.sliderXY_number, '%02i'))), '%.3e' ));
handles = update_thecallbacks(handles);
end
function handles = sliderXY_max_edit_Callback(hObject, eventdata, handles)
handles.sliderXY_number = str2num(get(hObject,'Tag'));

min = sprintf('handles.slider%s_min_value', num2str(handles.sliderXY_number, '%02i'));
max = sprintf('handles.slider%s_max_value', num2str(handles.sliderXY_number, '%02i'));

% read value written
aux = get(hObject , 'String');
if ~isempty(aux) && str2num(aux) > eval([min])
    eval([max,'= str2num(aux);'])
    % reajust handle and slider if value written exceeds currents limits of slider
    handles = sliderXY_limits_reajust(hObject, eventdata, handles);
    % change slider limit
    set(eval(sprintf('handles.slider%s', num2str(handles.sliderXY_number, '%02i'))),'Max',eval(max));
end
% print value (if inserted value is valid print it, otherwise print the one before)
set(eval(sprintf('handles.slider%s_max_edit', num2str(handles.sliderXY_number, '%02i'))),...
    'String',num2str( eval(sprintf('handles.slider%s_max_value', num2str(handles.sliderXY_number, '%02i'))), '%.3e' ));
handles = update_thecallbacks(handles);
end
% ************ sliderXY button Callback ************
function handles = sliderXY_block_radiobutton_Callback(hObject, eventdata, handles)
if ~isempty(get(hObject))
    handles.sliderXY_number = str2num(get(hObject,'Tag'));
end

if get(eval(sprintf('handles.slider%s_block_radiobutton',num2str(handles.sliderXY_number, '%02i'))),'value')
    set(eval(sprintf('handles.slider%s_workspace_radiobutton',num2str(handles.sliderXY_number, '%02i'))),'value',0);
    set( findall(eval(sprintf('handles.slider%s_block_uipanel',num2str(handles.sliderXY_number, '%02i'))), '-property', 'Enable'), 'Enable', 'on');
    set( findall(eval(sprintf('handles.slider%s_workspace_uipanel',num2str(handles.sliderXY_number, '%02i'))), '-property', 'Enable'), 'Enable', 'off');
else
    set(eval(sprintf('handles.slider%s_workspace_radiobutton',num2str(handles.sliderXY_number, '%02i'))),'value',1);
    set( findall(eval(sprintf('handles.slider%s_block_uipanel',num2str(handles.sliderXY_number, '%02i'))), '-property', 'Enable'), 'Enable', 'off');
    set( findall(eval(sprintf('handles.slider%s_workspace_uipanel',num2str(handles.sliderXY_number, '%02i'))), '-property', 'Enable'), 'Enable', 'on');
end
set(eval(sprintf('handles.slider%s_block_radiobutton',num2str(handles.sliderXY_number, '%02i'))),'Enable', 'on');
set(eval(sprintf('handles.slider%s_workspace_radiobutton',num2str(handles.sliderXY_number, '%02i'))),'Enable', 'on');
end
function handles = sliderXY_workspace_radiobutton_Callback(hObject, eventdata, handles)
handles.sliderXY_number = str2num(get(hObject,'Tag'));

if get(eval(sprintf('handles.slider%s_workspace_radiobutton',num2str(handles.sliderXY_number, '%02i'))),'value')
    set(eval(sprintf('handles.slider%s_block_radiobutton',num2str(handles.sliderXY_number, '%02i'))),'value',0);
    set( findall(eval(sprintf('handles.slider%s_block_uipanel',num2str(handles.sliderXY_number, '%02i'))), '-property', 'Enable'), 'Enable', 'off');
    set( findall(eval(sprintf('handles.slider%s_workspace_uipanel',num2str(handles.sliderXY_number, '%02i'))), '-property', 'Enable'), 'Enable', 'on');
else
    set(eval(sprintf('handles.slider%s_block_radiobutton',num2str(handles.sliderXY_number, '%02i'))),'value',1);
    set( findall(eval(sprintf('handles.slider%s_block_uipanel',num2str(handles.sliderXY_number, '%02i'))), '-property', 'Enable'), 'Enable', 'on');
    set( findall(eval(sprintf('handles.slider%s_workspace_uipanel',num2str(handles.sliderXY_number, '%02i'))), '-property', 'Enable'), 'Enable', 'off');
end
set(eval(sprintf('handles.slider%s_block_radiobutton',num2str(handles.sliderXY_number, '%02i'))),'Enable', 'on');
set(eval(sprintf('handles.slider%s_workspace_radiobutton',num2str(handles.sliderXY_number, '%02i'))),'Enable', 'on');
end
% ************ sliderXY block Callback ************
function handles = sliderXY_block_name_popupmenu_Callback(hObject, eventdata, handles)
handles.sliderXY_number = str2num(get(hObject,'Tag'));

value = get(hObject,'Value');
set(eval(sprintf('handles.slider%s_block_name_popupmenu',num2str(handles.sliderXY_number, '%02i'))),'Value',value);

aux = handles.modelname_blocknames;
eval([sprintf('handles.slider%s_block_name',num2str(handles.sliderXY_number, '%02i')),' = char(aux(value));'])

handles = sliderXY_block_property_popupmenu_update(handles);

handles = sliderXY_block_property_string_popupmenu_check(handles);

handles = update_thecallbacks(handles);
end
function handles = sliderXY_block_property_popupmenu_update(handles)
% find all properties of a block of simulink
handles = simulink_block_properties_names(handles);

aux = handles.modelname_blockpropertiesnames;
value_arbitrary = 1;

% sliderXY_block_property_popupmenu
set(eval(sprintf('handles.slider%s_block_property_popupmenu',num2str(handles.sliderXY_number, '%02i'))), 'String', aux);
set(eval(sprintf('handles.slider%s_block_property_popupmenu',num2str(handles.sliderXY_number, '%02i'))),'Value',value_arbitrary);

eval([sprintf('handles.slider%s_block_property',num2str(handles.sliderXY_number, '%02i')),' = char(aux(value_arbitrary));'])

end
function handles = sliderXY_block_property_popupmenu_Callback(hObject, eventdata, handles)
handles.sliderXY_number = str2num(get(hObject,'Tag'));

value = get(hObject,'Value');
set(eval(sprintf('handles.slider%s_block_property_popupmenu',num2str(handles.sliderXY_number, '%02i'))),'Value',value);

aux = handles.modelname_blockpropertiesnames;

eval([sprintf('handles.slider%s_block_property',num2str(handles.sliderXY_number, '%02i')),' = char(aux(value));'])

handles = sliderXY_block_property_string_popupmenu_check(handles);

handles = update_thecallbacks(handles);
end
function handles = sliderXY_block_property_string_popupmenu_Callback(hObject, eventdata, handles)
handles.sliderXY_number = str2num(get(hObject,'Tag'));

value = get(hObject,'Value') - 1; %start counting in 0

aux = sprintf('%s/%s',...
    char(handles.modelname),...
    char(eval(char(sprintf('handles.slider%s_block_name',num2str(handles.sliderXY_number, '%02i'))))));

set_param(aux,...
    eval(char(sprintf('handles.slider%s_block_property',num2str(handles.sliderXY_number, '%02i')))) ,...
    value);

% check:
% get_param(sprintf('%s/%s',char(handles.modelname),char(handles.sliderXY_block_name)),...
%     char(handles.sliderXY_block_property))

handles = update_thecallbacks(handles);
end
function handles = sliderXY_block_property_string_popupmenu_build(handles)
aux = sprintf('uicontrol( handles.slider%s_block_uipanel,''Style'',''popupmenu'', ''String'',{''''}, ''Units'',''normalized'', ''Position'',handles.sliderXY_block_property_string_popupmenu_position, ''Tag'',''%s'')',...
    num2str(handles.sliderXY_number, '%02i') , num2str(handles.sliderXY_number, '%02i'));
eval(['handles.slider', num2str(handles.sliderXY_number, '%02i'), '_block_property_string_popupmenu =', aux ,';']);

handles = sliderXY_block_property_string_popupmenu_check(handles);
end
function handles = sliderXY_block_property_string_popupmenu_check(handles)

% block_property is a string
% do no delete next lines
% x=get_param('SimPowerSystem_gettingstarted_08/C','ObjectParameters');
% get_param('SimPowerSystem_gettingstarted_08/C','BranchType')
% aux = fieldnames(x);
% for k = 1 : length(aux)
%     aux(k)
%     eval(['x.',char(aux(k))]);
% end
% x.BranchType.BranchType

% block_property is a string
% handles.sliderXY_block_property = 'BranchType'; % comment
if eval(sprintf('get(handles.slider%s_block_radiobutton,''Value'')',num2str(handles.sliderXY_number, '%02i')));
    aux = get_param([char(handles.modelname),'/',char(eval(sprintf('handles.slider%s_block_name', num2str(handles.sliderXY_number, '%02i'))))],...
        'ObjectParameters');
    aux = eval(['aux.',char(eval(sprintf('handles.slider%s_block_property', num2str(handles.sliderXY_number, '%02i')))),'.Enum']);
    
    if ~isempty(aux)
        set( findall(eval(sprintf('handles.slider%s_sliderandlimits_uipanel', num2str(handles.sliderXY_number, '%02i'))), '-property', 'Enable'), 'Enable', 'off')
        set (handles.pushbutton_start, 'Enable', 'off')
        set (handles.pushbutton_add_sliderXY, 'Enable', 'off')
        set( eval(sprintf('handles.slider%s_block_property_string_popupmenu', num2str(handles.sliderXY_number, '%02i'))) ,'String', aux);
        set( eval(sprintf('handles.slider%s_block_property_string_popupmenu', num2str(handles.sliderXY_number, '%02i'))) ,'Visible','on');
    else
        set( findall(eval(sprintf('handles.slider%s_sliderandlimits_uipanel', num2str(handles.sliderXY_number, '%02i'))), '-property', 'Enable'), 'Enable', 'on')
        set (handles.pushbutton_start, 'Enable', 'on')
        set (handles.pushbutton_add_sliderXY, 'Enable', 'on')
        set( eval(sprintf('handles.slider%s_block_property_string_popupmenu', num2str(handles.sliderXY_number, '%02i'))) ,'Visible','off');
        
        % reajust slider and limits
        variable = get_param([char(handles.modelname),'/',char(eval(sprintf('handles.slider%s_block_name', num2str(handles.sliderXY_number, '%02i'))))],...
            char(eval(sprintf('handles.slider%s_block_property', num2str(handles.sliderXY_number, '%02i')))));
        if isempty(str2num(variable))
            % if it is empty str2num(variable), then that block property read value of a variable from workspace (which may not been already defined)
            value = evalin('base',variable);
            if isempty(value)
                % variable is NOT defined in workspace yet
                % define and input arbitrary value to variable of workspace
                value = 10;
                % assignin ('base', variable, value);
            else
                % variable is defined in workspace
                if ~isnumeric(value)
                    % variable is not a number
                    % define and input arbitrary value to variable of workspace
                    value = 10;
                    % assignin ('base', variable, value);
                end
            end
        else
            % no workspace variable, just a value assigned to that property
            value = str2num(variable);
        end
        eval(['handles.slider', num2str(handles.sliderXY_number, '%02i'), '_value = num2str(value);']);
        min = sprintf('handles.slider%s_min_value', num2str(handles.sliderXY_number, '%02i'));
        max = sprintf('handles.slider%s_max_value', num2str(handles.sliderXY_number, '%02i'));
        eval([min,'= value/10*(value>0) +  value*10*(value<0) ;'])
        eval([max,'= value*10*(value>0) +  value/10*(value<0) + 10*(value==0);'])
        
        % reajust handle and slider if value written exceeds currents limits of slider
        handles = sliderXY_value_reajust([], [], handles);
        
    end
end
end
% ************ sliderXY workspace Callback ************
function handles = sliderXY_workspace_name_edit_Callback(hObject, eventdata, handles)
handles.sliderXY_number = str2num(get(hObject,'Tag'));

aux  = get(hObject,'String');
eval(['handles.slider', num2str(handles.sliderXY_number, '%02i'), '_workspace_name = aux;']);

%check if variable (or position of array) exist in workspace 'base'
try
    % read variable from workspace
    value = evalin('base',char(aux));
    eval(['handles.slider', num2str(handles.sliderXY_number, '%02i'), '_value = num2str(value);']);
catch
    value = handles.sliderXY_value_default;
    eval(['handles.slider', num2str(handles.sliderXY_number, '%02i'), '_value = num2str(value);']);
    
    % assign('base',aux,value); is unneed cause in simulation(handles) function does it
end

% reajust slider and limits
% reajust handle and slider if value written exceeds currents limits of slider
handles = sliderXY_value_reajust([], [], handles);

handles = update_thecallbacks(handles);
end












