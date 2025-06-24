# Resume PDF Setup

## Implementation:

The app now uses the `pdfx` package which is compatible with both **web** and **mobile** platforms.

## Setup Instructions:

1. **Add your resume.pdf file** to this directory (`assets/pdf/resume.pdf`)
2. **Run** `flutter pub get` to include the file in the app bundle
3. **Restart** the app

## Features:

- **Cross-platform**: Works on web, iOS, Android, Windows, macOS, and Linux
- **Built-in viewer**: Opens PDF directly within the app
- **Responsive**: Adapts to different screen sizes
- **Error handling**: Shows helpful messages if PDF is missing

## File Requirements:

- **Format**: PDF (.pdf)
- **Filename**: `resume.pdf` (case sensitive)
- **Location**: `assets/pdf/resume.pdf`

## How it works:

When users tap on "My CV" in the header, the app will:

1. Load the PDF from assets
2. Open it in a dedicated PDF viewer screen
3. Display the PDF with zoom, scroll, and navigation controls

## Example Directory Structure:

```
assets/
├── images/
└── pdf/
    └── resume.pdf  <- Your resume file here
```

The PDF viewer includes:

- App bar with title
- Loading indicators
- Error handling with instructions
- Full PDF viewing capabilities
