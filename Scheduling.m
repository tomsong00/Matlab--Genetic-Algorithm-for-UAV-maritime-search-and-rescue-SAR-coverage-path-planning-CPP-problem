function [scheduling_result,population] = Scheduling(population,center_set,cen_po_dis_matrix,po_dis_matrix,adj_cen_po_matrix,adj_point_matrix)
%解码，也就是生成方案和合法的种群，因为每一个只能走邻接的。
%   此处显示详细说明
% 首先从起点开始
population_size=size(population,1);
task_size=size(po_dis_matrix,1);
scheduling_result=cell(population_size,3);%1存结果,2存使用数量和用时,3安排任务数量
temp_single_result=zeros(task_size,4);%1无人机编号，2当前位置，3下一位置，4用时
center_number=size(center_set,1);

v=2;
MAX_TIME=100;
for i=1:population_size
    uav_number=zeros(center_number,1);
    single_result=temp_single_result;
    records=zeros(task_size,1);%记录是否已经访问
    total_time_records=zeros(center_number,2);%记录各个中心总时长，使用的uav数量
    line=0;
    %j=0;
    is_strat=false;
    while sum(records(:,1))<task_size
        temp_sum=0;
        %j=j+1;
        %出发的情况：1.第一个；2.上一个已经返回
        %         if j>task_size
        %             j=1;
        %         end
        if is_strat==false
            %uav_id=1;
            start_center=randi([1,center_number]);
            uav_number(start_center,1)=uav_number(start_center,1)+1;
            uav_id=uav_number(start_center,1);
            total_time=0;
            for k=1:task_size
                task_id=population(i,k);
                %判断是否使用
                if records(task_id,1)==0
                    %根据构造解调整种群
                    line=line+1;
                    single_result(line,1)=uav_id;
                    single_result(line,2)=center_set(start_center,1);
                    single_result(line,3)=task_id;
                    time=cen_po_dis_matrix(start_center,task_id)/v;
                    single_result(line,4)=time;
                    records(task_id,1)=1;
                    current_task=task_id;
                    total_time=total_time+time;
                    is_strat=true;
                    %j=j+1;
                    break
                end
            end
        end
        if is_strat==true
            %找离这个点最近的点
            %judge_contain=ismember(population(i,j),adj_point_matrix(current_task,:));
            for k=1:task_size
                task_id=population(i,k);
                %如果无需返回，则安排
                %                 if judge_contain==1 && records(task_id,1)==0 && (total_time+po_dis_matrix(current_task,population(i,j))/v)<=MAX_TIME
                %                     task_id=population(i,j);
                %                 else
                %                     task_id=adj_point_matrix(current_task,k);
                %                 end
                time=po_dis_matrix(current_task,task_id)/v;
                if records(task_id,1)==0 && (total_time+time)<=MAX_TIME
                    %                     if population(i,j)~=task_id
                    %                         [~,y_position]=find(population(i,:)==task_id);
                    %                         temp_task_id=population(i,y_position);
                    %                         population(i,y_position)=population(i,j);
                    %                         population(i,j)=temp_task_id;
                    %                     end
                    line=line+1;
                    single_result(line,1)=uav_id;
                    single_result(line,2)=current_task;
                    single_result(line,3)=task_id;
                    single_result(line,4)=time;
                    records(task_id,1)=1;
                    current_task=task_id;
                    total_time=total_time+time;
                    if k~=task_size
                        break;
                    end
                end
                %必须返回的情况，1.超过限制时间 2.已经安排过一遍了
                if k==task_size
                    %                     for l=1:8
                    %                         temp_sum=temp_sum+records(adj_point_matrix(current_task,l));
                    %                     end
                    %                     lastest_task_adj=adj_point_matrix(current_task,k);
                    
                    line=line+1;
                    single_result(line,1)=uav_id;
                    single_result(line,2)=current_task;
                    single_result(line,3)=center_set(start_center,1);
                    single_result(line,4)=0; %因为做搜救，返回不是重点
                    %records(task_id,1)=1;
                    current_task=center_set(start_center,1);
                    total_time=total_time+time;
                    %j=j-1;%因为返回了，就没有安排
                    total_time_records(start_center,1)=total_time;
                    is_strat=false;
                    break;
                    
                end
            end
            
        end
    end
    if sum(records(:,1))==task_size
        line=line+1;
        single_result(line,1)=uav_id;
        single_result(line,2)=current_task;
        single_result(line,3)=center_set(start_center,1);
        single_result(line,4)=0; %因为做搜救，返回不是重点
        %records(task_id,1)=1;
        current_task=center_set(start_center,1);
        total_time=total_time+time;
        %j=j-1;%因为返回了，就没有安排
        total_time_records(start_center,1)=total_time;
        %is_strat=false;
    end
    total_time_records(:,2)=uav_number;
    scheduling_result{i,1}=single_result;
    scheduling_result{i,2}=total_time_records;
    scheduling_result{i,3}=records;
end

end

