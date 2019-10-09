#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Oct  9 15:10:07 2019

@author: dmann
"""

import matplotlib.pyplot as plt
import scipy.io.wavfile as wav
import numpy as np

path = '/Users/dmann/w/learn/wavStats/'

fileName = 'FMsweep.wav'
#s, y = wav.read(path + fileName)

# example with y as full-scale impulse
#y = np.array([0,32768,0])

# hydrophone calibration dBV re 1uPascal
hydroCal = -180

# board gain dB full-scale referenced to 1.0 V
boardGain = 2.0

sensitivityDb = hydroCal + boardGain

# calculate V / uPa
sensitivityLinear = np.power(10, sensitivityDb/20.0)

# scale to +/- 1.0
y = y / 32768.0

# remove DC offset (optional)
#y = y - np.mean(y)

# scale to Pascals
yMicroPascals = y / sensitivityLinear
yPascals = yMicroPascals / 1000000

peakPascals = max(yPascals)
peakDb = 20 * np.log10(peakPascals * 1000000)

print('Peak Pascals')
print(peakPascals)
print()
print('Peak dB re 1uPa')
print(peakDb)

plt.plot(yPascals)
plt.ylabel('Pa')
plt.show()