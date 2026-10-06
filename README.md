![Version](https://img.shields.io/endpoint?url=https://shield.abappm.com/github/abapPM/ABAP-Twemoji/src/%2523apmg%2523cl_twemoji.clas.abap/c_version&label=Version&color=blue)

[![License](https://img.shields.io/github/license/abapPM/ABAP-Emoji?label=License&color=success)](LICENSE)
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg?color=success)](https://github.com/abapPM/.github/blob/main/CODE_OF_CONDUCT.md)
[![REUSE Status](https://api.reuse.software/badge/github.com/abapPM/ABAP-Emoji)](https://api.reuse.software/info/github.com/abapPM/ABAP-Emoji)

# ✨ ABAP-Twemoji ✨

[Twitter Emoji](https://github.com/ikatyang/emoji-cheat-sheet/blob/master/README.md) Sets for ABAP.

Currently supports Twemoji v14.0

Based on [Twemoji](https://github.com/jdecked/twemoji) and [Twemoji-Amazing](https://github.com/SebastianAigner/twemoji-amazing) with assets located at `https://cdn.jsdelivr.net/gh/jdecked/twemoji@latest/assets`.

Twemoji are in SVG format. If you looking for emoji in PNG format, check out [ABAP Emoji](https://registry.abappm.com/emoji).

NO WARRANTIES, [MIT License](LICENSE)

## Prerequisite

HTML output with Internet connection since Twemoji graphics are hosted on a CDN.

## Usage

Use a [preview page](https://jdecked.github.io/twemoji/v/latest/preview-svg.html) to view supported Emoji shortcodes. Raw text may contains the emoji character (cut&paste it into your text) or the emoji shortcode.

Get CSS for the emoji class:

```abap
data(emoji) = /apmg/cl_twemoji=>create( ).
data(css) = emoji->styles( ).
```

Find emojis with regex:

```abap
data(list) = emoji->find( '^red-heart$' ).
```

Format any text:

```abap
write emoji->format( 'I :red-heart: ABAP' ).
```

I ❤ ABAP

```html
I <i class="twa twa-red-heart"></i> ABAP
```

Optionally, get the emoji in larger sizes: `lg`, `2x`, `3x`, `4x`, or `5x`.

```abap
write emoji->format( 
  line = 'Party! :partying-face:' 
  size = '3x' ).
```

## Installation

Install `twemoji` as a global module in your system using [apm](https://abappm.com).

or

Specify the `twemoji` module as a dependency in your project and import it to your namespace using [apm](https://abappm.com).

## Contributions

All contributions are welcome! Read our [Contribution Guidelines](https://github.com/abapPM/ABAP-Emoji/blob/main/CONTRIBUTING.md), fork this repo, and create a pull request.

You can install the developer version of ABAP Twemoji using [abapGit](https://github.com/abapGit/abapGit) by creating a new online repository for `https://github.com/abapPM/ABAP-Twemoji`.

Recommended SAP package: `/APMG/TWEMOJI`

## Attribution

The Emoji data is under the Unicode License and copyright to the Unicode Consortium. The full license can be found here: http://www.unicode.org/copyright.html.

## About

Made with ❤ in Canada

Copyright 2025 apm.to Inc. <https://apm.to>

Follow [@marcf.be](https://bsky.app/profile/marcf.be) on Bluesky and [@marcfbe](https://linkedin.com/in/marcfbe) or LinkedIn
