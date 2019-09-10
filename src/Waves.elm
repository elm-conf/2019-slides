module Waves exposing (..)

import Svg exposing (Svg, g, svg)
import Svg.Attributes exposing (..)


waves : Svg msg
waves =
    svg [ width "1084", height "580" ]
        [ g [ stroke "#F0F0F0", strokeWidth "2", fill "none", fillRule "evenodd" ]
            [ Svg.path [ d "M-2334 610c775.46 0 1157.23-338 1907.367-338S724.303 610 1474.996 610c750.692 0 1123.28-338 1888.004-338" ] []
            , Svg.path [ d "M-2075 563c704.951 0 1052.009-307 1733.94-307 681.93 0 1046.287 307 1728.722 307C2070.098 563 2408.81 256 3104 256", opacity ".947" ] []
            , Svg.path [ d "M-1840 519c640.84 0 956.334-279 1576.248-279 619.913 0 951.133 279 1571.505 279 620.373 0 928.28-279 1560.247-279", opacity ".895" ] []
            , Svg.path [ d "M-1626 478c582.582 0 869.395-254 1432.953-254 563.557 0 864.666 254 1428.64 254 563.976 0 843.89-254 1418.407-254", opacity ".842" ] []
            , Svg.path [ d "M-1432 439c529.632 0 790.378-231 1302.715-231 512.337 0 786.079 231 1298.795 231 512.716 0 767.19-231 1289.49-231", opacity ".789" ] []
            , Svg.path [ d "M-1255 402c481.447 0 718.47-210 1184.195-210 465.725 0 714.562 210 1180.632 210 466.07 0 697.392-210 1172.173-210", opacity ".737" ] []
            , Svg.path [ d "M-1094 367c437.617 0 653.062-191 1076.388-191 423.327 0 649.51 191 1073.15 191 423.64 0 633.904-191 1065.462-191", opacity ".684" ] []
            , Svg.path [ d "M-948 334c397.87 0 593.748-174 978.626-174 384.878 0 590.52 174 975.682 174 385.163 0 576.33-174 968.692-174", opacity ".632" ] []
            , Svg.path [ d "M-815 302c361.664 0 539.716-158 889.569-158 349.853 0 536.78 158 886.892 158 350.113 0 523.883-158 880.539-158", opacity ".579" ] []
            , Svg.path [ d "M-694 272c328.723 0 490.558-144 808.547-144 317.988 0 487.89 144 806.114 144 318.224 0 476.167-144 800.339-144", opacity ".526" ] []
            , Svg.path [ d "M-584 243c298.777 0 445.87-131 734.89-131 289.021 0 443.445 131 732.68 131 289.235 0 432.79-131 727.43-131", opacity ".474" ] []
            , Svg.path [ d "M-484 215c271.554 0 405.244-119 667.93-119 262.686 0 403.04 119 665.92 119 262.881 0 393.356-119 661.15-119", opacity ".421" ] []
            , Svg.path [ d "M-394 188c246.917 0 368.477-108 607.33-108 238.854 0 366.474 108 605.504 108 239.03 0 357.668-108 601.166-108", opacity ".368" ] []
            , Svg.path [ d "M-312 162c224.457 0 334.96-98 552.088-98s333.14 98 550.428 98S1115.65 64 1337 64", opacity ".316" ] []
            , Svg.path [ d "M-237 137c204.04 0 304.491-89 501.868-89s302.836 89 500.358 89c197.523 0 295.56-89 496.774-89", opacity ".263" ] []
            , Svg.path [ d "M-169 113c185.528 0 276.866-81 456.335-81 179.47 0 275.36 81 454.962 81C921.9 113 1011.041 32 1194 32", opacity ".211" ] []
            , Svg.path [ d "M-107 90c168.65 0 251.678-74 414.82-74s250.309 74 413.57 74C884.654 90 965.686 16 1132 16", opacity ".158" ] []
            , Svg.path [ d "M-51 67C102.268 67 177.724 0 325.987 0 474.25 0 553.467 67 701.84 67 850.213 67 923.854 0 1075 0", opacity ".105" ] []
            , Svg.path [ d "M0 44.88C139.384 44.88 208.005-16 342.837-16c134.833 0 206.874 60.88 341.806 60.88S886.546-16 1024-16", opacity ".053" ] []
            ]
        ]
