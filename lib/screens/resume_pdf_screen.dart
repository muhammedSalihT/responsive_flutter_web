import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

import '../services/pdf_download_service.dart';

class ResumePDFScreen extends StatefulWidget {
  const ResumePDFScreen({super.key});

  @override
  State<ResumePDFScreen> createState() => _ResumePDFScreenState();
}

class _ResumePDFScreenState extends State<ResumePDFScreen> {
  late PdfControllerPinch pdfPinchController;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadPDF();
  }

  void _loadPDF() {
    try {
      pdfPinchController = PdfControllerPinch(
        document: PdfDocument.openAsset('assets/pdf/resume.pdf'),
      );
      // pdfController = PdfController(
      //   document: PdfDocument.openAsset('assets/pdf/resume.pdf'),
      // );
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error loading PDF: $e';
      });
    }
  }

  @override
  void dispose() {
    pdfPinchController.dispose();
    super.dispose();
  }

  Future<void> _downloadResume() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xff194F82)),
          ),
        );
      },
    );
    try {
      final success = await PdfDownloadService.downloadResume();
      if (context.mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(success
                ? 'Resume downloaded successfully!'
                : 'Failed to download resume. Please try again.'),
            backgroundColor: success ? const Color(0xff194F82) : Colors.red,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Resume'),
        backgroundColor: const Color(0xff194F82),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          InkWell(
            onTap: _downloadResume,
            child: const Row(
              children: [
                Text('Download',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
                Icon(Icons.download, color: Colors.white),
                SizedBox(width: 16),
              ],
            ),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.description_outlined,
                size: 64,
                color: Color(0xff194F82),
              ),
              const SizedBox(height: 16),
              Text(
                _errorMessage!,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              const Text(
                'To add your resume:\n1. Place your resume.pdf file in assets/pdf/ directory\n2. Run "flutter pub get"\n3. Restart the app',
                style: TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xff194F82)),
        ),
      );
    }

    return PdfViewPinch(
      padding: kIsWeb ? 50 : 20,
      controller: pdfPinchController,
      builders: PdfViewPinchBuilders<DefaultBuilderOptions>(
        options: const DefaultBuilderOptions(),
        documentLoaderBuilder: (_) => const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xff194F82)),
          ),
        ),
        pageLoaderBuilder: (_) => const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xff194F82)),
          ),
        ),
        errorBuilder: (_, error) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              Text(
                'Error loading PDF: $error',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
