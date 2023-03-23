import os
import re
import argparse

def sorted_alphanumeric(data):
    convert = lambda text: int(text) if text.isdigit() else text.lower()
    alphanum_key = lambda key: [ convert(c) for c in re.split('([0-9]+)', key) ] 
    return sorted(data, key=alphanum_key)

def process(files, path):
    files = sorted_alphanumeric(files)

    out_dir = os.path.join(path,'../text.txt')
    if os.path.exists(out_dir):
        os.remove(out_dir)

    for file in files:
        if file.endswith('.txt'):
            pass
        else:
            continue
        position = path + file
        print(position)
        with open(position ,'r', encoding='utf-8') as f:
            for line in f.readlines():
                with open(out_dir,"a", encoding='utf-8') as p:
                    p.write(str(file) + " " + line + "\n")
                p.close()
        f.close()

if __name__ == '__main__':
    parser = argparse.ArgumentParser(__doc__)
    parser.add_argument("--path", type=str, required=True)
    args = parser.parse_args()

    files=os.listdir(args.path)




    process(files, args.path)