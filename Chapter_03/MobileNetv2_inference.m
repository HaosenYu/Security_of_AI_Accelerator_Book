clc
clear 
close all 

% load Train_data_selected.mat;
load Test_data_selected1.mat;
% load Val_data_selected.mat;

load net_parameter
mean_input=repmat(mean_input,[1,1,1,7300]);
X_test=double(X_test);
result=zeros(1,7300);
     i_test=X_test;
     i_test=i_test-mean_input;
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     batch1_feature=batch_normal(i_test,mean_b1,var_b1,...
                    scale_b1,offset_b1);
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     conv1_feature=pointwise_conv(kernel_1,batch1_feature,bias_1,0); 
     batch2_feature=batch_normal(conv1_feature,mean_b2,...
                    var_b2,scale_b2,offset_b2);
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     act1_feature=clip_relu(batch2_feature,6);
     bottle1_feature=bottle_neck_mobile(act1_feature,0,1,kernel_2,kernel_3,...
         kernel_4,bias_2,bias_3,bias_4,mean_b3,var_b3,scale_b3,offset_b3,...
         mean_b4,var_b4,scale_b4,offset_b4,mean_b5,var_b5,scale_b5,offset_b5,6);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     add1_feature=bottle1_feature+act1_feature;   
     max1_feature=max_pool(add1_feature,2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     bottle2_feature=bottle_neck_mobile(max1_feature,0,1,kernel_5,kernel_6,...
         kernel_7,bias_5,bias_6,bias_7,mean_b6,var_b6,scale_b6,offset_b6,...
         mean_b7,var_b7,scale_b7,offset_b7,mean_b8,var_b8,scale_b8,offset_b8,6); 
     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
     add2_feature=bottle2_feature+max1_feature;  
     max2_feature=max_pool(add2_feature,2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     bottle3_feature=bottle_neck_mobile(max2_feature,0,1,kernel_8,kernel_9,...
         kernel_10,bias_8,bias_9,bias_10,mean_b9,var_b9,scale_b9,offset_b9,...
         mean_b10,var_b10,scale_b10,offset_b10,mean_b11,var_b11,scale_b11,...
         offset_b11,6); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     add3_feature=bottle3_feature+max2_feature;    
     max3_feature=max_pool(add3_feature,2);    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
     bottle4_feature=bottle_neck_mobile(max3_feature,0,1,kernel_11,kernel_12,...
         kernel_13,bias_11,bias_12,bias_13,mean_b12,var_b12,scale_b12,offset_b12,...
         mean_b13,var_b13,scale_b13,offset_b13,mean_b14,var_b14,scale_b14,...
         offset_b14,6); 
     
     add4_feature=bottle4_feature+max3_feature;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
     global_feature=global_ave(add4_feature);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
     global_feature1=reshape(global_feature,1,[],7300);
     full_feature=fully(global_feature1,weight_ful1,bias_ful1,10);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%      classify_feature=softmax(full_feature); 
    full_feature=reshape(full_feature,10,7300);
     [fx,fy]=find(full_feature==max(full_feature,[],1));
     result=fx;
     preciison=sum(result==label_test')/7300;


