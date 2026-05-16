import 'package:html/parser.dart';

/// Removes all HTML tags from the given [htmlString] and returns plain text.
/// 
/// This function uses the `html` package to parse the HTML string and extract 
/// the text content, ensuring that HTML entities (like &amp;, &lt;, etc.) 
/// are correctly decoded.
String removeHtmlTags(String htmlString) {
  if (htmlString.isEmpty) return '';
  
  final document = parse(htmlString);
  return document.body?.text ?? '';
}
