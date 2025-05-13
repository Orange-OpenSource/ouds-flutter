
extension FormattedName on Enum {
  String get formattedName {
    final words = name.split(RegExp(r'(?=\p{Lu})', unicode: true));
    final joined = words.map((w) => w.toLowerCase()).join(' ').trim();
    return joined[0].toUpperCase() + joined.substring(1);
  }
}
