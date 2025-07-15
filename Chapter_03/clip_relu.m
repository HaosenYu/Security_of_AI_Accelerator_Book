function out_feature=clip_relu(input_feature,threshold)
    [x,y,z,k]=size(input_feature);
    feature=zeros(x,y,z,k);
    feature=max(0,input_feature);
    feature=min(feature,threshold);
    out_feature=feature;
end