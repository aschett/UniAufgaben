data Fuel = NaturalGas | Nuclear | Hydro | Wind deriving Show
data FuelType = Renewables | Fussel deriving Show
data Summary = CarbonZero | Resource deriving Show

class Electricity a where
  generation :: a -> Integer

-- Make Fuel instance of Electricity
instance Electricity Fuel where
  generation NaturalGas = 52
  generation Nuclear = 928
  generation Hydro =632
  generation Wind = 587

-- Make Fueltype instance of Electricity
instance Electricity FuelType where
  generation Renewables = 1469
  generation Fussel = 1519

-- Make Summary instance of Electricity
instance Electricity Summary where
  generation CarbonZero = 2397
  generation Resource = 3916

-- 7.1.2 Implement the comparison
generateMore :: (Electricity a, Electricity b) => a -> b -> Bool
generateMore x y = generation x > generation y

-- Difference between generateMore and generateMore2
-- generateMore allows more than one different instance of Electricity whereas generateMore2 strictly one allows.
-- generateMore Hydro and Renewables will work but generateMore2 with Hydro and Renewables wont work

{- Exercise 7.2 -}

-- 7.2.1 Implement the data constructors for complex number and define slope via "error"

data Complex = Complex Double Double

slope :: Complex -> Double
slope (Complex 0 b) = error "cant divide by 0"
slope (Complex a b) = b / a

slopeSum :: Complex -> Complex -> Complex -> Double
slopeSum c1 c2 c3 = slope c1 + slope c2 + slope c3

-- 7.2.2 Implement slope and slopeSum via the Maybe-type

slopeMaybe :: Complex -> Maybe Double
slopeMaybe (Complex 0 b) = Nothing
slopeMaybe (Complex a b) = Just (a/b)

slopeSumMaybe :: Complex -> Complex -> Complex -> Maybe Double
slopeSumMaybe c1 c2 c3 = addMaybeDouble (slopeMaybe c1) (addMaybeDouble(slopeMaybe c2) (slopeMaybe c3))

addMaybeDouble :: Maybe Double -> Maybe Double -> Maybe Double
addMaybeDouble (Just a) (Just b) = Just(a + b)
addMaybeDouble _ _ = Nothing

-- 7.2.3 Compare "error" and "Maybe" approach
-- Maybe still returns a value (Nothing) but is somehow more complex but also better i guess. i think its always better to return anything instead of returning an error
-- the second one would be much easier as i can just test for a nothing value and then print the string


{- Exercise 7.3 -}

-- 7.3.1 Implement the data constructors below
data Sex = Male | Female deriving Eq

data Person = Person Sex Double Double Integer

data HealthCategory = Underweight | Healthy | Overweight

instance Eq HealthCategory where
  Underweight == Underweight = True
  Healthy == Healthy = True
  Overweight == Overweight = True
  _ == _ = False

data Exercise = Sedentary | Active | Extreme

pal :: Exercise -> Double
pal Sedentary = 1.53
pal Active = 1.76
pal Extreme = 2.25

-- 7.3.2
health :: Person -> HealthCategory

health (Person s w h a)
  | y < 18.5 = Underweight
  | y < 25 = Healthy
  | otherwise = Overweight
  where y = w / h^2

-- 7.3.3
bmr :: Person -> Double
bmr (Person s w h a)
  | s == Male = 66 + 13.7 * w + 5 * h - 6.8 * fromInteger a
  | s == Female = 655 + 9.6 * w + 1.8 * h - 4.7 * fromInteger a



-- 7.3.4
healthAdvise :: Person -> Exercise -> String
healthAdvise (Person s w h a) exercise
  | health (Person s w h a) == Underweight = "Your Bmi is " ++ show (w / h^2) ++ " that means you are Underweight and you should consume more then " ++ show d ++ " calories a day "
  | health (Person s w h a) == Overweight =  "Your Bmi is " ++ show (w / h^2) ++ " that means you are Overweight and you should consume less then " ++ show d ++ " calories a day "
  | otherwise = "Your have normal weight congratulations ! but still pls consume about " ++ show d ++ "calories a day"
  where d = pal exercise * bmr (Person s w h a)



{- Test Heads-}
test_list f ss str = all (test_fun f) ss where
  test_fun f s = f (fst s) == snd s ||
    error ("function " ++ str ++ " on input " ++ show (fst s) ++ " delivered "
      ++ show (snd s) ++ ", but expected was " ++ show (f (fst s)))


test_list2 f ss str = testFun (\p -> f (fst p) (snd p)) ss where
    testFun f = all (\p -> f (fst p) == snd p ||
        error (str ++ ":on input "++(show (fst p))++" output is "++(show (f (fst p)))++" but should be "++(show (snd p))))

{- Tests for 7.1 -}

-- 7.1.1 No test available

test_Feul = zip [NaturalGas , Nuclear , Hydro , Wind] [52, 928, 632, 587]
test_FeulType = zip [Renewables , Fussel] [1469, 1519]
test_Summary = zip [CarbonZero , Resource] [2397, 3916]
test_definition = test_list generation test_Feul "generation1" && test_list generation test_FeulType "generation2" && test_list generation test_Summary "generation3"
-- 7.1.2 Implement the comparison
test_compare_data = (generateMore NaturalGas Wind == False) && (generateMore Wind Fussel == False) && (generateMore Renewables Fussel == False) && (generateMore Resource CarbonZero == True) && (generateMore Nuclear Fussel == False) || error ("7.1.2 is not passed")

        {- Tests for 7.3 -}

        -- 7.3.1

        -- personList = map (\(sex, weight, height, age) -> Person sex weight height age) [(Male, 138, 1.79, 54), (Female, 43, 1.58, 32), (Male, 82, 1.83, 40)]

        -- testPerson = all (\(Person sex weight height age) -> typeOf sex == typeOf (Female :: Sex) && typeOf weight == typeOf (1.0 :: Double) && typeOf height == typeOf (1.0 :: Double) && typeOf age == typeOf (1 :: Integer)) personList

        -- testHealthCategory = all (\(cat1, cat2, result) -> (cat1 == cat2) == result) [(Underweight, Underweight, True), (Overweight, Overweight, True), (Healthy, Healthy, True), (Underweight, Overweight, False), (Overweight, Healthy, False), (Healthy, Overweight, False)]

        -- testPal = all (\(cat, result) -> pal cat == result) [(Sedentary, 1.53), (Moderate, 1.76), (Active, 2.25)]

        -- 7.3.2

        -- testHealth = all (\(person, category) -> health person == category) (zip personList [Overweight, Underweight, Healthy])

        -- 7.3.3

        -- testBmr = all (\(person, val) -> abs (bmr person - val) < 1e-4) (zip personList [1598.35, 920.244, 926.55])

        -- 7.3.4 :: No test available

        -- test73 = testPerson && testHealthCategory && testPal && testHealth && testBmr
