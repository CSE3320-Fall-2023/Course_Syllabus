FROM ubuntu:bionic

WORKDIR /var/local

# combine into one run command to reduce image size
RUN apt-get update && \
    apt-get install -y perl wget libfontconfig1 fonts-font-awesome && \
    wget -qO- "https://yihui.org/tinytex/install-bin-unix.sh" | sh  && \
    apt-get install texlive-latex-extra --no-install-recommends && \
    apt-get clean && \
    mktexlsr 
ENV PATH="${PATH}:/root/bin"

RUN tlmgr update --self --all
RUN tlmgr path add
RUN fmtutil-sys --all

WORKDIR /

COPY . /

ENTRYPOINT ["/entrypoint.sh"]
