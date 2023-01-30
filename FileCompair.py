import hashlib
import os

def compare_files(file1, file2, hashes):
    hash1 = hashes[file1]
    hash2 = hashes[file2]
    if hash1 == hash2:
        return True
    return False

def delete_duplicate_files():
    files = os.listdir()
    hashes = {}

    for file in files:
        with open(file, 'rb') as f:
            hashes[file] = hashlib.md5(f.read()).hexdigest()

    while files:
        file1 = files.pop(0)
        for file2 in files[:]:
            if compare_files(file1, file2, hashes):
                os.remove(file2)
                print(f"Deleted {file2}")
                files = os.listdir()
                break

while True:
    try:
        delete_duplicate_files()
        break
    except Exception as e:
        print(f"Error: {e}")
