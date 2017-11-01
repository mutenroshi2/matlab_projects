%% Init
clc;
clear all;
close all;
dir = pwd;
set(0,'DefaultFigureWindowStyle','normal');

%% Read image and preprocess
imfile = 'eqn6.png';
exts = {'.png'; '.jpg'};
filename = [strrep(dir, '\src', '\images\') imfile];
I_orig = rgb2gray(imread(filename));
I = imresize(I_orig, (5e4 / numel(I_orig)));
% I = imrotate(I, 90);
thresh = 0.4 * graythresh(I);
eqnBW = not(im2bw(I, thresh));
ocrResults = ocr(not(eqnBW));
if (isempty(ocrResults.Text) || all(isspace(ocrResults.Text)))
    I = medfilt2(I, [10 10]);
    figure, subplot 221, imshow(I), title('Filtered Image');
    bg = imdilate(I, strel('disk', 20));
    bg = medfilt2(bg, [10 10]);
    subplot 222, imshow(bg), title('Background');
    eqnIm = imabsdiff(I, bg);
    subplot 223, imshow(eqnIm), title('Absolute Difference');
    eqnBW = im2bw(eqnIm, graythresh(eqnIm));
    eqnBW = imdilate(eqnBW, strel('disk', 7));
    eqnBW = imclearborder(imclose(eqnBW, strel('disk', 5)));
    subplot 224, imshow(eqnBW), title('BW Image');
end
h1 = figure;
subplot 211;
imshow(I_orig);
title('Input Image');

%% Perform OCR and display results
ocrResults = ocr(eqnBW, 'TextLayout', 'Block')
recognizedText = [ocrResults.Text];
figure(h1);
subplot 212;
imshow(I);
rect = ImDrawBox(eqnBW, 7);
title('After OCR');

%% Parse text to create m-file
if(exist([pwd '\currEqn.m'], 'file'))
    delete([pwd '\currEqn.m']);
end
[funs_det, symbols, eqn] = textparse(recognizedText);
xlabel(['Recognized Text: ' recognizedText 'Parsed Text: ' eqn]);
hold off;
fnr(symbols, eqn);
while ~exist('currEqn.m', 'file'); end
pause(2)
currEqn;

%% Save figures
%{-
figHandles = findobj('Type','figure');
for i = 1 : length(figHandles)
    print(figHandles(i), '-dpng', '-r600', ...
        ['..\images\' regexprep(imfile, exts, '') '_plot' num2str(i)]);
end
%}