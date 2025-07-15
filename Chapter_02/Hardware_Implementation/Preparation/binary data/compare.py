def compare_files(file1_path, file2_path):
    mismatch_count = 0

    with open(file1_path, 'r') as f1, open(file2_path, 'r') as f2:
        lines1 = f1.readlines()
        lines2 = f2.readlines()

    max_lines = max(len(lines1), len(lines2))

    for i in range(max_lines):
        line1 = lines1[i].strip() if i < len(lines1) else "<EOF>"
        line2 = lines2[i].strip() if i < len(lines2) else "<EOF>"

        if line1 != line2:
            print(f"Line {i+1} mismatch:\n  File1: {line1}\n  File2: {line2}")
            mismatch_count += 1

    if mismatch_count == 0:
        print("✅ All lines match!")
    else:
        print(f"\n❗Total mismatched lines: {mismatch_count}")


# 使用示例
compare_files("image1.txt", "compare.txt")
