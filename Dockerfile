FROM python:3.11-slim

# Variável de ambiente para habilitar a autoinstrumentação
ENV OTEL_PYTHON_AUTO_INSTRUMENTATION_ENABLED=true

WORKDIR /app

# Instalar dependências
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Instalar pacotes de auto-instrumentação
RUN pip install --no-cache-dir opentelemetry-distro opentelemetry-instrumentation

# Copiar todo o conteúdo da aplicação
COPY app/ app/

CMD ["opentelemetry-instrument", "uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "5000"]
