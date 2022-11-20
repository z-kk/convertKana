import
  convertKanapkg / submodule

export
  KanaType

proc convert*(str: string, kt: KanaType): string =
  ## convert Kana
  let strList = str.toRuneStrList
  case kt
  of ktHiragana:
    for runeStr in strList:
      result.add runeStr.toHiragana
  of ktKatakana:
    for runeStr in strList:
      result.add runeStr.toKatakana
  of ktHalfKana:
    for runeStr in strList:
      result.add runeStr.toHalfKana

when isMainModule:
  import
    std / parseopt

  var
    target: string
    kanaType: KanaType

  for kind, key, val in getopt():
    case kind
    of cmdArgument:
      target = key
    of cmdLongOption, cmdShortOption:
      case key
      of "h", "hira", "hiragana":
        kanaType = ktHiragana
      of "k", "kata", "katakana":
        kanaType = ktKatakana
      of "halk", "han", "hankaku":
        kanaType = ktHalfKana
    of cmdEnd:
      discard

  echo target.convert(kanaType)
