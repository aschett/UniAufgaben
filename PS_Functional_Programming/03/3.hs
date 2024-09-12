{- Exercise 3.1 -}
-- 3.1.1
{-
Drop as many parentheses as possible in:

  f (g (3) (h 5 7)) 10 !! (((y - 7) > (5 || x)))
-}

-- 3.1.2
{-
Drop as many parentheses as possible in:

  (1 >>= (2 >> f (x && y))) . ((y ++ True) : 'a')
-}

-- 3.1.3
{-
Drop as many parentheses as possible in:

  (3 > 2) == (3 ^ 5 < 42) >>= h && x == y
-}


{- Exercise 3.2 -}
import Prelude hiding (even, odd)

-- 3.2.1
evenNat :: Integer -> Bool
evenNat 0 = True
evenNat 1 = False
evenNat x = evenNat(x-2)


-- 3.2.2

even :: Integer -> Bool
even 0 = True
even x = if x > 0 then odd(x-1) else odd(x+1)

-- 3.2.3
odd :: Integer -> Bool
odd 0 = False
odd x = if x > 0 then even(x-1) else even(x+1)


{- Exercise 3.3 -}
-- 3.3.1

data Color = Green | Yellow | Orange | Red

severity :: Color -> Integer
severity Green = 0
severity Yellow = 1
severity Orange = 2
severity Red = 3

-- 3.3.2
data District = Reutte | Landeck | Imst | Innsbruck | InnsbruckLand | Schwaz | Kufstein | Kitzbuehel

colorOf :: District -> Color
colorOf Reutte = Yellow
colorOf Landeck = Red
colorOf Kufstein = Orange
colorOf Kitzbuehel = Yellow
colorOf Imst = Red
colorOf Innsbruck = Red
colorOf InnsbruckLand = Red
colorOf Schwaz = Red

-- 3.3.3
moreSever :: District -> District -> Bool
moreSever x y = if severity (colorOf x) > severity (colorOf y) then True else False
