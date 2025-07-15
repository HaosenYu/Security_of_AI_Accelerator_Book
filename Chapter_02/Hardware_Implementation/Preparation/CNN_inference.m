clc
clear
close all

load MINST.mat
%label    
label_test=zeros(1,2000);
label_test=MINST_TEST_LABEL; 
label_test=double(label_test);
X_test = reshape(MINST_TEST,[28,28,1,2000])/255;

            filename_1=strcat('mean_input.mat');
            load (filename_1)   
            
            filename_2=strcat('kernal_conv.mat');
            load (filename_2)
            
            filename_3=strcat('bias_conv.mat');
            load (filename_3)
 
            filename_4=strcat('kernal_conv2.mat');
            load (filename_4)
            
            filename_5=strcat('bias_conv2.mat');
            load (filename_5)
            
            filename_6=strcat('weight_ful.mat');
            load (filename_6)

            filename_7=strcat('bias_ful.mat');
            load (filename_7)
            
            filename_8=strcat('weight_ful2.mat');
            load (filename_8)

            filename_9=strcat('bias_ful2.mat');
            load (filename_9)
    number_test=1;
    counter_test=0;
    result=zeros(1,2000);
    max_i_test=0;
    max_a=0;
    max_a2=0;
    max_a3=0;
    max_a4=0;
    max_c1=0;
    max_c_b1=0;
    max_c2=0;
    max_c_b2=0;
    
    max_f1=0;
    max_f_b1=0;
    max_f2=0;
    max_f_b2=0; 
    
    max_act=6;
    %PARAMETER
    while(number_test<=2000)
        %initial
        featuremap_conv=zeros(24,24,3);
        poolmap_test=zeros(12,12,3);    
        featuremap_conv2=zeros(8,8,3);
        poolmap_test2=zeros(4,4,3);
        full_test1=zeros(1,30);
        full_test2=zeros(1,10);
        Y_test=zeros(1,10);
        
        %start
        i_test=X_test(:,:,:,number_test)-mean_input;
        
        if(max_i_test>max(abs(i_test),[],'all'))
            max_i_test=max_i_test;
        else
            max_i_test=max(abs(i_test),[],'all');
        end
        
        %conv1
        for k1 =1:3
            kernel=kernal_conv(:,:,:,k1);
                for m = 1:24
                    for n =1:24
                        a_test=i_test([n,n+1,n+2,n+3,n+4],[m,m+1,m+2,m+3,m+4]);
                         for ax = 1:5
                            for ay = 1:5
                                a=a_test(ay,ax)*kernel(ay,ax);
                                if(abs(a)>max_a)
                                    max_a=abs(a);
                                else
                                    max_a=max_a;
                                end
                                featuremap_conv(n,m,k1)=featuremap_conv(n,m,k1)+a;
                            end
                         end
                    end
                end
        end 
        
        if(max_c1>max(abs(featuremap_conv),[],'all'))
            max_c1=max_c1;
        else
            max_c1=max(abs(featuremap_conv),[],'all');
        end
        
        for k= 1:3
            featuremap_conv(:,:,k)=featuremap_conv(:,:,k)+bias_conv(:,:,k);
        end 
        
        if(max_c_b1>max(abs(featuremap_conv),[],'all'))
            max_c_b1=max_c_b1;
        else
            max_c_b1=max(abs(featuremap_conv),[],'all');
        end
        
        featuremap_conv=max(0, featuremap_conv);  
        featuremap_conv=min(6, featuremap_conv); 
%pool layer 
        for k1 =1:3
                for m = 1:12
                    for n = 1:12 
                        b_test=featuremap_conv([2*n-1,2*n],[2*m-1,2*m],k1);
                        poolmap_test(n,m,k1)=max(b_test,[],'all');
                    end
                end
        end   

