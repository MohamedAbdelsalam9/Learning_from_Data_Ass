function draw_percept(points,hypothesis, predictions, true_line, target, bad, new_h)

% points (number of points, weights) is the data points. the bias weight is LAST
% hypothesis is the hypothesis. bias term is LAST. 
% predictions(1, N) is what the hypothesis predicts for the points. 
% true_line is the true separating line. bias term is LAST
% target is the correct classifications for the points
% bad is optional; it's the misclassified point
% new_h is optional; it's the new hypothesis

   [hypx hypy] = pts_from_hypothesis(hypothesis);
   [truex truey] = pts_from_hypothesis(true_line);
   
   rightly_on = find(predictions == target & predictions == 1);
   wrongly_on = find(predictions ~= target & predictions ==1);
   rightly_off = find(predictions == target & predictions == -1);
   wrongly_off = find(predictions~= target & predictions == -1);


   hold off;
   % if we are displaying old & new hypotheses, 
   % display true line, old hypothesis, new hypothesis
   if nargin >6
      [newx newy] = pts_from_hypothesis(new_h);
      plot(hypx, hypy, 'r', truex, truey,'g',newx, newy,':b');
      legend("old hypothesis red", "true line green", "new hypothesis blue", "location", "southeast");
   else   
       % otherwise plot the hypothesis & real line
       plot(hypx, hypy, 'r', truex, truey,'g');
       legend("old hypothesis", "new hypothesis", "location", "southeast");
   end
   
   axis([-1 1 -1 1]);

   hold on;
   title("Perceptron");

   % plot the points
   scatter(points(rightly_on, 1),points(rightly_on, 2), 'g');
   hold on;
   scatter(points(rightly_off, 1),points(rightly_off, 2), 'b');
   hold on;
   scatter(points(wrongly_on, 1),points(wrongly_on, 2),15, 'r');
   hold on;
   scatter(points(wrongly_off, 1),points(wrongly_off, 2),15,  'c'); 

   % if we're displaying the selected bad point, display it
   if nargin >3
      hold on;
      scatter(bad(1), bad(2), 20, 'b');
   end
end


function [xs ys] = pts_from_hypothesis(hypothesis)
% hypothesis is a, b, c where line is ax + by + c> 0

% so y = -(a/b)x - c/b
% and x =-(b/a)y - c/a

% we need to find the the intercepts for y=-1, x=-1, y=1 and
% x = 1. Two of those points will be in the [-1,1],[-1,1] box
  

  a = hypothesis(1); 
  b = hypothesis(2);
  c= hypothesis(3); 
  xm1int = (b-c)/a;
  ym1int = (a-c)/b;
  x1int = (-b-c)/a;
  y1int = (-a-c)/b;

  xs = [-1 1 xm1int x1int];
  ys = [ym1int y1int -1 1];
  
  
end
