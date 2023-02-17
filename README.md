
# Progetto Elaborazione delle Immagini Appello di Febbraio 2023

## Componenti Gruppi
- Colombo Adriano (866359)
- Costato Marco (866373)
- Fantoni Giovanni (866101)

## Script Pipeline
tutti gli script necessari per eseguire la pipeline sono in questa cartella.

### *pipeline.m*
è una funzione matlab che accetta una immagine rgb come input e restituisce un oggetto così strutturato come output

```matlab
out.segmentation = %immagine contenente la segmentazione dell'immagine di inpunt
out.labels = %immagine contenente le labels ottenute dalla segmentazione
out.bboxes = %array di dimensioni n X 4 dove ogni riga ha i dati di una bbox
out.predictions = %array di cell dove nell'iesima posizione è presente la predict dell'iesima bbox;
```

### *test_pipeline.m*
script per eseguire la pipeline su ognuna delle immagini del dataset multiobject

### *extract_data_list_files.m*
script per leggere i datai necessari dai file in estensione .list nella cartella "List Files" e salvarli come oggetti .mat nalla cartella "Saved Data"

### *compute_partition.m*
script per dividere il data set mono oggetto con un holdout 80/20 e salvare tale divisione in un file .mat nella cartella saved file

### *compute_classificator_data_descriptors.m*
script per calcolare i descrittori delle immagini del dataset monooggetto caricato con *extract_data_list_files.m* e salvarli già divisi in train set e test set in un file .mat nella cartella "Saved Data"

### *create_classificator.m*
script per creare il classificatore partendo dai descrittori divisi in train e test set da *compute_classificator_data_descriptors*. Tale classificatore viene poi salvato in un file .mat in "Saved Data"

## Testare la Pipeline
una volta decompressa la cartella i file necessari per far funzionare la pipeline saranno già presenti quindi basterà eseguire lo script *test_pipeline.m*. Prima di eseguire tale script si potranno modificare le configurazioni di output dei risultati modificando i flag presenti ad inizio file. Se si volesse utilizzare tutti gli script per ricreare i dati utilizzati dalla pipeline bisognerà eseguire gli script nel seguente ordine
1. *extract_data_list_files.m*
2. *compute_partition.m*
3. *compute_classificator_data_descriptors.m*
4. *create_classificator.m*
5. *test_pipeline.m*