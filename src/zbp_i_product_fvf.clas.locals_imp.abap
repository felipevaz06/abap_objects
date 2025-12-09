*CLASS lhc_movment DEFINITION INHERITING FROM cl_abap_behavior_handler.
*
*  PRIVATE SECTION.
*
**    METHODS get_instance_features FOR INSTANCE FEATURES
**      IMPORTING keys REQUEST requested_features FOR Movment RESULT result.
*
**    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
**      IMPORTING REQUEST requested_authorizations FOR Movment RESULT result.
*
**    METHODS add_product FOR MODIFY
**      IMPORTING keys FOR ACTION Movment~add_product RESULT result.
*
*ENDCLASS.
*
*CLASS lhc_movment IMPLEMENTATION.
*
**  METHOD get_instance_features.
**  ENDMETHOD.
*
**  METHOD get_global_authorizations.
**  ENDMETHOD.
*
*  METHOD add_product.
*
*    DATA products_for_update TYPE TABLE FOR UPDATE ZI_MOVMENT_FVF.
*
*    DATA(valid_keys) = keys.
*
*    CHECK valid_keys IS NOT INITIAL.
*
*    READ ENTITIES OF ZI_PRODUCT_FVF IN LOCAL MODE
*     ENTITY Movment
*     FIELDS ( Quantity )
*     WITH CORRESPONDING #( valid_keys )
*     RESULT DATA(quantity).
*
*     LOOP AT quantity ASSIGNING FIELD-SYMBOL(<quant>).
*
*      DATA(quant_upd) = <quant>-Quantity + valid_keys[ 1 ]-%param-quantity_to.
*
*      APPEND VALUE #( %tky       = <quant>-%tky
*                      Quantity = quant_upd
*                      MovmentType = 'I'
*                    ) TO products_for_update.
*
*      ENDLOOP.
*
*      MODIFY ENTITIES OF ZI_PRODUCT_FVF IN LOCAL MODE
*      ENTITY Movment
*       UPDATE FIELDS ( Quantity MovmentType )
*       WITH products_for_update.
*
*      READ ENTITIES OF ZI_PRODUCT_FVF IN LOCAL MODE
*      ENTITY Movment
*        ALL FIELDS WITH
*        CORRESPONDING #( quantity )
*      RESULT DATA(added_product).
*
*    " set action result
*    result = VALUE #( FOR travel IN added_product ( %tky   = travel-%tky
*                                                            %param = travel ) ).
*
*
*
*
*
*
*  ENDMETHOD.
*
*ENDCLASS.

CLASS lhc_Product DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Product RESULT result.
*    METHODS get_instance_features FOR INSTANCE FEATURES
*      IMPORTING keys REQUEST requested_features FOR Product RESULT result.

    METHODS add_product FOR MODIFY
      IMPORTING keys FOR ACTION Product~add_product.

ENDCLASS.

CLASS lhc_Product IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

*  METHOD get_instance_features.
*  ENDMETHOD.

  METHOD add_product.


  DATA:
  movments       TYPE TABLE FOR CREATE zi_product_fvf\_movments.


   "APPEND INITIAL LINE TO movments.
  DATA products_for_update TYPE TABLE FOR UPDATE ZI_MOVMENT_FVF.

    DATA(valid_keys) = keys.

    CHECK valid_keys IS NOT INITIAL.

    READ ENTITIES OF ZI_PRODUCT_FVF IN LOCAL MODE
     ENTITY Movment
     FIELDS ( Quantity ) WITH CORRESPONDING #( keys )
     RESULT DATA(mov_read_result).


*     LOOP AT mov_read_result ASSIGNING FIELD-SYMBOL(<quant>).
*
*      " fill in travel container for creating new travel instance
*      APPEND VALUE #(
*
*                      %data     = CORRESPONDING #( <travel> EXCEPT TravelID )
*                   )
*        TO movments ASSIGNING FIELD-SYMBOL(<new_travel>).
*
*      " adjust the copied travel instance data
*      "" BeginDate must be on or after system date
*      <new_travel>-     = cl_abap_context_info=>get_system_date( ).
*      "" EndDate must be after BeginDate
*      <new_travel>-EndDate       = cl_abap_context_info=>get_system_date( ) + 30.
*      "" OverallStatus of new instances must be set to open ('O')
*      <new_travel>-OverallStatus = travel_status-open.
*    ENDLOOP.


*     LOOP AT quantity ASSIGNING FIELD-SYMBOL(<quant>).
*
*      DATA(quant_upd) = <quant>-Quantity + valid_keys[ 1 ]-%param-quantity_to.
*
*      APPEND VALUE #( %tky       = <quant>-%tky
*                      Quantity = quant_upd
*                      MovmentType = 'I'
*                    ) TO products_for_update.
*
*      ENDLOOP.



*      MODIFY ENTITIES OF ZI_PRODUCT_FVF IN LOCAL MODE
*      ENTITY Movment
*      CREATE FIELDS ( MovmentId  )
*       WITH products_for_update.
*
*      READ ENTITIES OF ZI_PRODUCT_FVF IN LOCAL MODE
*      ENTITY Movment
*        ALL FIELDS WITH
*        CORRESPONDING #( quantity )
*      RESULT DATA(added_product).
*
*    " set action result
*    result = VALUE #( FOR travel IN added_product ( %tky   = travel-%tky
*                                                            %param = travel ) ).
  ENDMETHOD.

ENDCLASS.
