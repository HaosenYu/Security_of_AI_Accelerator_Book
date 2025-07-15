clc
clear 
close all
% load MINST.mat
% load mean_input.mat
% X_test = MINST_TEST/255-mean_input;
count=1;
sequence=zeros(1,2*2*5*5*5*5*2*2*2*2);
for ki=1:4
    for kj=1:4
         for i_p2=1:2
             for j_p2=1:2
                for i_c=1:5
                    for j_c=1:5
                        for i_p= 1:2
                            for j_p=1:2
                                for i=1:5
                                    for j=1:5
% %                                         sequence(1,count)=j+28*(i-1)+j_p-1+(i_p-1)*28;
% %                                         sequence(1,count)=j+28*(i-1)+((2*(j_c-1+j_p2-1)+j_p)-1)+(2*(i_c-1+i_p2-1)+i_p-1)*28;
%                                         sequence(1,count)=j+28*(i-1)+((2*(2*(j_p2-1)+j_c-1)+j_p)-1)+(2*(2*(i_p2-1)+i_c-1)+i_p-1)*28;
                                        sequence(1,count)=j+((j_p-1)+2*(j_c-1+j_p2-1+2*(kj-1)))+28*(i+((i_p-1)+2*(i_c-1+i_p2-1+2*(ki-1))-1));
                                        count=count+1;
                                    end
                                end
                            end
                        end
                    end
                end
             end
         end
    end
end
sequence_binary=dec2bin(sequence,16);
sequence_file=fopen(['D:\Working\Matlab Code\MNIST_CODE\MNIST_CNN_GDP\ligth version\binary data\','sequence.txt'],'w');
for i=1:size(sequence_binary,1)
    fprintf(sequence_file,'%s\n',sequence_binary(i,:));
end
fclose(sequence_file);
% image_file=fopen(['D:\Working\Matlab Code\MNIST_CODE\MNIST_CNN_GDP\ligth version\binary data\','image.txt'],'w');
% X_test=round(X_test*2^10);
% X_test_binary=dec2bin(X_test,16);
% for i=1:size(X_test_binary,1)
%     fprintf(image_file,'%s\n',X_test_binary(i,:));
% end
% fclose(image_file);