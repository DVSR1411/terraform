import boto3
import os
from transformers import AutoModel, AutoTokenizer
model_name = 'deepseek-ai/DeepSeek-R1-Distill-Llama-8B'
model = AutoModel.from_pretrained(model_name)
tokenizer = AutoTokenizer.from_pretrained(model_name)
local_model_path = "./models"
os.makedirs(local_model_path, exist_ok=True)
model.save_pretrained(local_model_path)
tokenizer.save_pretrained(local_model_path)
print("Model upload complete")