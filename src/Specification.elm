module Specification exposing ( Specification, Relation, Cardinality(..), Model
                              , Columns, Permissions
                              , allowCreate, allowRead, allowUpdate, allowDelete
                              )



import Array exposing ( Array )
import Set   exposing ( Set )
import Dict  exposing ( Dict )


type alias RowLevelPermissionPredicate = String -> Bool


type alias Permissions = Dict String (Maybe RowLevelPermissionPredicate)


type alias Columns =
    { bool   : Dict String (Array Bool)
    , string : Dict String (Array String)
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
