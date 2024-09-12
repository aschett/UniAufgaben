import Data.Ratio

{- Exercise 8.1 -}

approx :: (Fractional a, Ord a) => a -> a -> (a, Integer)
approx a e = approxAux a e a 0

approxAux :: (Fractional a, Ord a) => a -> a -> a -> Integer -> (a, Integer)
approxAux a e x i = if goodEnough a x e
                      then (x, i)
                      else approxAux a e (fortify a x) (i+1)

goodEnough :: (Fractional a, Ord a) => a -> a -> a -> Bool
goodEnough a x e = abs (1/2 * (x^2 - a)) < e

fortify :: (Fractional a, Ord a) => a -> a -> a
fortify a x = 1/2 * (x + a / x)



{- Exercise 8.2 -}

data MP = MP String

{- Exercise 8.2.1 -}

nrmString, negateString :: String -> String
nrmString str = nrmStringAux "" str

nrmStringAux :: String -> String -> String
nrmStringAux [] [] = []
nrmStringAux str [] = str
nrmStringAux (s1:tl1) (s2:[]) = if s1 == s2 then (s1:s2:tl1) else tl1
nrmStringAux [] (s2:tl2) = nrmStringAux [s2] tl2
nrmStringAux (s1:tl1) (s2:tl2)
  | s1 == s2 = nrmStringAux (s2:s1:tl1) (tl2)
  | s1 /= s2 && null tl1 = nrmStringAux "" (tl2)
  | s1 /= s2 = nrmStringAux (tl1) (tl2)


negateString ('+':[]) = "-"
negateString ('-':[]) = "+"
negateString ('+':tl) = "-" ++ negateString tl
negateString ('-':tl) = "+" ++ negateString tl

{- Exercise 8.2.2 -}

instance Show MP where
  show (MP str) = show str
instance Eq MP where
  (MP str1) == (MP str2) = nrmString str1 == nrmString str2

{- Exercise 8.2.3 -}

instance Num MP where
  (+) (MP x) (MP y) = MP (nrmString(x ++ y))
  (*) (MP str1) (MP str2)
    | nrmString str1 == "" = (MP "")
    | nrmString str2 == "" = (MP "")
    | nrmString [head (nrmString str2)] == "-" = (MP (nrmString(negateString str1))) + ((*) (MP (nrmString str1)) (MP (nrmString (tail str2))))
    | otherwise = (MP (nrmString str1)) + ((*) (MP (nrmString str1)) (MP (nrmString (tail str2))))
  negate (MP str) = (MP (negateString str))
  signum (MP []) = (MP [])
  signum (MP (s:tl)) = (MP [s])
  abs (MP str)
    | null str  = (MP [])
    | head (nrmString str) == '-' = (MP (negateString (nrmString str)))
    | otherwise = (MP (nrmString str))
  fromInteger x
    | x == 0 = MP []
    | x < 0 = MP ("-") + fromInteger (x+1)
    | otherwise = MP ("+") + fromInteger(x-1)

fromMP :: MP -> Integer
fromMP (MP []) = 0
fromMP (MP (s:tl))
  | s == '+' = 1 + fromMP (MP tl)
  | otherwise = (- 1) + fromMP (MP tl)

-- some tests for Exercise 8.2 corresponding to text
-- provided for convenience only

test82 = test821 && test822 && test823

test821 = test821ex && test821neg "+-++" && test821nrm "+-++"
test821ex =
  (nrmString "+-+-++" == "++") &&
  (nrmString "-+-+--" == "--") &&
  (nrmString "---++-++" == "") &&
  (negateString "+-+-++" == "-+-+--") &&
  (negateString "-+-+--" == "+-+-++")
test821nrm s = let t = nrmString s in nrmString t == t
test821neg s = negateString (negateString s) == s

test822 = ((MP "+-+-+") == (MP "--+++")) &&
  not ((MP "+-+-+") == (MP "")) &&
  (show (MP "+-+-+") == show "+-+-+")

three,four,mfive :: MP
three = fromInteger 3
four = fromInteger 4
mfive = fromInteger (-5)

test823 = (fromMP ((three + four) * mfive) == -35) &&
  (fromMP (four * (three + mfive)) == -8)
