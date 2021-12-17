"""
Random sampling from very large files.
http://metadatascience.com/2014/02/27/random-sampling-from-very-large-files
Algorithm #3
"""

import argparse
import random
from collections import defaultdict


def random_sampler(filename, samplesize, randomseed):
    sample = []

    random.seed(randomseed)

    cache = defaultdict()

    with open(filename, 'rb') as f:
        f.seek(0, 2)
        filesize = f.tell()

        positions = sorted(random.sample(range(filesize), samplesize))

        for pos in positions:
            f.seek(pos)
            # Skip current line (because we might be in the middle of a line)
            f.readline()
            # Skip until line is not empty and have not yet occured
            line = ""
            while not line or line in cache:
                line = f.readline().decode("utf-8").rstrip()
            # Append the next line to the sample set
            sample.append(line)
            cache[line] = True

    return sample


def main():
    """Main."""
    args = get_args()

    sample = random_sampler(args.filename, args.samplesize, args.randomseed)

    for s in sample:
        print(s)


def get_args():
    """Parse command line arguments."""
    parser = argparse.ArgumentParser(
        description=__doc__,
        formatter_class=argparse.ArgumentDefaultsHelpFormatter
    )
    parser.add_argument(
        '-f', '--filename',
        help='name of file to sample from',
        required=True,
        type=str,
        default=argparse.SUPPRESS
    )
    parser.add_argument(
        '-s', '--samplesize',
        help='number of lines in sample',
        required=True,
        type=int,
        default=argparse.SUPPRESS
    )
    parser.add_argument(
        '-r', '--randomseed',
        help='random seed',
        required=True,
        type=int,
        default=argparse.SUPPRESS
    )
    

    return parser.parse_args()


if __name__ == '__main__':
    main()

