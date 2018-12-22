import argparse
import os
import shutil

import config

ORIG_DIR = "orig"
LINK_DIR = "link"
CUR_DIR  = os.getcwd()


def get_target_files():
    path = CUR_DIR + "/" + ORIG_DIR
    files = os.listdir(path)
    return [f for f in files if os.path.isfile(os.path.join(path, f))]


def change_file(path):
    target_file = os.path.basename(path)
    contents = []

    if target_file == ".gitconfig":
        with open(path, "r") as f:
            for line in f:
                if "example_user" in line:
                    contents.append(line.replace("example_user", config.GITCONFIG_NAME))
                elif "example@example.com" in line:
                    contents.append(line.replace("example@example.com", config.GITCONFIG_MAIL))
                else:
                    contents.append(line)
            return contents

    raise ValueError()


def store_file(path, contents):
    with open(path, "w+") as f:
        for c in contents:
            f.write(c)
        return


def copy2linkdir(target_files):

    # Make link dir if not exists
    path = CUR_DIR + "/" + LINK_DIR
    if not os.path.exists(path):
        os.mkdir(path)

    for target_file in target_files:
        link_path = CUR_DIR + "/" + LINK_DIR + "/" + target_file
        if os.path.exists(link_path):
            print("File already exists!: " + link_path)
            continue

        orig_path = CUR_DIR + "/" + ORIG_DIR + "/" + target_file
        if target_file == ".gitconfig":
            contents = change_file(orig_path)
            store_file(link_path, contents)
        else:
            shutil.copy(orig_path, link_path)
            continue

        print(orig_path + " -> " + link_path)


def main():
    parser = argparse.ArgumentParser(
        prog="make.py",
        add_help=True,
    )

    parser.add_argument(
        "-l",
        "--link",
        action="store_true",
    )

    args = parser.parse_args()
    target_files = get_target_files()

    copy2linkdir(target_files)


if __name__ == "__main__":
    main()
