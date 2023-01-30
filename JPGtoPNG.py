import os

for filename in os.listdir():
    if filename.endswith('.jpg'):
        new_filename = filename[:-4] + '.png'
        os.system(f'sips -s format png {filename} --out {new_filename}')
