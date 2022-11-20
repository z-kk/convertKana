import unittest

import convertKana

let teststr = "japaneseじゃぱにーずジャパニーズｼﾞｬﾊﾟﾆｰｽﾞ"

test "convert to hiragana":
  check teststr.convert(ktHiragana) == "japaneseじゃぱにーずじゃぱにーずじゃぱにーず"

test "convert to katakana":
  check teststr.convert(ktKatakana) == "japaneseジャパニーズジャパニーズジャパニーズ"

test "convert to halfkana":
  check teststr.convert(ktHalfKana) == "japaneseｼﾞｬﾊﾟﾆｰｽﾞｼﾞｬﾊﾟﾆｰｽﾞｼﾞｬﾊﾟﾆｰｽﾞ"
