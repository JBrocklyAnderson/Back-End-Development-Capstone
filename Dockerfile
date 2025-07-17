FROM python:3.9.16-slim

ENV PYTHONBUFFERED 1
ENV PYTHONWRITEBYTECODE 1

RUN apt-get update \
    && apt-get install -y netcat

ENV APP=/app

# Change the working directory to $APP
WORKDIR $APP

# Copy the requirements.txt file to $APP
COPY requirements.txt $APP

# Install requirements from requirements.txt
RUN pip3 install -r requirements.txt

# Copy the rest of the files into $APP
COPY . $APP

EXPOSE 8000 

RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/bin/bash","/app/entrypoint.sh"]

# Set the run command to "python manage.py runserver 0.0.0.0:8000"
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]