function varargout = gproject(varargin)
% GPROJECT MATLAB code for gproject.fig
%      GPROJECT, by itself, creates a new GPROJECT or raises the existing
%      singleton*.
%
%      H = GPROJECT returns the handle to a new GPROJECT or the handle to
%      the existing singleton*.
%
%      GPROJECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GPROJECT.M with the given input arguments.
%
%      GPROJECT('Property','Value',...) creates a new GPROJECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gproject_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gproject_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gproject

% Last Modified by GUIDE v2.5 08-Jul-2022 09:31:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gproject_OpeningFcn, ...
                   'gui_OutputFcn',  @gproject_OutputFcn, ...
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


% --- Executes just before gproject is made visible.
function gproject_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gproject (see VARARGIN)

% Choose default command line output for gproject
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gproject wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gproject_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in neg_pushbutton.
function neg_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to neg_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Im_input;
global Im_output;
L = 256;
Im_output = L-Im_input-1;
axes(handles.axes4);
imshow(Im_output);
axes(handles.axes5);
imhist(Im_output);

% --- Executes on button press in constr_pushbutton.
function constr_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to constr_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Im_input;
global Im_output;
Im_output = imadjust(Im_input,stretchlim(Im_input,[0.05 0.95]),[]);
axes(handles.axes4);
imshow(Im_output);
axes(handles.axes5);
imhist(Im_output);

% --- Executes on button press in grls_pushbutton.
function grls_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to grls_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Im_input;
global Im_output;

[m,n] = size(Im_input);

low= str2double(get(handles.low,'String'));
high= str2double(get(handles.high,'String'));
tresh= str2double(get(handles.tresh,'String'));


if get(handles.Discard,'value')
    for i = 1:m
        for j = 1:n
         if((Im_input(i,j)>=low) && (Im_input(i,j)<=high))
            Im_output(i,j) = uint8(tresh);
         else
            Im_output(i,j) = Im_input(i,j);
         end
        end
    end
else
    for i = 1:m
         for j = 1:n
          if((Im_input(i,j)>=low) && (Im_input(i,j)<=high))
            Im_output(i,j) = uint8(tresh);
          else
            Im_output(i,j) = 0;
          end
         end
    end
end 
axes(handles.axes4);
imshow(Im_output);
axes(handles.axes5);
imhist(Im_output);

% --- Executes on button press in minl_pushbutton.
function minl_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to minl_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Im_input;
global Im_output;
minf=@(x) min(x(:));
Im_output = nlfilter(Im_input,[3 3], minf);
axes(handles.axes4);
imshow(Im_output);
axes(handles.axes5);
imhist(Im_output);

% --- Executes on button press in maxfl_pushbutton.
function maxfl_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to maxfl_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Im_input;
global Im_output;
maxf=@(x) max(x(:));
Im_output = nlfilter(Im_input,[3 3],maxf);
axes(handles.axes4);
imshow(Im_output);
axes(handles.axes5);
imhist(Im_output);

% --- Executes on button press in medfl_pushbutton.
function medfl_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to medfl_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Im_input;
global Im_output;
Im_output = medfilt2(Im_input,[3 3]);
axes(handles.axes4);
imshow(Im_output);
axes(handles.axes5);
imhist(Im_output);

% --- Executes on selection change in mpo_popup.
function mpo_popup_Callback(hObject, eventdata, handles)
% hObject    handle to mpo_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns mpo_popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from mpo_popup
global Im_input;
global Im_output;
se = strel("line", 7, 7); 
val = get(hObject,'value');
if(val==2)
    Im_output = imopen(Im_input, se);
    axes(handles.axes4);
    imshow(Im_output);
    axes(handles.axes5);
    imhist(Im_output);
    
elseif(val==3)
    Im_output = imclose(Im_input, se);
    axes(handles.axes4);
    imshow(Im_output);
    axes(handles.axes5);
    imhist(Im_output);  
end

