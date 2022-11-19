import unittest

import convertKana

let teststr = "abcあいうアイウ"

test "convert to hiragana":
  check teststr.convert(ktHiragana) == "abcあいうあいう"

test "convert to katakana":
  check teststr.convert(ktKatakana) == "abcアイウアイウ"
