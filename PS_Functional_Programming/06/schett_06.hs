{- Exercise 6.1 -}
data Time = Time Integer Integer Integer
  deriving Show

-- Exercise 6.1.1
hours :: Time -> Integer
hours (Time h _ _ ) = h

minutes :: Time -> Integer
minutes (Time _ m _) = m

seconds :: Time -> Integer
seconds (Time _ _ s) = s

-- Exercise 6.1.2
well_formed :: Time -> Bool
well_formed (Time h m s)
 | h > 23 || h < 0 = False
 | m > 60 || m < 0 = False
 | s > 60 || s < 0 = False
 | otherwise = True

-- Exercise 6.1.3
pretty :: Time -> String
pretty (Time h m s) = prettyPadding h ++ ":" ++ prettyPadding m ++ ":" ++ prettyPadding s

prettyPadding :: Integer -> String
prettyPadding x = if x < 10 then "0" ++ show x else show x

-- Exercise 6.1.4
tick :: Time -> Time
tick (Time h m s)
 | h == 23 && m == 59 && s == 59 = Time 0 0 0
 | m == 59 && s == 59 = Time (h+1) 0 0
 | s == 59 = Time h (m+1) 0
 | otherwise = Time h m (s+1)

{- Exercise 6.2 -}

-- Exercise 6.2.1
-- Add your datatype definition here
data Region = Region TypeOfRegion String Integer
  deriving Show

data TypeOfRegion = City | State | Country

instance Show TypeOfRegion where
  show City = "city"
  show State = "state"
  show Country = "country"


-- innsbruck, tyrol and austria are so called constants
-- to define a constant in Haskell you simple define a function that takes no parameters
innsbruck :: Region
innsbruck = Region City "Innsbruck" 132110

tyrol :: Region
tyrol = Region State "Tyrol" 754705

austria :: Region
austria = Region Country "Austria" 8858775

-- Exercise 6.2.1
name :: Region -> String
name (Region _ x _ ) = x

population :: Region -> Integer
population (Region _ _ x) = x

typeOfRegion :: Region -> String
typeOfRegion (Region x _ _ ) = show x

 -- Exercise 6.2.3
info :: Region -> String
info (Region x y z) = "The " ++ show x ++ " of " ++ y ++ " has a population of " ++ show z


{- Exercise 6.3 -}

-- Exercise 6.3.1

ev :: String -> String
ev [] = []
ev (h:[]) = [h]
ev (h:tl) = h : ev(tail(tl))

od :: String -> String
od [] = []
od (h:[]) = [h]
od (h:tl) = head(tl) : od(tail(tl))

merge :: String -> String -> String
merge [] [] = []
merge s [] = error "empty list"
merge [] s = error "empty list"
merge (s1:tl1) (s2:tl2) = [s1] ++ [s2] ++ merge tl1 tl2

-- Exercise 6.3.2

lshift :: String -> String
lshift [] = []
lshift (s:[]) = "F"
lshift (s:tl) = tl ++ "F"

sand :: String -> String -> String
sand [] [] = []
sand [] s2 = error "empty list"
sand s1 [] = error "empty list"
sand ('F':tl1) ('_':tl2) = "F" ++ sand tl1 tl2
sand ('_':tl1) ('F':tl2) = "F" ++ sand tl1 tl2
sand ('T':tl1) ('T':tl2) = "T" ++ sand tl1 tl2
sand (h1:tl1) (h2:tl2) = "F" ++ sand tl1 tl2

-- below some functions that allow to test correctness.
-- they are there for your convenience. note that these are tests:
-- if a test fails you can conclude something is wrong
-- but if a test succeeds you cannot conclude that everything is right,
-- only that some things (those tested) are

-- test of all functions in 6.3
test63 = test631 && test632 && testMatch

-- test of functions in 6.3.1
test631 = testEvOdMerge "" && testEvOdMerge "ababacda"
testEvOdMerge s = merge (ev s) (od s) == s
test631error = testEvOdMerge "a"

-- test of functions in 6.3.2
test632 = lshift "ababacda" == "babacdaF" &&
  sand "aTbTTcF" "xTbcTcT" == "FTFFTFF"

testMatch =
  match "a" "ababacda" == "TFTFTFFT" &&
  match "ab" "ababacda" == "TFTFFFFF" &&
  match "abab" "ababacda" == "TFFFFFFF" &&
  match "c" "ababacda" == "FFFFFTFF" &&
  match "e" "ababacda" == "FFFFFFFF"

-- function that indicates at which positions
-- the first string occurs in the second string
-- T if it occurs there, F if it does not occur; see testMatch for examples
match :: String -> String -> String
match [c] [d] = if c == d then "T" else "F"
match [c] rs = merge (match [c] (ev rs)) (match [c] (od rs))
match _ [d] = "F"
match pq rs = merge (sand (match (ev pq) (ev rs)) (match (od pq) (od rs)))
                    (sand (lshift (match (od pq) (ev rs))) (match (ev pq) (od rs)))
-- this match function makes use of all functions in 6.3
-- this function only works for strings that have a power of 2 (1,2,4,..) as length
-- (you do not need to understand how and why the function works)
