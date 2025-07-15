function out_feature=depth_conv(Kernel,In_featuremap,bias,padding)
input=padarray(In_featuremap,[padding padding],0,'both');
[xin,yin,~,kin]=size(input);
[xk,yk,zk]=size(Kernel);
Kernel=reshape(Kernel,[xk,yk,zk]);
featuremap_depthwise=zeros(size(In_featuremap));
bias_1=reshape(bias,1,1,zk);
bias_1=repmat(bias_1,[1,1,1,kin]);
kernel1=repmat(Kernel,[1,1,1,kin]);
for y =1:yin-yk+1
    for x =1:xin-xk+1
        a=input(x:x+xk-1,y:y+yk-1,:,:);  
        featuremap_depthwise(x,y,:,:)=sum(sum(a.*kernel1,1),2);
    end
end
featuremap_depthwise=featuremap_depthwise+bias_1;
out_feature=featuremap_depthwise;
end