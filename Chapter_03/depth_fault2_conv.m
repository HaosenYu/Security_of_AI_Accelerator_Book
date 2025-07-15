function out_feature=depth_fault2_conv(Kernel,In_featuremap,bias,padding,...
                     error_matrix_im,error_matrix_un,col_num1,col_num2,row_num1,row_num2)
input=padarray(In_featuremap,[padding padding],0,'both');
[xin,yin,~,kin]=size(input);
[xk,yk,zk]=size(Kernel);
x_out=xin-xk+1;
y_out=yin-yk+1;
featuremap_depthwise=zeros(size(In_featuremap));
bias_1=reshape(bias,1,1,zk);
bias_1=repmat(bias_1,[1,1,1,kin]);
Kernel=reshape(Kernel,[xk,yk,zk]);
kernel1=repmat(Kernel,[1,1,1,kin]);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for y_un =1:col_num1
        for x_un =1: x_out
            a_un=input(x_un:x_un+xk-1,y_un:y_un+yk-1,:,:);  
            error_rate_un=1+reshape(error_matrix_un(1,randi(215168,xk,yk,zk,kin)),xk,yk,zk,kin);
            featuremap_depthwise(x_un,y_un,:,:)=sum(sum(a_un.*kernel1.*error_rate_un,1),2);
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for y_un =col_num1+1:y_out
        for x_un =1:row_num1
            a_un=input(x_un:x_un+xk-1,y_un:y_un+yk-1,:,:);  
            error_rate_un=1+reshape(error_matrix_un(1,randi(215168,xk,yk,zk,kin)),xk,yk,zk,kin);
            featuremap_depthwise(x_un,y_un,:,:)=sum(sum(a_un.*kernel1.*error_rate_un,1),2);
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for y_un =y_out-col_num2+1:y_out
        for x_un =row_num1+1: x_out
            a_un=input(x_un:x_un+xk-1,y_un:y_un+yk-1,:,:);  
            error_rate_un=1+reshape(error_matrix_un(1,randi(215168,xk,yk,zk,kin)),xk,yk,zk,kin);
            featuremap_depthwise(x_un,y_un,:,:)=sum(sum(a_un.*kernel1.*error_rate_un,1),2);
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for y_un =col_num1+1:y_out-col_num2
        for x_un =x_out-row_num2+1: x_out
            a_un=input(x_un:x_un+xk-1,y_un:y_un+yk-1,:,:);  
            error_rate_un=1+reshape(error_matrix_un(1,randi(215168,xk,yk,zk,kin)),xk,yk,zk,kin);
            featuremap_depthwise(x_un,y_un,:,:)=sum(sum(a_un.*kernel1.*error_rate_un,1),2);
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for y_im =col_num1+1:y_out-col_num2
        for x_im =row_num1+1:x_out-row_num2
            a_im=input(x_im:x_im+xk-1,y_im:y_im+yk-1,:,:);  
            error_rate_im=1+reshape(error_matrix_im(1,randi(215168,xk,yk,zk,kin)),xk,yk,zk,kin);
            featuremap_depthwise(x_im,y_im,:,:)=sum(sum(a_im.*kernel1.*error_rate_im,1),2);
        end
    end

featuremap_depthwise=featuremap_depthwise+bias_1;
out_feature=featuremap_depthwise;
end