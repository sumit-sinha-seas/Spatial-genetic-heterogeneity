rng('shuffle');


N = 100;
nSteps =1000; 

driv_prob=0.0001;        %probability per site

driver_types=300;      %as per 2018 cell paper, there are 299 driver genes
fitsd=0;
dimension=3;
driver_loci=300;
cellradius=100;
%sampling=10;
%driver_mut_history_entire=zeros(N*N*N,driver_loci,round(nSteps/sampling));

for nonze=1:100 

L = zeros(N,N,N);
driver=zeros(N,N,N);

numbd=zeros(nSteps,1);
numbwithout=zeros(nSteps,1);

driver_mut_history=zeros(N*N*N,driver_loci+dimension);
mutation_profile=zeros(N*N*N,driver_types+dimension);

driver_mut_history3D=zeros(N*N*N,1); 
birth_prob=ones(N,N,N);
prob_birth=0.55;
birth_prob=birth_prob*prob_birth; 
L(N/2,N/2,N/2)=1;

count=0;
for i=1:N                      
for j=1:N                       
for k=1:N                         
count=count+1;
driver_mut_history(count,1)=i; 
mutation_profile(count,1)=i;
driver_mut_history(count,2)=j;
mutation_profile(count,2)=j;
driver_mut_history(count,3)=k; 
mutation_profile(count,3)=k;

end
end
end

counter2=1;
size_tumor=zeros(nSteps,1);
t_half=0;
t_half_counter=0;
recording_frequency=0;



for counter=1:nSteps
    counter
idx = find(L);
[row,col,pag]=ind2sub(size(L),idx);
no_occupied=length(row);
no_occupied
if(no_occupied==0)
       break;
end

if(t_half_counter==0 && no_occupied>=(50000/2) )
t_half=counter;
t_half_counter=1;
end
 no_cells_zero_mut=0;
 for j=1:no_occupied
      x=row(j);
      y=col(j);
      z=pag(j);
      label=N*N*(x-1)+N*(y-1)+z;  
	no_cells_zero_mut=no_cells_zero_mut+1-(driver_mut_history(label,4)>=1);
      b_prob=rand(1,1);
      inside_loop=0;
   
      if (b_prob<birth_prob(x,y,z) && (  size(find(~L(x-1:x+1,y-1:y+1,z-1)),1)>0 ||  size(find(~L(x-1:x+1,y-1:y+1,z)),1)>0 || size(find(~L(x-1:x+1,y-1:y+1,z+1)),1)>0))
          inside_loop=1;
          count1=0;
          while count1<1
              pos_x=randi(3);
              pos_y=randi(3);
              pos_z=randi(3);
              if(~(pos_x==2 && pos_y==2 && pos_z==2) && L(x-2+pos_x,y-2+pos_y,z-2+pos_z)==0 )
                  L(x-2+pos_x,y-2+pos_y,z-2+pos_z)=1;
                  x1=x-2+pos_x;
                  y1=y-2+pos_y;
                  z1=z-2+pos_z;
                  label2=N*N*(x1-1)+N*(y1-1)+z1;                        
                   driver_mut_history(label2,4:driver_loci)=driver_mut_history(label,4:driver_loci);
                   mutation_profile(label2,4:end)=mutation_profile(label,4:end);
                   driver_mut_history3D(label2,1)=cellradius; 
                   birth_prob(x1,y1,z1)=birth_prob(x,y,z);
                   driver(x1,y1,z1)=driver(x,y,z);
                   count1=1;
                   
              end
          end
          
