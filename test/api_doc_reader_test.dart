import 'package:test/test.dart';

import 'package:api_doc_reader/api_doc_reader.dart';

class Doc {
  final String docRoot = '/opt/flutter/flutter_doc';

  final String relPath;

  Doc(this.relPath);

  String get fullPath => '$docRoot/$relPath';
}

void main() {
  group('Color', () {
    test('className', () {
      final colorDoc = Doc('dart-ui/Color-class.html');
      final reader = DocReader(path: colorDoc.fullPath);
      reader.doParse();
      expect(reader.classInfo.name, 'Color');
    });
  });

  group('Colors', () {
    test('className', () {
      final colorDoc = Doc('material/Colors-class.html');
      final reader = DocReader(path: colorDoc.fullPath);
      reader.doParse();
      expect(reader.classInfo.name, 'Colors');
    });
  });

  group('EdgeInsets', () {
    test('className', () {
      final colorDoc = Doc('painting/EdgeInsets-class.html');
      final reader = DocReader(path: colorDoc.fullPath);
      reader.doParse();
      expect(reader.classInfo.name, 'EdgeInsets');
    });
  });
  group('Image', () {
    test('className', () {
      final colorDoc = Doc('widgets/Image-class.html');
      final reader = DocReader(path: colorDoc.fullPath);
      reader.doParse();
      expect(reader.classInfo.name, 'Image');
    });
  });

  group('Container', () {
    test('className', () {
      final colorDoc = Doc('widgets/Container-class.html');
      final reader = DocReader(path: colorDoc.fullPath);
      reader.doParse();
      expect(reader.classInfo.name, 'Container');
    });
  });

  group('Alignment', () {
    test('className', () {
      final colorDoc = Doc('painting/Alignment-class.html');
      final reader = DocReader(path: colorDoc.fullPath);
      reader.doParse();
      expect(reader.classInfo.name, 'Alignment');
    });
  });
}
