function out_feature=batch_normal(input_feature,mean,var,scale,offset)
    division=(1./sqrt(var+0.00001));
    multi=division.*scale;
    [~,~,~,tk]=size(input_feature);
    multi=repmat(multi,[1,1,1,tk]);
    mean=repmat(mean,[1,1,1,tk]);
    offset=repmat(offset,[1,1,1,tk]);
    out_feature=(input_feature-mean).*multi+offset;
end
