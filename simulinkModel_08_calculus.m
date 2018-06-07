variables2load = {...
    'T_muestreo',...
    };

% get variables2load in local workspace
for k = 1 : length(variables2load)
aux = sprintf('%s = evalin(''base'', ''%s'');',char(variables2load(k)),char(variables2load(k)));
eval(aux);

% check it works:
% eval(['x =', char(variables2load(k))])
end

% time array
t = (0:T_muestreo:str2num(handles.modelname_StopTime))'; % make time array column
handles.time = t;