function y = CNN_imageNumer_Berry_version1()
digitDatasetPath = fullfile(matlabroot,'toolbox','nnet','nndemos', ...
    'nndatasets','DigitDatasetBerry');
imds = imageDatastore(digitDatasetPath, ...
    'IncludeSubfolders',true,'LabelSource','foldernames');

%figure;
%เช็ครูปภาพตัวอย่าง
%perm = randperm(300,10);
%for i = 1:10
  %  subplot(2,5,i);
   % imshow(imds.Files{perm(i)});
%end
%นับจำนวน labelcounT
labelCount = countEachLabel(imds)

img = readimage(imds,1);
size(img)

%แสดงรูปในเห็น 240 รูป แล้วเก็บไว้ 60 รูปเพื่อทดสอบ
numTrainFiles = 40;
[imdsTrain,imdsValidation] = splitEachLabel(imds,numTrainFiles,'randomize');


%Define Network Architecture
layers = [
    imageInputLayer([150 150 3])
    
    convolution2dLayer(3,8,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,16,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,32,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    fullyConnectedLayer(6)
    softmaxLayer
    classificationLayer];

%Training Options
    options = trainingOptions('sgdm', ...
    'InitialLearnRate',0.001, ...
    'MaxEpochs',32, ...
    'Shuffle','every-epoch', ...
    'ValidationData',imdsValidation, ...
    'ValidationFrequency',30, ...
    'Verbose',false, ...
    'Plots','training-progress');
%Train Network Using Training Data
    net = trainNetwork(imdsTrain,layers,options);

    YPred = classify(net,imdsValidation)
    YValidation = imdsValidation.Labels

    accuracy = sum(YPred == YValidation)/numel(YValidation)
    yy=12;
