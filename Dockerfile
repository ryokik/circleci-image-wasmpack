FROM circleci/rust:1.34.2

WORKDIR /home/circleci 

RUN curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh
RUN sudo apt install cmake
RUN curl -L https://github.com/WebAssembly/binaryen/archive/version_88.tar.gz -o binaryen.tar.gz
RUN tar -zxvf binaryen.tar.gz

WORKDIR /home/circleci/binaryen-version_88 

RUN cmake .
RUN make
RUN sudo make install

WORKDIR /home/circleci 
