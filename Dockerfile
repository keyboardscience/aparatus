FROM keyboardscience/ruby-base:latest

RUN git clone https://${GITHUB_TOKEN}:x-oauth-basic@github.com/keyboardscience/aparatus.git
