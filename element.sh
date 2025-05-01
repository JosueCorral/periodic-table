#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only -c"

  if [[ $1 ]]
  then
    #Validate number symbol name
    if [[ ! $1 =~ ^[0-9]+$ ]]
    then
    #Validate if Symbol or name
      if [[ ${#1} -gt 2 ]]
      then
      #By Name
      GET_DATA_BY_NAME=$($PSQL "SELECT elements.atomic_number, symbol, name, atomic_mass, melting_point_celsius, boiling_point_celsius, type FROM elements INNER JOIN properties ON elements.atomic_number = properties.atomic_number INNER JOIN types ON properties.type_id = types.type_id WHERE name = '$1';")
        if [[ -z $GET_DATA_BY_NAME ]]
          then
          echo "I could not find that element in the database."
          else
          echo "$GET_DATA_BY_NAME" | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELTING BAR BOILING BAR TYPE
          do

          echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."

          done
        fi

      else
        #By Symbol
        GET_DATA_BY_SYMBOL=$($PSQL "SELECT elements.atomic_number, symbol, name, atomic_mass, melting_point_celsius, boiling_point_celsius, type FROM elements INNER JOIN properties ON elements.atomic_number = properties.atomic_number INNER JOIN types ON properties.type_id = types.type_id WHERE symbol = '$1';")
        if [[ -z $GET_DATA_BY_SYMBOL ]]
          then
          echo "I could not find that element in the database."
          else
          echo "$GET_DATA_BY_SYMBOL" | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELTING BAR BOILING BAR TYPE
          do

          echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."

          done
        fi
         
      
      fi

    

    else
      #If atomic number provided
      GET_DATA_BY_NUMBER=$($PSQL "SELECT elements.atomic_number, symbol, name, atomic_mass, melting_point_celsius, boiling_point_celsius, type FROM elements INNER JOIN properties ON elements.atomic_number = properties.atomic_number INNER JOIN types ON properties.type_id = types.type_id WHERE elements.atomic_number = '$1';")
      if [[ -z $GET_DATA_BY_NUMBER ]]
      then
        echo "I could not find that element in the database."
      else
      echo "$GET_DATA_BY_NUMBER" | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELTING BAR BOILING BAR TYPE
      do

      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."

      done
      fi
    fi
   
  else
  echo "Please provide an element as an argument."
  fi
