DSP Project: Audio Signal Denoising and Spectral Analysis

Overview

This project focuses on digital signal processing techniques applied to an audio file to analyze and remove a 15.2 kHz sinusoidal interference. The tasks are divided into two main parts: Spectral Estimation and Digital Filter Design.

⸻

Part 1: Spectral Estimation

Objectives
	•	Read and manipulate audio data.
	•	Inject sinusoidal interference.
	•	Analyze the signal in the frequency domain using Welch’s method.

Steps
	1.	Audio Processing:
	•	Read the audio file and extract the sampling frequency.
	•	Extract a 3-second segment from the center of the audio signal.
	2.	Signal Visualization:
	•	Plot the 3-second audio signal in the time domain.
	3.	Interference Injection:
	•	Generate a 15.2 kHz sinusoidal signal (amplitude: 1.8).
	•	Add the interference to the audio signal and listen to both versions.
	4.	Spectral Analysis:
	•	Use Welch’s method to plot the power spectral density (PSD).
	•	Explore effects of different parameters:
	•	FFT Size: 2^9, 2^{10}, 2^{11}
	•	Window Types: Kaiser (β=7), Rectangular, Hanning, Hamming
	•	Window Size: 256, 512, 1024
	•	Percentage Overlap: 25%, 50%, 75%
	•	Sampling Frequency: 22050, 32000, 44100 Hz

⸻

Part 2: Digital Filter Design

Problem Statement

Remove the 15.2 kHz interference from the corrupted audio signal using a digital FIR filter, while meeting strict constraints on performance and computational cost.

Design Constraints

Parameter	Constraint
Computational Cost	1.6–6.4 million MACs/s
Latency	< 3.2 ms
Filter Length (N)	100 ≤ N ≤ 200
Stopband Attenuation	≥ 50 dB
Passband Ripple	≤ 0.4 dB

Filter Specifications
	•	Fs: 32 kHz
	•	Filter Type: FIR (Linear Phase)
	•	Transition Band: 14.6 kHz to 15.2 kHz
	•	Stopband Attenuation: ≥ 60 dB
	•	Passband Ripple: ≤ 0.1 dB
	•	Transition Width: ~600 Hz

Filter Designs

Design Method	Order	Stopband Att.	Ripple	Latency	MACs/s
Kaiser Window	175	75 dB	< 0.001	2.73 ms	5.63 M
Equiripple	150	51.57 dB	< 0.2	2.73 ms	5.63 M
Blackman Window	200	~	< 0.002	3.125ms	6.43 M
Least Squares	190	~	< 0.0002	2.97 ms	6.11 M

Decision Analysis

A weighted criteria table was used to evaluate filters. The Kaiser Window FIR was selected due to its superior attenuation, minimal ripple, and low latency.

Final Steps
	•	Apply the selected FIR filter to the noisy audio.
	•	Plot the frequency spectrum before and after filtering.
	•	Observe the significant reduction in the 15.2 kHz interference.
 
⸻

Requirements
	•	MATLAB (with Signal Processing Toolbox)
	•	Audio file for analysis
 
⸻

Conclusion

This project demonstrates end-to-end audio signal processing, from data acquisition to advanced filter design and evaluation. The final result is a cleaner, interference-free audio signal that satisfies both auditory and computational constraints.
