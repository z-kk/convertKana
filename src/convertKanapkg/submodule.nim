import
  std / unicode

type
  KanaType* = enum
    ktHiragana
    ktKatakana

proc toRuneStrList*(str: string): seq[string] =
  ## split string to Runes
  let runes = str.toRunes
  for rune in runes:
    result.add $rune

proc toHiragana*(str: string): string =
  ## convert to Hiragana
  if str.len == 0:
    return
  if str[0].ord == 0xe3:
    if str.len != 3:
      return
    let cp = str[1].ord shl 8 + str[2].ord
    if cp in {0x82a1 .. 0x82bf, 0x83a0 .. 0x83b6}:
      # ァ～タ, ム～ヶ
      result.add str[0]
      result.add (str[1].ord - 0x01).chr
      result.add (str[2].ord - 0x20).chr
    elif cp in 0x8380 .. 0x839f:
      # ダ～ミ
      result.add str[0]
      result.add (str[1].ord - 0x02).chr
      result.add (str[2].ord + 0x20).chr
    else:
      return str
  else:
    return str

proc toKatakana*(str: string): string =
  ## convert to Katakana
  if str.len == 0:
    return
  if str[0].ord == 0xe3:
    if str.len != 3:
      return
    let cp = str[1].ord shl 8 + str[2].ord
    if cp in {0x8181 .. 0x819f, 0x8280 .. 0x8296}:
      # ぁ～た, む～ゖ
      result.add str[0]
      result.add (str[1].ord + 0x01).chr
      result.add (str[2].ord + 0x20).chr
    elif cp in 0x81a0 .. 0x81bf:
      # だ～み
      result.add str[0]
      result.add (str[1].ord + 0x02).chr
      result.add (str[2].ord - 0x20).chr
    else:
      return str
  else:
    return str
