-- ejercicio 1

-- a

data Carrera = Matematica | Fisica | Computacion | Astronomia | Profesorado deriving (Show, Eq, Ord, Enum, Bounded)

-- b

titulo :: Carrera -> String
titulo Matematica = "Licenciatura en Matematica"
titulo Fisica = "Licenciatura en Fisica"
titulo Computacion = "Licenciatura en Ciencias de la Computacion"
titulo Astronomia = "Licenciatura en Astronomia"
titulo Profesorado = "Profesorado de Matematica"

-- c

--Si, puedo definir la funcion anterior usando analisi por casos, porque

titulo1 :: Carrera -> String
titulo1 x | x == Matematica = "Licenciatura en Matematica"
          | x == Fisica = "Licenciatura en Fisica" 
          | x == Computacion = "Licenciatura en Ciencias de la Computacion"
          | x == Astronomia = "Licenciatura en Astronomia"
          | x == Profesorado = "Profesorado de Matematica"

-- ejercicio 2 

-- a

-- Ingreso es un sinonimo de tipo
type Ingreso = Int

-- Cargo y Area son tipos enumerados
data Cargo = Titular | Asociado | Adjunto | Asistente | Auxiliar deriving (Show, Eq, Ord, Enum, Bounded)
data Area = Administrativa | Ensenanza | Economica | Postgrado deriving (Show, Eq, Ord, Enum, Bounded)

-- Rol es un tipo algebraico
data Rol = Decanx Genero
         | Docente Cargo 
         | NoDocente Area 
         | Estudiante [(Carrera, Ingreso)] deriving (Show, Eq, Ord)



-- b

--type Docente = Cargo -> Rol

-- c

cuantos_doc :: [Rol] -> Cargo -> Int
cuantos_doc [] c = 0
cuantos_doc (Docente Titular:xs) Titular =  1 + cuantos_doc xs Titular
cuantos_doc (Docente Asociado : xs) Asociado = 1 + cuantos_doc xs Asociado
cuantos_doc (Docente Adjunto : xs) Adjunto = 1 + cuantos_doc xs Adjunto
cuantos_doc (Docente Asistente : xs) Asistente = 1 + cuantos_doc xs Asistente
cuantos_doc (Docente Auxiliar : xs) Auxiliar = 1 + cuantos_doc xs Auxiliar
cuantos_doc (_ :xs) c = cuantos_doc xs c

-- d

cuantos_doc' :: [Rol] -> Cargo -> Int
cuantos_doc' xs c = length (filter (==Docente c) xs)

-- e

--data Rol = Decanx Genero
data Genero = Masculino | Femenino deriving (Show, Eq, Ord)

-- f

-- No se puede representar un alumno inscripto en dos carreras

estudia :: Rol -> Carrera -> Bool
estudia (Estudiante []) _ = False
estudia (Decanx _) _ = False
estudia (NoDocente _) _ = False
estudia (Docente _) _ = False
estudia (Estudiante ((x,_):xs)) c = x == c || estudia (Estudiante xs) c

-- ejercicio 3

-- a

data Persona = Per String String Int Int Int Int Rol deriving (Show, Eq, Ord)
tome = Per "Uribe" "Tomas" 41624903 12 11 1998 (Estudiante [(Computacion, 2017)])
miguel = Per "Rodenas" "Miguel" 406383999 15 10 1997 (Estudiante [(Computacion, 2017)])
maria = Per "Sa" "Maria" 42539156 12 3 1999 (Estudiante [(Astronomia, 2017)])
-- b

-- Si se puede usar el mismo identificador del constructor Per y el nombre del tipo persona

-- c

-- 1

