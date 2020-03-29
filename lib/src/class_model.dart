import 'package:meta/meta.dart';

bool _isNotEmpty(String str) => str?.isNotEmpty ?? false;

class Package {
  String path;
  String name;
}

class Param {
  final String type;
  final String label;
  final String defaultValue;

  bool get hasLabel => _isNotEmpty(label);

  Param({@required this.type, this.label, this.defaultValue});

  @override
  String toString() {
    var buffer = StringBuffer();
    buffer.write('$type');
    if (_isNotEmpty(label)) {
      buffer.write(' $label');
      if (_isNotEmpty(defaultValue)) {
        buffer.write(': $defaultValue');
      }
    }
    return buffer.toString();
  }
}

class Params {
  final List<Param> params = [];
  void add(Param param) => params.add(param);

  @override
  String toString() {
    var buffer = StringBuffer();
    var isFirst = true;
    var hasLabel = false;

    buffer.write('(');
    for (var param in params) {
      if (isFirst) {
        isFirst = false;
      } else {
        buffer.write(', ');
      }
      if (!hasLabel) {
        if (param.hasLabel) {
          hasLabel = true;
          buffer.write('{');
        }
      }
      buffer.write(param.toString());
    }

    if (hasLabel) {
      buffer.write('}');
    }
    buffer.write(')');

    return buffer.toString();
  }
}

class Method {
  String returnType;
  String function;
  final Params params = Params();

  @override
  String toString() {
    var buffer = StringBuffer();
    buffer.write(function);
    buffer.write(params.toString());
    if (_isNotEmpty(returnType)) {
      buffer.write(' -> $returnType');
    }
    return buffer.toString();
  }
}

class Constant {
  final String type;
  final String name;

  Constant({this.name, this.type});
  @override
  String toString() {
    var buffer = StringBuffer();
    buffer.write(name);
    if (_isNotEmpty(type)) {
      buffer.write(' -> $type');
    }
    return buffer.toString();
  }
}

class Constructor extends Method {}

class ClassInfo {
  Package package;
  String name;
  final List<Method> methods = [];
  final List<Constant> constants = [];
  @override
  String toString() {
    var buffer = StringBuffer();
    buffer.writeln('Class: $name');
    if (methods.isNotEmpty) {
      buffer.writeln('\tMethod');
      for (var item in methods) {
        buffer.writeln('\t\t${item.toString()}');
      }
    }

    if (constants.isNotEmpty) {
      buffer.writeln('\tConstants');
      for (var item in constants) {
        buffer.writeln('\t\t${item.toString()}');
      }
    }
    return buffer.toString();
  }
}