%CONV2 
       for k =1:3
          kernal2=kernal_conv2(:,:,:,k);
            for m = 1:8
                for n =1:8
                    a_test2=poolmap_test([n,n+1,n+2,n+3,n+4],[m,m+1,m+2,m+3,m+4],:);
                    for q = 1:3
                        for ax = 1:5
                            for ay = 1:5
                                a2=a_test2(ax,ay,q)*kernal2(ax,ay,q);
                                if(abs(a2)>max_a2)
                                    max_a2=abs(a2);
                                else
                                    max_a2=max_a2;
                                end
                                featuremap_conv2(n,m,k)=featuremap_conv2(n,m,k)+a2;
                            end
                        end
                    end
                end
            end
       end

        if(max_c2>max(abs(featuremap_conv2),[],'all'))
            max_c2=max_c2;
        else
            max_c2=max(abs(featuremap_conv2),[],'all');
        end
        for k= 1:3
            featuremap_conv2(:,:,k)=featuremap_conv2(:,:,k)+bias_conv2(:,:,k);
        end
         c2=round(featuremap_conv2*2^10);       
        if(max_c_b2>max(abs(featuremap_conv2),[],'all'))
            max_c_b2=max_c_b2;
        else
            max_c_b2=max(abs(featuremap_conv2),[],'all');
        end
        
        featuremap_conv2=max(0, featuremap_conv2); 
        featuremap_conv2=min(6, featuremap_conv2); 
        
%POOL2        
        for k =1:3
            for m = 1:4
                for n = 1:4 
                     b_test2=featuremap_conv2([2*n-1,2*n],[2*m-1,2*m],k);
                     poolmap_test2(n,m,k)=max(b_test2,[],'all');
                end
            end
        end          
        in_test=reshape(poolmap_test2,1,[]);
        neuros1=0;
        for i=1:16
            neuros1=neuros1+(weight_ful(1,i)*in_test(1,i)+weight_ful(1,16+i)*in_test(1,16+i)+weight_ful(1,32+i)*in_test(1,32+i))*2^10
        end
        for f = 1:30
            for i=1:48
               full_test1(1,f)=full_test1(1,f)+in_test(1,i)*weight_ful(f,i);
               if(max_a3>abs(in_test(1,i)*weight_ful(f,i)))
                   max_a3=max_a3;
               else
                   max_a3=abs(in_test(1,i)*weight_ful(f,i));
               end
            end
               if(max_f1>max(abs(full_test1),[],'all'))
                    max_f1=max_f1;
                else
                    max_f1=max(abs(full_test1),[],'all');
                end
            full_test1(1,f)=full_test1(1,f)+bias_ful(f,1);
                if(max_f_b1>max(abs(full_test1),[],'all'))
                    max_f_b1=max_f_b1;
                else
                    max_f_b1=max(abs(full_test1),[],'all');
                end
        end
        
        full_test1=max(0,full_test1); 
        full_test1=min(6,full_test1); 
        for f = 1:10
            for i = 1:30
                full_test2(1,f)=full_test2(1,f)+full_test1(1,i)*weight_ful2(f,i);
               if(max_a4>abs(full_test1(1,i)*weight_ful2(f,i)))
                   max_a4=max_a4;
               else
                   max_a4=abs(full_test1(1,i)*weight_ful2(f,i));
               end
            end
                if(max_f2>max(abs(full_test2),[],'all'))
                    max_f2=max_f2;
                else
                    max_f2=max(abs(full_test2),[],'all');
                end
            full_test2(1,f)=full_test2(1,f)+bias_ful2(f,1);
                if(max_f_b2>max(abs(full_test2),[],'all'))
                    max_f_b2= max_f_b2;
                else
                     max_f_b2=max(abs(full_test2),[],'all');
                end
        end

        Y_test=softmax(full_test2');

        res=find(Y_test==max(Y_test));
        result(1,number_test)=res;
        res_c=label_test(1,number_test);
        if(res==res_c)
            counter_test=counter_test+1;
        else
            counter_test=counter_test;
        end
        number_test=number_test+1;
    end   
    precision=counter_test/2000; 
