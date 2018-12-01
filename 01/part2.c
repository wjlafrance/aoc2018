#import <stdio.h>
#import <stdlib.h>
#import <stdbool.h>

int* previouslySeenFrequencies = NULL;
int previouslySeenFrequenciesCount = 0;

bool hasSeenFrequency(int frequency) {
    for (int i = 0; i < previouslySeenFrequenciesCount; i++) {
        if (frequency == previouslySeenFrequencies[i]) {
            return true;
        }
    }
    return false;
}

void addFrequency(int frequency) {
    previouslySeenFrequencies = realloc(previouslySeenFrequencies, ++previouslySeenFrequenciesCount * sizeof(int));
    previouslySeenFrequencies[previouslySeenFrequenciesCount - 1] = frequency;
}

void doReadLoop(int* frequency) {
    int frequencyChange = 0;

    FILE *f = fopen("input1.txt", "r");
    while (1 == fscanf(f, "%d\n", &frequencyChange)) {
        printf("frequency: %d, change: %d\n", *frequency, frequencyChange);
        *frequency += frequencyChange;

        if (hasSeenFrequency(*frequency)) {
            printf("%d\n", *frequency);
            fclose(f);
            exit(0);
        }

        addFrequency(*frequency);
    }
    fclose(f);
}

int main() {
    int frequency = 0;

    addFrequency(frequency);
    while (true) {
        doReadLoop(&frequency);
    }

    return 0;
}
