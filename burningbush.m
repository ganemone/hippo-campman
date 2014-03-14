IN = dlmread('depoLast.csv', ' ');
IN;

T = -0.020;

%Number of spikes.
counter = 0;

mutex = 0;

for i=1:length(IN),
   
    curVal = IN(i, 2);
    
    if curVal >= T && mutex == 0
        mutex = 1;
        counter = counter + 1;
    end
    
    if mutex == 1 && curVal < T
       mutex = 0 
    end
    
end

plot(IN);

fprintf('Number of Spikes: %f\n ', counter);
fprintf('Firing Rate: %f\n spikes/mills', counter/length(IN));
