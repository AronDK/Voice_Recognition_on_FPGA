#ifndef WAV_H
#define WAV_H

#include <stdint.h>
#include <stdio.h>

// Define a structure to hold WAV file header information
typedef struct {
    char chunk_id[4];
    uint32_t chunk_size;
    char format[4];
    char subchunk1_id[4];
    uint32_t subchunk1_size;
    uint16_t audio_format;
    uint16_t num_channels;
    uint32_t sample_rate;
    uint32_t byte_rate;
    uint16_t block_align;
    uint16_t bits_per_sample;
    char subchunk2_id[4];
    uint32_t subchunk2_size;
} wav_header_t;

// Define a structure to represent a WAV file
typedef struct {
    FILE *file;
    char *filename;
    uint32_t data_size;
    uint32_t sample_rate;
    uint16_t num_channels;
    uint16_t bits_per_sample;
} wav_file_t;

wav_file_t* wav_file_create(const char *filename, uint32_t sample_rate, uint16_t num_channels, uint16_t bits_per_sample);
void wav_file_write(wav_file_t *wav_file, const int32_t *data, size_t num_samples);
void wav_file_close(wav_file_t *wav_file);

#endif // WAV_H
