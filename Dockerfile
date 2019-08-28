FROM alpine:3.7

WORKDIR /i_luv_docker
RUN echo "step 1 before copy"
COPY config.json .
RUN echo "step 2 post copy"
CMD ["cat", "config.json"]
