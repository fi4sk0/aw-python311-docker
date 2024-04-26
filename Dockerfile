FROM python:3.11


RUN wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.0g-2ubuntu4_amd64.deb 
RUN dpkg -i libssl1.1_1.1.0g-2ubuntu4_amd64.deb

RUN pip install aspose-words

WORKDIR /home

COPY convert.py ./
COPY GESSI-Exit-Muster-SPA.docx ./example.docx
COPY Aspose.WordsforPythonvia.NET.lic ./

CMD ["python3", "convert.py"]
