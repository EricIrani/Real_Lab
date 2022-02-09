#US interpolator Eric Irani
clc, close, clearvars
pkg load io

%ultrasound data location
b = 'C:\Octave\Eric Project\Ultrasound\Experiment 7(participant 1)\K110_P40_L_3\K110_P40_L_3.xlsx';
%us filename/foldername/sheetname
a = 'K110_P40_L_';
%moco data
d = 'C:\Octave\Eric Project\IK\trial7-p1\K110_P40_L_3.xlsx';

%file for selected moco data
%prod = 'C:\Octave\Eric Project\3DUS_TRC\T3_50_L11_goodmoco.xlsx';
i = '1';
F_fnames= strjoin({a,i,'_goodmoco.mot'},'');
Datafolder='C:\Octave\Eric Project\MOCO\reduced fps moco\participant1_insertiontest2';
Dataheadermotion = 'time\tpelvis_tilt\tpelvis_list\tpelvis_rotation\tpelvis_tx\tpelvis_ty\tpelvis_tz\thip_flexion_r\thip_adduction_r\thip_rotation_r\tknee_angle_r\tankle_angle_r\tsubtalar_angle_r\tmtp_angle_r\thip_flexion_l\thip_adduction_l\thip_rotation_l\tknee_angle_l\tankle_angle_l\tsubtalar_angle_l\tmtp_angle_l\tlumbar_extension\tlumbar_bending\tlumbar_rotation\tUS_rx\tUS_ry\tUS_rz\tUS_tx\tUS_ty\tUS_tz\tCLine_rx\tCLine_ry\tCLine_rz\tCLine_tx\tCLine_ty\tCLine_tz';
numberofframesUS = 12;
fpsUS = 8;     
numberofframesMOCO = 1619;
fpsMOCO = 100;
  
for i = 1:3
  gmoco = zeros(numberofframesUS,35);
  #timestamps
  us(:,1) = xlsread(b,'Sheet1','B2:B13');
  #centroid data
  us(:,2:3) = xlsread(b,'Sheet1','D2:E13');
  #us(:,2:3) = us(:,2:3);
  #timestamps and position data, make sure that the columns encompass all of the markers used
  moco = xlsread(d,r,'A12:AI1631');
  gmoco(:,36) = us(:,3)/1000;
  gmoco(:,34) = us(:,2)/1000;
  gmoco(:,1)  = us(:,1);
  for k = 2:30 #2nd number based off # of markers and results desired in final mot
     gmoco(:,k) = interp1(moco(:,1),moco(:,k),us(:,1));
  endfor
  #gmoco = xlsread(b,'Sheet1','A12:AJ24');  commented bc gmoco based of interpolated and actual timestams matching that in US, not just based on certain cells in excel file
  ## rstatus = xlswrite (prod, gmoco)
  delimiterIn='\t';
  ##F_fnames=append(Subjectname,char(filename),'_Motion.mot');
  Title='\nversion=1\nnRows=%d\nnColumns=%d\ninDegrees=yes\nendheader\n';
  MDatadata=gmoco;
  [r,c] = size(gmoco);
  Titledata = [r,c];
  makefile(Datafolder,F_fnames,Title,Titledata,Dataheadermotion,MDatadata,5,delimiterIn);
endfor
