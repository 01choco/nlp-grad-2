CUDA_VISIBLE_DEVICES=0,1,2,4 PYTHONPATH=./src llamafactory-cli train examples/train_lora/qwen2-vl-2b/full-highavg.yaml
CUDA_VISIBLE_DEVICES=0,1,2,4 PYTHONPATH=./src llamafactory-cli train examples/train_lora/qwen2-vl-2b/full-rand42.yaml
CUDA_VISIBLE_DEVICES=0,1,2,4 PYTHONPATH=./src llamafactory-cli train examples/train_lora/qwen2-vl-2b/full-highvar.yaml
CUDA_VISIBLE_DEVICES=0,1,2,4 PYTHONPATH=./src llamafactory-cli train examples/train_lora/qwen2-vl-2b/full-lowavg.yaml
CUDA_VISIBLE_DEVICES=0,1,2,4 PYTHONPATH=./src llamafactory-cli train examples/train_lora/qwen2-vl-2b/full-full.yaml