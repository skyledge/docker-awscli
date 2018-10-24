FROM python:3.7-slim

RUN pip install awscli --upgrade --user
RUN echo 'export PATH=~/.local/bin:$PATH'>>root/.bashrc

CMD ["/bin/bash"]
