import Prelude hiding (gcd, lcm)

{- Exercise 4.1 -}

-- 4.1.1
gcd :: Integer -> Integer -> Integer
gcd a 0 = a
gcd 0 b = b
gcd a b = if a > b then gcd (a - b) b else gcd a (b - a)

-- 4.1.2
gcd_eff :: Integer -> Integer -> Integer
gcd_eff a 0 = a
gcd_eff 0 b = b
gcd_eff a b = if a > b then gcd_eff (mod a b) b else gcd_eff a (mod b a)


-- 4.1.3
{- because modulo does the same thing as the one above just more often. it substracts until it cant substract anymore
and then gives the remainder ergo the new value that now needs to be substracted from the higher value.
if the value is already true, it returns the gcd.
just look at the example of gcd 3 1
3 - 1 1
2 - 1 1
1 - 1 1
0 1 = 1

modulo does this step just in one step
mod(3 1) 1
0 1 = 1
-}

{- Exercise 4.2 -}

-- 4.2.1
lcm :: Integer -> Integer -> Integer
lcm a b = if a == b then a else lcm_aux a b a b

lcm_aux :: Integer -> Integer -> Integer -> Integer -> Integer
lcm_aux ma mb a b =
  if ma == mb
    then lcm ma mb
    else if ma > mb
      then lcm_aux ma (mb+b) a b
      else lcm_aux (ma+a) mb a b

-- 4.2.2
lcm2 :: Integer -> Integer -> Integer
lcm2 a b
  | (mod a b) == 0 = a
  | (mod b a) == 0 = b
  | a > b = lcm2_aux (a+a) a b
  | a < b = lcm2_aux (b+b) b a

lcm2_aux :: Integer -> Integer -> Integer -> Integer
lcm2_aux m a b = if mod m b == 0 then lcm2 m b else lcm2_aux (m+a) a b

-- 4.2.3
lcm3 :: Integer -> Integer -> Integer
lcm3 a b = a * b `div` (gcd_eff a b)

-- 4.2.4
{- i think the most efficient one is the lm3 because its far more easier to search for the gcd than the lcm.
and then there is just a simple calculation. and also its the fastest-}

{- Exercise 4.3 -}

-- 4.3.1
data Mountain = Everest | K2 | Lhotse | Makalu | ChoOyu deriving Show

isHigher :: Mountain -> Mountain -> Bool
isHigher Everest _ = True
isHigher _ Everest = False
isHigher K2 _ = True
isHigher _ K2 = False
isHigher Lhotse _ = True
isHigher _ Lhotse = False
isHigher Makalu _ = True
isHigher  _ Makalu  = False

-- Does need 2*(n-1) equations


-- 4.3.2
altitude :: Mountain -> Integer
altitude Everest = 8848
altitude K2 = 8611
altitude Lhotse = 8586
altitude Makalu = 8481
altitude ChoOyu = 8188

isHigher2 :: Mountain -> Mountain -> Bool
isHigher2 x y = altitude x > altitude y

 -- Does need n + 1 equations
