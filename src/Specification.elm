module Specification exposing ( Specification, Relation, Cardinality(..), Model
                              , Columns, Permissions, allowCreate, allowRead
                              , allowUpdate, allowDelete, columnsZero, addBoolColumns
                              , addIntColumns, addStringColumns
                              )



import Array exposing ( Array )
import Set   exposing ( Set )
import Dict  exposing ( Dict, union )
-- import Date  exposing ( Date )
-- import Time  exposing ( Time)


type alias RowLevelPermissionPredicate = String -> Bool


type alias Permissions = Dict String (Maybe RowLevelPermissionPredicate)


{-
This data structure allows the same name to be set for multiple columns.
I'd like to avoid that, but it doesn't seem to be possible to define a
dictionary that supports multiple array types for the values.
I'll need to find some solution for this later.

Actually it occurred to me it is a better idea to have functions for adding
fields rather than individual columns. That avoids a mismatch in the number
of entries.
-}
type alias Columns =
    { bool   : Maybe (Dict String (Array Bool))
    -- , date   : Maybe (Dict String (Array Date))
    -- , double : Maybe (Dict String (Array Double))
    , int    : Maybe (Dict String (Array Int))
    , string : Maybe (Dict String (Array String))
    -- , time   : Maybe (Dict String (Array Time))
    }


type alias Model =
    { permissions : Dict String Permissions
    , columns     : Columns
    }


type Cardinality
    = OneToOne
    | OneToMany
    | ManyToOne
    | ManyToMany


type alias Relation =
    { permissions : Dict String Permissions
    , left        : Model
    , right       : Model
    , cardinality : Cardinality
    }

    
type alias Specification =
    { roles     : Set String
    , models    : Dict String Model
    , relations : Dict String Relation
    }


allowCreate : Maybe RowLevelPermissionPredicate -> Dict String (Maybe RowLevelPermissionPredicate) -> Permissions
allowCreate predicate permissions = Dict.insert "Create" predicate permissions


allowRead : Maybe RowLevelPermissionPredicate -> Dict String (Maybe RowLevelPermissionPredicate) -> Permissions
allowRead predicate permissions = Dict.insert "Read" predicate permissions


allowUpdate : Maybe RowLevelPermissionPredicate -> Dict String (Maybe RowLevelPermissionPredicate) -> Permissions
allowUpdate predicate permissions = Dict.insert "Update" predicate permissions


allowDelete : Maybe RowLevelPermissionPredicate -> Dict String (Maybe RowLevelPermissionPredicate) -> Permissions
allowDelete predicate permissions = Dict.insert "Delete" predicate permissions


columnsZero : Columns
columnsZero =
    { bool   = Nothing
    -- , date   = Nothing
    -- , double = Nothing
    , int    = Nothing
    , string = Nothing
    -- , time   = Nothing
    }


addBoolColumns : Dict String (Array Bool) -> Columns -> Columns
addBoolColumns x y =
    case y.bool of
        Nothing ->
            y

        Just elements ->
            { y | bool = Just <| Dict.union x elements }


addIntColumns : Dict String (Array Int) -> Columns -> Columns
addIntColumns x y =
    case y.int of
        Nothing ->
            y

        Just elements ->
            { y | int = Just <| Dict.union x elements }
                
    
addStringColumns : Dict String (Array String) -> Columns -> Columns
addStringColumns x y =
    case y.string of
        Nothing ->
            y

        Just elements ->
            { y | string = Just <| Dict.union x elements }
