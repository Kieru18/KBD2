import os
import PyPDF2

def pdf_to_txt(pdf_file_path, txt_file_path):
    # Open the PDF file
    with open(pdf_file_path, 'rb') as pdf_file:
        pdf_reader = PyPDF2.PdfReader(pdf_file)
        num_pages = len(pdf_reader.pages)
        
        # Open the TXT file to write
        with open(txt_file_path, 'w', encoding='utf-8') as txt_file:
            # Iterate through each page and extract text
            for page_num in range(num_pages):
                page = pdf_reader.pages[page_num]
                text = page.extract_text()
                txt_file.write(text)
                txt_file.write("\n")  # Add a newline character after each page

# Get the current directory
current_directory = os.getcwd()

# Get a list of all PDF files in the current directory
pdf_files = [file for file in os.listdir(current_directory) if file.endswith(".pdf")]

# Loop through each PDF file and convert it to TXT
for pdf_file in pdf_files:
    pdf_file_path = os.path.join(current_directory, pdf_file)
    txt_file_path = os.path.splitext(pdf_file_path)[0] + ".txt"
    pdf_to_txt(pdf_file_path, txt_file_path)
