function varargout = GUIVer1(varargin)
% GUIVER1 MATLAB code for GUIVer1.fig
%      GUIVER1, by itself, creates a new GUIVER1 or raises the existing
%      singleton*.
%
%      H = GUIVER1 returns the handle to a new GUIVER1 or the handle to
%      the existing singleton*.
%
%      GUIVER1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIVER1.M with the given input arguments.
%
%      GUIVER1('Property','Value',...) creates a new GUIVER1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUIVer1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUIVer1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUIVer1

% Last Modified by GUIDE v2.5 15-Apr-2018 19:44:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUIVer1_OpeningFcn, ...
                   'gui_OutputFcn',  @GUIVer1_OutputFcn, ...
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


% --- Executes just before GUIVer1 is made visible.
function GUIVer1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUIVer1 (see VARARGIN)

% Choose default command line output for GUIVer1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
 
% %   
% pos_size = get(handles.figure1,'Position')
% user_response = modaldlg('Title','DISCLAIMER')
% UIWAIT makes GUIVer1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

    vid = videoinput('winvideo',1,'YUY2_640x480');
    vid.ReturnedColorspace = 'rgb';
    setappdata(0,'vid',vid)
    
    vid = getappdata(0,'vid')
    closepreview(vid)
    %close all

 % set ICON status ON
    set(handles.Browse,'Enable','on')
    
 
 % set ICON status OFF
    set(handles.Reset,'Enable','off')
    set(handles.AdjustEdge,'Enable','off')
    set(handles.SetEdge,'Enable','off')
    set(handles.Fuse,'Enable','off')
    set(handles.SelectROI,'Enable','off')
    set(handles.Preview,'Enable','off')
    set(handles.StopPreview,'Enable','off')
    set(handles.EdgeSlider,'Enable','off')
    set(handles.RotateSlider,'Enable','off')
    set(handles.ClearFuse,'Enable','off')
    set(handles.save,'Enable','off')
    
    axes(handles.axes1)
    cla reset
    
    axes(handles.axes2)
    cla reset
 
    axes(handles.axes3)
    cla reset
     selection = questdlg('The MRI MAPPING APP is an experimental and informative application that can sometimes fail to assist the surgeons during diagnosis or treatment.You also understand that it can be circumvented or defeated by other means,not yet understood by the developers.Thus you also agree and understand that the developers of this product,can in no way be held responsible for any result or outcome.The product is not intended to be a substitute for professional medical advice,diagnosis or treatment','DISCLAIMER',...
                      'OK','OK');
  switch selection,
      case 'OK'
          x = inputdlg({'Name'},...
              'Patient', [1 50;]); 
          Patient_Name = x{:};
          setappdata(0,'Patient_Name',Patient_Name)

  end
 count = 1
setappdata(0,'count',count)
set(handles.edit4,'string','Press BROWSE to select MRI image or EXIT to leave the app')

% --- Outputs from this function are returned to the command line.
function varargout = GUIVer1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in Browse.
function Browse_Callback(hObject, eventdata, handles)
% hObject    handle to Browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Set ICON Status
%set(handles.Reset,'Enable','on')
set(handles.edit4,'string','select the image,RIGHT CLICK and select CROP to crop the image or RESET to select another image ')

%
[filename,pathname]=uigetfile('*.jpg','fileselector');
 name=strcat(pathname,filename);
 Input_MRI_img = imread(name);
 fig= figure;
 imshow(Input_MRI_img);


 [Cropped_img, rect] = imcrop(Input_MRI_img);
 Resize_img = imresize(Cropped_img,[480 640]);
 Sharpen_img = imsharpen(Resize_img,'radius',2,'amount',3)
 Gray_img = rgb2gray(Sharpen_img)
 
 close(fig)
 
 axes(handles.axes1);
 imshow(Gray_img);
 
 Edge_detected_img = edge(Gray_img,'canny',0.1,'both',sqrt(50))
 
 axes(handles.axes2)
 cla reset
 axes(handles.axes3)
 cla reset
 
 imshow(Edge_detected_img)
 
 set(handles.EdgeSlider,'BackgroundColor','Blue')
 
 %set values
 setappdata(0,'Gray_img',Gray_img);
 setappdata(0,'Edge_detected_img',Edge_detected_img);
 
 %set icon status OFF
 set(handles.Browse,'Enable','off') 
 set(handles.AdjustEdge,'Enable','off') 
 set(handles.Fuse,'Enable','off')
 set(handles.SelectROI,'Enable','off')
 set(handles.Preview,'Enable','off')
 set(handles.StopPreview,'Enable','off')
 set(handles.RotateSlider,'Enable','off')
 set(handles.ClearFuse,'Enable','off')
 set(handles.save,'Enable','off')
  %set icon status ON
 set(handles.Reset,'Enable','on')
 set(handles.SetEdge,'Enable','on')
 set(handles.EdgeSlider,'Enable','on')

 
 