%           d_prob=rand(1,1);
%            if(d_prob<driv_prob)
%              driver(x,y,z)= driver(x,y,z)+1;
%               birth_prob(x,y,z)=birth_prob(x,y,z)+fitsd; 
%                alpha=find(~driver_mut_history(label,:),1);
%               driver_mut_type= randi(driver_types);
%               driver_mut_history(label,alpha)= driver_mut_type;
%            end
            for string=1:driver_types
                     d_prob=rand(1,1);
                     if(d_prob<driv_prob & mutation_profile(label,dimension+string)==0)
                         driver(x,y,z)= driver(x,y,z)+1;
                         birth_prob(x,y,z)=birth_prob(x,y,z)+fitsd; 
                         mutation_profile(label,dimension+string)=1;
                      %   alpha=find(~driver_mut_history(label,:),1);
                      %   driver_mut_type= randi(driver_types);
                         driver_mut_history(label,dimension+driver(x,y,z))= string;
                     end
            end


%             d_prob=rand(1,1);
%              if(d_prob<driv_prob)
%              driver(x1,y1,z1)= driver(x1,y1,z1)+1;
%               birth_prob(x1,y1,z1)=birth_prob(x1,y1,z1)+fitsd; 
%               alpha=find(~driver_mut_history(label2,:),1);
%              driver_mut_type= randi(driver_types);
%              driver_mut_history(label2,alpha)= driver_mut_type;
%              end

            for string=1:driver_types
                     d_prob=rand(1,1);
                     if(d_prob<driv_prob & mutation_profile(label2,dimension+string)==0)
                         driver(x1,y1,z1)= driver(x1,y1,z1)+1;
                         birth_prob(x1,y1,z1)=birth_prob(x1,y1,z1)+fitsd; 
                         mutation_profile(label2,dimension+string)=1;
                      %   alpha=find(~driver_mut_history(label,:),1);
                      %   driver_mut_type= randi(driver_types);
                         driver_mut_history(label2,dimension+driver(x1,y1,z1))= string;
                         
                     end
            end


            
            
      end
      
%       if(b_prob<birth_prob & inside_loop==0)
% %            d_prob=rand(1,1);
% %            if(d_prob<driv_prob)
% %              driver(x,y,z)= driver(x,y,z)+1;
% %               birth_prob(x,y,z)=birth_prob(x,y,z)+fitsd; 
% %                alpha=find(~driver_mut_history(label,:),1);
% %               driver_mut_type= randi(driver_types);
% %               driver_mut_history(label,alpha)= driver_mut_type;
% %            end
% 
%                for string=1:driver_types
%                              d_prob=rand(1,1);
%                              if(d_prob<driv_prob & mutation_profile(label,dimension+string)==0)
%                                 driver(x,y,z)= driver(x,y,z)+1;
%                                 birth_prob(x,y,z)=birth_prob(x,y,z)+fitsd; 
%                                 mutation_profile(label,dimension+string)=1;
%                                %   alpha=find(~driver_mut_history(label,:),1);
%                                %   driver_mut_type= randi(driver_types);
%                                 driver_mut_history(label,dimension+driver(x,y,z))= string;
%                              end
%                end
% 
%        end
      if ( b_prob>birth_prob(x,y,z))
             L(x,y,z)=0;
     
             driver_mut_history(label,4:driver_loci)=0;
             driver_mut_history3D(label,1)=0; 
             mutation_profile(label,4:end)=0;
             driver(x,y,z)=0;
             birth_prob(x,y,z)=0; 
 
         
      end
      
      
      
     
 end
 
          numbd(counter2)=size(unique(driver_mut_history(:,4)),1);
	numbwithout(counter2)=no_cells_zero_mut/no_occupied;
        counter2=counter2+1;
		[row,col]=find(L);
              no_occupied=length(row);
     
             if  no_occupied>=(50000)
                    break;
             end
             
             size_tumor(counter2)=no_occupied;
%              if(rem(counter,sampling)==0)
%                  recording_frequency=recording_frequency+1;
%                  driver_mut_history_entire(:,:,recording_frequency)=driver_mut_history;
%              end
 
%    if  no_occupied~=0   %9-6-2017
%         break;
%    end
end
idx = find(L);   %9-7-2017
[row,col,pag]=ind2sub(size(L),idx);
no_occupied=length(row);
no_occupied

