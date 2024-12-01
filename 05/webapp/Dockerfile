FROM python:3.11.4
WORKDIR /app
COPY . .
RUN pip install --no-cache-dir -r requirements.txt
CMD ["python3", "-m", "flask", "run", "--host=0.0.0.0", "--port=8000"]