% --- Executes during object creation, after setting all properties.
function mpo_popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mpo_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in inp_img.
function inp_img_Callback(hObject, eventdata, handles)
% hObject    handle to inp_img (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Image_input;
[path,~]=imgetfile();
Image_input=imread(path);
axes(handles.axes1);
imshow(Image_input) ;



% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in clear.
function clear_Callback(hObject, eventdata, handles)
% hObject    handle to clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear;
clc;
cla;

% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;

% --- Executes on selection change in btpl_popup.
function btpl_popup_Callback(hObject, eventdata, handles)
% hObject    handle to btpl_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns btpl_popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from btpl_popup
global Im_input;
global Im_output;
val = get(hObject,'value');
switch (val)
    case 2
    Im_output = bitget(Im_input,1);
    axes(handles.axes4);
    imshow(logical(Im_output));  
    axes(handles.axes5);
    imhist(logical(Im_output));
    
    case 3
    Im_output = bitget(Im_input,2);
    axes(handles.axes4);
    imshow(logical(Im_output)); 
    axes(handles.axes5);
    imhist(logical(Im_output));
    
    case 4
    Im_output = bitget(Im_input,3);
    axes(handles.axes4);
    imshow(logical(Im_output));    
    axes(handles.axes5);
    imhist(logical(Im_output));
    
    case 5
    Im_output = bitget(Im_input,4);
    axes(handles.axes4);
    imshow(logical(Im_output)); 
    axes(handles.axes5);
    imhist(logical(Im_output));
    
    case 6
    Im_output = bitget(Im_input,5);
    axes(handles.axes4);
    imshow(logical(Im_output)); 
    axes(handles.axes5);
    imhist(logical(Im_output));
    
    case 7
    Im_output = bitget(Im_input,6);
    axes(handles.axes4);
    imshow(logical(Im_output)); 
    axes(handles.axes5);
    imhist(logical(Im_output));
    
    case 8
    Im_output = bitget(Im_input,7);
    axes(handles.axes4);
    imshow(logical(Im_output)); 
    axes(handles.axes5);
    imhist(logical(Im_output));
    
    case 9
    Im_output = bitget(Im_input,8);
    axes(handles.axes4);
    imshow(logical(Im_output)); 
    axes(handles.axes5);
    imhist(logical(Im_output));
end


% --- Executes during object creation, after setting all properties.
function btpl_popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to btpl_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in avfl_pushbutton.
function avfl_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to avfl_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Im_input;
global Im_output;
filter = fspecial('average',3);
I_Fitered_Zero = imfilter(Im_input,filter); 
Im_output = I_Fitered_Zero;
axes(handles.axes4);
imshow(Im_output);
axes(handles.axes5);
imhist(Im_output);

function tresh_Callback(hObject, eventdata, handles)
% hObject    handle to tresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tresh as text
%        str2double(get(hObject,'String')) returns contents of tresh as a double


% --- Executes during object creation, after setting all properties.
function tresh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in dback.
function dback_Callback(hObject, eventdata, handles)
% hObject    handle to dback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of dback


% --- Executes on button press in pback.
function pback_Callback(hObject, eventdata, handles)
% hObject    handle to pback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of pback


% --- Executes on button press in Discard.
function Discard_Callback(hObject, eventdata, handles)
% hObject    handle to Discard (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Discard


% --- Executes on button press in Preserve.
function Preserve_Callback(hObject, eventdata, handles)
% hObject    handle to Preserve (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Preserve


% --- Executes on button press in save_pushbutton.
function save_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to save_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Im_input;
global Im_output;
button = questdlg('Do you want to save the changes?');
if strcmp('Yes',button)
  startingFolder = userpath;
  defaultFileName = fullfile(startingFolder, ".jpg");
  [baseFileName, folder] = uiputfile(defaultFileName, 'Save As');
  if baseFileName == 0
      return;
  end
 fullFileName = fullfile(folder, baseFileName);
 imwrite(Im_output, fullFileName); 
end

function sve_Callback(hObject, eventdata, handles)
% hObject    handle to sve (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sve as text
%        str2double(get(hObject,'String')) returns contents of sve as a double


% --- Executes during object creation, after setting all properties.
function sve_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sve (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function low_Callback(hObject, eventdata, handles)
% hObject    handle to low (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of low as text
%        str2double(get(hObject,'String')) returns contents of low as a double


% --- Executes during object creation, after setting all properties.
function low_CreateFcn(hObject, eventdata, handles)
% hObject    handle to low (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function high_Callback(hObject, eventdata, handles)
% hObject    handle to high (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of high as text
%        str2double(get(hObject,'String')) returns contents of high as a double


% --- Executes during object creation, after setting all properties.
function high_CreateFcn(hObject, eventdata, handles)
% hObject    handle to high (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Image_input;
global Im_input;

if get (handles.gray_radio,'value')
    Im_input=Image_input;
    axes(handles.axes2);
    imshow(Im_input);
    axes(handles.axes3);
    imhist(Im_input);
else
    Im_input=rgb2gray(Image_input);
    
    axes(handles.axes2);
    imshow(Im_input);
    axes(handles.axes3);
    imhist(Im_input);
end
