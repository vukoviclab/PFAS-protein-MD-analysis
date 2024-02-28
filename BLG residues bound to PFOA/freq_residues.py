from collections import defaultdict

def process_data(input_file, output_file, total_frames):
    frequency_dict = defaultdict(list)

    with open(input_file, 'r') as file:
        for line in file:
            frame, entry, _ = line.strip().split(',')
            frequency_dict[entry].append(frame)

    with open(output_file, 'w') as file:
        for entry, values in sorted(frequency_dict.items(), key=lambda x: len(x[1]), reverse=True):
            frequency = len(values)
            percentage = (frequency / total_frames) * 100
            file.write(f"{entry} {frequency} {percentage:.4f}%\n")

# Specify input and output file paths
input_file_path = 'all-frames-distance.csv'
output_file_path = 'total_freq_residues.txt'
total_frames_value = 21080

# Call the function with the file paths and total frames value
process_data(input_file_path, output_file_path, total_frames_value)
