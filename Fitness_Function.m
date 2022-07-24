function [fitness,local_best,local_worst,best_id,worst_id] =Fitness_Function (scheduling_result)
%适应度函数
sr_size=size(scheduling_result,1);
fitness=zeros(sr_size,1);

for i=1:sr_size
    time=scheduling_result{i,2};   
    fit=max(time(:,1));
    var1=std(time(:,2));
    fitness(i,1)=0.1*fit+0.9*var1;
    %fitness(i,1)=fit;
    % /sum(taskset(:,5))*100;
end
local_best=min(fitness(:,:));
local_worst=max(fitness(:,:));
[temp_best_id,~]=find(fitness(:,:)==local_best);
[temp_worst_id,~]=find(fitness(:,:)==local_worst);
best_id=temp_best_id(1,1);
worst_id=temp_worst_id(1,1);
end

