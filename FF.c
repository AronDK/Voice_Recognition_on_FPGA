#include <stdio.h>
#include <complex.h>
#include <math.h>

#define N 8

unsigned int bitReverse(unsigned int x, int log2n) {
  int n = 0;
  for (int i = 0; i < log2n; i++) {
    n = (n << 1) | (x & 1);
    x >>= 1;
  }
  return n;
}

const double PI = 3.1415926536;

void fft(complex double* a, complex double* b, int log2n) {
  const complex double J = I;
  int n = 1 << log2n;
  for (unsigned int i = 0; i < n; ++i) {
    b[bitReverse(i, log2n)] = a[i];
  }
  for (int s = 1; s <= log2n; ++s) {
    int m = 1 << s;
    int m2 = m >> 1;
    complex double w = 1.0 + 0.0 * I;
    complex double wm = cexp(-J * (2.0 * PI / m2));
    for (int j = 0; j < m2; ++j) {
      for (int k = j; k < n; k += m) {
        complex double t = w * b[k + m2];
        complex double u = b[k];
        b[k] = u + t;
        b[k + m2] = u - t;
      }
      w *= wm;
    }
  }
}

int main() {
  complex double a[N] = { 0 + 0 * I, 1 + 1 * I, 3 + 3 * I, 4 + 4 * I, 4 + 4 * I, 3 + 3 * I, 1 + 1 * I, 0 + 0 * I };
  complex double b[N];
  fft(a, b, 3);
  for (int i = 0; i < N; i++) {
    printf("%lf + %lfi ", creal(b[i]), cimag(b[i]));
  }
  return 0;
}
