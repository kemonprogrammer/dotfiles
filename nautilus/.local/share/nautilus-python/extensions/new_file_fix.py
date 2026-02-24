import os
import subprocess
import urllib.parse
from gi.repository import Nautilus, GObject

class NewFileExtension(GObject.GObject, Nautilus.MenuProvider):
    def create_file_logic(self, folder_path):
        # We launch zenity as a standalone process so it doesn't freeze Nautilus
        # Using a shell wrapper to handle the output without blocking the parent
        cmd = f'filename=$(zenity --entry --title="Create New Document" --text="Enter filename:" --entry-text="New Document"); [ -n "$filename" ] && touch "{folder_path}/${{filename%.txt}}.txt"'
        
        # Popen starts the process and moves on immediately
        subprocess.Popen(cmd, shell=True)
        return False

    def create_file_handler(self, menu, folder):
        raw_path = folder.get_uri().replace("file://", "")
        base_directory = urllib.parse.unquote(raw_path)
        
        # Use a tiny timeout to ensure the context menu closes first
        GObject.timeout_add(150, self.create_file_logic, base_directory)

    def get_background_items(self, folder):
        item = Nautilus.MenuItem(
            name='NewFile::CreateText', 
            label='New Text Document',
            tip='Creates a new text file'
        )
        item.connect('activate', self.create_file_handler, folder)
        return [item]

    def get_file_items(self, *args):
        return []
