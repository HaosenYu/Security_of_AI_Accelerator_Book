function out_feature=fully(input_feature,weight,bias,neurons)
    [~,~,kin]=size(input_feature);
    e_test=zeros(1,neurons,kin);
    weight=repmat(weight,[1,1,kin]);
    bias=repmat(bias,[1,1,kin]);
        for f = 1:neurons
            e_test(:,f,:)=sum(input_feature.*weight(f,:,:),2);
            e_test(:,f,:)=e_test(:,f,:)+bias(f,:,:);
        end
       out_feature=e_test;
end