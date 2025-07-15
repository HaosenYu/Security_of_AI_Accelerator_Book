clc
clear
close all
load MINST.mat 
X_train =reshape(MINST_TRAIN,[28,28,1,7000])/255;
X_val = reshape(MINST_VAL,[28,28,1,1000])/255;
X_test = reshape(MINST_TEST,[28,28,1,2000])/255;
Y_train=MINST_TRAIN_LABEL';
Y_val=MINST_VAL_LABEL';
Y_test=MINST_TEST_LABEL';
layers = [...
          imageInputLayer([28,28,1]); %1

          convolution2dLayer(5,3);%2
          
          clippedReluLayer(6); %3
          
          maxPooling2dLayer(2,'Stride',2);%4 
          
          convolution2dLayer(5,3);%5
          
          clippedReluLayer(6); %6
          
          maxPooling2dLayer(2,'Stride',2);%7 
          
          fullyConnectedLayer(30);%8
          
          clippedReluLayer(6); %9
          
          fullyConnectedLayer(10);%10  
          
          softmaxLayer(); 
          
          classificationLayer(),...
    ];
options = trainingOptions('sgdm',...                        
                          'MiniBatchSize',128, ...
                          'MaxEpochs',200,...                
                          'ValidationData',{X_val,Y_val},... 
                          'Verbose',true, ...                
                          'Shuffle','every-epoch', ...
                          'InitialLearnRate',1e-3,...
                          'Plots','training-progress');
while(1)
        net_cnn = trainNetwork(X_train,Y_train,layers,options);
        testLabel = classify(net_cnn,X_test);
        precision = sum(testLabel==Y_test)/numel(testLabel);
        disp(['Classification accuracy',num2str(precision*100),'%'])
        if(precision>=0.90)
            Layers=(net_cnn.Layers);
            
            inputlayer=Layers(1,1);
            c_1layer=Layers(2,1);
            c_2layer=Layers(5,1);
            f_1layer=Layers(8,1);
            f_2layer=Layers(10,1);
            
            mean_input=inputlayer.Mean;
            
            kernal_conv=c_1layer.Weights;
            bias_conv=c_1layer.Bias;
            
            kernal_conv2=c_2layer.Weights;
            bias_conv2=c_2layer.Bias;
            
            weight_ful=f_1layer.Weights;
            bias_ful=f_1layer.Bias;

            weight_ful2=f_2layer.Weights;
            bias_ful2=f_2layer.Bias;
            
            filename_1=strcat('mean_input.mat');
            save (filename_1, 'mean_input')
            
            filename_2=strcat('kernal_conv.mat');
            save (filename_2, 'kernal_conv')
            
            filename_3=strcat('bias_conv.mat');
            save (filename_3, 'bias_conv')

            filename_4=strcat('kernal_conv2.mat');
            save (filename_4, 'kernal_conv2')
            
            filename_5=strcat('bias_conv2.mat');
            save (filename_5, 'bias_conv2')

            filename_6=strcat('weight_ful.mat');
            save (filename_6, 'weight_ful')

            filename_7=strcat('bias_ful.mat');
            save (filename_7, 'bias_ful')
            
            filename_8=strcat('weight_ful2.mat');
            save (filename_8, 'weight_ful2')

            filename_9=strcat('bias_ful2.mat');
            save (filename_9, 'bias_ful2')
            break
        end
end
