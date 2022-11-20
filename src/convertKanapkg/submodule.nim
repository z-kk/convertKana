import
  std / [tables, unicode]

type
  KanaType* = enum
    ktHiragana
    ktKatakana
    ktHalfKana

  Gojuon = enum
    a, i, u, e, o,
    ka, ki, ku, ke, ko,
    sa, si, su, se, so,
    ta, ti, tu, te, to,
    na, ni, nu, ne, no,
    ha, hi, hu, he, ho,
    ma, mi, mu, me, mo,
    ya, yi, yu, ye, yo,
    ra, ri, ru, re, ro,
    wa, wo, n , vu,
    ga, gi, gu, ge, go,
    za, zi, zu, ze, zo,
    da, di, du, de, `do`,
    ba, bi, bu, be, bo,
    pa, pi, pu, pe, po,
    la, li, lu, le, lo,
    lka, lke, ltu,
    lya, lyu, lyo,
    lwa,
    bar, ten, daku, maru

  KanaSet = tuple[hira, kata, half: string]

const
  KanaDef: Table[string, Gojuon] =
    {
      "あ": a, "い": i, "う": u, "え": e, "お": o,
      "か": ka, "き": ki, "く": ku, "け": ke, "こ": ko,
      "さ": sa, "し": si, "す": su, "せ": se, "そ": so,
      "た": ta, "ち": ti, "つ": tu, "て": te, "と": to,
      "な": na, "に": ni, "ぬ": nu, "ね": ne, "の": no,
      "は": ha, "ひ": hi, "ふ": hu, "へ": he, "ほ": ho,
      "ま": ma, "み": mi, "む": mu, "め": me, "も": mo,
      "や": ya, "ゐ": yi, "ゆ": yu, "ゑ": ye, "よ": yo,
      "ら": ra, "り": ri, "る": ru, "れ": re, "ろ": ro,
      "わ": wa, "を": wo, "ん": n,  "ゔ": vu,
      "が": ga, "ぎ": gi, "ぐ": gu, "げ": ge, "ご": go,
      "ざ": za, "じ": zi, "ず": zu, "ぜ": ze, "ぞ": zo,
      "だ": da, "ぢ": di, "づ": du, "で": de, "ど": `do`,
      "ば": ba, "び": bi, "ぶ": bu, "べ": be, "ぼ": bo,
      "ぱ": pa, "ぴ": pi, "ぷ": pu, "ぺ": pe, "ぽ": po,
      "ぁ": la, "ぃ": li, "ぅ": lu, "ぇ": le, "ぉ": lo,
      "ゕ": lka, "ゖ": lke, "っ": ltu,
      "ゃ": lya, "ゅ": lyu, "ょ": lyo,
      "ゎ": lwa,
      "ー": bar, "・": ten, "゛": daku, "゜": maru,

      "ア": a, "イ": i, "ウ": u, "エ": e, "オ": o,
      "カ": ka, "キ": ki, "ク": ku, "ケ": ke, "コ": ko,
      "サ": sa, "シ": si, "ス": su, "セ": se, "ソ": so,
      "タ": ta, "チ": ti, "ツ": tu, "テ": te, "ト": to,
      "ナ": na, "ニ": ni, "ヌ": nu, "ネ": ne, "ノ": no,
      "ハ": ha, "ヒ": hi, "フ": hu, "ヘ": he, "ホ": ho,
      "マ": ma, "ミ": mi, "ム": mu, "メ": me, "モ": mo,
      "ヤ": ya, "ヰ": yi, "ユ": yu, "ヱ": ye, "ヨ": yo,
      "ラ": ra, "リ": ri, "ル": ru, "レ": re, "ロ": ro,
      "ワ": wa, "ヲ": wo, "ン": n,  "ヴ": vu,
      "ガ": ga, "ギ": gi, "グ": gu, "ゲ": ge, "ゴ": go,
      "ザ": za, "ジ": zi, "ズ": zu, "ゼ": ze, "ゾ": zo,
      "ダ": da, "ヂ": di, "ヅ": du, "デ": de, "ド": `do`,
      "バ": ba, "ビ": bi, "ブ": bu, "ベ": be, "ボ": bo,
      "パ": pa, "ピ": pi, "プ": pu, "ペ": pe, "ポ": po,
      "ァ": la, "ィ": li, "ゥ": lu, "ェ": le, "ォ": lo,
      "ヵ": lka, "ヶ": lke, "ッ": ltu,
      "ャ": lya, "ュ": lyu, "ョ": lyo,
      "ヮ": lwa,
      "ー": bar, "・": ten, "゛": daku, "゜": maru,

      "ｱ": a, "ｲ": i, "ｳ": u, "ｴ": e, "ｵ": o,
      "ｶ": ka, "ｷ": ki, "ｸ": ku, "ｹ": ke, "ｺ": ko,
      "ｻ": sa, "ｼ": si, "ｽ": su, "ｾ": se, "ｿ": so,
      "ﾀ": ta, "ﾁ": ti, "ﾂ": tu, "ﾃ": te, "ﾄ": to,
      "ﾅ": na, "ﾆ": ni, "ﾇ": nu, "ﾈ": ne, "ﾉ": no,
      "ﾊ": ha, "ﾋ": hi, "ﾌ": hu, "ﾍ": he, "ﾎ": ho,
      "ﾏ": ma, "ﾐ": mi, "ﾑ": mu, "ﾒ": me, "ﾓ": mo,
      "ﾔ": ya, "ｲ": yi, "ﾕ": yu, "ｴ": ye, "ﾖ": yo,
      "ﾗ": ra, "ﾘ": ri, "ﾙ": ru, "ﾚ": re, "ﾛ": ro,
      "ﾜ": wa, "ｦ": wo, "ﾝ": n,  "ｳﾞ": vu,
      "ｶﾞ": ga, "ｷﾞ": gi, "ｸﾞ": gu, "ｹﾞ": ge, "ｺﾞ": go,
      "ｻﾞ": za, "ｼﾞ": zi, "ｽﾞ": zu, "ｾﾞ": ze, "ｿﾞ": zo,
      "ﾀﾞ": da, "ﾁﾞ": di, "ﾂﾞ": du, "ﾃﾞ": de, "ﾄﾞ": `do`,
      "ﾊﾞ": ba, "ﾋﾞ": bi, "ﾌﾞ": bu, "ﾍﾞ": be, "ﾎﾞ": bo,
      "ﾊﾟ": pa, "ﾋﾟ": pi, "ﾌﾟ": pu, "ﾍﾟ": pe, "ﾎﾟ": po,
      "ｧ": la, "ｨ": li, "ｩ": lu, "ｪ": le, "ｫ": lo,
      "ｶ": lka, "ｹ": lke, "ｯ": ltu,
      "ｬ": lya, "ｭ": lyu, "ｮ": lyo,
      "ﾜ": lwa,
      "ｰ": bar, "･": ten, "ﾞ": daku, "ﾟ": maru,
    }.toTable

  KanaTable: Table[Gojuon, KanaSet] =
    {
      a : ("あ", "ア", "ｱ"),
      i : ("い", "イ", "ｲ"),
      u : ("う", "ウ", "ｳ"),
      e : ("え", "エ", "ｴ"),
      o : ("お", "オ", "ｵ"),
      ka: ("か", "カ", "ｶ"),
      ki: ("き", "キ", "ｷ"),
      ku: ("く", "ク", "ｸ"),
      ke: ("け", "ケ", "ｹ"),
      ko: ("こ", "コ", "ｺ"),
      sa: ("さ", "サ", "ｻ"),
      si: ("し", "シ", "ｼ"),
      su: ("す", "ス", "ｽ"),
      se: ("せ", "セ", "ｾ"),
      so: ("そ", "ソ", "ｿ"),
      ta: ("た", "タ", "ﾀ"),
      ti: ("ち", "チ", "ﾁ"),
      tu: ("つ", "ツ", "ﾂ"),
      te: ("て", "テ", "ﾃ"),
      to: ("と", "ト", "ﾄ"),
      na: ("な", "ナ", "ﾅ"),
      ni: ("に", "ニ", "ﾆ"),
      nu: ("ぬ", "ヌ", "ﾇ"),
      ne: ("ね", "ネ", "ﾈ"),
      no: ("の", "ノ", "ﾉ"),
      ha: ("は", "ハ", "ﾊ"),
      hi: ("ひ", "ヒ", "ﾋ"),
      hu: ("ふ", "フ", "ﾌ"),
      he: ("へ", "ヘ", "ﾍ"),
      ho: ("ほ", "ホ", "ﾎ"),
      ma: ("ま", "マ", "ﾏ"),
      mi: ("み", "ミ", "ﾐ"),
      mu: ("む", "ム", "ﾑ"),
      me: ("め", "メ", "ﾒ"),
      mo: ("も", "モ", "ﾓ"),
      ya: ("や", "ヤ", "ﾔ"),
      yi: ("ゐ", "ヰ", "ｲ"),
      yu: ("ゆ", "ユ", "ﾕ"),
      ye: ("ゑ", "ヱ", "ｴ"),
      yo: ("よ", "ヨ", "ﾖ"),
      ra: ("ら", "ラ", "ﾗ"),
      ri: ("り", "リ", "ﾘ"),
      ru: ("る", "ル", "ﾙ"),
      re: ("れ", "レ", "ﾚ"),
      ro: ("ろ", "ロ", "ﾛ"),
      wa: ("わ", "ワ", "ﾜ"),
      wo: ("を", "ヲ", "ｦ"),
      n : ("ん", "ン", "ﾝ"),
      vu: ("ゔ", "ヴ", "ｳﾞ"),
      ga: ("が", "ガ", "ｶﾞ"),
      gi: ("ぎ", "ギ", "ｷﾞ"),
      gu: ("ぐ", "グ", "ｸﾞ"),
      ge: ("げ", "ゲ", "ｹﾞ"),
      go: ("ご", "ゴ", "ｺﾞ"),
      za: ("ざ", "ザ", "ｻﾞ"),
      zi: ("じ", "ジ", "ｼﾞ"),
      zu: ("ず", "ズ", "ｽﾞ"),
      ze: ("ぜ", "ゼ", "ｾﾞ"),
      zo: ("ぞ", "ゾ", "ｿﾞ"),
      da: ("だ", "ダ", "ﾀﾞ"),
      di: ("ぢ", "ヂ", "ﾁﾞ"),
      du: ("づ", "ヅ", "ﾂﾞ"),
      de: ("で", "デ", "ﾃﾞ"),
      `do`: ("ど", "ド", "ﾄﾞ"),
      ba: ("ば", "バ", "ﾊﾞ"),
      bi: ("び", "ビ", "ﾋﾞ"),
      bu: ("ぶ", "ブ", "ﾌﾞ"),
      be: ("べ", "ベ", "ﾍﾞ"),
      bo: ("ぼ", "ボ", "ﾎﾞ"),
      pa: ("ぱ", "パ", "ﾊﾟ"),
      pi: ("ぴ", "ピ", "ﾋﾟ"),
      pu: ("ぷ", "プ", "ﾌﾟ"),
      pe: ("ぺ", "ペ", "ﾍﾟ"),
      po: ("ぽ", "ポ", "ﾎﾟ"),
      la: ("ぁ", "ァ", "ｧ"),
      li: ("ぃ", "ィ", "ｨ"),
      lu: ("ぅ", "ゥ", "ｩ"),
      le: ("ぇ", "ェ", "ｪ"),
      lo: ("ぉ", "ォ", "ｫ"),
      lka: ("ゕ", "ヵ", "ｶ"),
      lke: ("ゖ", "ヶ", "ｹ"),
      ltu: ("っ", "ッ", "ｯ"),
      lya: ("ゃ", "ャ", "ｬ"),
      lyu: ("ゅ", "ュ", "ｭ"),
      lyo: ("ょ", "ョ", "ｮ"),
      lwa: ("ゎ", "ヮ", "ﾜ"),
      bar: ("ー", "ー", "ｰ"),
      ten: ("・", "・", "･"),
      daku: ("゛", "゛", "ﾞ"),
      maru: ("゜", "゜", "ﾟ"),
    }.toTable

