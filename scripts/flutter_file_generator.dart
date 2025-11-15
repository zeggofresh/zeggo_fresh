import 'dart:io';
import 'dart:async';

class FlutterFileGenerator {
  static const String _screenTemplate = '''
import 'package:flutter/material.dart';

class {{className}} extends StatelessWidget {
  const {{className}}({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('{{fileName}}'),
      ),
      body: const Center(
        child: Text('{{fileName}}'),
      ),
    );
  }
}
''';

  static const String _widgetTemplate = '''
import 'package:flutter/material.dart';

class {{className}} extends StatelessWidget {
  const {{className}}({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
''';

  static const String _serviceTemplate = '''
class {{className}} {
  // TODO: Implement service methods
}
''';

  static const String _providerTemplate = '''
import 'package:flutter/foundation.dart';

class {{className}} with ChangeNotifier {
  // TODO: Implement provider state management
  
  void dispose() {
    // TODO: Dispose resources if needed
    super.dispose();
  }
}
''';

  static Future<void> generateFile({
    required String type,
    required String fileName,
    required String directory,
  }) async {
    final className = _toCamelCase(fileName, true);
    String template;

    switch (type.toLowerCase()) {
      case 'screen':
        template = _screenTemplate;
        break;
      case 'widget':
        template = _widgetTemplate;
        break;
      case 'service':
        template = _serviceTemplate;
        break;
      case 'provider':
        template = _providerTemplate;
        break;
      default:
        throw Exception('Unsupported file type: \$type');
    }

    // Replace placeholders
    template = template.replaceAll('{{className}}', className);
    template = template.replaceAll('{{fileName}}', fileName);

    // Create directory if it doesn't exist
    final dir = Directory(directory);
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    // Write file
    final filePath = '$directory/$fileName.dart';
    final file = File(filePath);
    await file.writeAsString(template);

    print('Generated ${file.path}');
  }

  static String _toCamelCase(String text, bool upperFirst) {
    final words = text.split('_');
    final capitalizedWords = words.map((word) => word.substring(0, 1).toUpperCase() + word.substring(1).toLowerCase()).toList();
    
    if (!upperFirst && capitalizedWords.isNotEmpty) {
      capitalizedWords[0] = capitalizedWords[0].substring(0, 1).toLowerCase() + capitalizedWords[0].substring(1);
    }
    
    return capitalizedWords.join('');
  }
}

void main(List<String> arguments) async {
  if (arguments.length < 3) {
    print('Usage: dart flutter_file_generator.dart <type> <file_name> <directory>');
    print('Types: screen, widget, service, provider');
    return;
  }

  final type = arguments[0];
  final fileName = arguments[1];
  final directory = arguments[2];

  try {
    await FlutterFileGenerator.generateFile(
      type: type,
      fileName: fileName,
      directory: directory,
    );
    print('Successfully generated \$type file: \$fileName.dart');
  } catch (e) {
    print('Error generating file: \$e');
    rethrow;
  }
}