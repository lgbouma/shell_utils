#!/Users/luke/local/miniconda3/envs/py311/bin/python

import argparse
import datetime
from astropy.time import Time

def main():
    parser = argparse.ArgumentParser(
        description="Convert input YYYYMMDD date to TESS Julian Date (JD - 2457000)"
    )
    parser.add_argument("date", help="Date string in YYYYMMDD format")
    args = parser.parse_args()

    # Convert datestring to datetime object
    dt = datetime.datetime.strptime(args.date, '%Y%m%d')
    # Create astropy Time object
    t = Time(dt)
    # Calculate TESS Julian Date
    tess_jd = t.jd - 2457000
    print(tess_jd)

if __name__ == "__main__":
    main()
