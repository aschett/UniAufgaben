{- Exercise 2.2 -}
-- 2.2.1
{-
You can add the evaluation steps as comments here:
if 5 * 8 <= 70 && 7 - 8 < 0 then 8 `div` 2 else 90
= true && true
= true
= then 8 'div' 2
= 4
-}

{-
if 7 - 8 > 0 then 8 `div` 2 else (if 7 * 7 == 49 then 0 else 49)
=  -1 > 0 == false
= (if 7 * 7 == 49 then 0 else 49)
= (7 * 7 == 49) --> true
= else 49
-}

-- 2.2.2
noe :: Integer -> Integer
noe n = if n == 2 || n == 4 || n == 6 && n <= 9  then 0 else 1


-- 2.2.3
arbitraryFun :: Integer -> Integer
arbitraryFun x = if x >= 100 then 8 else if x < 100 && (isDivisible x 7) then 19 else 17


{- Exercise 2.3 -}
-- 2.3.1
mod1 :: Integer -> Integer -> Integer
mod1 x y = x - (x `div` y) * y

isDivisible :: Integer -> Integer -> Bool
isDivisible x y = if (mod1 x y) == 0 then True else False

-- 2.3.2
stl :: Integer -> Integer
stl x = (mod1 x 100) `div`  10

-- 2.3.3
repl :: Integer -> Bool
repl x = if (stl x) /= 0 && (stl x) == (mod1(mod1 x 100) 10) then True else False
