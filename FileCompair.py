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
    files_processed = set()
    for root, files in os.walk('.'):
        for file in files:
            full_path = os.path.join(root, file)
            with open(full_path, 'rb') as f:
                hashes[full_path] = hashlib.md5(f.read()).hexdigest()
            files_processed.add(full_path)

#ik hou van jou es


    for root, files in os.walk('.'):
        for file1 in files:
            full_path1 = os.path.join(root, file1)
            if full_path1 in files_processed:
                file_to_delete = None
                for file2 in files_processed - set([full_path1]):
                    if compare_files(full_path1, file2, hashes):
                        if file_to_delete is None:
                            file_to_delete = file2
                        else:
                            if os.stat(file2).st_mtime < os.stat(file_to_delete).st_mtime:
                                file_to_delete = file2
                if file_to_delete is not None:
                    os.remove(file_to_delete)
                    print(f"Deleted {file_to_delete}")
                    files_processed.remove(file_to_delete)

while True:
    try:
        delete_duplicate_files()
        break
    except Exception as e:
        print(f"Error: {e}")
