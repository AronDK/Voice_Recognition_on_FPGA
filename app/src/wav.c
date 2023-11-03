#include "wav.h"
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <stdint.h>

wav_file_t* wav_file_create(const char *filename, uint32_t sample_rate, uint16_t num_channels, size_t num_samples, size_t bits_per_sample) {
    // Allocate memory for wav_file_t structure
    wav_file_t *wav_file = (wav_file_t *)malloc(sizeof(wav_file_t));
    if (wav_file == NULL) {
        fprintf(stderr, "Error allocating memory for wav_file_t\n");
        return NULL;
    }

    // Initialize the WAV file structure for 32-bit samples
    wav_file->filename = strdup(filename);
    wav_file->sample_rate = sample_rate;
    wav_file->num_channels = num_channels;
    wav_file->bits_per_sample = bits_per_sample;  // Set to 32 bits per sample
    wav_file->data_size = 0;

    // Open the WAV file for writing
    wav_file->file = fopen(filename, "wb");
    if (wav_file->file == NULL) {
        fprintf(stderr, "Error opening file %s for writing\n", filename);
        free(wav_file->filename);
        free(wav_file);
        return NULL;
    }

    // Write the initial WAV header with placeholders for final values
    wav_header_t header;
    memset(&header, 0, sizeof(wav_header_t));
    strncpy(header.chunk_id, "RIFF", 4);
    strncpy(header.format, "WAVE", 4);
    strncpy(header.subchunk1_id, "fmt ", 4);
    header.subchunk1_size = 16;  // PCM header size
    header.audio_format = 1;  // PCM format
    header.num_channels = num_channels;
    header.sample_rate = sample_rate;
    header.byte_rate = sample_rate * num_channels * (wav_file->bits_per_sample/8);  // 4 bytes per 32-bit sample
    header.block_align = num_channels * (wav_file->bits_per_sample/8);  // 4 bytes per 32-bit sample
    header.bits_per_sample = bits_per_sample;  // 32 bits per sample
    strncpy(header.subchunk2_id, "data", 4);
    header.subchunk2_size = num_channels * (wav_file->bits_per_sample/8) * num_samples;  // Will be updated later
    header.chunk_size = 4 + (header.subchunk1_size + 8) + (header.subchunk2_size + 8);  // Will be updated later

    size_t written = fwrite(&header, 1, sizeof(wav_header_t), wav_file->file);
    if (written != sizeof(wav_header_t)) {
        fprintf(stderr, "Error writing WAV header to %s\n", filename);
        fclose(wav_file->file);
        free(wav_file->filename);
        free(wav_file);
        return NULL;
    }

    return wav_file;
}

void wav_file_write(wav_file_t *wav_file, uint32_t *data, size_t num_samples) {
    if (!wav_file || !data || num_samples == 0) {
        fprintf(stderr, "Invalid arguments passed to wav_file_write\n");
        return;
    }

    // Write the 32-bit audio sample data to the WAV file
    size_t written = fwrite(data, wav_file->bits_per_sample/8, num_samples, wav_file->file);
    if (written != num_samples) {
        fprintf(stderr, "Failed to write audio data to WAV file\n");
    } else {
        // Update the data size in the WAV file structure
        wav_file->data_size += written * sizeof(int32_t);
    }
}

void wav_file_close(wav_file_t *wav_file) {
    if (!wav_file || !wav_file->file) {
        fprintf(stderr, "Invalid WAV file structure passed to wav_file_close\n");
        return;
    }

    // Go back to the beginning of the file to update the headers
    fseek(wav_file->file, 0, SEEK_SET);

    wav_header_t header;
    memset(&header, 0, sizeof(wav_header_t));
    strncpy(header.chunk_id, "RIFF", 4);
    header.chunk_size = 36 + wav_file->data_size;  // Size of the entire file minus 8 bytes
    strncpy(header.format, "WAVE", 4);
    strncpy(header.subchunk1_id, "fmt ", 4);
    header.subchunk1_size = 16;  // PCM header size
    header.audio_format = 1;  // PCM format
    header.num_channels = wav_file->num_channels;
    header.sample_rate = wav_file->sample_rate;
    header.byte_rate = wav_file->sample_rate * wav_file->num_channels * 4;  // 4 bytes per 32-bit sample
    header.block_align = wav_file->num_channels * 4;  // 4 bytes per 32-bit sample
    header.bits_per_sample = 32;  // 32 bits per sample
    strncpy(header.subchunk2_id, "data", 4);
    header.subchunk2_size = wav_file->data_size;

    // Write the updated header back to the file
    size_t written = fwrite(&header, 1, sizeof(wav_header_t), wav_file->file);
    if (written != sizeof(wav_header_t)) {
        fprintf(stderr, "Error updating WAV header in file %s\n", wav_file->filename);
    }

    // Close the WAV file
    fclose(wav_file->file);

    // Free the memory allocated for the filename and the WAV file structure
    free(wav_file->filename);
    free(wav_file);
}
