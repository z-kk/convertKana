# convertKana [![nimble](https://raw.githubusercontent.com/yglukhov/nimble-tag/master/nimble.png)](https://github.com/yglukhov/nimble-tag)
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
