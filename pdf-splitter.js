const fs = require('fs');
const path = require('path');
const { PDFDocument } = require('pdf-lib');

async function splitPdf(inputPdf) {
  const pdfBytes = fs.readFileSync(inputPdf);
  const pdfDoc = await PDFDocument.load(pdfBytes);

  const outputFolder = path.join(__dirname, 'temp_folder');
  if (!fs.existsSync(outputFolder)) {
    fs.mkdirSync(outputFolder);
  }

  for (let i = 0; i < pdfDoc.getPageCount(); i++) {
    const newPdfDoc = await PDFDocument.create();
    const [copiedPage] = await newPdfDoc.copyPages(pdfDoc, [i]);
    newPdfDoc.addPage(copiedPage);

    const outputPath = path.join(outputFolder, `page_${i + 1}.pdf`);
    const newPdfBytes = await newPdfDoc.save();

    fs.writeFileSync(outputPath, newPdfBytes);
  }

  console.log(`PDF successfully split! Individual pages are saved in the '${outputFolder}' folder.`);
}

async function main() {
  // Run the script with the provided PDF file
  const args = process.argv.slice(2);
  if (args.length !== 1) {
    console.error('Usage: node split_pdf.js Your_PDF_File.pdf');
    process.exit(1);
  }

  const inputPdf = args[0];
  await splitPdf(inputPdf);
}

main();
