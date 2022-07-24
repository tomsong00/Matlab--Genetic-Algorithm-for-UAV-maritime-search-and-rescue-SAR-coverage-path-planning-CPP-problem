function [aaa,mean_time,zzzz,all_records]=bGA_main(runtimes,center_set,point_set,MAX_GENERATION)
zzzz=zeros(runtimes,1);
record_time=zeros(runtimes,1);
[cen_po_dis_matrix,po_dis_matrix,adj_cen_po_matrix,adj_point_matrix] = calMatrix_Function(center_set,point_set);
for kkkkk=1:runtimes
    t1=clock;
    population_size=10;
    % MAX_GENERATION=500;
    therhold1=20;
    count=0;
    Thre=200;
    every_gernation_result=zeros(MAX_GENERATION,1);
    target=2406;
    gobal_best=inf;
    therhold1=20;
    count1=0;
    count2=0;
    alp=0.9;
    length=3;
    beta=0.05;
    
    population=GenerateInitialPopulation_Function(point_set,population_size);
    
    for i=1:MAX_GENERATION
        
        [scheduling_result,population] = Scheduling(population,center_set,cen_po_dis_matrix,po_dis_matrix,adj_cen_po_matrix,adj_point_matrix);
        
        [fitness,local_best,local_worst,best_id,worst_id] =Fitness_Function (scheduling_result);
        
        
        if(local_best<gobal_best)
            gobal_best=local_best;
            gobal_best_individual=population(best_id,:);
        end
        % if(local_best>gobal_best &&count1<therhold1)
        %     count1=count1+1;
        % end
        % if(local_best>gobal_best && count1==therhold1)
        %     count1=0;
        %     population(worst_id,:)=randperm(size(point_set,1));
        %     population(best_id,:)=gobal_best_individual;
        % end
        
        population=Optimization_Function_Ga(population,point_set,alp,length,beta);
        
        every_gernation_result(i,1)=gobal_best;
        %all_records(i,kkkkk)=gobal_best;
        %     if(gobal_best>=target &&reach_time==0)
        %         t2=clock;
        %         reach_time=reach_time+1;
        %     end
        %     if(gobal_best<target && i==max_generation &&reach_time==0)
        %         t2=clock;
        %         reach_time=reach_time+1;
        %     end
        %
        %     if(reach_time==1)
        %         record_time(kkkkk,1)=etime(t2,t1);
        %     end
    end
    t2=clock;
    record_time(kkkkk,1)=etime(t2,t1);
    all_records(:,kkkkk)=every_gernation_result;
    zzzz(kkkkk,1)=gobal_best;
end
aaa=zeros(1,3);
aaa(1,1)=min(zzzz(:,:));
aaa(1,2)=mean(zzzz(:,:));
aaa(1,3)=std(zzzz(:,:));
a=sortrows(zzzz,-1);
mean_time=mean(record_time(:,:));
max_value=min(min(all_records));
[row,col]=find(max_value==all_records);
end


