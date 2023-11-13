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
#include "FFT.h"



void fft( complex *v, int n, complex *tmp ) {
  if(n>1) {			/* otherwise, do nothing and return */
    int k,m;    complex z, w, *vo, *ve;
    ve = tmp; vo = tmp+n/2;
    for(k=0; k<n/2; k++) {
      ve[k] = v[2*k];
      vo[k] = v[2*k+1];
    }
    fft( ve, n/2, v );		/* FFT on even-indexed elements of v[] */
    fft( vo, n/2, v );		/* FFT on odd-indexed elements of v[] */
    for(m=0; m<n/2; m++) {
      w.Re = cos(2*PI*m/(double)n);
      w.Im = -sin(2*PI*m/(double)n);
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

complex *DirAvg(DIR *dir, char *profileName, int transLen, int transRuns) {
  struct dirent *de;
  int count, i = 0;
  complex *cur = (complex *)malloc(transLen * transRuns * sizeof(complex));
  complex *next = (complex *)malloc(transLen * transRuns * sizeof(complex));
  while (de = readdir(dir) != NULL) {     
    FILE *fp = fopen(de->d_name, "r");
    for (i = 0; fscanf(fp, "%f,%f", &next[i].Re, &next[i].Im) != EOF; i++) {
      cur[i].Re += next[i].Re;
      cur[i].Im += next[i].Im;
    } 
    fclose(fp);
    count++;
  }
  
  for (i--; i >= 0; i--) {
    cur[i].Re /= count;
    cur[i].Im /= count;
  }

  return cur;
}

complex *fft_setup(uint32_t frames[][256], int transLens, int transRuns) {
  complex *fft_input = (complex *)malloc(transLens * transRuns * sizeof(complex));
  for (int i = 0; i < transRuns; i++) {
      for (int j = 0; j < transLens; j++) {
          fft_input[i * transLens + j].Re = frames[j][i];
          fft_input[i * transLens + j].Im = frames[j][i];
      }
  }
  complex *tmp = (complex *)malloc(transLens * transRuns * sizeof(complex));
  fft(&fft_input, transLens * transRuns, tmp);
  free(tmp);
}

void saveWaveform(DIR *dir, char *filename, complex *waveform) {
  time_t seconds;
  seconds = time(NULL);
  char *filename = strcat(seconds, ".txt");
  FILE *fp = fopen(filename, "w");
  fprintf(fp, "%s", waveform);
}