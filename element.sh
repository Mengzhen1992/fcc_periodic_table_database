#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"


if [[ $# -eq 0 ]]
then 
  # if no arguments
  echo Please provide an element as an argument. 
elif [[ $1 =~ ^[0-9]+$ ]]
then
  ELEMENT_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1")
  if [[ -z $ELEMENT_NUMBER ]]
  then 
    echo I could not find that element in the database.
  else
    ELEMENT_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$1")
    ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$1")
    ELEMENT_TYPE=$($PSQL "SELECT type FROM types FULL JOIN properties USING(type_id) WHERE atomic_number=$1")
    ELEMENT_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$1")
    ELEMENT_MELTING=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$1")
    ELEMENT_BOILING=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$1")
    echo "The element with atomic number $ELEMENT_NUMBER is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ELEMENT_MASS amu. $ELEMENT_NAME has a melting point of $ELEMENT_MELTING celsius and a boiling point of $ELEMENT_BOILING celsius."
  fi
elif [[ "$1" =~ ^[A-Z][a-zA-Z]{0,1}$ ]]
then
  ELEMENT_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol='$1'")
  if [[ -z $ELEMENT_SYMBOL ]]
  then 
    echo I could not find that element in the database.
  else
    ELEMENT_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1'")
    ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE symbol='$1'")
    ELEMENT_TYPE=$($PSQL "SELECT type FROM types FULL JOIN properties USING(type_id) FULL JOIN elements USING(atomic_number) WHERE symbol='$1'")
    ELEMENT_MASS=$($PSQL "SELECT atomic_mass FROM properties FULL JOIN elements USING(atomic_number) WHERE symbol='$1'")
    ELEMENT_MELTING=$($PSQL "SELECT melting_point_celsius FROM properties FULL JOIN elements USING(atomic_number) WHERE symbol='$1'")
    ELEMENT_BOILING=$($PSQL "SELECT boiling_point_celsius FROM properties FULL JOIN elements USING(atomic_number) WHERE symbol='$1'")
    echo "The element with atomic number $ELEMENT_NUMBER is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ELEMENT_MASS amu. $ELEMENT_NAME has a melting point of $ELEMENT_MELTING celsius and a boiling point of $ELEMENT_BOILING celsius."
  fi
else
  ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE name='$1'")
  if [[ -z $ELEMENT_NAME ]]
  then 
    echo I could not find that element in the database.
  else
    ELEMENT_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name='$1'")
    ELEMENT_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE name='$1'")
    ELEMENT_TYPE=$($PSQL "SELECT type FROM types FULL JOIN properties USING(type_id) FULL JOIN elements USING(atomic_number) WHERE name='$1'")
    ELEMENT_MASS=$($PSQL "SELECT atomic_mass FROM properties FULL JOIN elements USING(atomic_number) WHERE name='$1'")
    ELEMENT_MELTING=$($PSQL "SELECT melting_point_celsius FROM properties FULL JOIN elements USING(atomic_number) WHERE name='$1'")
    ELEMENT_BOILING=$($PSQL "SELECT boiling_point_celsius FROM properties FULL JOIN elements USING(atomic_number) WHERE name='$1'")
    echo "The element with atomic number $ELEMENT_NUMBER is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ELEMENT_MASS amu. $ELEMENT_NAME has a melting point of $ELEMENT_MELTING celsius and a boiling point of $ELEMENT_BOILING celsius."
  fi
fi
