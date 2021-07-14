#!/usr/bin/env python
#-*- coding: utf-8 -*-
import os
import sys
from PIL import Image

# 图片转 GIF

## Usage
# `python3 main.py -i inputfilename.png`
# `python3 main.py -i inputfilename.png -o outputfilename.gif`


def tips():
    print(help)
    sys.exit(2)

help = "usage: python3 main.py <input iamge file>"

if (len(sys.argv) < 2):
    tips()

inputFileName = sys.argv[1:][0]

if len(inputFileName) == 0:
    tips()

try:
    outFileName = os.path.splitext(inputFileName)[0] + ".gif"
    image1 = Image.open(inputFileName)
    im1 = image1.convert('RGB')
    im1.save(outFileName)
except:
    tips()
