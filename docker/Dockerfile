# Using Base image alpine with installed python3
FROM frolvlad/alpine-python3

#choosing /app as working directory
WORKDIR /app

# Mentioned python module name to run application 
ADD requirements.txt /app
ADD app.py /app
RUN pip3 install --no-cache-dir -r requirements.txt

# Exposing applicaiton on 80 so that it can be accessible on 80
EXPOSE 5000

#Making default entry as python will launch api.py
CMD [ "python3", "app.py" ]
