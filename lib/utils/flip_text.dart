Map<K, String> flipMap<K>(Map<K, String> map) {
  Map<K, String> result = {};
  map.forEach((key, value) {
    result[key] = flipText(value);
  });
  return result;
}

String flipText(String text) {
  return text
      .split('')
      .reversed
      .map((c) => table.containsKey(c) ? table[c] : c)
      .join('');
}

const Map<String, String> table = {
  "0": "0",
  "1": "Ɩ",
  "2": "ᄅ",
  "3": "Ɛ",
  "4": "ㄣ",
  "5": "ϛ",
  "6": "9",
  "7": "ㄥ",
  "8": "8",
  "9": "6",
  "a": "ɐ",
  "b": "q",
  "c": "ɔ",
  "d": "p",
  "e": "ǝ",
  "f": "ɟ",
  "g": "ƃ",
  "h": "ɥ",
  "i": "ᴉ",
  "j": "ɾ",
  "k": "ʞ",
  "m": "ɯ",
  "n": "u",
  "r": "ɹ",
  "t": "ʇ",
  "v": "ʌ",
  "w": "ʍ",
  "y": "ʎ",
  "A": "∀",
  "C": "Ɔ",
  "E": "Ǝ",
  "F": "Ⅎ",
  "G": "פ",
  "H": "H",
  "I": "I",
  "J": "ſ",
  "L": "˥",
  "M": "W",
  "N": "N",
  "P": "Ԁ",
  "T": "┴",
  "U": "∩",
  "V": "Λ",
  "Y": "⅄",
  ".": "˙",
  ",": "'",
  "'": ",",
  '"': ",,",
  "`": ",",
  "?": "¿",
  "!": "¡",
  "[": "]",
  "]": "[",
  "(": ")",
  ")": "(",
  "{": "}",
  "}": "{",
  "<": ">",
  ">": "<",
  "&": "⅋",
  "_": "‾",
  "∴": "∵",
  "⁅": "⁆"
};
