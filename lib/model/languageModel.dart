const String tablelanguage = 'language';

class LanguageFields {
  static final List<String> values = [
    /// Add all fields
    srno, defaultlang, english, tamil, hindi, kannada, malayalam, telugu
  ];

  static const String srno = 'srno';
  static const String defaultlang = 'default';
  static const String english = 'english';
  static const String tamil = 'tamil';
  static const String hindi = 'hindi';
  static const String kannada = 'kannada';
  static const String malayalam = 'malayalam';
  static const String telugu = 'telugu';
}

class Language {
  final int? srno;
  final String defaultlang;
  final String english;
  final String tamil;
  final String hindi;
  final String kannada;
  final String malayalam;
  final String telugu;

  const Language({
    this.srno,
    required this.defaultlang,
    required this.english,
    required this.tamil,
    required this.hindi,
    required this.kannada,
    required this.malayalam,
    required this.telugu,
  });

  Language copy({
    int? srno,
    String? defaultlang,
    String? english,
    String? tamil,
    String? hindi,
    String? kannada,
    String? malayalam,
    String? telugu,
  }) =>
      Language(
        srno: srno ?? this.srno,
        defaultlang: defaultlang ?? this.defaultlang,
        english: english ?? this.english,
        tamil: tamil ?? this.tamil,
        hindi: hindi ?? this.hindi,
        kannada: kannada ?? this.kannada,
        malayalam: malayalam ?? this.malayalam,
        telugu: telugu ?? this.telugu,
      );

  static Language fromJson(Map<String, Object?> json) => Language(
        srno: json[LanguageFields.srno] as int?,
        defaultlang: json[LanguageFields.defaultlang] as String,
        english: json[LanguageFields.english] as String,
        tamil: json[LanguageFields.tamil] as String,
        hindi: json[LanguageFields.hindi] as String,
        kannada: json[LanguageFields.kannada] as String,
        malayalam: json[LanguageFields.malayalam] as String,
        telugu: json[LanguageFields.telugu] as String,
      );

  Map<String, Object?> toJson() => {
        LanguageFields.srno: srno,
        LanguageFields.defaultlang: defaultlang,
        LanguageFields.english: english,
        LanguageFields.tamil: tamil,
        LanguageFields.hindi: hindi,
        LanguageFields.kannada: kannada,
        LanguageFields.malayalam: malayalam,
        LanguageFields.telugu: telugu,
      };
}
