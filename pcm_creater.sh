#!/bin/bash

# 设置参数
SAMPLE_RATE=44100
FREQUENCY=200
DURATION=5  # 持续时间（秒）
SAMPLES=$((SAMPLE_RATE * DURATION))
AMPLITUDE=2147483647  # 32 位 PCM 的最大值

# 生成方波 PCM 数据
for ((i=0; i<SAMPLES; i++)); do
    if (( (i * FREQUENCY) / SAMPLE_RATE % 2 == 0 )); then
        echo -n -e "\x33\x33\x33\x33"
    else
        echo -n -e "\x00\x00\x00\x00"
    fi
done > square_wave.pcm

echo "方波 PCM 文件已生成: square_wave.pcm"

ffmpeg -f s32le -ar $SAMPLE_RATE -ac 1 -i square_wave.pcm square_wave.mp3

echo "MP3 文件已生成: square_wave.mp3"