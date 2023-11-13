/** 22T3 COMP3601 Design Project A
 * File name: main.c
 * Description: Example main file for using the audio_i2s driver for your Zynq audio driver.
 *
 * Distributed under the MIT license.
 * Copyright (c) 2022 Elton Shih
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
 * of the Software, and to permit persons to whom the Software is furnished to do
 * so, subject to the following conditions:
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <stdlib.h>
#include "kiss_fft.h"
#include "audio_i2s.h"
#include "wav.h"

#define NUM_CHANNELS 1  
#define BPS 24
#define SAMPLE_RATE 44600 / 2
#define RECORD_DURATION 10
#define TRANSFER_RUNS RECORD_DURATION * SAMPLE_RATE / TRANSFER_LEN

// Define the notch filter frequency
#define NOTCH_FREQ 1000  // Replace with the frequency you want to notch


void bin(uint8_t n) {
    uint8_t i;
    // for (i = 1 << 7; i > 0; i = i >> 1)
    //     (n & i) ? printf("1") : printf("0");
    // for (i = 0; i < 8; i++) // LSB first
    //     (n & (1 << i)) ? printf("1") : printf("0");
}

void parsemem(void* virtual_address, int word_count) {
    uint32_t *p = (uint32_t *)virtual_address;
    char *b = (char*)virtual_address;
    int offset;

    uint32_t sample_count = 0;
    uint32_t sample_value = 0;
    for (offset = 0; offset < word_count; offset++) {
        sample_value = p[offset] & ((1<<18)-1);
        sample_count = p[offset] >> 18;

        for (int i = 0; i < 4; i++) {
            bin(b[offset*4+i]);
            // printf(" ");
        }
        // printf(" -> [%d]: %02x (%dp)\n", sample_count, sample_value, sample_value*100/((1<<18)-1));
    }

}

// Function to apply a notch filter using Kiss FFT
void apply_notch_filter(uint32_t *frame, size_t frame_size, float sample_rate, float notch_freq) {
    float bin_width = sample_rate / frame_size;
    int notch_bin = notch_freq / bin_width;

    kiss_fft_cpx *in = (kiss_fft_cpx*)malloc(sizeof(kiss_fft_cpx) * frame_size);
    kiss_fft_cpx *out = (kiss_fft_cpx*)malloc(sizeof(kiss_fft_cpx) * frame_size);
    kiss_fft_cfg cfg = kiss_fft_alloc(frame_size, 0, NULL, NULL);

    // Fill input buffer
    for (size_t i = 0; i < frame_size; i++) {
        in[i].r = frame[i];
        in[i].i = 0;
    }

    // Perform FFT
    kiss_fft(cfg, in, out);

    // Apply notch filter in the frequency domain
    for (size_t i = notch_bin - 1; i <= notch_bin + 1; i++) {  // Simple notch filter
        out[i].r *= 0.1;  // Attenuate the real part
        out[i].i *= 0.1;  // Attenuate the imaginary part
    }

    // Perform inverse FFT
    kiss_fft_cfg icfg = kiss_fft_alloc(frame_size, 1, NULL, NULL);
    kiss_fft(icfg, out, in);

    // Copy back to frame
    for (size_t i = 0; i < frame_size; i++) {
        frame[i] = in[i].r;
    }

    // Cleanup
    free(in);
    free(out);
    free(cfg);
    free(icfg);
}



int main() {
    printf("Entered main\n");

    uint32_t frames[TRANSFER_RUNS][TRANSFER_LEN] = {0};

    audio_i2s_t my_config;
    if (audio_i2s_init(&my_config) < 0) {
        printf("Error initializing audio_i2s\n");
        return -1;
    }

    printf("mmapped address: %p\n", my_config.v_baseaddr);
    printf("Before writing to CR: %08x\n", audio_i2s_get_reg(&my_config, AUDIO_I2S_CR));
    audio_i2s_set_reg(&my_config, AUDIO_I2S_CR, 0x1);
    printf("After writing to CR: %08x\n", audio_i2s_get_reg(&my_config, AUDIO_I2S_CR));
    printf("SR: %08x\n", audio_i2s_get_reg(&my_config, AUDIO_I2S_SR));
    printf("Key: %08x\n", audio_i2s_get_reg(&my_config, AUDIO_I2S_KEY));
    printf("Before writing to gain: %08x\n", audio_i2s_get_reg(&my_config, AUDIO_I2S_GAIN));
    audio_i2s_set_reg(&my_config, AUDIO_I2S_GAIN, 0x1);
    printf("After writing to gain: %08x\n", audio_i2s_get_reg(&my_config, AUDIO_I2S_GAIN));
    printf("Initialized audio_i2s\n");
    printf("Starting audio_i2s_recv\n");
    for (int i = 0; i < TRANSFER_RUNS; i++) {
        int32_t *samples = audio_i2s_recv(&my_config);
        memcpy(frames[i], samples, TRANSFER_LEN*sizeof(int32_t));
    
        // Apply notch filter to each frame
        apply_notch_filter(frames[i], TRANSFER_LEN, SAMPLE_RATE, NOTCH_FREQ);
    }

    for (int i = 0; i < TRANSFER_RUNS; i++) {
        // printf("Frame %d:\n", i);
        parsemem(frames[i], TRANSFER_LEN);
        // printf("==============================\n");
    }
    
    wav_file_t* wav_file = wav_file_create("test.wav", SAMPLE_RATE, NUM_CHANNELS, TRANSFER_LEN * TRANSFER_RUNS, BPS);
    if (wav_file == NULL) {
        fprintf(stderr, "Failed to create WAV file\n");
        return 1;
    }

    for (int i = 0; i < TRANSFER_RUNS; i++) {
        wav_file_write(wav_file, frames[i], TRANSFER_LEN);
    }
    wav_file_close(wav_file);

    audio_i2s_release(&my_config);
    return 0;
}