CLASS zcl_1111_connections DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS get_connections
      IMPORTING
        i_departure TYPE /dmo/airport_from_id
      RETURNING
        VALUE(r_connections) TYPE zcert_connections.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_1111_connections IMPLEMENTATION.
  METHOD get_connections.

    DATA: ls_connection TYPE ZCERT_CONNECTION,
          lt_direct     TYPE zcert_connections,
          lt_indirect   TYPE zcert_connections.

    SELECT
        carrier_id,
        airport_from_id,
        airport_to_id,
        '-' AS airport_via_id
    FROM /dmo/connection
    WHERE airport_from_id = @i_departure
    INTO TABLE @lt_direct.

    APPEND LINES OF lt_direct TO r_connections.

    SELECT
      a~carrier_id,
      a~airport_from_id,
      b~airport_to_id,
      a~airport_to_id AS airport_via_id
    FROM /dmo/connection AS a
    JOIN /dmo/connection AS b
      ON a~carrier_id = b~carrier_id
     AND a~airport_to_id = b~airport_from_id
    WHERE a~airport_from_id = @i_departure
      AND b~airport_to_id <> @i_departure
    INTO TABLE @lt_indirect.

    APPEND LINES OF lt_indirect TO r_connections.

  ENDMETHOD.

ENDCLASS.
