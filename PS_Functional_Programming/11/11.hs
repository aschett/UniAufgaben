{-11.1.1-}

addPos :: [a] -> [(Int,a)]
addPos xs = zip [y | y <- [1 .. length xs]] xs

{-11.1.2-}

prodSumEven :: [Int] -> Int
prodSumEven xs = undefined

{-11.1.3-}

prodSum :: (Int -> Bool) -> [Int] -> Int
prodSum cond_f xs  = undefined


{- 11.2 -}

{- 11.2.2 -}
filterr :: (a -> Bool) -> [a] -> [a]
filterr f [] = []
filterr f (x:xs) = foldr(\x xs -> if f x then x:xs else xs) [] (x:xs)

filterl :: (a -> Bool) -> [a] -> [a]
filterl f [] = []
filterl f (x:xs) = foldl(\xs x -> if f x then x:xs else xs) [] (x:xs)

{- 11.2.3 -}
findFirst :: (a -> Bool) -> [a] -> Maybe a
findFirst f (x:xs) = foldr(\x xs -> if f x then Just x else xs) Nothing (x:xs)

findLast :: (a -> Bool) -> [a] -> Maybe a
findLast f (x:xs) = foldl(\xs x -> if f x then Just x else xs) Nothing (x:xs)
