function f=ofun(x)  
% objective function (minimization)
% x=9
% x0(i,j)=round(LB(j)+C*(UB(j)-LB(j)))
 of=10*(x(1)-1)^2+20*(x(2)-2)^2+30*(x(3)-3)^2;
 a=x(1);
 b=x(2);
 c=x(3);
% of=8*(x-1)^2+16*(x-2)^2+24*(x-3)^2
% constraints (all constraints must be converted into <=0 type)
% if there is no constraints then comments all c0 lines below 
c0=[] ;
c0(1)=x(1)+x(2)+x(3)-5  ;   % <=0 type constraints 
c0(2)=x(1)^2+2*x(2)-x(3) ;  % <=0 type constraints
%  c0(1)=x+x+x-5     % <=0 type constraints 
%  c0(2)=-x^2+2*x-x   % <=0 type constraints
%  c0(3)=-x^3
% defining penalty for each constraint
for i=1:length(c0)
    p=i;
    if c0(i)>0  
        q=c0(i);
        c(i)=1 ;
        r=c(i);
    else
        c(i)=0; 
        s=c(i);
    end
end
penalty=10000;
u=c;
t=sum(c);% penalty on each constraint violation
f=of+penalty*sum(c)   ; % fitness function
 end