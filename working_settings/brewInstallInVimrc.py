#!python3

import re

reBrewInstall = re.compile(
    r'brew\s+install(?:\s+(\w[a-zA-Z0-9-]*))+(?!.*deprecated)')

if __name__ == '__main__':
    with open("./vimrc") as fp:
        lines = fp.readlines()

    all = []
    for line in lines:
        res = reBrewInstall.findall(line)
        if res:
            print(res, line)
            all.extend(res)

    print(f'total {len(all)} fomulas to install')
    print(f"brew install {' '.join(all)}")
