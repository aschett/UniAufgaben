import Prelude hiding (fromInteger, toInteger, pred)

{- Exercise 5.1 -}

-- 5.1.1
samePrefix :: String -> String
samePrefix [] = []
samePrefix (c:[]) = [c]
samePrefix (c1 : c2 : tl) = if c1 == c2 then [c1] ++ samePrefix(c2:tl) else [c1]

--yeah i know i couldve solved it without : operator but it was so much more beautiful

-- 5.1.2
dropSamePrefix :: String -> String
dropSamePrefix (c:[]) = ""
dropSamePrefix (c:tl) = if c == head (tl) then dropSamePrefix (tl) else tl

-- 5.1.3
reverseString :: String -> String
reverseString [] = []
reverseString input = reverseString(dropSamePrefix input) ++ samePrefix input

{- Exercise 5.2 -}

-- 5.2.1
fromDigit :: Integer -> Char
fromDigit 0 = '0'
fromDigit 1 = '1'
fromDigit 2 = '2'
fromDigit 3 = '3'
fromDigit 4 = '4'
fromDigit 5 = '5'
fromDigit 6 = '6'
fromDigit 7 = '7'
fromDigit 8 = '8'
fromDigit 9 = '9'

fromInteger :: Integer -> String
fromInteger 0 = ""
fromInteger d = fromDigit (d `mod` 10) : fromInteger(d `div` 10)

toDigit :: Char -> Integer
toDigit '0' = 0
toDigit '1' = 1
toDigit '2' = 2
toDigit '3' = 3
toDigit '4' = 4
toDigit '5' = 5
toDigit '6' = 6
toDigit '7' = 7
toDigit '8' = 8
toDigit '9' = 9

toInteger :: String -> Integer
toInteger s = toIntegerAux s 0

toIntegerAux :: String -> Integer -> Integer
toIntegerAux (h:[]) n = toDigit h * 10^n
toIntegerAux (h:tl) n = toDigit h * 10^n + toIntegerAux tl (n+1)

-- 5.2.2
addDigits :: Char -> Char -> String
addDigits n1 n2 = fromInteger(toDigit n1 + toDigit n2)

add :: String -> String -> String
add xs [] = xs
add [] ys = ys
add (x:xs) (y:ys) = (head(addDigits x y)) : (add(tail(addDigits x y)) (add xs ys))

-- 5.2.3

pred :: String -> String
pred [] = []
pred "0" = "0"
pred (x:[]) = [x]
pred ('1':[]) = ""
pred ('0':xs) = '9' : pred(xs)
pred (x:xs) = fromDigit(toDigit(x) - 1) : xs
