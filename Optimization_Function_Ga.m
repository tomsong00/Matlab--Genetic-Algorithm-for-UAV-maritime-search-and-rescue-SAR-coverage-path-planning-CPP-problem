function optimized_population=Optimization_Function_Ga(population,taskset,alp,length,beta)
%交叉和变异
population_size=size(population,1);
temp_population=[];
optimized_population=[];
location1=0;
location2=0;
temp=0;
temp_sequence=zeros(1,length);
task_number=size(taskset,1);
for i=1:population_size
    rand_number1=rand;
    rand_number2=rand;
    if rand_number1<=alp
        
        location1=randi([1,(task_number-length+1)]);
        location2=randi([1,(task_number-length+1)]);
        while (abs(location2-location1)<length)
            location1=randi([1,(task_number-length+1)]);
            location2=randi([1,(task_number-length+1)]);           
        end
        
        temp_sequence=population(i,location1:(location1+length-1));
        population(i,location1:(location1+length-1))=population(i,location2:(location2+length-1));
        population(i,location2:(location2+length-1))=temp_sequence;
    end
    if rand_number2<=beta
        location1=randi([1,task_number]);
        location2=randi([1,task_number]);
        temp=population(i,location1);
        population(i,location1)=population(i,location2);
        population(i,location2)=temp;
    end
end

optimized_population=population;
end