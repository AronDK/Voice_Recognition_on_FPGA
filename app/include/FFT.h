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

#define q	8		/* for 2^3 points */
#define N	(1<<q)		/* N-point FFT, iFFT */

typedef float real;
typedef struct{real Re; real Im;} complex;
typedef struct{complex *wave; int length;} avgWF;


#ifndef PI
# define PI	3.14159265358979323846264338327950288
#endif

// FFT
static void fft( complex *v, int n, complex *tmp );
// Setup FFT with wav inputs
complex *fft_setup(uint32_t frames[][256], int transLens, int transRuns);
// Setup FFT with wav inputs
void saveWaveform(DIR *dir, char *filename, complex *waveform, int size);
// Average directory
complex *DirAvg(DIR *dir, char *profileName, int transLen, int transRuns); 
// Compares 2 waveforms, returns array of matched indexes - 1 if they are the same, 0 if they are different 
avgWF *Comparison(complex *waveform, avgWF *original, int transLen, int transRuns);
// Saves avgWF struct
void saveAvg(DIR *dir, char *filename, complex *wf, int size);