set(handles.edit4,'string','press SET EDGE if the edge continuity is desired or vary the EDGE VARIANCE to get desired continuity')


% --- Executes on button press in Reset.
function Reset_Callback(hObject, eventdata, handles)
% hObject    handle to Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% set ICON status ON
    set(handles.Browse,'Enable','on')
    
 
 % set ICON status OFF
    set(handles.Reset,'Enable','off')
    set(handles.AdjustEdge,'Enable','off')
    set(handles.SetEdge,'Enable','off')
    set(handles.Fuse,'Enable','off')
    set(handles.SelectROI,'Enable','off')
    set(handles.Preview,'Enable','off')
    set(handles.StopPreview,'Enable','off')
    set(handles.EdgeSlider,'Enable','off')
    set(handles.RotateSlider,'Enable','off')
    set(handles.ClearFuse,'Enable','off')
    set(handles.save,'Enable','off')
    StopFuse = getappdata(0,'StopFuse')
    StopFuse = 0
    setappdata(0,'StopFuse',StopFuse);
  
    StopClearFuse = getappdata(0,'StopClearFuse')
    StopClearFuse = 0;
    setappdata(0,'StopClearFuse',StopClearFuse)
  
    StopPreview = getappdata(0,'StopPreview')
    StopPreview = 0;
    setappdata(0,'StopPreview',StopPreview)
    
    axes(handles.axes1)
    cla reset
    
    axes(handles.axes2)
    cla reset
 
    axes(handles.axes3)
    cla reset


% --- Executes on slider movement.
function RotateSlider_Callback(hObject, eventdata, handles)
% hObject    handle to RotateSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.RotateSlider,'Max',360);
set(handles.RotateSlider,'Min',0);

Edge_detected_img_1 = getappdata(0,'Edge_detected_img')

Rotation_angle = get(hObject,'Value');

Rotate_img = imrotate(Edge_detected_img_1,Rotation_angle);
Resize_img = imresize(Rotate_img,[480 640]);

%axes(handles.axes2);
%cla reset;

axes(handles.axes2);
imshow(Resize_img);

%setappdata(0,'Edge_detected_img',Resize_img)


% --- Executes during object creation, after setting all properties.
function RotateSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RotateSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function EdgeSlider_Callback(hObject, eventdata, handles)
% hObject    handle to EdgeSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of 
set(handles.edit4,'string','press the SETEDGE button if the line continuity is desired')

set(handles.EdgeSlider,'Max',500);
set(handles.EdgeSlider,'Min',1);

 Gray_img = getappdata(0,'Gray_img')

 axes(handles.axes2) 
 cla reset
 
 axes(handles.axes3)
 cla reset

 slider_value = get(hObject,'Value')
 sigma_value = sqrt(slider_value)

 Edge_detected_img = edge(Gray_img,'canny',0.1,'both',sigma_value)
 axes(handles.axes3)
 imshow(Edge_detected_img)
 
 setappdata(0,'Edge_detected_img',Edge_detected_img);


% --- Executes during object creation, after setting all properties.
function EdgeSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EdgeSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.31 .31 .31]);
end


% --- Executes on button press in AdjustEdge.
function AdjustEdge_Callback(hObject, eventdata, handles)
% hObject    handle to AdjustEdge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 set(handles.edit4,'string','vary the EDGE VARIANCE bar to get the desired continuity ')

  StopFuse = getappdata(0,'StopFuse')
  StopFuse = 0
  setappdata(0,'StopFuse',StopFuse);
  
  StopClearFuse = getappdata(0,'StopClearFuse')
  StopClearFuse = 0;
  setappdata(0,'StopClearFuse',StopClearFuse)
  
  StopPreview = getappdata(0,'StopPreview')
  StopPreview = 0;
  setappdata(0,'StopPreview',StopPreview)


 Edge_detected_img = getappdata(0,'Edge_detected_img')
 
 axes(handles.axes2)
 cla reset
 
 axes(handles.axes3)
 cla reset
 imshow(Edge_detected_img)

  %set icon status OFF
     set(handles.Browse,'Enable','off')
     set(handles.AdjustEdge,'Enable','off')
     set(handles.Fuse,'Enable','off')
     set(handles.SelectROI,'Enable','off')
     set(handles.Preview,'Enable','off')
     set(handles.StopPreview,'Enable','off')
     set(handles.RotateSlider,'Enable','off')
     set(handles.ClearFuse,'Enable','off')
     set(handles.save,'Enable','off')
  %set icon status ON
     set(handles.Reset,'Enable','on')
     set(handles.SetEdge,'Enable','on')
     set(handles.EdgeSlider,'Enable','on')
     
     set(handles.EdgeSlider,'BackgroundColor','Blue')


