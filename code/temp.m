d=1;
V=1;
sigma=1;
ratio=1

    d=d*ratio/2;
    mu= d/V;
    lambda=d^2/sigma^2;
    %QD time required to travel direct channel
    x=0:0.05:50;
    QD=pdf('InverseGaussian',x,mu,lambda);
    %QI time required to travel indirect channel
    i=1;
    for j=0:0.05:50
    QI(i)=integral(@(x)pdf('InverseGaussian',j-x,mu,lambda).*pdf('InverseGaussian',x,mu,lambda),0,50);
    i=i+1;
    end
    %conditional distrinution
    disp('Calculating conditional distribution PDI and PID')
    X=[0:1:1000];
    ind=1;
    clear Q10
    for value = -200:1:200
       count=1;
       for i=1:1001 %%checking for sum of time deviation in both path is del t
            for j=1:1001
                if (X(i)-X(j)==value)
                    Xa(count)=i;
                    Ya(count)=j;
                    count=count+1;
                end
            end
        end
        QYR(ind)=0.05*sum(QD(Xa).*QI(Ya));
        ind=ind+1;
        clear Xa
        clear Ya
    end