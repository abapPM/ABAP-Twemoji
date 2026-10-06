********************************************************************************
* Twemoji List
*
* Copyright 2026 apm.to Inc. <https://apm.to>
* SPDX-License-Identifier: MIT
********************************************************************************

REPORT /apmg/twemoji_list.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-t01.
  PARAMETERS p_regex TYPE string LOWER CASE DEFAULT 'face'.
SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-t02.
  PARAMETERS:
    p_size RADIOBUTTON GROUP g1 DEFAULT 'X',
    p_lg   RADIOBUTTON GROUP g1,
    p_2x   RADIOBUTTON GROUP g1,
    p_3x   RADIOBUTTON GROUP g1,
    p_4x   RADIOBUTTON GROUP g1,
    p_5x   RADIOBUTTON GROUP g1.
SELECTION-SCREEN END OF BLOCK b2.

START-OF-SELECTION.

  CASE abap_true.
    WHEN p_size.
      DATA(size) = ``.
    WHEN p_lg.
      size = `lg`.
    WHEN p_2x.
      size = `2x`.
    WHEN p_3x.
      size = `3x`.
    WHEN p_4x.
      size = `4x`.
    WHEN p_5x.
      size = `5x`.
  ENDCASE.

  DATA(emoji) = /apmg/cl_twemoji=>create( ).

  DATA(html) =
    `<!DOCTYPE html>` &&
    `<html lang="en">` &&
    `<head>` &&
    `<title>Emoji Tester</title>` &&
    `<style>` && emoji->styles( ) && `</style>` &&
    `</head>` &&
    `<body>`.

  DATA(list) = emoji->get_list( ).

  html = html && |<h1>Twemoji List ({ lines( list ) } emoji)</h1>|.


  DATA(count) = 0.

  " TODO: Format this as a nice table
  LOOP AT list ASSIGNING FIELD-SYMBOL(<emoji>).
    IF p_regex IS NOT INITIAL.
      FIND REGEX p_regex IN <emoji> ##REGEX_POSIX.
      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.
    ENDIF.

    DATA(tag) = |:{ <emoji> }:|.
    html = html && emoji->format( line = tag size = size ) && |  { tag }|.
    html = html && '<br><div style="height:3px;"></div>'.
    count = count + 1.
  ENDLOOP.

  html = html && |<h2>{ count } twemoji selected</h2>|.

  html = html && `</html>`.

  cl_abap_browser=>show_html(
    title       = 'Twemoji List'
    dialog      = abap_false
    html_string = html ).
