function out_feature=batch_fault2_normal(input_feature,mean,var,scale,offset,...
                     error_matrix_im,error_matrix_un,col_num1,col_num2,row_num1,row_num2)
    division=(1./sqrt(var+0.00001));
    multi=division.*scale;
    [xin,yin,~,kin]=size(input_feature);
    multi=repmat(multi,[1,1,1,kin]);
    mean=repmat(mean,[1,1,1,kin]);
    offset=repmat(offset,[1,1,1,kin]);
        in=(input_feature(:,:,:,:)-mean);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        y_un=1:col_num1;
        x_un=1:xin;
        error_rate_un=1+reshape(error_matrix_un(1,randi(215168,size(in(x_un,y_un,:,:)))),size(in(x_un,y_un,:,:)));
        out_feature(x_un,y_un,:,:)=in(x_un,y_un,:,:).*multi.*error_rate_un+offset; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       y_un =col_num1+1:yin;
       x_un =1:row_num1;
        error_rate_un=1+reshape(error_matrix_un(1,randi(215168,size(in(x_un,y_un,:,:)))),size(in(x_un,y_un,:,:)));
        out_feature(x_un,y_un,:,:)=in(x_un,y_un,:,:).*multi.*error_rate_un+offset; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       y_un =yin-col_num2+1:yin;
       x_un =row_num1+1: xin;
        error_rate_un=1+reshape(error_matrix_un(1,randi(215168,size(in(x_un,y_un,:,:)))),size(in(x_un,y_un,:,:)));
        out_feature(x_un,y_un,:,:)=in(x_un,y_un,:,:).*multi.*error_rate_un+offset; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       y_un =col_num1+1:yin-col_num2;
       x_un =xin-row_num2+1: xin;
        error_rate_un=1+reshape(error_matrix_un(1,randi(215168,size(in(x_un,y_un,:,:)))),size(in(x_un,y_un,:,:)));
        out_feature(x_un,y_un,:,:)=in(x_un,y_un,:,:).*multi.*error_rate_un+offset; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       y_im=col_num1+1:yin-col_num2;
       x_im=row_num1+1:xin-row_num2;
       error_rate_im=1+reshape(error_matrix_im(1,randi(215168,size(in(x_im,y_im,:,:)))),size(in(x_im,y_im,:,:)));
       out_feature(x_im,y_im,:,:)=in(x_im,y_im,:,:).*multi.*error_rate_im+offset; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end