if  no_occupied~=0    %9-6-2017
        break;
end
end
%j=1;
%for i=1:N*N*N
%    if(driver_mut_history3D(i,1)>0)
%        driver_mut_historyp(j,:)=driver_mut_history(i,:);
%        j=j+1;
%    end
%end

% column1=driver_mut_history(:,1);
% column2=driver_mut_history(:,2);
% column3=driver_mut_history(:,3);
% column4=driver_mut_history(:,4);
% column5=driver_mut_history(:,5);
% column6=driver_mut_history(:,6);
% column7=driver_mut_history(:,7);
% column8=driver_mut_history(:,8);
% column9=driver_mut_history(:,9);
% column10=driver_mut_history(:,10);


 save('L.mat','L');
%  save('column1.mat','column1');
%  save('column2.mat','column2');
%  save('column3.mat','column3');
%  save('column4.mat','column4');
%  save('column5.mat','column5');
%  save('column6.mat','column6');
%  save('column7.mat','column7');
%  save('column8.mat','column8');
%  save('column9.mat','column9');
%  save('column10.mat','column10');
%save('driver_mut_history_entire.mat','driver_mut_history_entire');
save('numberofdriver.mat','numbd');
save('counter2.mat','counter2');
save('size_tumor.mat','size_tumor');
save('numbwithout.mat','numbwithout');
save('t_half.mat','t_half');
save('driver.mat','driver');
%scatter3(driver_mut_history(:,1),driver_mut_history(:,2),driver_mut_history(:,3),driver_mut_history3D(:,1)+0.00001,driver_mut_history(:,4))
%colorbar
% N=1000;
% load('L.mat');
% load('driver_mut_history.mat');
% load('numberofdriver.mat');
%figure(1)
%scatter3(driver_mut_historyp(:,1),driver_mut_historyp(:,2),driver_mut_historyp(:,3),10,driver_mut_historyp(:,4))
%colorbar

%figure(2)
%for i=1:N
%for j=1:N
%    if(L(i,j,N/2)==1)
% if(L(p,q)==1&&driver_mut_history(N*(p-1)+q,3)~=0)
%M(i,j)= driver_mut_history(N*N*(i-1)+N*(j-1)+N/2,4); % 9-6-2017
%end
%elseif(L(i,j,N/2)==0)
    %elseif(L(p,q)==0||driver_mut_history(N*(p-1)+q,3)==0)
%M(i,j)=-200;
%end
%end
%end
%C=imagesc(M);
%C
%colorbar

fileID = fopen('processed_data.txt','w');

N=size(L,1);


for p=1:N
    p
    for q=1:N
        for r=1:N
            
            if(L(p,q,r)==1)
                
%                 a1=column1(N*N*(p-1)+N*(q-1)+r,1);
%                 a2=column2(N*N*(p-1)+N*(q-1)+r,1);
%                 a3=column3(N*N*(p-1)+N*(q-1)+r,1);
%                 a4=column4(N*N*(p-1)+N*(q-1)+r,1);
%                 a5=column5(N*N*(p-1)+N*(q-1)+r,1);
%                 a6=column6(N*N*(p-1)+N*(q-1)+r,1);
%                 a7=column7(N*N*(p-1)+N*(q-1)+r,1);
%                 a8=column8(N*N*(p-1)+N*(q-1)+r,1);
%                 a9=column9(N*N*(p-1)+N*(q-1)+r,1);
%                 a10=column10(N*N*(p-1)+N*(q-1)+r,1);
                
                A=driver_mut_history(N*N*(p-1)+N*(q-1)+r,:);
                
                for i=1:size(A,2)
                     fprintf(fileID,'%d ',A(i));
                end
                
                    fprintf(fileID,'\n');
              
                
              
                
                
                
            end
        end
        
        
    end
    
    
end



save('driver_mut_history.mat','driver_mut_history');

