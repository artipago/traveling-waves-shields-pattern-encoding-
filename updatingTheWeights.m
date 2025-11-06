function newWeightVector = updatingTheWeights(weightVectorTravelling,v1,v2)

thresholdSpikes = 1; %threshold to consider the active states

deltaIncrease = 0.05;
tauDecay = 0.9;

spike1 = find(v1>=thresholdSpikes);
spike2 = find(v2>=thresholdSpikes);

weightVectorTravelling = weightVectorTravelling*tauDecay;

updateWeight = zeros(size(v1,1),size(v2,1));

for ii=1:size(spike2,1)
    updateWeight(spike2(ii),spike1)=deltaIncrease;
end

% for ii=1:size(updateWeight,1)
%     updateWeight(ii,ii)=0;
% end
newWeightVector = weightVectorTravelling + updateWeight;

newWeightVector(newWeightVector<0)=0; %only positive synapses

end