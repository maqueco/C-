-- ejercicio 1

-- a

esCero :: Int -> Bool
esCero x | x== 0 = True
         | otherwise = False
-- b

esPositivo :: Int -> Bool
esPositivo x | x>=0 = True
             | otherwise = False
-- c

esVocal :: Char -> Bool
esVocal x | x=='a' || x=='e' || x=='i' || x=='o' || x=='u' = True
          | otherwise = False

-- d

factorial :: Int -> Int
factorial n = product [1..n]

-- e

promedio :: [Int] -> Int
promedio [] = 0
promedio (x:xs) = div (sumatoria xs) (length xs)

-- ejercicio 2

-- a

paratodo :: [Bool] -> Bool
paratodo [] = False
paratodo (x:xs) = x && paratodo xs

-- b

sumatoria :: [Int] -> Int
sumatoria [] = 0
sumatoria (x:xs)= x+sumatoria xs

-- c

productoria :: [Int] -> Int
productoria [] = 1
productoria (x:xs) = x * productoria xs

-- ejercicio 3

pertenece :: Int -> [Int] -> Bool
pertenece n [] = False
pertenece n (x:xs) = x==n || pertenece n xs

-- ejercicio 4

encuentra :: Int -> [(Int,String)] -> String
encuentra n [] = ""
encuentra n ((a,b):xs) | n==a = b
                       | otherwise = encuentra n xs

-- ejercicio 5

-- a

paratodo' :: [a] -> (a -> Bool) -> Bool

paratodo' [] t = True

paratodo' (x:xs) t = t x && paratodo' xs t

-- b

existe' :: [a] -> (a -> Bool) -> Bool
existe' [] t = False
existe' (x:xs) t = t x || paratodo' xs t

-- c

sumatoria' :: [a] -> (a -> Int) -> Int
sumatoria' [] t = 0
sumatoria' (x:xs) t = t x + sumatoria' xs t

-- e

productoria' :: [a] -> (a -> Int) -> Int
productoria' [] t = 1
productotia' (x:xs) t = t x * productoria' xs t

-- ejercicio 6

paratodo'' :: [Bool] -> Bool

paratodo'' xs = paratodo' xs b
                where b :: Bool -> Bool
                      b x = x
-- ejercicio 7

-- a

todosPares:: [Int] -> Bool
todosPares xs = paratodo' xs par
                where par :: Int -> Bool
                      par x = mod x 2 == 0
-- b

hayMultiplo :: Int -> [Int] -> Bool
hayMultiplo n xs = existe' xs esM
                   where esM :: Int -> Bool
                         esM x = mod x n == 0

-- c

sumaCuadrados :: Int -> Int
sumaCuadrados n = sumatoria' [0..n] cuadrado
                  where cuadrado :: Int -> Int
                        cuadrado n = n * n

-- d

multiplicaPares :: [Int] -> Int
multiplicaPares xs = productoria' xs pares
                   where pares :: Int -> Int
                         pares x | mod x 2 == 0 = x
-- ejercicio 8

-- *map :: (a -> b) -> [a] -> [b] 
--  map es una funcion que toma un lista y la transforma usando otra funcion para dar una lista nueva

--  filter :: (a -> Bool) -> [a] -> [a]
--  filter es una funcion que toma una lista y verifica usando otra funcion que valores son verdaderos y cuales no  devolviendo en una nueva lista los solo los elementos que son ciertos

-- *La expresion map succ [1, -4, 6, 2, -8] donde succ n = n+1, es equivale a sumarle 1 a cada elemento, es decir su succesor = [2, -3, 7, 3, -7]

-- *La expresion filter esPositivo [1, -4, 6, 2, -8] es equivalente a una lista con solo valores positivos [1,6,2]

-- ejercicio 9

-- a

duplicar :: [Int] -> [Int]
duplicar [] = []
duplicar (x:xs) = x*2: duplicar xs

-- b

duplicar' :: [Int] -> [Int]
duplicar' xs = map (*2) xs

-- ejercicio 10

--a

sonPares :: [Int] -> [Int]
sonPares [] = []
sonPares (x:xs) | mod x 2 == 0 = x : sonPares xs
                | mod x 2 /= 0 = sonPares xs
--b

sonPares' :: [Int] -> [Int]
sonPares' xs = filter even xs

--c

multiplicaPares' :: [Int] -> Int
multiplicaPares' xs = productoria (sonPares' xs)

-- ejercicio 11

-- a

sumarALista :: Num a => a -> [a] -> [a]
sumarALista n [] = []
sumarALista n (x:xs) = (n+x) :  sumarALista n xs

encabezar :: a -> [[a]] -> [[a]]
encabezar n [] = []
encabezar n (xs:xss) = (n:xs): encabezar n xss

mayoresA :: Ord a => a -> [a] -> [a]
mayoresA n [] = []
mayoresA n (x:xs) | n<x = x : mayoresA n xs
                  | otherwise = mayoresA n xs
-- b

sumarALista' :: Num a => a -> [a] -> [a]
sumarALista' n xs = map (n+) xs

encabezar' :: a -> [[a]] -> [[a]]
encabezar' n xs = map (n:) xs

mayoresA' :: Ord a => a -> [a] -> [a]
mayoresA' n xs = filter (n<) xs

-- ejercicio 12

sies :: Int -> (Int, String) -> Bool
sies m (k,j) = m == k

primTup :: [(Int, String)] -> (Int, String)
primTup [] = (0,"")
primTup (x:xs) = x

sacatup :: (Int, String) -> String
sacatup (x,e) = e

encuentra' :: Int -> [(Int,String)] -> String
encuentra' n xs = sacatup ( primTup ( filter (sies n) xs))

-- ejercicio 13

-- a

primIgualesA :: Eq a => a -> [a] -> [a]
primIgualesA n [x] = []
primIgualesA n (x:e:xs) | n == x = x : primIgualesA n (e:xs)
                        | n == e = primIgualesA n xs
                        | n /= x = primIgualesA n (e:xs)
                        | n /= e = x :[]

-- b

primIgualesA' :: Eq a => a -> [a] -> [a]
primIgualesA' n xs = takeWhile (==n) xs

-- ejercicio 14

-- a

primIguales :: Eq a => [a] -> [a]
primIguales [] = []
primIguales (x:y:xs) | x == y = x : primIguales (y:xs)
                     | otherwise = x : []

-- b

primIguales' :: Eq a => [a] -> [a]
primIguales' xs = primIgualesA' (head xs) xs

-- ejercicio 15

-- a

minimo :: Ord a => [a] -> a
minimo [x] = x
minimo (x:xs) = x `min` minimo xs

-- b

minimo' :: (Bounded a, Ord a) => [a] -> a
minimo' [] = maxBound :: Bounded a => a
minimo' (x:xs) = x`min`minimo' xs