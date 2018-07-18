%{
Copyright (c) 2009, Shameemraj Nadaf
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in
      the documentation and/or other materials provided with the distribution

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.

Modifications: Marios Kyriakou, KIOS Research and Innovation Centre of Excellence
 (KIOS CoE), 2013.

%}


function progressbar(handles,nload)
%     set(handles.figure1,'name',handles.str);
    set(handles.text_progress,'String',strcat(num2str(0),'%'),'FontSize',8);
    progpatch = patch(...
            'XData',            [0 0 0 0],...
            'YData',            [0 0 1 1] );
    percentdone = 0;
    set(handles.text_progress,'String',strcat(num2str(percentdone),' %'),'FontSize',8);
    set(progpatch,'FaceColor',handles.color); 

    fractiondone = (nload);
    percentdone = floor(100*fractiondone);
    if percentdone>99
        percentdone=100; fractiondone=1;
    end
    % Update progress patch
    axes(handles.axes2)
    set(progpatch,'XData',[0 fractiondone fractiondone 0]);
    set(handles.text_progress,'String',strcat(num2str(percentdone),'%'),'FontSize',8);
    
    drawnow;
    %pause(0.1)
    % Force redraw to show changes
%     drawnow
end