import zlib
import gzip
import bz2
import lzma
import sys
import io
import zipfile
import numpy as np

if len(sys.argv) < 2:
    print("Usage: python compressRateCompare.py <file_path>")
    sys.exit(1)

file_path = sys.argv[1]

with open(file_path, "rb") as f:
    data = f.read()

for name, compress in [
    ("zlib", zlib.compress),
    ("gzip", gzip.compress),
    ("bz2", bz2.compress),
    ("lzma", lzma.compress),
]:
    result = compress(data)
    ratio = len(result) / len(data) * 100
    print(f"{name:5} 压缩后: {len(result):>8} bytes, " f"剩余比例: {ratio:.2f}%")
