removeAt :: Integer -> [a] -> [a]
removeAt 0 (x:xs) = xs
removeAt n (x:xs)
  | n < 0 = (x:xs)
  | n >= toInteger (length (x:xs)) = (x:xs)
  | n /= 0 = [x] ++ removeAt (n-1) xs


insertS :: Ord a => a -> [a] -> [a]
insertS x [] = [x]
insertS x (y:ys)
  | x > y = [y] ++ insertS x ys
  | x <= y = [y] ++ [x] ++ ys


unique :: Eq a => [a] -> [a]
unique [] = []
unique (x:[]) = [x]
unique (x:xs) = [x] ++ uniqueAux x xs

uniqueAux :: Eq a => a -> [a] -> [a]
uniqueAux x (x1:[]) = if x == x1 then [] else [x1]
uniqueAux x (x1:xs)
  | x == x1 = uniqueAux x xs
  | otherwise = [x1] ++ uniqueAux x xs


sl :: [Integer] -> Integer
sl (x1:x2:xs) =  if x1 > x2 then sl_aux x1 x2 xs else sl_aux x2 x2 xs

sl_aux :: Integer -> Integer -> [Integer] -> Integer
sl_aux fst snd [] = snd
sl_aux fst snd (h:tl)
  | h >= fst = sl_aux h fst tl
  | h > snd = sl_aux fst h tl
  | h < snd = sl_aux fst snd tl
