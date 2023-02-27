import hashlib
import os

def compare_files(file1, file2, hashes):
    hash1 = hashes[file1]
    hash2 = hashes[file2]
    if hash1 == hash2:
        return True
    return False

def delete_duplicate_files():
    hashes = {}
    for root, dirs, files in os.walk('.'):
        for file in files:
            full_path = os.path.join(root, file)
            with open(full_path, 'rb') as f:
                hashes[full_path] = hashlib.md5(f.read()).hexdigest()

    for root, dirs, files in os.walk('.'):
        for file1 in files:
            full_path1 = os.path.join(root, file1)
            for file2 in files:
                full_path2 = os.path.join(root, file2)
                if full_path1 != full_path2 and compare_files(full_path1, full_path2, hashes):
                    os.remove(full_path2)
                    print(f"Deleted {full_path2}")

while True:
    try:
        delete_duplicate_files()
        break
    except Exception as e:
        print(f"Error: {e}")
