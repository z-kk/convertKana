# convertKana
Convert Japanese Kana

## Usage

### binary file

```
$ convertKana -h <kana string>
#result: hiragana string

$ convertKana -k <kana string>
#result: katakana string

$ convertKana --half <kana string>
#result: halfkana string
```

### import

```nim
import convertKana

let str = "<kana string>"
let
  hiragana = str.convert(ktHiragana)
  katakana = str.convert(ktKatakana)
  halfkana = str.convert(ktHalfKana)
```
