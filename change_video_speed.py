#!/Users/luke/local/miniconda3/envs/py38/bin/python

"""
Script to change the speed of a video file.

Usage:
    python script_name.py input.mov output.mp4 0.5

This script uses the moviepy library to change the speed of a video file.
It takes three command-line arguments:
    - input_file: Path to the input video file.
    - output_file: Path to the output video file.
    - speed_factor: Speed factor for the video.
                    0.5 for half-speed, 2 for double-speed, etc.

Example:
    python script_name.py input.mov output.mp4 0.5

This example command will process the "input.mov" video file, change its speed
to half-speed (0.5), and save the modified video as "output.mp4".
"""

import argparse
from moviepy.editor import VideoFileClip, vfx

def change_video_speed(input_file, output_file, speed_factor):
    """
    Change the speed of a video file.

    Args:
        input_file (str): Path to the input video file.
        output_file (str): Path to the output video file.
        speed_factor (float): Speed factor for the video.
                              0.5 for half-speed, 2 for double-speed, etc.
    """
    # Load the input video file
    clip = VideoFileClip(input_file)

    # Change the speed of the video
    modified_clip = clip.fx(vfx.speedx, speed_factor)

    # Write the modified video to a new file
    modified_clip.write_videofile(output_file, codec='libx264')

    # Close the video clips
    clip.close()
    modified_clip.close()

def main():
    parser = argparse.ArgumentParser(description='Change the speed of a video file.')
    parser.add_argument('input_file', type=str, help='Path to the input video file')
    parser.add_argument('output_file', type=str, help='Path to the output video file')
    parser.add_argument('speed_factor', type=float, help='Speed factor for the video')

    args = parser.parse_args()

    change_video_speed(args.input_file, args.output_file, args.speed_factor)

if __name__ == '__main__':
    main()
