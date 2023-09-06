##### 230831

The goal of this project is simply to create a container which runs a website.

##### 230901

It has been difficult to make the dockerfile work. I wanted to use RHEL UBI images but didn't want to install all of Rust's dependencies. So I split the file into a builder image and a run image. Having a lot of trouble installing Dioxus on the Rust image and running dioxus build. Installing it via a RUN command doesn't seem to add the dioxus executable to the path.

Bruh. Dioxus changed their CLI to be named dx but their docs aren't updated. On my local machine I have an old version of dioxus-cli so my local command is dioxus.

##### 230903

Anyway, The resultant .wasm file wasn't runnable by its own. I tried to run it via Wasmtime and it failed. Then I realized I had no idea how Dioxus is supposed to be used in production. Trunk is used to take your app and compile it into HTTP, CSS, and WASM, so it can be served like any other page. Except Dioxus build already compiles the project into a distributable format. Trunk is used just to serve it? Tried installing apache2 locally, but setting up the environment variables was too much of a pain for me. Luckily, there is a docker image which does all that for me.

##### 230906

Worked on this for an hour yesterday mainly trying to figure out why trunk serve wasn't working locally. I reached out on the Dioxus discord for help, and a guy told me to use SSR. The problem is I don't want to use a HTTP library like Axum, I want to use a production web server(Apache2). But Apache2 was still showing a blank page with the index.html's header tag working but no generated code. I tried swapping out trunk with Dioxus going against the doc recommendations but at least Dioxus worked locally. But it took a while to compile, and I wasn't sure that using Dioxus serve was production grade for my test site of no users.

Anyway, I figured it out with a lot of trial and error this morning. I finally tried compiling with Dioxus build, copying the output to Apache2, and it WORKED. IDK why the docs recommended trunk, it seemed not compatible with Dioxus.
