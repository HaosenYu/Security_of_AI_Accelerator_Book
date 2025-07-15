function out_feature=pointwise_conv(Kernel,In_featuremap,bias,padding)
input=padarray(In_featuremap,[padding padding],0,'both');
[xin,yin,~,kin]=size(input);
[~,~,~,ck]=size(Kernel);
featuremap_point=zeros(xin,yin,ck,kin);
bias_1=reshape(bias,1,1,ck);
bias_1=repmat(bias_1,[1,1,1,kin]);
for channel=1:ck
    kernel1=Kernel(:,:,:,channel);
    kernel1=repmat(kernel1,[1,1,1,kin]);
%     for y =1: yin-yk+1
%         for x =1: xin-xk+1 
              a=input(:,:,:,:);  
              featuremap_point(:,:,channel,:)=sum(a.*kernel1,3);
%         end
%     end
end
featuremap_point=featuremap_point+bias_1;
out_feature=featuremap_point;
end