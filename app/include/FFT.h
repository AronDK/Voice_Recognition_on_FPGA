#define FFT_H

#include <assert.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <dirent.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>
#include <time.h>
#include <string.h>
#include <stdbool.h>
#include <math.h>

#include "misc.h"
#include "audio_i2s.h"

#define q	8		/* for 2^3 points */
#define N	(1<<q)		/* N-point FFT, iFFT */
#define VARIANCE 1.8 // VARIANCE factor for comparison

typedef float real;
typedef struct{real Re; real Im;} complex; // Waveform
typedef struct{complex *wave; int length;} avgWF; // Averaged waveform to be saved, in hindsight length param is unnecesssary


#ifndef PI
# define PI	3.14159265358979323846264338327950288
#endif

/**
 * FFT Function - https://rosettacode.org/wiki/Fast_Fourier_transform#C
 * @param v: complex array of waveform
 * @param n: length of waveform
 * @param tmp: temporary array
 * @return: DFT'd waveform
*/
static void fft( complex *v, int n, complex *tmp );

/**
 * Wrapper Function for FFT, returns corrected Waveform
 * @param frames: array of frames to be FFT'd
 * @return: DFT'd waveform
*/
complex *fft_setup(uint32_t frames[TRANSFER_RUNS][TRANSFER_LEN]);

/**
 * Saves waveform to file
 * @param dir: directory to save to
 * @param filename: name of file to save to
 * @param waveform: waveform to save
 * @param size: size of waveform
*/
void saveWaveform(DIR *dir, char *filename, complex *waveform, int size);

/**
 * Calculates average waveform from directory
 * @param dir: directory to calculate from
 * @param profileName: name of profile to calculate
 * @return average waveform
*/
complex *profileCalc(DIR *dir, char *profileName); 

/**
 * Compares 2 waveforms, returns array of matched indexes - 1 if they are the same, 0 if they are different 
 * @param waveform: waveform to compare
 * @param original: original waveform to compare to
 * @param save: whether or not to save the waveform
 * @return: Compared waveform, with irrelevant frequencies removed
*/
avgWF *Comparison(complex *waveform, avgWF *original, bool save);

/**
 * Saves profile waveform to file
 * @param dir: directory to save to
 * @param filename: name of profile to save to
 * @param wf: waveform to save
*/
void saveProfile(DIR *dir, char *filename, complex *wf, int size);