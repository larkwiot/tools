#!/bin/bash

CC=clang CXX=clang++ CFLAGS=-march=native ./build.sh --enable-avx --enable-sse2 --enable-pretty --with-pcre2 --with-boost_regex --with-zlib --with-bzlib --with-lzma --with-lz4CC=clang CXX=clang++ CFLAGS='-march=native' ./build.sh --enable-pretty --with-pcre2 \
	--with-boost_regex --with-zlib --with-bzlib --with-lzma --with-lz4 --mmap --avx