clc
clear 
close all
load bias_conv.mat
load bias_conv2.mat
load bias_ful.mat
load bias_ful2.mat
load kernal_conv.mat
load kernal_conv2.mat
load mean_input.mat
load weight_ful.mat
load weight_ful2.mat
load MINST.mat

bias_file=fopen(['D:\Working\Matlab Code\MNIST_CODE\MNIST_CNN_GDP\ligth version\binary data\','bias_conv.txt'],'w');
bias_conv=round(bias_conv*2^10);
bias_conv_binary=dec2bin(bias_conv,16);
for i=1:size(bias_conv_binary,1)
    fprintf(bias_file,'%s\n',bias_conv_binary(i,:));
end
fclose(bias_file);

bias_file2=fopen(['D:\Working\Matlab Code\MNIST_CODE\MNIST_CNN_GDP\ligth version\binary data\','bias_conv2.txt'],'w');
bias_conv2=round(bias_conv2*2^10);
bias_conv2_binary=dec2bin(bias_conv2,16);
for i=1:size(bias_conv2_binary,1)
    fprintf(bias_file2,'%s\n',bias_conv2_binary(i,:));
end
fclose(bias_file2);

bias_file3=fopen(['D:\Working\Matlab Code\MNIST_CODE\MNIST_CNN_GDP\ligth version\binary data\','bias_ful.txt'],'w');
bias_ful=round(bias_ful*2^10);
bias_ful_binary=dec2bin(bias_ful,16);
for i=1:size(bias_ful_binary,1)
    fprintf(bias_file3,'%s\n',bias_ful_binary(i,:));
end
fclose(bias_file3);

bias_file4=fopen(['D:\Working\Matlab Code\MNIST_CODE\MNIST_CNN_GDP\ligth version\binary data\','bias_ful2.txt'],'w');
bias_ful2=round(bias_ful2*2^10);
bias_ful2_binary=dec2bin(bias_ful2,16);
for i=1:size(bias_ful2_binary,1)
    fprintf(bias_file4,'%s\n',bias_ful2_binary(i,:));
end
fclose(bias_file4);

kernel_file=fopen(['D:\Working\Matlab Code\MNIST_CODE\MNIST_CNN_GDP\ligth version\binary data\','kernel_conv.txt'],'w');
kernal_conv=round(kernal_conv*2^10);
kernel_conv_binary=dec2bin(kernal_conv,16);
for i=1:size(kernel_conv_binary,1)
    fprintf(kernel_file,'%s\n',kernel_conv_binary(i,:));
end
fclose(kernel_file);

kernel_file2=fopen(['D:\Working\Matlab Code\MNIST_CODE\MNIST_CNN_GDP\ligth version\binary data\','kernel_conv2.txt'],'w');
kernal_conv2=round(kernal_conv2*2^10);
kernel_conv2_binary=dec2bin(kernal_conv2,16);
for i=1:size(kernel_conv2_binary,1)
    fprintf(kernel_file2,'%s\n',kernel_conv2_binary(i,:));
end
fclose(kernel_file2);

weight_file=fopen(['D:\Working\Matlab Code\MNIST_CODE\MNIST_CNN_GDP\ligth version\binary data\','weight_ful.txt'],'w');
weight_ful=round(weight_ful*2^10);
weight_ful_binary=dec2bin(weight_ful,16);
for i=1:size(weight_ful_binary,1)
    fprintf(weight_file,'%s\n',weight_ful_binary(i,:));
end
fclose(weight_file);

weight_file2=fopen(['D:\Working\Matlab Code\MNIST_CODE\MNIST_CNN_GDP\ligth version\binary data\','weight_ful2.txt'],'w');
weight_ful2=round(weight_ful2*2^10);
weight_ful2_binary=dec2bin(weight_ful2,16);
for i=1:size(weight_ful2_binary,1)
    fprintf(weight_file2,'%s\n',weight_ful2_binary(i,:));
end
fclose(weight_file2);

X_test = MINST_TEST/255-mean_input;

image_file=fopen(['D:\Working\Matlab Code\MNIST_CODE\MNIST_CNN_GDP\ligth version\binary data\','image.txt'],'w');
X_test=round(X_test*2^10);
X_test_binary=dec2bin(X_test,16);
for i=1:size(X_test_binary,1)
    fprintf(image_file,'%s\n',X_test_binary(i,:));
end
fclose(image_file);

