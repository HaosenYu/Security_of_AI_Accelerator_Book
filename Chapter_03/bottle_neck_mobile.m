function output_feature=bottle_neck_mobile(input_feature,padding1,padding2,...
    kernel1,kernel2,kernel3,bias1,bias2,bias3,mean1,var1,scale1,offset1,...
    mean2,var2,scale2,offset2,mean3,var3,scale3,offset3,threshold) 
    conv1_feature=pointwise_conv(kernel1,input_feature,bias1,padding1);
    batch1_feature=batch_normal(conv1_feature,mean1,var1,scale1,offset1);
    act1_feature=clip_relu(batch1_feature,threshold);
    
    conv2_feature=depth_conv(kernel2,act1_feature,bias2,padding2);
    batch2_feature=batch_normal(conv2_feature,mean2,var2,scale2,offset2);
    act2_feature=clip_relu(batch2_feature,threshold);  
    
    conv3_feature=pointwise_conv(kernel3,act2_feature,bias3,padding1);
    batch3_feature=batch_normal(conv3_feature,mean3,var3,scale3,offset3);
    output_feature=batch3_feature;
end