% --- Executes on button press in SetEdge.
function SetEdge_Callback(hObject, eventdata, handles)
% hObject    handle to SetEdge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 set(handles.edit4,'string','press the ADJUST EDGE if you wish to change the continuity or PREVIEW to get video input')
 
 Edge_detected_img = getappdata(0,'Edge_detected_img')
 axes(handles.axes3) 
 cla reset
 
 axes(handles.axes2)
 cla reset
 imshow(Edge_detected_img)

  %set icon status OFF
     set(handles.Browse,'Enable','off')
     set(handles.SetEdge,'Enable','off')
     set(handles.Fuse,'Enable','off')
     set(handles.ClearFuse,'Enable','off')
     set(handles.SelectROI,'Enable','off')
     set(handles.EdgeSlider,'Enable','off')
     set(handles.RotateSlider,'Enable','off')
     set(handles.StopPreview,'Enable','off')
     set(handles.save,'Enable','off')
  %set icon status ON
     set(handles.Reset,'Enable','on')
     set(handles.AdjustEdge,'Enable','on')
     set(handles.Preview,'Enable','on')
     
     set(handles.EdgeSlider,'BackgroundColor',[.9 .9 .9])


% --- Executes on button press in Fuse.
function Fuse_Callback(hObject, eventdata, handles)
% hObject    handle to Fuse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%set icon status OFF
    set(handles.edit4,'string','press the CLEAR FUSE button to clear fusion or SAVEFUSION to save the fusion or SELECT ROI')

    set(handles.Browse,'Enable','off')
     set(handles.SetEdge,'Enable','off')
     
     set(handles.Fuse,'Enable','off')
     set(handles.EdgeSlider,'Enable','off')
     set(handles.Preview,'Enable','off')
     set(handles.StopPreview,'Enable','off')
 
  %set icon status ON
     set(handles.Reset,'Enable','on')
     set(handles.AdjustEdge,'Enable','on')
     set(handles.save,'Enable','on')
     set(handles.ClearFuse,'Enable','on')
     set(handles.SelectROI,'Enable','on')
     set(handles.RotateSlider,'Enable','on')
     %set(handles.Fuse,'Enable','on')
     
  StopClearFuse = getappdata(0,'StopClearFuse')
  StopClearFuse = 0
  setappdata(0,'StopClearFuse',StopClearFuse);
  
  StopPreview = getappdata(0,'StopPreview')
  StopPreview = 0
  setappdata(0,'StopPreview',StopPreview);
  
  Edge_detected_img_1 = getappdata(0,'Edge_detected_img_fuse')
  
  h = getappdata(0,'h')
  delete(h)
  
  Edge_detected_img_2 = imresize(Edge_detected_img_1,[480 640])
  Edge_detected_img_3 = cat(3,Edge_detected_img_2,Edge_detected_img_2,Edge_detected_img_2)
  Edge_detected_img_4 = im2uint8(Edge_detected_img_3)
  
  StopFuse = 1;
  setappdata(0,'StopFuse',StopFuse)
  
  while (1)
      StopFuse = getappdata(0,'StopFuse')
      if StopFuse == 0
          break
      end
      
      vid = getappdata(0,'vid')
      Camera_input_frame = getsnapshot(vid)
      superimpose = imadd(Edge_detected_img_4,Camera_input_frame)
      axes(handles.axes3)
      imshow(superimpose)
      pause(0.1)
  end
      
    %setappdata(0,'superimpose',superimpose);  
      
      
  
%   while (1)
%       Fuse_value = get(hObject,'Value');
%      if Fuse_value == 0
%         break
%      end
%         vid = getappdata(0,'vid')
%         Camera_input_frame = getsnapshot(vid)
%         axes(handles.axes3)
%         imshow(Camera_input_frame)
%   end
  

set(handles.edit4,'string','press ROI button to get desired region or ROTATE SLIDER to rotate image')



