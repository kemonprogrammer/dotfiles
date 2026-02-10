#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# Copyright (C) 2013 Stefan Simroth <stefan.simroth@gmail.com>. All Rights Reserved.
# Based on the script for KeepassX by Juhamatti Niemelä <iiska@iki.fi>.
# Updated for Python 3 compatibility.
#
# This file is licensed under the GPLv2+. Please see COPYING for more information.

import getopt
import sys
from subprocess import Popen, PIPE
from xml.etree import ElementTree

def pass_import_entry(path, data):
    """ Import new password entry to password-store using pass insert command """
    proc = Popen(['pass', 'insert', '--multiline', path], stdin=PIPE, stdout=PIPE)
    proc.communicate(data.encode('utf8'))
    proc.wait()

def get_value(elements, node_text):
    for element in elements:
        for child in element.findall('Key'):
            if child.text == node_text:
                value_node = element.find('Value')
                return value_node.text if value_node is not None else ''
    return ''

def path_for(element, path=''):
    """ Generate path name from elements title and current path """
    if element.tag == 'Entry':
        title = get_value(element.findall("String"), "Title")
    elif element.tag == 'Group':
        name_node = element.find('Name')
        title = name_node.text if name_node is not None else ''
    else:
        title = ''
    
    # Sanitize title to avoid empty path segments
    if not title:
        title = "Unknown"

    if path == '':
        return title
    else:
        return '/'.join([path, title])

def password_data(element, path=''):
    """ Return password data and additional info if available from password entry element. """
    data = ""
    password = get_value(element.findall('String'), 'Password')
    if password is not None:
        data = password + "\n"
    else:
        print(f"[WARN] No password: {path_for(element, path)}")
    
    # Mapping XML keys to desired pass-store labels
    # Use conventional labels
    fields = {
        'UserName': 'user',
        'URL': 'url',
        'Notes': 'notes'
    }

    for xml_field, pass_label in fields.items():
        value = get_value(element.findall('String'), xml_field)
        if value and len(value) > 0:
            data = f"{data}{pass_label}: {value}\n"
    return data

def import_entry(entries, element, path=''):
    element_path = path_for(element, path) 
    if element_path in entries:
        print(f"[INFO] Duplicate needs merging: {element_path}")
        existing_data = entries[element_path]
        data = f"{existing_data}---------\nPassword: {password_data(element)}"
    else:
        data = password_data(element, path)
        
    entries[element_path] = data

def import_group(entries, element, path='', npath=None):
    """ Import all entries and sub-groups from given group """
    if npath is None:
        npath = path_for(element, path)
    for group in element.findall('Group'):
        import_group(entries, group, npath)
    for entry in element.findall('Entry'):
        import_entry(entries, entry, npath)

def import_passwords(xml_file, root_path=None):
    """ Parse given Keepass2 XML file and import password groups from it """
    print(f"[>>>>] Importing passwords from file {xml_file}")
    print(f"[INFO] Root path: {root_path}")
    entries = dict()
    try:
        with open(xml_file, 'r', encoding='utf-8') as xml:
            text = xml.read()
            xml_tree = ElementTree.XML(text)
            root = xml_tree.find('Root')
            if root is None:
                print("[ERROR] Could not find Root element in XML.")
                return
            root_group = root.find('Group')
            if root_group is None:
                print("[ERROR] Could not find Group under Root.")
                return
            
            import_group(entries, root_group, '', root_path)
            password_count = 0
            
            for path, data in sorted(entries.items()):
                sys.stdout.write(f"[>>>>] Importing {path} ... ")
                sys.stdout.flush()
                pass_import_entry(path, data)
                sys.stdout.write("OK\n")
                password_count += 1
                
            print(f"[ OK ] Done. Imported {password_count} passwords.")
    except Exception as e:
        print(f"[ERROR] An error occurred: {e}")

def usage():
    """ Print usage """
    print(f"Usage: {sys.argv[0]} -f XML_FILE")
    print("Optional:")
    print(" -r ROOT_PATH    Different root path to use than the one in xml file, use \"\" for none")

def main(argv):
    try:
        opts, args = getopt.gnu_getopt(argv, "f:r:")
    except getopt.GetoptError as err:
        print(str(err))
        usage()
        sys.exit(2)
    
    xml_file = None
    root_path = None
    
    for opt, arg in opts:
        if opt == "-f":
            xml_file = arg
        if opt == "-r":
            root_path = arg
    
    if xml_file is not None:
        import_passwords(xml_file, root_path)
    else:
        usage()
        sys.exit(2)
    
if __name__ == '__main__':
    main(sys.argv[1:])
