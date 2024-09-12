module Bag() where
data Bag a = Bag [(a, Integer)]

fromList :: Bag [(a, Integer)] => [a] -> Bag a
fromList (x:xs) = (x , 1) : fromList fromList xs
