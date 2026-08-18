import "package:archive/archive.dart";
import "dart:convert";

String encodeToBZip2(String text) {
  final bytes = utf8.encode(text);
  final compressed = BZip2Encoder().encode(bytes);
  return base64.encode(compressed);
}

String decodeBZip2String(String compressedText) {
  final compressedBytes = base64.decode(compressedText);
  final decompressedBytes = BZip2Decoder().decodeBytes(compressedBytes);
  return utf8.decode(decompressedBytes);
}
