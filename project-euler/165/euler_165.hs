import Data.Int
import Data.List

r_transform :: Int64 -> Int64

r_transform s_n = ((s_n * s_n) `mod` 50515093)

r :: Int64 -> [Int64]
r s_n = s_n:(r $ r_transform s_n)

get_t :: [Int64]
get_t = [x `mod` 500 | x <- (tail $ r 290797)]

type Seg = (Int64,Int64,Int64,Int64)

get_seg :: [Int64] -> [Seg]
get_seg (a:b:c:d:rest) = (a,b,c,d):(get_seg rest)

segs = get_seg get_t

data Frac = Frac {
      frac_n :: Int64
    , frac_d :: Int64
} deriving (Show)

data Type_X_Only_Seg = Type_X_Only_Seg {
      x_Only_x :: Int64
    , x_Only_y1 :: Int64
    , x_Only_y2 :: Int64
} deriving (Show)

data Type_XY_Seg = Type_XY_Seg {
      xy_m :: Frac
    , xy_b :: Frac
    , xy_x1 :: Int64
    , xy_x2 :: Int64
} deriving (Show)

data CompiledSeg = CompX Type_X_Only_Seg
                 | CompXY Type_XY_Seg

-- gcd n m = if m < n then (gcd m n) else if m == 0 then n else (gcd m (n `mod` m))

signed_gcd n m = gcd (abs n) (abs m)

_reduce n d = let g = (signed_gcd n d) in let ret = (Frac (n `div` g) (d `div` g)) in
    let Frac nn dd = ret in
    (if nn == 0 then (Frac 0 1) else
        if dd < 0 then (Frac (-nn) (-dd)) else ret)

_mul (Frac xn xd) (Frac yn yd) = _reduce (xn*yn) (xd*yd)

_add (Frac xn xd) (Frac yn yd) = _reduce (xn*yd+xd*yn) (xd*yd)

_subtract x (Frac yd yn) = _add x (Frac (-yd)  yn)

compile_segment :: Seg -> CompiledSeg
compile_segment (x1,y1,x2,y2) = (if (x1 == x2)
    then let y_s = (sort [y1,y2]) in (CompX $ Type_X_Only_Seg x1 (y_s!!0) (y_s!!1))
    else (CompXY $ Type_XY_Seg m bb (x_s!!0) (x_s!!1)) ) where
        m = _reduce (y2-y1) (x2-x1)
        bb = _subtract (Frac y1 1) (_mul m (Frac x1 1))
        x_s = sort [x1,x2]


mysegs = map compile_segment $ take 5000 segs
