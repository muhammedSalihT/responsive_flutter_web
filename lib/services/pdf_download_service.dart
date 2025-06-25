// Conditional import for web
import 'dart:html' if (dart.library.io) 'dart:io' as html;
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class PdfDownloadService {
  static Future<bool> downloadResume() async {
    try {
      // Request storage permission for mobile
      if (!kIsWeb) {
        final status = await Permission.storage.request();
        if (!status.isGranted) {
          return false;
        }
      }

      // Load the PDF from assets
      final ByteData data = await rootBundle.load('assets/pdf/resume.pdf');
      final Uint8List bytes = data.buffer.asUint8List();

      if (kIsWeb) {
        // For web, create a blob and trigger download
        final blob = html.Blob([bytes]);
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url)
          ..setAttribute('download', 'flutter_dev_salih_resume.pdf')
          ..click();
        html.Url.revokeObjectUrl(url);
        return true;
      } else {
        // For mobile platforms
        final directory = await getExternalStorageDirectory();
        if (directory == null) {
          return false;
        }

        final file = File('${directory.path}/resume.pdf');
        await file.writeAsBytes(bytes);
        return true;
      }
    } catch (e) {
      debugPrint('Error downloading PDF: $e');
      return false;
    }
  }
}
