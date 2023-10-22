import os

current_directory = os.getcwd()  # Get the current working directory

for filename in os.listdir(current_directory):
    if filename.lower().endswith(('.jpg', '.jpeg')):
        new_filename = os.path.splitext(filename)[0] + '.png'
        os.system(f'sips -s format png "{os.path.join(current_directory, filename)}" --$
