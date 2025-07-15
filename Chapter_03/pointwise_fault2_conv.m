function out_feature=pointwise_fault2_conv(Kernel,In_featuremap,bias,padding,...
                     error_matrix_im,error_matrix_un,col_num1,col_num2,row_num1,row_num2)
input=padarray(In_featuremap,[padding padding],0,'both');
[xin,yin,~,kin]=size(input);
[xk,yk,zk,ck]=size(Kernel);
featuremap_point=zeros(xin,yin,ck,kin);
bias_1=reshape(bias,1,1,ck);
bias_1=repmat(bias_1,[1,1,1,kin]);
for channel=1:ck
    kernel1=Kernel(:,:,:,channel);
    kernel1=repmat(kernel1,[1,1,1,kin]);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          y_un =1:col_num1;
          x_un =1: xin;
          a_un=input(x_un,y_un,:,:);
          error_rate_un=1+reshape(error_matrix_un(1,randi(215168,length(x_un),length(y_un),zk,kin)),length(x_un),length(y_un),zk,kin);
          featuremap_point(x_un,y_un,channel,:)=sum(a_un.*kernel1.*error_rate_un,3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

          y_un =col_num1+1:yin;
           x_un =1:row_num1;
          a_un=input(x_un,y_un,:,:);
          error_rate_un=1+reshape(error_matrix_un(1,randi(215168,length(x_un),length(y_un),zk,kin)),length(x_un),length(y_un),zk,kin);
          featuremap_point(x_un,y_un,channel,:)=sum(a_un.*kernel1.*error_rate_un,3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
          y_un =yin-col_num2+1:yin;
          x_un =row_num1+1: xin;
          a_un=input(x_un,y_un,:,:);
          error_rate_un=1+reshape(error_matrix_un(1,randi(215168,length(x_un),length(y_un),zk,kin)),length(x_un),length(y_un),zk,kin);
          featuremap_point(x_un,y_un,channel,:)=sum(a_un.*kernel1.*error_rate_un,3);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
          y_un =col_num1+1:yin-col_num2;
          x_un =xin-row_num2+1: xin;
          a_un=input(x_un,y_un,:,:);
          error_rate_un=1+reshape(error_matrix_un(1,randi(215168,length(x_un),length(y_un),zk,kin)),length(x_un),length(y_un),zk,kin);
          featuremap_point(x_un,y_un,channel,:)=sum(a_un.*kernel1.*error_rate_un,3);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         y_im =col_num1+1:yin-col_num2;
         x_im =row_num1+1:xin-row_num2;
         a_im=input(x_im,y_im,:,:);  
         error_rate_im=1+reshape(error_matrix_im(1,randi(215168,length(x_im),length(y_im),zk,kin)),length(x_im),length(y_im),zk,kin);
         featuremap_point(x_im,y_im,channel,:)=sum(a_im.*kernel1.*error_rate_im,3);
end
featuremap_point=featuremap_point+bias_1;
out_feature=featuremap_point;
end