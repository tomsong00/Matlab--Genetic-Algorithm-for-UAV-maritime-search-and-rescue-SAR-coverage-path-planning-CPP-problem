function population = GenerateInitialPopulation_Function(taskset,population_size)
%生成初始种群
task_number=size(taskset,1);

population=zeros(population_size,task_number);
location1=0;
location2=0;
temp=0;

for i=1:(population_size)
    population(i,:)=randperm(task_number);
end
% for i=(population_size/2+1):population_size
%     population(i,:)=population((i-population_size/2),:);
%     location1=randperm(task_number,1);
%     location2=randperm(task_number,1);
%     temp=population(i,location1);
%     population(i,location1)=population(i,location2);
%     population(i,location2)=temp;
% end
end

