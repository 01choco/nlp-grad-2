# Evaluating Safety and Stability in Reference-Free Preference Learning: A Comparative Study of DPO and SimPO
## Seohyeong Lee, Jeongpil Lee, Seoyeon Lee, Woocheol Jeong

This repository includes all codebases used for data preparation, training, and evaluation.  
- `./data-swap` contains the code for swapping labels in the UltraFeedback and HH-RLHF datasets, with configurable swap ratios.  
- `./LLaMA-Factory` includes the training code.  
- All configuration files used for training and adapter merging are saved in the `./examples` directory.  
- `./eval` contains evaluation benchmark scripts.  
- `./eval/FastChat` is used for evaluating MT-Bench and Evol-Instruct.  
- `./eval/red-instruct` includes code for evaluating on dangerousQA and adversarialQA.

## Contents
- [Install](#install)
- [Constructing Datasets](#constructing-datasets)
- [Training](#training)
- [Evaluation](#evaluation)
## Install

### `./LLaMA-Factory`
```bash
cd LLaMA-Factory
pip install -e ".[torch,metrics]"
```

### `./eval/FastChat` 
```
cd FastChat
pip install -e ".[model_worker,llm_judge]"
```

### `./eval/red-instruct`
```
cd red-instruct
conda create --name redeval -c conda-forge python=3.11
conda activate redeval
pip install -r requirements.txt
conda install sentencepiece
```

## Constructing Datasets
We provide data swapping code in `./data-swap/ultrafeedback_sampleing.ipynb`. 
By adjusting the swap ratio for each dataset, new datasets with different levels of label noise can be generated. We used this code to create swapped datasets with varying ratios for UltraFeedback and HH-RLHF separately.

## Training 
After preparing dataset, you can conduct model DPO and SimPO Training in `./LLaMA-Factory`. 
```
CUDA_VISIBLE_DEVICES=[devices] PYTHONPATH=./src llamafactory-cli train examples/train_lora/llama3-8b/[config-file-path]
```
Merging adapter using: 
```
CUDA_VISIBLE_DEVICES=[devices] PYTHONPATH=./src llamafactory-cli export examples/merge_lora/llama3-8b/[config-file-path]
```
## Evaluation

### MT-bench / Evol-Instruct

#### Step 1. Generate model answers to MT-bench questions
```
python gen_model_answer.py --model-path [MODEL-PATH] --model-id [MODEL-ID] --bench-name [BENCHMARK-NAME]
```
#### Step 2. Generate GPT-4o-mini judgments
```
python gen_judgment.py --model-list [LIST-OF-MODEL-ID] --judge-model [GPT-JUDGE-NAME] --bench-name [BENCHMARK-NAME] --parallel [num-concurrent-api-call] 
```

#### Step 3. Show MT-bench scores
```
python show_result.py --model-list [LIST-OF-MODEL-ID] --judge-model [GPT-JUDGE-NAME] --bench-name [BENCHMARK-NAME]
```
Use `--mode pairwise-baseline` option for pairwise scoring. 

### dangerousQA
#### Step 1. Generate model answers
```
python generate_responses.py --model "[MODEL-PATH]" --prompt red_prompts/standard.txt --dataset harmful_questions/adversarialqa.json
```
#### Step 2. Generate GPT-4o-mini judgments
```
python gpt4_as_judge.py --response_file "results/[PATH].json" --save_path results
```