% --- Executes on button press in SelectROI.
function SelectROI_Callback(hObject, eventdata, handles)
% hObject    handle to SelectROI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  set(handles.edit4,'string','DOUBLE CLICK ON THE SELECTED REGION')

   h = getappdata(0,'h')
   delete(h)

  set(handles.SelectROI,'Enable','off')
  set(handles.Fuse,'Enable','off')
   set(handles.save,'Enable','off')
  StopClearFuse = getappdata(0,'StopClearFuse')
  StopClearFuse = 0
  setappdata(0,'StopClearFuse',StopClearFuse);
  
  StopPreview = getappdata(0,'StopPreview')
  StopPreview = 0
  setappdata(0,'StopPreview',StopPreview);
  
  StopFuse = getappdata(0,'StopFuse')
  StopFuse = 0
  setappdata(0,'StopFuse',StopFuse);
  
  
%   Done = getappdata(0,'Done')
%   Done = 0;  
%   setappdata(0,'Done',Done)
  
  %Edge_detected_img = getappdata(0,'Edge_detected_img')
  
  axes(handles.axes2)  
  Detected__ROI_img = getimage;
  axes(handles.axes2)
  h = imrect(gca, [10 10 100 100])
  
  

  fcn = makeConstrainToRectFcn('imrect',get(gca,'XLim'),get(gca,'YLim'))
  setPositionConstraintFcn(h,fcn)
  addNewPositionCallback( h, @myFunc )
  setappdata(0,'h',h)
  wait(h)
  pos = getPosition(h)

  Crop_pos_img = imcrop(Detected__ROI_img,pos)
  Resize_img = imresize(Crop_pos_img,[480 640])
  setappdata(0,'Edge_detected_img_fuse',Resize_img)
  
  %delete(h)
  set(handles.Fuse,'Enable','on')
  set(handles.SelectROI,'Enable','on')

  
  set(handles.edit4,'string','press FUSEIMAGE to fuse the MRI and video')



