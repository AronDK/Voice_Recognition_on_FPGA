#include <stdio.h>
#include <stdint.h>
#include <math.h>
#include <string.h>

typedef struct WavHeader {
    char chunkID[4];           // "RIFF"
    uint32_t chunkSize;        // Size of the entire file minus 8 bytes
    char format[4];            // "WAVE"
    char subchunk1ID[4];       // "fmt "
    uint32_t subchunk1Size;    // 16 for PCM
    uint16_t audioFormat;      // 1 for PCM
    uint16_t numChannels;      // 1 for mono, 2 for stereo
    uint32_t sampleRate;       // Samples per second
    uint32_t byteRate;         // sampleRate * numChannels * bitsPerSample/8
    uint16_t blockAlign;       // numChannels * bitsPerSample/8
    uint16_t bitsPerSample;    // Number of bits per sample
    char subchunk2ID[4];       // "data"
    uint32_t subchunk2Size;    // Number of bytes in data
} __attribute__((packed)) WavHeader;

void writeWavHeader(FILE *wavFile, int sampleRate, int numSamples, int bitsPerSample, int numChannels) {
    WavHeader header;

    // RIFF header
    strncpy(header.chunkID, "RIFF", 4);
    header.chunkSize = 36 + numSamples * numChannels * (bitsPerSample / 8);
    strncpy(header.format, "WAVE", 4);

    // fmt subchunk
    strncpy(header.subchunk1ID, "fmt ", 4);
    header.subchunk1Size = 16;
    header.audioFormat = 1;
    header.numChannels = numChannels;
    header.sampleRate = sampleRate;
    header.bitsPerSample = bitsPerSample;
    header.byteRate = sampleRate * numChannels * bitsPerSample / 8;
    header.blockAlign = numChannels * bitsPerSample / 8;

    // data subchunk
    strncpy(header.subchunk2ID, "data", 4);
    header.subchunk2Size = numSamples * numChannels * (bitsPerSample / 8);

    fwrite(&header, sizeof(WavHeader), 1, wavFile);
}

void writeSineWave(FILE *wavFile, int sampleRate, int duration, int frequency, int amplitude, int bitsPerSample, int numChannels) {
    int numSamples = sampleRate * duration;
    double sample;
    int16_t sampleInt;

    for (int i = 0; i < numSamples; ++i) {
        // Generate sine wave value
        sample = amplitude * sin(2 * M_PI * frequency * i / sampleRate);
        
        // Convert to integer format and ensure it's within bounds
        sampleInt = (int16_t)(sample * (1 << (bitsPerSample - 1)));
        if (sampleInt > 32767) sampleInt = 32767;
        if (sampleInt < -32768) sampleInt = -32768;

        for (int j = 0; j < numChannels; ++j) {
            fwrite(&sampleInt, sizeof(int16_t), 1, wavFile);
        }
    }
}

int main() {
    FILE *wavFile = fopen("sine_wave.wav", "wb");
    if (!wavFile) {
        fprintf(stderr, "Error opening file for writing\n");
        return 1;
    }

    int sampleRate = 44100;
    int duration = 5; // 5 seconds
    int frequency = 440; // A4
    int amplitude = 32000; // close to max value for 16-bit audio
    int bitsPerSample = 16;
    int numChannels = 1;

    writeWavHeader(wavFile, sampleRate, duration * sampleRate, bitsPerSample, numChannels);
    writeSineWave(wavFile, sampleRate, duration, frequency, amplitude, bitsPerSample, numChannels);

    fclose(wavFile);
    printf("WAV file sine_wave.wav created.\n");

    return 0;
}
