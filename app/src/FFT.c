/* Factored discrete Fourier transform, or FFT, and its inverse iFFT */

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
#include <math.h>
#include <stdbool.h>

#include "misc.h"
#include "FFT.h"
#include "audio_i2s.h"

/**
 * FFT Function - from https://rosettacode.org/wiki/Fast_Fourier_transform#C
 * @param v: complex array of waveform
 * @param n: length of waveform
 * @param tmp: temporary array
 * @return: DFT'd waveform
*/
void fft( complex *v, int n, complex *tmp ) {
  if(n > 1) {			/* otherwise, do nothing and return */
    int k,m;    complex z, w, *vo, *ve;
    ve = tmp; vo = tmp+n/2;
    for(k=0; k<n/2; k++) {
      ve[k] = v[2*k];
      vo[k] = v[2*k+1];
    }
    fft( ve, n/2, v );		/* FFT on even-indexed elements of v[] */
    fft( vo, n/2, v );		/* FFT on odd-indexed elements of v[] */
    for(m=0; m<n/2; m++) {
      w.Im = -sin(2*PI*m/(double)n);
      w.Re = cos(2*PI*m/(double)n);
      z.Re = w.Re*vo[m].Re - w.Im*vo[m].Im;	/* Re(w*vo[m]) */
      z.Im = w.Re*vo[m].Im + w.Im*vo[m].Re;	/* Im(w*vo[m]) */
      v[  m  ].Re = ve[m].Re + z.Re;
      v[  m  ].Im = ve[m].Im + z.Im;
      v[m+n/2].Re = ve[m].Re - z.Re;
      v[m+n/2].Im = ve[m].Im - z.Im;
    }
  }
  return;
}

/**
 * Calculates average waveform from directory
 * @param dir: directory to calculate from
 * @param profileName: name of profile to calculate
 * @return average waveform
*/
complex *profileCalc(DIR *dir, char *profileName) {

  printf("Calculating average waveform...\n");
  struct dirent *de;
  int i = 0;
  complex *cur = (complex *)malloc(TRANSFER_LEN * TRANSFER_RUNS * sizeof(complex));
  complex *next = (complex *)malloc(TRANSFER_LEN * TRANSFER_RUNS * sizeof(complex));
  
  // Initialize cur to first waveform of directory
  printf("Reading directory...\n");
  if ((de = readdir(dir)) != NULL) {
    FILE *fp = fopen(de->d_name, "r");
    printf("filename = %s\n", de->d_name);
    // Check if filename includes string avg.txt
    if (strstr(de->d_name, "avg.txt") != NULL) {
      // Scans file into cur
      for (i = 0; fscanf(fp, "%f,%f", &cur[i].Re, &cur[i].Im) != EOF; i++);
    }
    fclose(fp);
  }

  // Create averaged Wavefrom
  avgWF *tmp = (avgWF *)malloc(sizeof(avgWF));
  tmp->length = i;
  tmp->wave = cur;

  // Loop through directory and calculate average waveform
  while ((de = readdir(dir)) != NULL) {     
    FILE *fp = fopen(de->d_name, "r");
    if (fp == NULL) {
      printf("Error opening file\n");
      return NULL;
    }

    // Scans file into next, compares to cur, and saves to tmp
    for (i = 0; fscanf(fp, "%f,%f", &next[i].Re, &next[i].Im) != EOF; i++);
    tmp = Comparison(next, tmp, true);
  }
  printf("Done calculating average waveform\n");
  return tmp->wave;
}

/**
 * Wrapper Function for FFT, returns corrected Waveform
 * @param frames: array of frames to be FFT'd
 * @return: DFT'd waveform
*/
complex *fft_setup(uint32_t frames[TRANSFER_RUNS][TRANSFER_LEN]) {

  // Create waveform to save frames into
  complex *fft_input = (complex *)malloc(TRANSFER_LEN * TRANSFER_RUNS * sizeof(complex));
  int i, j = 0;
  for (i = 0; i < TRANSFER_RUNS; i++) {
      for (j = 0; j < TRANSFER_LEN; j++) {
          // Save 2d array into 1d array for FFT
          fft_input[i * TRANSFER_LEN + j].Re = frames[i][j];
          fft_input[i * TRANSFER_LEN + j].Im = frames[i][j];
      }
  }

  // Create temp waveform for FFT
  complex *tmp = (complex *)malloc(TRANSFER_LEN * TRANSFER_RUNS * sizeof(complex));
  fft(fft_input, TRANSFER_LEN * TRANSFER_RUNS, tmp);
  free(tmp);

  // Return DFT'd waveform
  return fft_input;
}

/**
 * Saves waveform to file
 * @param dir: directory to save to
 * @param filename: name of file to save to
 * @param waveform: waveform to save
 * @param size: size of waveform
*/
void saveWaveform(DIR *dir, char *filename, complex *waveform, int size) {
  printf("Saving waveform..., size = %d\n", size);  

  // Create .txt file, current system will time will be used as filename
  char *dataname = (char *)malloc(100 * sizeof(char)); 
  time_t seconds;
  seconds = time(NULL);
  char time_str[20];
  sprintf(time_str, "%ld", seconds);
  dataname = strcat(time_str, ".txt");
  chdir(filename);
  FILE *fp = fopen(dataname, "w");
  if (fp == NULL) {
    printf("Error opening file");
    return;
  }

  // Save wave to file
  for (int i = 0; i < size - 1; i++) {
    fprintf(fp, "%f,%f\n", waveform[i].Re, waveform[i].Im);
  }
  fclose(fp);
  printf("Saved waveform to %s\n", filename);
}

/**
 * Saves profile waveform to file
 * @param dir: directory to save to
 * @param filename: name of profile to save to
 * @param wf: waveform to save
*/
avgWF *Comparison(complex *waveform, avgWF *original, bool save) {

  printf("Comparing waveforms...\n");
  // Create matched array of same size, initialize to 0
  int count = 0; int *matched = (int *)malloc(original->length * sizeof(int));
  for (int i = 0; i < original->length; i++) { 
    // If waveform is within VARIANCE of original, count as matched
    if (waveform[i].Re <= (original->wave[i].Re * VARIANCE) && 
      waveform[i].Re >= (original->wave[i].Re * (-VARIANCE)) && 
      waveform[i].Im <= (original->wave[i].Im * VARIANCE) && 
      waveform[i].Im >= (original->wave[i].Im * (-VARIANCE))) {
      count++;
      matched[i] = 1; // Common elements are 1, uncommon are 0
    }
  }
  printf("Matched %d/%d samples\n", count, TRANSFER_LEN * TRANSFER_RUNS);

  // Remove points in original that do not match with new waveform
  if (save) {
    for (int i = 0; i < original->length; i++) {
      if (matched[i] == 0) {
        original->wave[i].Re = -1; // Set to negative number
        original->wave[i].Im = -1;
      }
    }
  }
  
  printf("Done comparing waveforms\n");
  return original;
}

/**
 * Saves profile waveform to file
 * @param dir: directory to save to
 * @param filename: name of profile to save to
 * @param wf: waveform to save
*/
void saveProfile(DIR *dir, char *filename, complex *wf, int size) {
  printf("Saving average waveform...\n");
  // final profile wavefroms saved as filename + avg.txt
  FILE *fp = fopen(strcat(filename, "avg.txt"), "w");
  // .txt structured as length, then waveform values
  fprintf(fp, "%d\n", size);
  for (int i = 0; i < size; i++) {
    fprintf(fp, "%f,%f\n", wf[i].Re, wf[i].Im);
  }
  fclose(fp);
  printf("Saved average waveform to %s\n", filename);
}