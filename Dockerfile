FROM python:3.11-slim-bookworm

WORKDIR /usr/src/app

# Install required system dependencies
RUN apt-get update && apt-get install -y python3-dev gcc-11 g++-11 build-essential

# Copy the requirements file and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Download the model file and place it in the root directory
RUN curl -LJO https://huggingface.co/TheBloke/Llama-2-7B-Chat-GGML/resolve/main/llama-2-7b-chat.ggmlv3.q8_0.bin?download=true && \
    mv llama-2-7b-chat.ggmlv3.q8_0.bin /usr/src/app/

# Copy the rest of the application code
COPY . .

# Set the default command to run your application
CMD ["python", "api.py"]
