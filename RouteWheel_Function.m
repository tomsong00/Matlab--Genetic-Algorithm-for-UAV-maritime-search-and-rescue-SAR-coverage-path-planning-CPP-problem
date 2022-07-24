function select_id=RouteWheel_Function(fitness)
%轮盘赌选择
population_size=size(fitness,1);
fitness_process=zeros(population_size,4);
total_fitness=sum(fitness(:,1));
rand_choose=rand();
for i=1:population_size
    fitness_process(i,1)=i;
    fitness_process(i,2)=fitness(i,1);
    if(i==1)
      fitness_process(i,3)=fitness_process(i,2); 
    else
      fitness_process(i,3)=fitness_process(i,2)+fitness_process(i-1,3);
    end
    fitness_process(i,4)=fitness_process(i,3)/total_fitness;
    if(i==1)
        if(rand_choose<=fitness_process(i,4))
            select_id=1;
        end
    else
        if(rand_choose>fitness_process(i-1,4)&& rand_choose<=fitness_process(i,4))
            select_id=i;
        end
    end

end



end