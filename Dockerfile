# Pull latest Python image
FROM python:3.14.0a5-alpine3.21

# Set working directory
WORKDIR /project

# Copy the script
COPY hello.py .

# Install Flask
RUN pip install flask

# Open port 8000
EXPOSE 8000

# Run the script
CMD ["python", "hello.py"]
