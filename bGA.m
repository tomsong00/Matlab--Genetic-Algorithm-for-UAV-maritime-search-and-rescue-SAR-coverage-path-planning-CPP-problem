clc;
clear all;
% author: Yanjie Song
%多中心，多无人机
%思路：
% 1.首先是从中心到第一个点-先做一个中心的-选最近的，无人机数量已知，速度已知
% 2.规划算法：选择一个点后，看邻接矩阵，选择最近得
% 3.约束条件：只能走邻接，服务总时长（旋转之后再做）
% 4.目标函数：最小搜索成本：时间要短/各个中心均衡
center_set=xlsread('D:\文件\博士期间\西电\论文\海上搜救\data\center.xlsx',1);
point_set=xlsread('D:\文件\博士期间\西电\论文\海上搜救\data\point.xlsx',2);
[cen_po_dis_matrix,po_dis_matrix,adj_cen_po_matrix,adj_point_matrix] = calMatrix_Function(center_set,point_set);
population_size=10;
MAX_GENERATION=500;
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


