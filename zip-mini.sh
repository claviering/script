#!/bin/bash
# 压缩的时候忽略 git 文件, 文件大小从 12.7M 减少到 1.6M

zip -r ~/Desktop/file.zip . -x "*.git*" -9