edad :: Persona -> (Int, Int, Int) -> Int
edad (Per _ _ _ d m a _) (d', m', a') | a >= a' = 0
                                       | m < m' = a'-a
                                       | m > m' = a'-a-1
                                       | m == m' = if d <= d' then a'-a
                                                else if d > d' then a'-a-1 
                                                else a'-a

edad (Per _ _ _ _ _ _ _) (_, _, _) = undefined

-- 2

existe :: String -> [Persona] -> Bool
existe a [] = False
existe a ((Per a' _ _ _ _ _ _):xs) | a==a' = True
                                   | a/=a' = existe a xs

existe' :: String -> [Persona] -> Bool
existe' _ [] = False
existe' d ((Per a _ _ _ _ _ _):xs) = d == a || existe' d xs

-- 3

est_astronomia :: [Persona] -> [Persona]
est_astronomia xs = filter (est Astronomia) xs

est :: Carrera -> Persona -> Bool
est Astronomia (Per _ _ _ _ _ _(Estudiante ((Astronomia, _): _))) = True
est Astronomia (Per a b c d e f (Estudiante ((_, _):xs))) = est Astronomia (Per a b c d e f (Estudiante xs))
est _ _ = False

-- 4

padron :: [Persona] -> [(String, Int)]
padron [] = []
padron ((Per a n d _ _ _(NoDocente _)):xs) = ( n ++ " " ++ a, d): padron xs
padron ((Per _ _ _ _ _ _ _): _)= undefined

nodocente :: Persona -> Bool
nodocente (Per _ _ _ _ _ _(NoDocente _)) = True
nodocente (Per _ _ _ _ _ _ _) = False 

padron_nodocente :: [Persona] -> [(String, Int)]
padron_nodocente xs = padron (filter (nodocente) xs)

-- ejercicio 4

data Cola = Vacia | Encolada Persona Cola deriving (Eq,Show) 

-- a
-- 1

atender :: Cola -> Cola
atender Vacia = Vacia
atender (Encolada _ x) = x

-- 2

encolar :: Persona -> Cola -> Cola
encolar p Vacia = (Encolada p Vacia)
encolar p (Encolada p' c) = Encolada p' (encolar p c)

-- 3

busca :: Cola -> Cargo -> Persona
busca Vacia _ = error "No hay docentes"
busca (Encolada p r) c | esDocente p c == True = p
                       | esDocente p c == False = busca r c
                       | otherwise = error "No hay docentes"

esDocente :: Persona -> Cargo -> Bool
esDocente (Per _ _ _ _ _ _ (Docente c)) r = c == r
esDocente _ _ = False

-- b

data ListaP = Vacia' | Cons Persona ListaP

-- Las mismas funciones con el nuevo tipo:

atender' :: ListaP -> ListaP
atender' Vacia' = Vacia'
atender' (Cons _ x) = x 

encolar' :: Persona -> ListaP  -> ListaP 
encolar' p Vacia' = (Cons p Vacia')
encolar' p (Cons x u) = Cons x (encolar' p u)

busca' :: ListaP -> Cargo -> Persona
busca' Vacia' _ = error "no hay docente"
busca' (Cons p r) c | esDocente p c == True = p
                    | esDocente p c == False = busca' r c
                    | otherwise = error "No hay docente"

-- ejercicio 5

data ListaAsoc a b = Vacia'' | Nodo a b (ListaAsoc a b) deriving (Eq, Show)

type Diccionario = ListaAsoc String String
type Padron      = ListaAsoc Int    String

-- a

type GuiaTelefonica = ListaAsoc String Int

-- b
-- 1

la_long :: Integral c => ListaAsoc a b -> c
la_long Vacia'' = 0
la_long (Nodo _ _ c) = 1 + la_long c

-- 2

la_concat ::  (Eq a,Eq b) => ListaAsoc a b -> ListaAsoc a b -> ListaAsoc a b
la_concat Vacia'' y = y
la_concat x Vacia'' = x
la_concat (Nodo a b (z)) y | z == Vacia'' = (Nodo a b (y))
                           | otherwise = (Nodo a b (la_concat z y))
-- 3

la_pares :: ListaAsoc a b -> [(a,b)]
la_pares Vacia'' = []
la_pares (Nodo a b c) = (a, b) : la_pares c

-- 4

la_busca :: Eq a => ListaAsoc a b -> a -> Maybe b
la_busca Vacia'' _ = Nothing
la_busca (Nodo a b c) x | a == x = Just b
                        | otherwise = la_busca c x
-- c

-- ejercicio 6

data Arbol a = Hoja | Rama (Arbol a) a (Arbol a) deriving (Show, Read, Eq)

type Prefijos = Arbol String

can, cana, canario , canas, cant, cantar, canto :: Prefijos
can     = Rama cana "can" cant
cana    = Rama canario "a" canas
canario = Rama Hoja "rio" Hoja
canas   = Rama Hoja "s" Hoja
cant    = Rama cantar "t" canto
cantar  = Rama Hoja "ar" Hoja
canto   = Rama Hoja "o" Hoja

-- a

a_long :: Integral b => Arbol a -> b
a_long Hoja = 0
a_long (Rama a _ c) = 1 + a_long a + a_long c

-- b

a_hojas :: Integral b => Arbol a -> b
a_hojas Hoja = 1
a_hojas (Rama Hoja _ Hoja) = 2
a_hojas (Rama Hoja _ _) = 1
a_hojas (Rama _ _ Hoja) = 1
a_hojas (Rama _ _ _ ) = 0

a_hojas' :: Integral b => Arbol a -> b
a_hojas' Hoja = 1
a_hojas' (Rama a _ c) = a_hojas a + a_hojas c

-- c

a_inc :: Num a => Arbol a -> Arbol a
a_inc(Rama Hoja a Hoja) = (Rama Hoja (a+1) Hoja)
a_inc(Rama Hoja a b) = (Rama Hoja (a+1) b)
a_inc(Rama c a Hoja) = (Rama c (a+1) Hoja)
a_inc (Rama c a b) = (Rama c (a+1) b)


a_inc' :: Num a => Arbol a -> Arbol a
a_inc' Hoja = Hoja
a_inc' (Rama a b c) = Rama (a_inc a) (b + 1) (a_inc c)

-- d

a_nombre :: Arbol Persona -> Arbol String
a_nombre Hoja = Hoja
a_nombre (Rama x (Per a b _ _ _ _ _ ) f) = (Rama (a_nombre x) (a ++ " " ++ b) (a_nombre f))

-- e

a_map :: (a -> b) -> Arbol a -> Arbol b
a_map _ Hoja = Hoja
a_map r (Rama a b c) = Rama (a_map r a) (r b) (a_map r c)

-- f

a_sum :: Num a => Arbol a -> a
a_sum Hoja = 0
a_sum (Rama a b c) = b+ a_sum a + a_sum c

-- g

a_prod :: Num a => Arbol a -> a
a_prod Hoja = 1
a_prod (Rama a b c) = b * a_prod a * a_prod c