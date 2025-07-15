clc
clear 
close all 
threshold=0.93;
row_num2_1=0;
col_num2_1=0;
row_num1_1=0;
col_num1_1=0;
skip_col_num1_1=0;
skip_col_num2_1=0;
skip_row_num1_1=0;
skip_row_num2_1=0;
load ('gtsrb.mat');
X_test=reshape(X_test,32,32,1,12630);
label_test=label_test+1;
precision=zeros(16,4);
error_matrix_main=load('error_matrix.mat').error_matrix;
error_matrix_im=error_matrix_main(:,:,4);
error_matrix_un=error_matrix_main(:,:,3);
for i=1:16
%%%%%%%%%%%%%%col1
    if(skip_col_num1_1)
        
    else
        col_num1_1=i;
        result1=inference2(X_test,col_num1_1,col_num2_1,row_num1_1,row_num2_1,error_matrix_im,error_matrix_un);
        precision1=sum(result1==label_test,'all')/length(label_test);
        precision(i,1)=precision1;
        disp(['precision1_inter=',num2str(precision1)])
        if(precision1<threshold)
                col_num1_1=col_num1_1-1;
                skip_col_num1_1=1;
        else
            
        end
    end
%%%%%%%%row1
    if(skip_row_num1_1)
        
    else
        row_num1_1=i;
            result2=inference2(X_test,col_num1_1,col_num2_1,row_num1_1,row_num2_1,error_matrix_im,error_matrix_un);
        precision2=sum(result2==label_test,'all')/length(label_test);
                precision(i,2)=precision2;
        disp(['precision2_inter=',num2str(precision2)])
        if(precision2<threshold)
                row_num1_1=row_num1_1-1;
                skip_row_num1_1=1;
        else
            
        end
    end
%%%%%%%%%%col2
    if(skip_col_num2_1)
        
    else
        col_num2_1=i;

            result3=inference2(X_test,col_num1_1,col_num2_1,row_num1_1,row_num2_1,error_matrix_im,error_matrix_un);

        precision3=sum(result3==label_test,'all')/length(label_test);
                precision(i,3)=precision3;
        disp(['precision3_inter=',num2str(precision3)])
        if(precision3<threshold)
                col_num2_1=col_num2_1-1;
                skip_col_num2_1=1;
        else
            
        end
    end
%%%%%%row2 
    if(skip_row_num2_1)
        
    else
        row_num2_1=i;

            result4=inference2(X_test,col_num1_1,col_num2_1,row_num1_1,row_num2_1,error_matrix_im,error_matrix_un);

        precision4=sum(result4==label_test,'all')/length(label_test);
                precision(i,4)=precision4;
        disp(['precision4_inter=',num2str(precision4)])
        if(precision4<threshold)
                row_num2_1=row_num2_1-1;
                skip_row_num2_1=1;
        else
            
        end
    end
   disp(['loop=',num2str(i)])
   if(precision4<threshold&&precision3<threshold&&precision2<threshold&&precision1<threshold)
       break
   else
   end
   save precision_gtsrb_1.mat row_num2_1 row_num1_1 col_num2_1 col_num1_1
end
disp(['col_num1_1=',num2str(col_num1_1)])
disp(['row_num1_1=',num2str(row_num1_1)])
disp(['col_num2_1=',num2str(col_num2_1)])
disp(['row_num2_1=',num2str(row_num2_1)])
save determine_result2_gtsrb_1.mat row_num2_1 row_num1_1 col_num2_1 col_num1_1
