FROM circleci/rust:1.34.2

WORKDIR /home/circleci 

ENV WASMPACK_VERSION 0.8.1
ENV BINARYEN_VERSION 88
ENV NODE_VERSION 10.16.2

RUN cargo install wasm-pack --vers ${WASMPACK_VERSION}

RUN sudo apt install cmake
RUN curl -L https://github.com/WebAssembly/binaryen/archive/version_${BINARYEN_VERSION}.tar.gz -o binaryen.tar.gz
RUN tar -zxvf binaryen.tar.gz

WORKDIR /home/circleci/binaryen-version_${BINARYEN_VERSION}

RUN cmake .
RUN make
RUN sudo make install

WORKDIR /home/circleci 

RUN curl https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.xz -o node-v${NODE_VERSION}-linux-x64.tar.xz
RUN sudo mkdir -p /usr/local/lib/nodejs
RUN sudo tar -xJvf node-v${NODE_VERSION}-linux-x64.tar.xz -C /usr/local/lib/nodejs
ENV PATH /usr/local/lib/nodejs/node-v${NODE_VERSION}-linux-x64/bin:$PATH
