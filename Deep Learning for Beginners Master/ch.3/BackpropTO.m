function [W1, W2] = BackpropTO(W1, W2, X, D)
  alpha = 0.5;
  b1=0.35;
  b2=0.6;
  es1=0;
  N = 1;  
  for k = 1:N
    x = X(k, :)';
    d = D';
    
    v1 = W1*x+b1;
    y1 = Sigmoid(v1);    
    v  = W2*y1+b2;
    y  = Sigmoid(v);
    
    e     = d - y;
    delta = y.*(1-y).*e;

    e1     = W2'*delta;
    delta1 = y1.*(1-y1).*e1; 
    
    dW1 = alpha*delta1*x';
    W1  = W1 + dW1;
    
    dW2 = alpha*delta*y1';    
    W2  = W2 + dW2;
    es1 = es1 + 0.5*(d - y).^2;
    save es1 
  end
end