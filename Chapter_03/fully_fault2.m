function out_feature=fully_fault2(input_feature,weight,bias,neurons,error_matrix)
    [xin,yin,kin]=size(input_feature);
    e_test=zeros(1,neurons,kin);
    weight=repmat(weight,[1,1,kin]);
    bias=reshape(bias,1,neurons);
    bias=repmat(bias,[1,1,kin]);
        for f = 1:neurons
            error_rate=1+reshape(error_matrix(1,randi(215168,xin,yin,kin)),xin,yin,kin);
            e_test(:,f,:)=sum(input_feature.*weight(f,:,:).*error_rate,2);
            e_test(:,f,:)=e_test(:,f,:)+bias(1,f);
        end
       out_feature=e_test;
end