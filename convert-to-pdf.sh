#!/bin/bash

# Simple Login Project Guide - PDF Conversion Helper
# This script helps convert the HTML guide to PDF

echo "📚 Simple Login Project Guide - PDF Conversion Helper"
echo "=================================================="
echo ""

# Check if HTML file exists
if [ ! -f "Simple-Login-Project-Guide.html" ]; then
    echo "❌ Error: Simple-Login-Project-Guide.html not found!"
    echo "Please run: pandoc Simple-Login-Project-Guide.md -o Simple-Login-Project-Guide.html --standalone"
    exit 1
fi

echo "✅ HTML file found: Simple-Login-Project-Guide.html"
echo ""

# Try to open the HTML file in the default browser
echo "🌐 Opening HTML file in your default browser..."
echo ""

if command -v open >/dev/null 2>&1; then
    # macOS
    open Simple-Login-Project-Guide.html
    echo "📖 The guide has been opened in your default browser."
elif command -v xdg-open >/dev/null 2>&1; then
    # Linux
    xdg-open Simple-Login-Project-Guide.html
    echo "📖 The guide has been opened in your default browser."
elif command -v start >/dev/null 2>&1; then
    # Windows
    start Simple-Login-Project-Guide.html
    echo "📖 The guide has been opened in your default browser."
else
    echo "⚠️  Could not automatically open the file."
    echo "Please manually open: Simple-Login-Project-Guide.html"
fi

echo ""
echo "📄 To convert to PDF:"
echo "1. In your browser, press Ctrl+P (or Cmd+P on Mac)"
echo "2. Select 'Save as PDF' as the destination"
echo "3. Choose 'More settings' and set:"
echo "   - Margins: Minimum"
echo "   - Scale: 100%"
echo "   - Options: Background graphics (checked)"
echo "4. Click 'Save' and choose filename: Simple-Login-Project-Guide.pdf"
echo ""
echo "🎯 Alternative: Use online HTML to PDF converters like:"
echo "   - https://html-pdf-converter.com"
echo "   - https://www.ilovepdf.com/html-to-pdf"
echo ""
echo "📋 File Information:"
echo "   - HTML Size: $(du -h Simple-Login-Project-Guide.html | cut -f1)"
echo "   - Markdown Size: $(du -h Simple-Login-Project-Guide.md | cut -f1)"
echo ""
echo "✨ The guide contains comprehensive information about:"
echo "   - Project architecture and setup"
echo "   - Backend and frontend implementation"
echo "   - Database integration and security"
echo "   - API documentation and testing"
echo "   - Troubleshooting and best practices"
echo "   - Reference materials for JWT, MongoDB, React, etc."
