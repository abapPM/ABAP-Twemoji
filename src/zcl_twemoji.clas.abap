CLASS zcl_twemoji DEFINITION PUBLIC FINAL CREATE PRIVATE.

************************************************************************
* ABAP Twemoji
*
* Support for Twemoji v14.0
* https://github.com/jdecked/twemoji
*
* Copyright 2024 apm.to Inc. <https://apm.to>
* SPDX-License-Identifier: MIT
************************************************************************
* Source locations used for twemoji data:
*
* Local Implementations: Unicode twemoji list
* Macros: CSS for Twemoji
*
* Location of emoji images:
* https://cdn.jsdelivr.net/gh/jdecked/twemoji@15.1.0/assets
************************************************************************
* TODO: Update list and CSS to v15.1
************************************************************************
  PUBLIC SECTION.

    TYPES:
      ty_code    TYPE string_table,
      ty_results TYPE SORTED TABLE OF string WITH UNIQUE KEY table_line.

    CONSTANTS c_version TYPE string VALUE '1.5.0' ##NEEDED.

    CLASS-METHODS create
      RETURNING
        VALUE(result) TYPE REF TO zcl_twemoji.

    METHODS constructor.

    METHODS get_twemoji_css
      RETURNING
        VALUE(result) TYPE ty_code.

    METHODS get_twemoji_list
      RETURNING
        VALUE(result) TYPE ty_code.

    METHODS find_twemoji
      IMPORTING
        !regex        TYPE string
      RETURNING
        VALUE(result) TYPE ty_results.

    METHODS format_twemoji
      IMPORTING
        !line         TYPE string
      RETURNING
        VALUE(result) TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.

    CONSTANTS c_base_url TYPE string VALUE 'https://cdn.jsdelivr.net/gh/jdecked/twemoji@15.1.0/assets'.

    CLASS-DATA twemoji TYPE REF TO zcl_twemoji.

    DATA emojis TYPE HASHED TABLE OF string WITH UNIQUE KEY table_line.

    METHODS init_twemoji_list.

    METHODS get_program_for_twemoji_list
      RETURNING
        VALUE(result) TYPE program.

    METHODS get_program_for_twemoji_css
      RETURNING
        VALUE(result) TYPE program.

ENDCLASS.



CLASS zcl_twemoji IMPLEMENTATION.


  METHOD constructor.

    init_twemoji_list( ).

  ENDMETHOD.


  METHOD create.

    IF twemoji IS INITIAL.
      twemoji = NEW #( ).
    ENDIF.

    result = twemoji.

  ENDMETHOD.


  METHOD find_twemoji.

    LOOP AT emojis ASSIGNING FIELD-SYMBOL(<emoji>).
      IF find(
           val   = <emoji>
           regex = regex
           case  = abap_false ) >= 0.
        INSERT <emoji> INTO TABLE result.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD format_twemoji.

    result = line.

    LOOP AT emojis ASSIGNING FIELD-SYMBOL(<emoji>).
      DATA(twemoji) = |:{ <emoji> }:|.
      DATA(html)  = |<i class="twa twa-{ <emoji> }"></i>|.
      REPLACE ALL OCCURRENCES OF twemoji IN result WITH html.
    ENDLOOP.

  ENDMETHOD.


  METHOD get_program_for_twemoji_css.

    DATA(descr) = cl_abap_classdescr=>get_class_name( me ).
    DATA(class) = CONV seoclsname( descr+7(*) ).

    result = cl_oo_classname_service=>get_ccmac_name( class ).

  ENDMETHOD.


  METHOD get_program_for_twemoji_list.

    DATA(descr) = cl_abap_classdescr=>get_class_name( me ).
    DATA(class) = CONV seoclsname( descr+7(*) ).

    result = cl_oo_classname_service=>get_ccimp_name( class ).

  ENDMETHOD.


  METHOD get_twemoji_css.

    DATA code TYPE ty_code.

    DATA(program) = get_program_for_twemoji_css( ).

    READ REPORT program INTO code STATE 'A'.
    ASSERT sy-subrc = 0.

    LOOP AT code ASSIGNING FIELD-SYMBOL(<line>).
      IF strlen( <line> ) > 2.
        INSERT <line>+2(*) INTO TABLE result.
      ELSE.
        INSERT `` INTO TABLE result.
      ENDIF.
    ENDLOOP.

    REPLACE ALL OCCURRENCES OF '"@/' IN TABLE result WITH |"{ c_base_url }/|.

  ENDMETHOD.


  METHOD get_twemoji_list.

    result = emojis.

  ENDMETHOD.


  METHOD init_twemoji_list.

    DATA code TYPE ty_code.

    CLEAR emojis.

    DATA(program) = get_program_for_twemoji_list( ).

    READ REPORT program INTO code STATE 'A'.
    ASSERT sy-subrc = 0.

    LOOP AT code ASSIGNING FIELD-SYMBOL(<line>) WHERE table_line CP '" *'.
      INSERT <line>+2(*) INTO TABLE emojis.
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
