function res = multifractal(ss)
    %tic
    %%
    % Author: Tegy J. Vadakkan
    % Date: 09/08/2009 
    % input a binary image
    % the multifractal spectra is calculated based on the ideas in the paper by
    % Posadas et al., Soil Sci. Soc. Am. J. 67:1361-1369, 2003

    %clc;
    %clear all;
    %close all;
    %%
    %indata=inputdlg({'input filename'});

    a = imread(ss);
    layers = size(a,3) - 1; % how many layers the image should have for the analysis (issue with tiff images)
    
    a = a(:,:,1:layers);
    if(layers == 3)
        a = rgb2gray(a);
    end
    
    [rows, cols] = size(a);
    %figure;imshow(a);
    npix = sum(sum(a));
    %% calculates niL which is the number of pixels in the ith box of size L 
    % ideas from boxcount.m by F. Moisy have been borrowed here
    width = rows;
    p = log(width)/log(2);
    max_boxes = power(rows,2)/power(2,2);
    nL = double(zeros(max_boxes,p));
    for g=(p-1):-1:0
                siz = 2^(p-g);
                sizm1 = siz - 1;
                index = log2(siz);
                count = 0;
                for i=1:siz:(width-siz+1)
                    for j=1:siz:(width-siz+1)
                        count = count + 1;
                        sums = sum(sum(a(i:i+sizm1,j:j+sizm1)));
                        nL(count,index) = sums;
                    end
                end
    end
    %%
    qran = 1;
    logl = zeros(p,1);

    for l=1:p
        logl(l) = log(power(2,l));
    end
    %% normalized masses
    pL = double(zeros(max_boxes,p));
    for l=1:p
        nboxes = power(rows,2)/power(power(2,l),2);
        norm = sum(nL(1:nboxes,l));
        if(norm ~= npix)
            display('error');
        end
        for i=1:nboxes
            pL(i,l) = nL(i,l)/norm;
        end
    end
    %%
    %falpha, alpha
    for l=1:p

        count = 0;
        nboxes = power(rows,2)/power(power(2,l),2);

        for q = -qran:+0.1:qran       

            %denominator of muiql
            qsum = 0.0;
            for i=1:nboxes
                if(pL(i,l) ~= 0)
                    qsum = qsum + power(pL(i,l),q);
                end
            end

            fqnum = 0.0;
            aqnum = 0.0;
            smuiqL = 0.0;
            for i=1:nboxes
                if(pL(i,l) ~= 0)
                      muiqL = power(pL(i,l),q)/qsum;
                      fqnum = fqnum + (muiqL * log(muiqL));
                      aqnum = aqnum + (muiqL * log(pL(i,l)));
                      smuiqL = smuiqL + muiqL;
                end 
            end
            if(uint8(smuiqL)~=1)
                display('error');
            end

            count = count + 1;
            fql(l,count) = fqnum;
            aql(l,count) = aqnum;
            qval(count) = q;
        end

    end
    %%
    % alpha_q
    for i=1:count
         line = polyfit(logl,aql(:,i),1);
         aq(i) = line(1);
         yfit = polyval(line,logl);
         sse = sum(power(aql(:,i)-yfit,2));
         sst = sum(power(aql(:,i)-mean(aql(:,i)),2));
         ar2(i) = 1-(sse/sst);
    end
    % f_q
    for i=1:count
         line = polyfit(logl,fql(:,i),1);
         fq(i) = line(1);
         yfit = polyval(line,logl);
         sse = sum(power(fql(:,i)-yfit,2));
         sst = sum(power(fql(:,i)-mean(fql(:,i)),2));
         fr2(i) = 1-(sse/sst);
    end
    %figure;plot(qval,aq,'r:o',qval,fq,'g:o');
    %h = legend('alpha(q)','f(q)',1); 
    %xlabel('q','FontSize',14);

    %figure;plot(aq,fq,'r:o');
    %xlabel('alpha(q)','FontSize',14);
    %ylabel('f(q)','FontSize',14);

    %line=polyfit(aq,fq,2);
    %pfit = polyval(line,aq);
    %figure;plot(aq,fq,'r:o',aq,pfit,'g:o');
    %h = legend('f(q)','Parabolic fit to f(q)',3); 
    %xlabel('alpha(q)','FontSize',14);
    res = [aq,fq];
    %toc
end