proc toRuneStrList*(str: string): seq[string] =
  ## split string to Runes
  let runes = str.toRunes
  for rune in runes:
    if $rune in [KanaTable[daku].half, KanaTable[maru].half] and result.len > 0:
      result[^1].add $rune
    else:
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
  elif str[0].ord == 0xef:
    if str in KanaDef:
      return KanaTable[KanaDef[str]].hira
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
  elif str[0].ord == 0xef:
    if str in KanaDef:
      return KanaTable[KanaDef[str]].kata
    else:
      return str
  else:
    return str

proc toHalfKana*(str: string): string =
  ## convert to HalfKana
  if str.len == 0:
    return
  if str[0].ord == 0xe3:
    if str.len != 3:
      return
    let cp = str[1].ord shl 8 + str[2].ord
    if cp in {0x8181 .. 0x819f, 0x8280 .. 0x8296, 0x829b, 0x829c}:
      # ぁ～た, む～ゖ, ゛, ゜
      return KanaTable[KanaDef[str]].half
    elif cp in 0x81a0 .. 0x81bf:
      # だ～み
      return KanaTable[KanaDef[str]].half
    elif cp in {0x82a1 .. 0x82bf, 0x83a0 .. 0x83b6, 0x83bb, 0x83bc}:
      # ァ～タ, ム～ヶ, ・, ー
      return KanaTable[KanaDef[str]].half
    elif cp in 0x8380 .. 0x839f:
      # ダ～ミ
      return KanaTable[KanaDef[str]].half
    else:
      return str
  else:
    return str
