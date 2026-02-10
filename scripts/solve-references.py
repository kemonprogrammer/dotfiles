import xml.etree.ElementTree as ET
import sys
import re
import base64
import binascii

def resolve_keepass_v2(input_file):
    try:
        tree = ET.parse(input_file)
        root = tree.getroot()
    except Exception as e:
        print(f"Error parsing XML: {e}")
        return

    # Map for lookup: Key is the HEX UUID, Value is a dict of fields
    entry_map = {}
    title_map = {}

    for entry in root.iter('Entry'):
        uuid_text = entry.findtext('UUID')
        if not uuid_text: continue
        
        # Convert Base64 XML UUID to HEX for matching {REF}
        try:
            uuid_hex = binascii.hexlify(base64.b64decode(uuid_text)).decode('utf-8').upper()
        except:
            continue

        fields = {'U': '', 'P': '', 'A': '', 'T': ''}
        for string_field in entry.findall('String'):
            key = string_field.findtext('Key')
            val = string_field.findtext('Value') or ""
            if key == 'UserName': fields['U'] = val
            elif key == 'Password': fields['P'] = val
            elif key == 'URL':      fields['A'] = val
            elif key == 'Title':    fields['T'] = val
        
        entry_map[uuid_hex] = fields
        if fields['T']:
            title_map[fields['T']] = fields

    # Regex: Group 1=Field, Group 2=ID Type (I/T), Group 3=Identity
    ref_pattern = re.compile(r'\{REF:([UPAT])@([IT]):(.*?)\}', re.IGNORECASE)

    def replace_match(match):
        field, id_type, identity = match.groups()
        field = field.upper()
        
        source = entry_map if id_type.upper() == 'I' else title_map
        if identity in source:
            return source[identity].get(field, match.group(0))
        return match.group(0)

    count = 0
    for value in root.iter('Value'):
        if value.text and "{REF:" in value.text:
            original = value.text
            # Use a loop in case there are multiple refs in one string or recursive refs
            new_text = ref_pattern.sub(replace_match, original)
            if new_text != original:
                value.text = new_text
                count += 1

    output_path = input_file + ".solved.xml"
    tree.write(output_path, encoding='utf-8', xml_declaration=True)
    print(f"Success: {count} tags updated. Check {output_path}")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python3 script.py your_database.xml")
    else:
        resolve_keepass_v2(sys.argv[1])
