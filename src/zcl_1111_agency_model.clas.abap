CLASS zcl_1111_agency_model DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS get_agency IMPORTING i_agency        TYPE /dmo/agency_id
                       RETURNING VALUE(r_agency) TYPE zc_abapd_agency
                       RAISING zcx_1111_no_agency.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_1111_AGENCY_MODEL IMPLEMENTATION.


  METHOD get_agency.
    SELECT SINGLE FROM zc_abapd_agency
    FIELDS *
    WHERE agencyId = @i_agency
    INTO @r_agency.

* To Do: Add suitable error handling if no data is returned
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_1111_no_agency
        EXPORTING
          textid = zcx_1111_no_agency=>no_agency.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
