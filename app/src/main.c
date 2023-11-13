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
 * IMPLIED, INCLUDING BUT NOT LIMITEDTO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <dirent.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>

#include "audio_i2s.h"
#include "wav.h"
#include "FFT.h"


#define NUM_CHANNELS 1  
#define BPS 24
#define SAMPLE_RATE 44600 / 2
#define RECORD_DURATION 10
#define TRANSFER_RUNS RECORD_DURATION * SAMPLE_RATE / TRANSFER_LEN

void addToProfile(complex *waveform, DIR *dir, char *name) {
    printf("\nEnter sound profile name to save to: ");
    scanf("%s", name);        
    // Find Directory
    dir = opendir(name);
    while (dir == NULL) {
        printf("\nDirectory not found. Enter sound profile name to save to: ");
        scanf("%s", name);
        dir = opendir(name);
    }
    saveWaveform(dir, name, waveform);
    complex *avg = DirAvg(dir, name, TRANSFER_LEN, TRANSFER_RUNS);
    DIR *avgdir = opendir(strcat(name, "avg"));
    saveWaveform(avgdir, name, avg);
}

void makeNewProfile(complex *waveform, DIR *dir, char *name) {
    printf("\nEnter sound profile name: ");
    scanf("%s", name);
    mkdir(name, 0777);
    dir = opendir(name); 
    saveWaveform(dir, name, waveform);
    complex *avg = DirAvg(dir, name, TRANSFER_LEN, TRANSFER_RUNS);
    mkdir(strcat(name, "avg"), 0777);
    DIR *avgdir = opendir(strcat(name, "avg"));
    saveWaveform(avgdir, name, avg);
}

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

int main(int argc, char **argv) {
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


    // Perform FFT on frames
    complex *waveform = fft_setup(frames, TRANSFER_LEN, TRANSFER_RUNS);
    if (argv[1][0] == '1') {
        int response; DIR *dir; char *name;
        printf("Save to existing sound profile or create new one? (1/0): ");
        scanf("%d", &response);
        if (response == 1) addToProfile(waveform, dir, name);
        else makeNewProfile(waveform, dir, name);
    } else if (argv[1][0] == '0') {
        // Compare to existing sound profiles
        DIR *dir; char *name;
        printf("Enter sound profile name to compare to: ");
        scanf("%s", name);
        dir = opendir(strcat(name, "avg"));
        FILE *fp = fopen(name, "r");
        complex *avg = (complex *)malloc(TRANSFER_LEN * TRANSFER_RUNS * sizeof(complex));
        for (int i = 0; fscanf(fp, "%f,%f", &avg[i].Re, &avg[i].Im) != EOF; i++);
        fclose(fp);

        // Compare
        int count = 0;
        for (int i = 0; i < TRANSFER_LEN * TRANSFER_RUNS; i++) {
            // Within 5% of average (Uncertainty)
            if (waveform[i].Re <= (avg[i].Re + avg[i].Re * 0.05) && 
            waveform[i].Re >= (avg[i].Re - avg[i].Re * 0.05) && 
            waveform[i].Im <= (avg[i].Im + avg[i].Im * 0.05) && 
            waveform[i].Im >= (avg[i].Im - avg[i].Im * 0.05)) count++;
        }
        printf("Matched %d/%d samples\n", count, TRANSFER_LEN * TRANSFER_RUNS);
    }

    audio_i2s_release(&my_config);
    return 0;
}