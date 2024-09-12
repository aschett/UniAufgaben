{- 10.1 -}

{- 10.1.1 -}
removeFirst :: Eq a => a -> [a] -> [a]
removeFirst x [] = []
removeFirst x (x1:xs)
  | x == x1 = xs
  | x /= x1 = x1 : removeFirst x xs

{- 10.1.2 -}

isPermutation :: Eq a => [a] -> [a] -> Bool
isPermutation [] [] = True
isPermutation _ [] = False
isPermutation [] _ = False
isPermutation (x:xs) ys = isPermutation xs (removeFirst x ys)

{- 10.1.3 -}
hasDuplicates :: Eq a => [a] -> Bool
hasDuplicates [] = False
hasDuplicates (x:xs)
  | elem x xs = True
  | otherwise = hasDuplicates xs

{- 10.3 -}

{- 10.3.1 -}
divisors :: Integer -> [Integer]
divisors n = filter (\x -> (n `mod` x) == 0) [y | y <- [1 .. n-1]]

{- 10.3.2 -}
isPerfectNumber :: Integer -> Bool
isPerfectNumber n = sum (divisors n) == n

{- 10.3.3 -}
perfectNumbers :: Integer -> [Integer]
perfectNumbers n = filter (\x -> isPerfectNumber x) [y | y <- [1 .. n]]



-- the time for 100 is (0.01 secs, 1,273,968 bytes)
-- the time for 1000 is (0.15 secs, 113,167,448 bytes)
-- the time for 10000 is (14.38 secs, 11,213,606,328 bytes)
