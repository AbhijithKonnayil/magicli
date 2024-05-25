extension CaseExtension on String {
  String toProperCase() {
    List<String> words = this.split(RegExp(r'[\s_]'));
    words = words.map((word) {
      if (word.isEmpty) {
        return '';
      }
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).toList();
    return words.join('');
  }
}

String updateTemplate(String template, Map<String, String> replacements) {
  String updatedTemplate = template;

  replacements.forEach((key, value) {
    updatedTemplate = updatedTemplate.replaceAll('{{$key}}', value);
  });

  return updatedTemplate;
}
