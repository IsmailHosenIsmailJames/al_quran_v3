import os

def count_all_lines(project_path):
    """
    Recursively walks through a directory and counts the total number of lines
    in all files.
    """
    total_lines = 0
    for dirpath, dirnames, filenames in os.walk(project_path):
        for filename in filenames:
            full_path = os.path.join(dirpath, filename)
            try:
                # Use 'rb' to read in binary mode to avoid encoding errors
                # and then decode line by line.
                with open(full_path, 'rb') as f:
                    # Simply count the number of newline characters
                    lines_in_file = sum(1 for line in f)
                    total_lines += lines_in_file
            except Exception as e:
                # This helps skip files that can't be opened, like system files.
                print(f"Could not read file {full_path}: {e}")
    return total_lines

if __name__ == "__main__":
    # Get the path from the user
    path_to_scan = input("Enter the path to your project directory: ")

    if os.path.isdir(path_to_scan):
        line_count = count_all_lines(path_to_scan)
        print(f"\nTotal physical lines in all files: {line_count}")
    else:
        print("The path you entered is not a valid directory.")