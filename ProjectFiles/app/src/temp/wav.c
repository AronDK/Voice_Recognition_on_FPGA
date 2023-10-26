#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdint.h>

typedef struct {
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
} WavHeader;

void createWavHeader(WavHeader *header, int sampleRate, int bitsPerSample, int numChannels, int numSamples) {
    // RIFF chunk
    header->chunkID[0] = 'R';
    header->chunkID[1] = 'I';
    header->chunkID[2] = 'F';
    header->chunkID[3] = 'F';
    header->chunkSize = 36 + numSamples * numChannels * (bitsPerSample / 8);
    header->format[0] = 'W';
    header->format[1] = 'A';
    header->format[2] = 'V';
    header->format[3] = 'E';

    // fmt sub-chunk
    header->subchunk1ID[0] = 'f';
    header->subchunk1ID[1] = 'm';
    header->subchunk1ID[2] = 't';
    header->subchunk1ID[3] = ' ';
    header->subchunk1Size = 16;
    header->audioFormat = 1; // PCM
    header->numChannels = numChannels;
    header->sampleRate = sampleRate;
    header->byteRate = sampleRate * numChannels * (bitsPerSample / 8);
    header->blockAlign = numChannels * (bitsPerSample / 8);
    header->bitsPerSample = bitsPerSample;

    // data sub-chunk
    header->subchunk2ID[0] = 'd';
    header->subchunk2ID[1] = 'a';
    header->subchunk2ID[2] = 't';
    header->subchunk2ID[3] = 'a';
    header->subchunk2Size = numSamples * numChannels * (bitsPerSample / 8);
}

int main() {
    FILE *file = fopen("sine_wave.wav", "wb");
    if (!file) {
        fprintf(stderr, "Failed to open file for writing\n");
        return 1;
    }

    int sampleRate = 44100;
    int bitsPerSample = 16;
    int numChannels = 1;
    double frequency = 440.0; // A4 note
    double duration = 5.0; // 5 seconds

    int numSamples = (int)(duration * sampleRate);
    WavHeader header;
    createWavHeader(&header, sampleRate, bitsPerSample, numChannels, numSamples);

    fwrite(&header, sizeof(WavHeader), 1, file);

    for (int i = 0; i < numSamples; ++i) {
        double sample = 0.5 * sin((2.0 * M_PI * frequency * i) / sampleRate);
        short sampleInt = (short)(sample * (pow(2, bitsPerSample - 1) - 1));
        fwrite(&sampleInt, sizeof(short), 1, file);
    }

    fclose(file);
    printf("WAV file created\n");

    return 0;
}
