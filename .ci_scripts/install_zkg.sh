#!/bin/bash

export PATH=/usr/local/zeek/bin:/opt/zeek/bin:/opt/zeek-nightly/bin:$PATH

pip3 install -U zkg sphinx_rtd_theme
zkg autoconfig