% --- Executes on button press in Preview.
function Preview_Callback(hObject, eventdata, handles)
% hObject    handle to Preview (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  %set icon status OFF
  set(handles.edit4,'string','press STOPPREVIEW to stop the video or SELECT ROI to select the desired region')
  set(handles.Browse,'Enable','off')
     set(handles.SetEdge,'Enable','off')
     set(handles.EdgeSlider,'Enable','off')
     set(handles.Preview,'Enable','off') 
     set(handles.Fuse,'Enable','off')     
     set(handles.save,'Enable','off')
  %set icon status ON
     set(handles.Reset,'Enable','on')     
     set(handles.SelectROI,'Enable','on')
     set(handles.RotateSlider,'Enable','on')
     set(handles.AdjustEdge,'Enable','on')
     set(handles.StopPreview,'Enable','on')  
     
     vid = getappdata(0,'vid')
     %preview(vid)
  
  StopClearFuse = getappdata(0,'StopClearFuse')
  StopClearFuse = 0
  setappdata(0,'StopClearFuse',StopClearFuse);
  
  StopFuse = getappdata(0,'StopFuse')
  StopFuse = 0
  setappdata(0,'StopFuse',StopFuse);
  
     
  StopPreview = 1;
  setappdata(0,'StopPreview',StopPreview)
  
  while (1)
      StopPreview = getappdata(0,'StopPreview')
      if StopPreview == 0
          break
      end
      
      vid = getappdata(0,'vid')
      Camera_input_frame = getsnapshot(vid)
      axes(handles.axes3)
      imshow(Camera_input_frame)
      pause(0.1)
  end
     
     
%   while (1)
%       Start_preview = get(hObject,'Value');
%      if Start_preview == 0
%         break
%      end
%         vid = getappdata(0,'vid')
%         Camera_input_frame = getsnapshot(vid)
%         axes(handles.axes3)
%         imshow(Camera_input_frame)
%   end
  
  
  %Edge_detected_img = getappdata(0,'Edge_detected_img')
  
%   axes(handles.axes2)
%   %imshow(Edge_detected_img)
%   
%   h = imrect(gca, [10 10 100 100])
% 
%   fcn = makeConstrainToRectFcn('imrect',get(gca,'XLim'),get(gca,'YLim'))
%   setPositionConstraintFcn(h,fcn)
%   addNewPositionCallback( h, @myFunc )
  %pos = getPosition(h)



function myFunc( newRect )
    pos = newRect
    setappdata(0,'pos',pos)   
  
set(handles.edit4,'string','press SELECT ROI to get ROI or ROTATE SLIDER to rotate the desired image')

% --- Executes on button press in Exit.
function Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%   pos_size = get(handles.figure1,'Position');
%   
%   user_response = modaldlg('Title','Confirm Close');
%   switch user_response
%       case('No')
%           
%       case 'Yes'
%           
%           delete(handles.figure1)
%   end     
    user_response = questdlg('Do you wish to EXIT?','EXIT','yes','no','no');
    
    switch user_response
        case 'yes'
            delete(handles.figure1)
        case 'no'
            uiresume(handles.figure1)
%             exit = 0
    end
    


% --- Executes on button press in StopPreview.
function StopPreview_Callback(hObject, eventdata, handles)
% hObject    handle to StopPreview (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

  %set icon status OFF
  set(handles.edit4,'string','press PREVIEW to get video input or ADJUST EDGE to get desired continuity')

     set(handles.Browse,'Enable','off')
     set(handles.SetEdge,'Enable','off')
     set(handles.Fuse,'Enable','off')
     set(handles.ClearFuse,'Enable','off')
     set(handles.SelectROI,'Enable','off')
     set(handles.EdgeSlider,'Enable','off')
     set(handles.RotateSlider,'Enable','off')
     set(handles.StopPreview,'Enable','off')
     set(handles.save,'Enable','off')
  %set icon status ON
     set(handles.Reset,'Enable','on')
     set(handles.AdjustEdge,'Enable','on')
     set(handles.Preview,'Enable','on')
  
  StopFuse = getappdata(0,'StopFuse')
  StopFuse = 0
  setappdata(0,'StopFuse',StopFuse);
  
  StopClearFuse = getappdata(0,'StopClearFuse')
  StopClearFuse = 0;
  setappdata(0,'StopClearFuse',StopClearFuse)
  
  StopPreview = getappdata(0,'StopPreview')
  StopPreview = 0;
  setappdata(0,'StopPreview',StopPreview)
  
%   set(handles.Preview, 'Value', 0);
  axes(handles.axes3)
  cla reset
    vid = getappdata(0,'vid')
    closepreview(vid)
    
%   stop = getappdata(0,'stop')
%   stop = 0
%   setappdata(0,'stop',stop);
  % clear(vid);

% --- Executes on button press in ClearFuse.
function ClearFuse_Callback(hObject, eventdata, handles)
% hObject    handle to ClearFuse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 set(handles.edit4,'string','press SAVEFUSION to save the fused image or EXIT to leave the app')

  
  h = getappdata(0,'h')
  delete(h)

  %set(handles.Fuse, 'Value', 0);
  StopFuse = getappdata(0,'StopFuse')
  StopFuse = 0;
  setappdata(0,'StopFuse',StopFuse)
  
  StopPreview = getappdata(0,'StopPreview')
  StopPreview = 0;
  setappdata(0,'StopPreview',StopPreview)
  
  %set icon status OFF
     set(handles.Browse,'Enable','off')
     set(handles.SetEdge,'Enable','off')
     %set(handles.Fuse,'Enable','off')
     %set(handles.SelectROI,'Enable','off')
     set(handles.EdgeSlider,'Enable','off')
     set(handles.Fuse,'Enable','off')
     set(handles.ClearFuse,'Enable','off')
     set(handles.Preview,'Enable','off')
    % set(handles.StopPreview,'Enable','off')
     set(handles.save,'Enable','off')
  %set icon status ON
     set(handles.Reset,'Enable','on')
     set(handles.AdjustEdge,'Enable','on')
     %set(handles.Preview,'Enable','on')
     
     set(handles.StopPreview,'Enable','on') 
     set(handles.SelectROI,'Enable','on')
     set(handles.RotateSlider,'Enable','on')
     
     axes(handles.axes3)
     cla reset
%    vid = getappdata(0,'vid');
%    preview(vid)
   
   StopFuse = 1
   setappdata(0,'StopFuse',StopFuse)
   
   while (1)
        StopFuse = getappdata(0,'StopFuse')
        if StopFuse == 0
           break
        end
        vid = getappdata(0,'vid')
        Camera_input_frame = getsnapshot(vid)
        axes(handles.axes3)
        imshow(Camera_input_frame)
        pause(0.1)
  end




function Display_Callback(hObject, eventdata, handles)
% hObject    handle to Display (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Display as text
%        str2double(get(hObject,'String')) returns contents of Display as a double


% --- Executes during object creation, after setting all properties.
function Display_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Display (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
selection = questdlg('Do you want to Exit?','Close Request Function',...
                      'Yes','No','Yes');
  switch selection,
      case 'Yes',
          delete(hObject);
      case 'No'
          return
  end
delete(hObject);


% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
count = getappdata(0,'count')
Patient_Name = getappdata(0,'Patient_Name')
axes(handles.axes3)
saveImagefusion=getimage;
fname=[Patient_Name num2str(count) '.jpg']
imwrite(saveImagefusion,fname)
count=count+1
setappdata(0,'count',count)

  set(handles.edit4,'string','The fused image is saved in the folder')


function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
