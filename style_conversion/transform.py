import re
from xml.etree.ElementTree import Element, SubElement, tostring
from xml.dom.minidom import parseString

def parse_txt_to_xml(file_path):
    with open(file_path, 'r', encoding='utf-8') as file:
        lines = file.readlines()
    
    root = Element('opis')
    
    sections = {
        'ekstrakt_poczatkowy': re.compile(r'^Ekstrakt początkowy:\s+(.+)$'),
        'ekstrakt_koncowy': re.compile(r'^Ekstrakt końcowy:\s+(.+)$'),
        'zawartosc_alkoholu': re.compile(r'^Zawartość alkoholu:\s+(.+)$'),
        'goryczka': re.compile(r'^Goryczka:\s+(.+)$'),
        'barwa': re.compile(r'^Barwa:\s+(.+)$'),
        'wyrozniki_stylu': re.compile(r'^Wyróżniki stylu:\s+(.+)$'),
        'historia': re.compile(r'^Historia:\s+(.+)$'),
        'aromat': re.compile(r'^Aromat:\s+(.+)$'),
        'smak': re.compile(r'^Smak:\s+(.+)$'),
        'opis_goryczki': re.compile(r'^Goryczka:\s+(.+)$'),
        'wyglad': re.compile(r'^Wygląd:\s+(.+)$'),
        'odczucie_w_ustach': re.compile(r'^Odczucie w ustach:\s+(.+)$'),
        'surowce_i_technologia': re.compile(r'^Surowce i technologia:\s+(.+)$'),
        'przyklady_komercyjne': re.compile(r'^Przykłady komercyjne:\s+(.+)$'),
        'komentarz': re.compile(r'^Komentarz:\s+(.+)$'),
        'temperatura_serwowania': re.compile(r'^Temperatura serwowania:\s+(.+)$'),
        'szklo': re.compile(r'^Szkło:\s+(.+)$')
    }

    current_section = None
    buffer = []
    skip_sections = ['autor', 'data_publikacji', 'tabela_natezen']

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
        skrot_match = re.search(r'Barwa:\s+.+?(\n.+?)(?=\nWyróżniki stylu:)', content, re.DOTALL)
        if skrot_match:
            skrot_text = skrot_match.group(1).strip()
            SubElement(root, 'skrot').text = skrot_text

    # Create a pretty XML string
    rough_string = tostring(root, encoding='utf-8')
    reparsed = parseString(rough_string)
    pretty_xml = reparsed.toprettyxml(indent="  ")
    
    return pretty_xml


file_path = 'Altbier.txt'
xml_data = parse_txt_to_xml(file_path)

output_file_path = 'Altbier.xml'
with open(output_file_path, 'w', encoding='utf-8') as output_file:
    output_file.write(xml_data)
