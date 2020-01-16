clear all;
load('X.mat');
city = X;
plot(city(:,3),city(:,2),'s','MarkerSize',5,'MarkerEdgeColor','b','MarkerFaceColor',[0,0.7,0.9]),axis equal;
cityAmount = size(city,1);
PopSize = 100;
Pc = 0.90;
Pm = 0.02;
 
for i = 1:100
    Chrom(i, :) = randperm(cityAmount);
end
 
for kk = 1:1000
    for i = 1:100
        fitness(i) = 0;
        for d = 1:cityAmount
            StartingCity = Chrom(i,d);
            DestinationCity = Chrom(i,rem(d,cityAmount)+1);
            fitness(i) = fitness(i) + sqrt((city(DestinationCity,2)-city(StartingCity,2))^2 + (city(DestinationCity,3)-city(StartingCity,3))^2);
        end
        RT(i) = sum(10000./fitness(1:i));
    end
    maxfit(kk) = max(10000./fitness);
    
    if kk==1
        QQQ=find((10000./fitness)==max(10000./fitness));
        BestChrom=Chrom(QQQ(1),:);
    else
        if maxfit(kk)>maxfit(kk-1)
            QQQ=find((10000./fitness)==max(10000./fitness));
            BestChrom=Chrom(QQQ(1),:);
        end
    end
    
    Chrom(1,:)=BestChrom;
    
    if kk>15 &&  abs(maxfit(kk)-maxfit(kk-14))<10^(-15)
        break
    end
    
    for i=1:30
        ReChrom(i,:) = BestChrom;
    end
    
    for i=31:100
        a=find(RT>=rand*sum(10000./fitness));
        ReChrom(i,:)=Chrom(a(1),:);
    end
    
    %Crossover
    CrChrom=ReChrom;
    for i=2:2:PopSize*Pc
        Crossover=randi([2 (cityAmount/2)]);
        for j = 1:Crossover
            index_s = find(CrChrom(i-1,:)==ReChrom(i,j));
            CrChrom(i-1,index_s)= CrChrom(i-1,j);
            CrChrom(i-1,j)= ReChrom(i,j);
            index_t = find(CrChrom(i,:)==ReChrom(i-1,j));
            CrChrom(i,index_t)= CrChrom(i,j);
            CrChrom(i,j)= ReChrom(i-1,j);
        end
    end
    
    %Mutation
    ChromTemp = CrChrom;
    for i=1:PopSize*Pm*cityAmount
        Mutation=randperm(cityAmount,2);
        if  (Mutation(1)>Mutation(2))
            temp_mutation = Mutation(2);
            Mutation(2) = Mutation(1);
            Mutation(1) = temp_mutation;
        end
        CrChrom(i,Mutation(1):Mutation(2)) = fliplr(ChromTemp(i,Mutation(1):Mutation(2)));
    end
    Chrom=CrChrom;
end
 
Best_Distance = 0;
for i = 1:cityAmount
    StartingCity = BestChrom(i);
    DestinationCity = BestChrom(rem(i, cityAmount) + 1);
    Best_Distance = Best_Distance + sqrt((city(DestinationCity,2)-city(StartingCity,2))^2 + (city(DestinationCity,3)-city(StartingCity,3))^2);
    ans(i,:) = city(BestChrom(i),:);
end
 
ans(i+1,:) = ans(1,:);
figure
plot(ans(:,3), ans(:,2), '--sm', 'LineWidth', 1, 'MarkerSize',5,'MarkerEdgeColor','b','MarkerFaceColor',[0,0.7,0.9]),axis equal;
title(sprintf('Best Distance = %f', Best_Distance));
            
