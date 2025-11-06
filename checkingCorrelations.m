function [d_H_norm,d_cosine]=checkingCorrelations(activityGridStatic,activityGridTraveling,cleanStatic,cleanTraveling)

staticWeight = reshape(activityGridStatic,[size(activityGridStatic,1)*size(activityGridStatic,2) size(activityGridStatic,3)]);
staticClean = reshape(cleanStatic,[size(cleanStatic,1)*size(cleanStatic,2) size(cleanStatic,3)]);
travelingWeight = reshape(activityGridTraveling,[size(activityGridTraveling,1)*size(activityGridTraveling,2) size(activityGridTraveling,3)]);
travelingClean = reshape(cleanTraveling,[size(cleanTraveling,1)*size(cleanTraveling,2) size(cleanTraveling,3)]);


for tt=1:size(activityGridStatic,3)
    d_H_norm(1,tt) = mean(staticWeight(:,tt) ~= staticClean(:,tt)); %normalized Hamming distance
    d_cosine(1,tt) = pdist([staticWeight(:,tt)'; staticClean(:,tt)'], 'cosine'); %cosine similarity
    
    d_H_norm(2,tt) = mean(travelingWeight(:,tt) ~= travelingClean(:,tt)); %normalized Hamming distance
    d_cosine(2,tt) = pdist([travelingWeight(:,tt)'; travelingClean(:,tt)'], 'cosine'); %cosine similarity
    
end





end