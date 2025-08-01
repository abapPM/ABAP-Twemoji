CLASS ltcl_test DEFINITION FOR TESTING RISK LEVEL HARMLESS DURATION SHORT FINAL.

  PRIVATE SECTION.
    DATA cut TYPE REF TO /apmg/cl_twemoji.

    METHODS setup.
    METHODS twemoji_find FOR TESTING.
    METHODS twemoji_format FOR TESTING.
    METHODS twemoji_styles FOR TESTING.
    METHODS twemoji_list FOR TESTING.

ENDCLASS.

CLASS ltcl_test IMPLEMENTATION.

  METHOD setup.
    cut = /apmg/cl_twemoji=>create( ).
  ENDMETHOD.

  METHOD twemoji_find.
    DATA(emojis) = cut->find_twemoji( '^sparkles$' ).

    cl_aunit_assert=>assert_equals(
      act = lines( emojis )
      exp = 1 ).
  ENDMETHOD.

  METHOD twemoji_format.
    DATA(html) = cut->format_twemoji( 'Here are some :sparkles:' ).

    cl_aunit_assert=>assert_equals(
      act = html
      exp = 'Here are some <i class="twa twa-sparkles"></i>' ).
  ENDMETHOD.

  METHOD twemoji_styles.
    DATA(css) = cut->get_twemoji_styles( ).

    cl_aunit_assert=>assert_not_initial( css ).
  ENDMETHOD.

  METHOD twemoji_list.
    DATA(emojis) = cut->get_twemoji_list( ).

    cl_aunit_assert=>assert_not_initial( emojis ).
  ENDMETHOD.

ENDCLASS.
