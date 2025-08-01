********************************************************************************
* Twemoji Tester
*
* Copyright 2024 apm.to Inc. <https://apm.to>
* SPDX-License-Identifier: MIT
********************************************************************************

REPORT /apmg/twemoji_tester.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.
  PARAMETERS p_text TYPE string LOWER CASE
    DEFAULT 'Twemoji for ABAP made with :red-heart: in Canada :flag-canada:'.
SELECTION-SCREEN END OF BLOCK b1.

START-OF-SELECTION.

  DATA(emoji) = /apmg/cl_twemoji=>create( ).

  DATA(html) =
    `<html>` &&
    `<head>` &&
    `<title>Emoji Tester</title>` &&
    `<style>` && concat_lines_of( emoji->get_twemoji_styles( ) ) && `</style>` &&
    `</head>` &&
    `<body>` && emoji->format_twemoji( p_text ) && `</body>` &&
    `</html>`.

  cl_abap_browser=>show_html(
    title       = 'Twemoji Tester'
    html_string = html ).
