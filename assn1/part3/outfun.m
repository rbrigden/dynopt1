function stop = outfun(x,optimValues,state)
stop = false;
 
   switch state
       case 'init'
       case 'iter'
           %fprintf('hi');
           %text(x(1)+.15,x(2),num2str(optimValues.iteration));
       case 'done'
           fprintf('hi');
       otherwise
   end
end
