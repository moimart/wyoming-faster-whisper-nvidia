#!/usr/bin/env bashi

CUDA_VISIBLE_DEVICES=2 script/run --device cuda --model tiny-int8 --language en --uri 'tcp://0.0.0.0:10300' --data-dir ./data --download-dir ./data
