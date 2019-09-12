# Docker crash course

Yet another one

## Why docker?

### The bad old days

- Trying to set up environments before docker world was a PITA
    - Often manual steps or flaky scripts involved to try and automate the setup of dev environments with the various versions of programming languages and databases
    - When new languages/dbs had to be changed or versions upgraded would require a lot of effort
    - Different setup from running code locally vs production
        - > "It works on my machine"

### What docker brings

- Standard way of packaging executable software
- Synonymous with containers in the shipping industry. When you have a standard it's easier to build tooling (container ships) around said standard
- Containers are _isolated environments_, they dont depend on the setup of the outside world (at least, not much). This means when you run the container locally you can have very high confidence of it working in production. 
    - > "It works on my machine..... _and_ prod"
- Incredibly rich, open ecosystem of images for all your favourite bits of software like databases, message queues, programming languages etc.
    - You never need to install a DB yourself manually
    - When you check out a project it should be configured with docker to get whatever things it needs

## Concrete benefits we've had

- Easily able to add new programming language support (Go) without any change to our infrastructure
    - Our *contract* with our platform is we provide them docker images to run. Whatever those images needs to do is entirely down to us
- Checking out projects with their various DBs is very trivial
- Running tests in a containerised environment means you can be confident if it builds locally it will through the pipelines too

## Key concepts

### Images

- You use a `Dockerfile` to configure how an image should be built
- It has a series of steps like "create a folder here", "copy some files to here", "fetch dependencies from here"
- Once the image is built, it is very cheap to create "instances" or **containers** to run your code

### Containers

- A running instance of an image
- Typically for us a web server listening on a port configured with whatever software we've written

## Quick demo

- `$ docker build . --tag woot` <- builds an image from a docker file (. for current dir)
- `$ docker run woot`
- `$ docker run -v ${PWD}:/i_luv_docker woot` <- mount local volume to container's `i_luv_docker` folder
- Mess around with it! See how caching works

## Considerations

- Leverage caching as best you can
    - People's #1 complaint about docker is slowness, and _usually_ it's down to not appreciating how to craft a lovely dockerfile
- If you find yourself having to rebuild images a lot, maybe you haven't designed things as well as you could have

## Different kinds of docker images you can make

### `CMD`

When you put this at the end of the file this is the _default_ command that will be run. 

```dockerfile
FROM alpine:3.7

RUN echo file1 >> file1.txt
RUN echo file2 >> file2.txt

CMD ["cat", "file1.txt"]
```

Try the following

`$ docker build cmd/ --tag=cmd`
`$ docker run cmd`

You can override the command ran like so

`$ docker run cmd ls`

### `ENTRYPOINT`

Sometimes you want to build an image that can be run as a program that takes arguments

```dockerfile
FROM alpine:3.7

RUN echo file1 >> file1.txt
RUN echo file2 >> file2.txt

ENTRYPOINT ["cat"]
```

Try the following

`$ docker build entrypoint/ --tag=ep`
`$ docker run ep`
`$ docker run ep file1.txt`
