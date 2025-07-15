function out_feature=max_pool(In_featuremap,kernel_size)
    [xin,yin,zin,kin]=size(In_featuremap);
    poolmap_test=zeros(xin/kernel_size,yin/kernel_size,zin,kin);
        for y=1:yin/kernel_size
            for x=1:xin/kernel_size
                 b_test=In_featuremap(kernel_size*(x-1)+1:kernel_size*x,kernel_size*(y-1)+1:kernel_size*y,:,:);
                 poolmap_test(x,y,:,:)=max(max(b_test,[],1),[],2);
            end
        end
    out_feature=poolmap_test;
end