FROM debian:buster-slim 

ARG WORKSPACE=/root 

RUN apt-get update 


RUN apt-get install git unzip curl wget  build-essential cmake clang -y

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash
RUN apt-get install nodejs  zsh  -y

RUN git clone https://github.com/vim/vim.git && cd vim/src && ./configure &&  make && make install 

RUN git config --global user.name "John Doe"
RUN git config --global user.email johndoe@example.com

RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

WORKDIR $WORKSPACE
COPY .vimrc ${WORKSPACE}/.vimrc 
COPY plug.vim ${WORKSPACE}/.vim/autoload/plug.vim

RUN vim +PlugInstall +qall 

RUN wget https://download.pytorch.org/libtorch/nightly/cpu/libtorch-shared-with-deps-latest.zip && unzip libtorch-shared-with-deps-latest.zip


CMD ["zsh"]
