square :: Integer -> Integer
square x = x * x

pow_4a :: Integer -> Integer
pow_4a x = x * x * x * x

pow_4b :: Integer -> Integer
pow_4b x = square (square x)    -- it evaluates square x to x * x and then multiplies that with himself so we have 2 multiplications

pow_16 :: Integer -> Integer
pow_16 x = pow_4b(pow_4b x)        -- same here so 4 evaluations

pow_20 :: Integer -> Integer
pow_20 x = pow_4b((pow_4b x) * x)   -- needs 5 evaluations
