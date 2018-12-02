#import <stdio.h>
#import <stdlib.h>
#import <stdbool.h>

const int hashTableSize = 4*1024;
void* hashTable[hashTableSize];
int hashTableEntryLengths[hashTableSize];

int hashTableIndex(int frequency) {
    return abs(frequency) % hashTableSize;
}

bool hasSeenFrequency(int frequency) {
    int index = hashTableIndex(frequency);
    if (NULL == hashTable[index]) {
        return false;
    }

    for (int i = 0; i < hashTableEntryLengths[index]; i++) {
        int* hashTableEntry = hashTable[index];
        if (frequency == hashTableEntry[i]) {
            return true;
        }
    }
    return false;
}

void addFrequency(int frequency) {
    int index = hashTableIndex(frequency);
    hashTableEntryLengths[index] += 1;
    int *hashTableEntry = hashTable[index];
    hashTableEntry = realloc(hashTableEntry, hashTableEntryLengths[index] * sizeof(int));
    hashTableEntry[hashTableEntryLengths[index] - 1] = frequency;
    hashTable[index] = hashTableEntry;
}

bool doReadLoop(FILE *f, int* frequency) {
    int frequencyChange = 0;

    while (1 == fscanf(f, "%d\n", &frequencyChange)) {
        *frequency += frequencyChange;

        if (hasSeenFrequency(*frequency)) {
            printf("%d\n", *frequency);
            return false;
        }

        addFrequency(*frequency);
    }

    return true;
}

int main() {
    int frequency = 0;

    for (int i = 0; i < hashTableSize; i++) {
        hashTable[i] = NULL;
        hashTableEntryLengths[i] = 0;
    }

    addFrequency(frequency);

    FILE *f = fopen("input1.txt", "r");
    while (doReadLoop(f, &frequency)) {
        rewind(f);
    }
    fclose(f);

    return 0;
}
