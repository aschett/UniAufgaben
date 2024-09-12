import Text.Read

main :: IO ()
main = return ()

replRead :: IO (Maybe Int)
replRead = do
  input <- getLine
  case readMaybe input :: Maybe Int of
    Just x -> return (Just x)
    Nothing -> do
      putStrLn $ "wrong input try again"
      return Nothing
