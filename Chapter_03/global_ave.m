function out_feature=global_ave(input_feature)
[xin,yin,zin,kin]=size(input_feature);
feature=zeros(1,1,zin,kin);
feature=sum(sum(input_feature,2),1)/(xin*yin);
out_feature=feature;
end