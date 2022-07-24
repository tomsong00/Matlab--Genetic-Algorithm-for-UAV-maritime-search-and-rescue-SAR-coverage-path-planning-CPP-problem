function [cen_po_dis_matrix,po_dis_matrix,adj_cen_po_matrix,adj_point_matrix] = calMatrix_Function(center_set,point_set)
%计算搜救中心到目标点距离，点之间距离，中心到点邻接矩阵，点到点邻接
%   此处显示详细说明
center_size=size(center_set,1);
point_size=size(point_set,1);
cen_po_dis_matrix=zeros(center_size,point_size);
po_dis_matrix=zeros(point_size,point_size);
adj_point_matrix=zeros(point_size,8);
big_integer=100000;
adj_cen_po_matrix=zeros(center_size,point_size);
for i=1:center_size
    for j=1:point_size
        x_square=(center_set(i,2)-point_set(j,2))^2;
        y_square=(center_set(i,3)-point_set(j,3))^2;
        distance_square=x_square+y_square;
        cen_po_dis_matrix(i,j)=sqrt(distance_square);
    end
    
end
for i=1:center_size
    A=cen_po_dis_matrix(i,:);
    [temp,index]=sort(A);%排序后变成100行1列向量    
    %index=[m,n];%前 8 个最小项在矩阵A中的位置[行,列]
    adj_cen_po_matrix(i,:)=index;
end

for i=1:point_size
    for j=1:point_size
        if i~=j
            x_square=(point_set(i,2)-point_set(j,2))^2;
            y_square=(point_set(i,3)-point_set(j,3))^2;
            distance_square=x_square+y_square;
            po_dis_matrix(i,j)=sqrt(distance_square);
        end
        if i==j
            distance_square=big_integer;
            po_dis_matrix(i,j)=distance_square;
        end
        
    end
end
for i=1:point_size
    A=po_dis_matrix(i,:);
    [temp,index]=sort(A);%排序后变成100行1列向量
    %[~,n]=find(A<=temp(1,9),8);%在A矩阵找到小于t(20)的20个数
    %index=[m,n];%前 8 个最小项在矩阵A中的位置[行,列]
    adj_point_matrix(i,:)=index(1,1:8);
end
end


