import 'dart:io' as io;

import 'package:html/parser.dart' as html;
import 'package:html/dom.dart';
import 'class_model.dart';

class DocReader {
  final String path;
  Document _doc;

  final _classInfo = ClassInfo();
  ClassInfo get classInfo => _classInfo;

  DocReader({this.path});

  void doParse() {
    var file = io.File(path);
    var content = file.readAsStringSync();
    _doc = html.parse(content);

    _parseName();
    _parseConstructors();
    _parseStaticMethod();
    _parseConstants();

    print(_classInfo.toString());
  }

  void _parseName() {
    var node = _doc.querySelector('#title > div');
    _classInfo.name = node?.innerHtml;
  }

  void _parseConstructors() {
    var node = _doc.querySelector('#constructors > dl');
    var items = node?.getElementsByClassName('callable');
    if (items != null) {
      for (var item in items) {
        _parseInnovation(item, true);
      }
    }
  }

  void _parseStaticMethod() {
    var node = _doc.querySelector('#static-methods > dl');
    var items = node?.getElementsByClassName('callable');
    if (items != null) {
      for (var item in items) {
        _parseInnovation(item, false);
      }
    }
  }

  void _parseConstants() {
    var node = _doc.querySelector('#constants > dl');
    var items = node?.getElementsByClassName('constant');
    if (items != null) {
      for (var item in items) {
        _parseConstant(item);
      }
    }
  }

  void _parseConstant(Element node) {
    var name = node.id;
    var type = node.querySelector('> span.signature > a')?.innerHtml;

    _classInfo.constants.add(Constant(name: name, type: type));
  }

  void _parseInnovation(Element node, bool isConstructor) {
    var method = isConstructor ? Constructor() : Method();

    method.function = node.id;
    var signature = node.querySelector('> span.signature');
    var params = signature?.getElementsByClassName('parameter');

    if (params != null) {
      var hasLabel = false;

      for (var param in params) {
        var type = param.querySelector('> span.type-annotation > a')?.innerHtml;
        if (type != null) {
          String label;
          String value;
          if (!hasLabel) {
            var firstNode = param.nodes.first;
            if (firstNode is Text) {
              var txt = firstNode.data;
              hasLabel = txt == '{';
              assert(txt != '[', "not support []");
            }
          }
          if (hasLabel) {
            label = param.querySelector('> span.parameter-name')?.innerHtml;
            value = param.querySelector('> span.default-value')?.innerHtml;
          }
          method.params
              .add(Param(type: type, label: label, defaultValue: value));
        }
      }

      if (!isConstructor) {
        method.returnType = signature
            .querySelector('> span.returntype.parameter > a')
            ?.innerHtml;
      }
    }

    _classInfo.methods.add(method);
  }
}
