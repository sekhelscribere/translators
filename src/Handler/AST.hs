module Handler.AST (
        Form(..),
        Ag,
        tr ) where

-- | The type of agents, a synonym of String
type Ag = String

data Form
  = PropVar Integer -- Proposition formulas
  | Neg Form        -- Boolean negation
  | Conj Form Form  -- Boolean conjunction
  | Disj Form Form  -- Boolean disjunction
  | Impl Form Form  -- Boolean implication
  | Dyn Form Form   -- The test formula
  | K Ag Form       -- The knowledge operator


instance Show Form where
        show (PropVar i) = "p" ++ (show i)
        show (Neg form) = "~"  ++ (show form) 
        show (Conj form1 form2) = "(" ++  (show form1) ++ " & " ++ (show form2) ++ ")"
        show (Disj form1 form2) = "(" ++  (show form1) ++ " v " ++ (show form2) ++ ")"
        show (Impl form1 form2) = "(" ++  (show form1) ++ " -> " ++ (show form2) ++ ")"
        show (Dyn form1 form2) = "[!" ++ (show form1) ++ "]" ++ (show form2)
        show (K i form) = "K " ++ i ++ " " ++ (show form)

tr :: Form -> Form
tr (Dyn (f1) (PropVar i)) = (tr f1) `Impl` (PropVar i) 
tr (Dyn (f1) (Neg f2 )) = tr $ Neg (Dyn f1 f2)
tr (Dyn (f1) (f2 `Conj` f3)) = (tr (Dyn f1 f2)) `Conj` (tr (Dyn f1 f3)) 
tr (Dyn (f1) (f2 `Disj` f3)) = (tr (Dyn f1 f2)) `Disj` (tr (Dyn f1 f3)) 
tr (Dyn (f1) (f2 `Impl` f3)) = (tr (Dyn f1 f2)) `Impl` (tr (Dyn f1 f3)) 
tr (Dyn (f1) (K i f2 )) = (tr f1) `Impl` tr (K i (Dyn f1 f2))
tr (Dyn (f1) (Dyn f2 f3)) = tr (Dyn (f1) (tr (Dyn f2 f3)))         
tr (PropVar i) = PropVar i
tr (Neg f1) = Neg (tr f1)
tr (f1 `Conj` f2) = (tr f1) `Conj` (tr f2)
tr (f1 `Disj` f2) = (tr f1) `Disj` (tr f2)
tr (f1 `Impl` f2) = (tr f1) `Impl` (tr f2)
tr (K xs form1) = K xs (tr form1)