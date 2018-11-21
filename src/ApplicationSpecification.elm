{-
This file contains the specification of your models, 
including permissions and rendering preferences
-}

module ApplicationSpecification exposing (applicationSpecification)


import Array exposing ( Array, fromList )
import Set   exposing ( empty )
import Tuple exposing ( second )
import Dict  exposing ( Dict, empty, get )


import Specification exposing ( Specification, Model, Relation, Cardinality(..)
                              , Columns, Permissions
                              , allowCreate, allowRead, allowUpdate, allowDelete
                              )


book : (String, Model)
book =
    let
        p : Dict String Permissions
        p = Dict.fromList [ ( "Admin", Dict.empty
                            |> allowCreate Nothing
                            |> allowRead   Nothing
                            |> allowUpdate (Just <| \x -> False)
                            |> allowDelete Nothing
                            )
                          , ( "User", Dict.empty
                            |> allowRead   (Just <| \x -> True)
                            |> allowUpdate (Just <| \x -> False)
                            )
                          ]

        c : Columns
        c = { bool   = Dict.empty
            , string = Dict.fromList
                       [ ("Title",  Array.fromList [ "Free software, free society" ])
                       , ("Author", Array.fromList [ "Richard Matthew Stallman" ])
                       ]
            }
    in
        ( "Book"
        , { permissions = p
          , columns     = c
          }
        )


library : (String, Model)
library =
    let
        p : Dict String Permissions
        p = Dict.empty

        c : Columns
        c = { bool   = Dict.empty
            , string = Dict.empty
            }
    in
        ( "Library"
        , { permissions = p
          , columns     = c
          }
        )

          
bookLibrary : (String, Relation)
bookLibrary = ( "Book_Library"
              , { permissions = Dict.empty
                , left        = second book
                , right       = second library
                , cardinality = OneToOne
                }
              )


applicationSpecification : Specification
applicationSpecification =
    let
        ro = Set.fromList  [ "Admin", "User" ]
        mo = Dict.fromList [ book, library ]
        re = Dict.fromList [ bookLibrary ]
    in      
        { roles     = ro
        , models    = mo
        , relations = re
        }
