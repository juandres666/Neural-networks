function varargout = practica(varargin)
% PRACTICA M-file for practica.fig
%      PRACTICA, by itself, creates a new PRACTICA or raises the existing
%      singleton*.
%
%      H = PRACTICA returns the handle to a new PRACTICA or the handle to
%      the existing singleton*.
%
%      PRACTICA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PRACTICA.M with the given input arguments.
%
%      PRACTICA('Property','Value',...) creates a new PRACTICA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before practica_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to practica_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help practica

% Last Modified by GUIDE v2.5 04-Jan-2010 22:00:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @practica_OpeningFcn, ...
                   'gui_OutputFcn',  @practica_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before practica is made visible.
function practica_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to practica (see VARARGIN)

% Choose default command line output for practica
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
initialize_gui(hObject, handles, false);

% UIWAIT makes practica wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = practica_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in filtro.
function filtro_Callback(hObject, eventdata, handles)
% hObject    handle to filtro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global t Y fs r;
    e=r-Y;
axes(handles.graf_recuperada);
cla;
    if(1==get(handles.espectro,'value'));
        sfe=fft(e,512);
        ef=((0:255)/256*(fs/2));
        sfeesp=abs(sfe);
        plot(ef,sfeesp(1:256));
    else
        plot(e);
    end
grid on;

soundsc(e,fs);

% --- Executes on button press in selec_audio.
function selec_audio_Callback(hObject, eventdata, handles)
% hObject    handle to selec_audio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.selec_audio,'value',1)
set(handles.grabar,'value',0)
% Hint: get(hObject,'Value') returns toggle state of selec_audio


% --- Executes on button press in grabar.
function grabar_Callback(hObject, eventdata, handles)
% hObject    handle to grabar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.selec_audio,'value',0)
set(handles.grabar,'value',1)
% Hint: get(hObject,'Value') returns toggle state of grabar


% --- Executes on button press in aceptar_senal.
function aceptar_senal_Callback(hObject, eventdata, handles)
% hObject    handle to aceptar_senal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tam1 se fs;
[se,fs]=wavread('prueb1.wav');
se=se';
tam1=size(se)-1;
axes(handles.graf_senal);
cla;
    if(1==get(handles.espectro,'value'));
        sfse=fft(se,512);
        sef=((0:255)/256*(fs/2));
        sfseesp=abs(sfse);
        plot(sef,sfseesp(1:256));
    else
        plot(se);
    end
grid on;
soundsc(se,fs);



% --- Executes on selection change in tipo_ruido.
function tipo_ruido_Callback(hObject, eventdata, handles)
% hObject    handle to tipo_ruido (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global w tam1 fs t Y;
freq=3000;
t=(0:tam1(1,2))/fs;
  if( 1 == get(handles.tipo_ruido,'value'))
        w=sin(freq*2*pi*t); 
        load 'senoidal_Y.mat' Y;
  end
  if( 2 == get(handles.tipo_ruido,'value'))
        w=cos(freq*2*pi*t);
  end
  if( 3 == get(handles.tipo_ruido,'value'))
        w=randn(1,tam1(1,2)+1);  
  end
% Hints: contents = cellstr(get(hObject,'String')) returns tipo_ruido contents as cell array
%        contents{get(hObject,'Value')} returns selected item from tipo_ruido


% --- Executes during object creation, after setting all properties.
function tipo_ruido_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tipo_ruido (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in aceptar_ruido.
function aceptar_ruido_Callback(hObject, eventdata, handles)
% hObject    handle to aceptar_ruido (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global w fs t tam1;
t=(0:tam1(1,2))/fs;
axes(handles.graf_ruido);
cla;
    if(1==get(handles.espectro,'value'));
        sfw=fft(w,512);
        wf=((0:255)/256*(fs/2));
        sfwesp=abs(sfw);
        plot(wf,sfwesp(1:256));
    else
        plot(w);
    end
grid on;

soundsc(w,fs);

% --- Executes on button press in sumar_senal.
function sumar_senal_Callback(hObject, eventdata, handles)
% hObject    handle to sumar_senal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global se w r fs;
r=se+w;
axes(handles.graf_suma);
cla;
    if(1==get(handles.espectro,'value'));
        sfr=fft(r,512);
        rf=((0:255)/256*(fs/2));
        sfresp=abs(sfr);
        plot(rf,sfresp(1:256));
    else
        plot(r);
    end
grid on;
soundsc(r,fs);


% --- Executes on button press in entrenar.
function entrenar_Callback(hObject, eventdata, handles)
% hObject    handle to entrenar (see GCBO)
global r w se Y;
f=msgbox('Entrenando sistema.','Busy');
P=con2seq(w);                         %Hacemos en filas, no en columnas
T=con2seq(r);                   
net=newlin([-2 2],1,[0 1],0.01);       %Definimos valores max, min y 1 neurona, Error mínimo: 0.01
net.adaptParam.epoch=20;
[net,Y,E,Pf]=adapt(net,P,T);          %entrenamos a la red
Y=cell2mat(Y);
delete(f)

% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function initialize_gui(fig_handle, handles, isreset)
global w;
global fs;
global tam1;
global se;
set(handles.selec_audio,'value',1)
set(handles.grabar,'value',0)
set(handles.onda,'value',1)
set(handles.espectro,'value',0)
