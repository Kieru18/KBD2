import re
from xml.etree.ElementTree import Element, SubElement, tostring, ElementTree

def parse_txt_to_xml(file_path):
    with open(file_path, 'r', encoding='utf-8') as file:
        lines = file.readlines()
    
    # Initialize XML structure
    root = Element('opis')
    
    # Define patterns for sections we want to extract
    sections = {
        'initial_extract': re.compile(r'^Ekstrakt początkowy:\s+(.+)$'),
        'final_extract': re.compile(r'^Ekstrakt końcowy:\s+(.+)$'),
        'alcohol_content': re.compile(r'^Zawartość alkoholu:\s+(.+)$'),
        'bitterness': re.compile(r'^Goryczka:\s+(.+)$'),
        'color': re.compile(r'^Barwa:\s+(.+)$'),
        'style_characteristics': re.compile(r'^Wyróżniki stylu:\s+(.+)$'),
        'history': re.compile(r'^Historia:\s+(.+)$'),
        'aroma': re.compile(r'^Aromat:\s+(.+)$'),
        'flavor': re.compile(r'^Smak:\s+(.+)$'),
        'bitterness_description': re.compile(r'^Goryczka:\s+(.+)$'),
        'appearance': re.compile(r'^Wygląd:\s+(.+)$'),
        'mouthfeel': re.compile(r'^Odczucie w ustach:\s+(.+)$'),
        'ingredients_and_technology': re.compile(r'^Surowce i technologia:\s+(.+)$'),
        'commercial_examples': re.compile(r'^Przykłady komercyjne:\s+(.+)$'),
        'comments': re.compile(r'^Komentarz:\s+(.+)$'),
        'serving_temperature': re.compile(r'^Temperatura serwowania:\s+(.+)$'),
        'glass': re.compile(r'^Szkło:\s+(.+)$')
    }

    current_section = None
    buffer = []
    skip_sections = ['author', 'published', 'aroma_intensity']

    for line in lines:
        line = line.strip()

        # Check if the line matches any section headers
        for section, pattern in sections.items():
            match = pattern.match(line)
            if match:
                # Save previous section content
                if current_section and buffer:
                    text = ' '.join(buffer).strip()
                    if current_section not in skip_sections:
                        SubElement(root, current_section).text = text
                    buffer = []
                
                # Set new section
                current_section = section
                buffer.append(match.group(1) if match.groups() else '')
                break
        else:
            if current_section:
                buffer.append(line)

    # Add the last buffered section
    if current_section and buffer:
        text = ' '.join(buffer).strip()
        if current_section not in skip_sections:
            SubElement(root, current_section).text = text

    # Handle the "Skrót" section separately
    with open(file_path, 'r', encoding='utf-8') as file:
        content = file.read()
        skrot_match = re.search(r'Barwa:\s+(.+?)Wyróżniki stylu:', content, re.DOTALL)
        if skrot_match:
            skrot_text = skrot_match.group(1).strip()
            SubElement(root, 'Skrot').text = skrot_text

    # Convert the XML to a formatted string
    xml_data = tostring(root, encoding='unicode', pretty_print=True)

    return xml_data

# Test the function
file_path = 'Altbier.txt'
xml_data = parse_txt_to_xml(file_path)

output_file_path = 'Altbier.xml'
with open(output_file_path, 'w', encoding='utf-8') as output_file:
    output_file.write(xml_data)
