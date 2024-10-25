
1- A short summary of what you built, how it works, and decisions you made to get there.

- I deployed a T2.micro instance on Amazon Web Services which provided me with a small virtual machine running in the eu-west-2 zone (London). The container is small and serves a single age so required minimal compute and memory. 
- I initially built the image on my local machine and attempted to run it 'as is' but ncountered some problems (see section 3 for details). By running the image locally I could create a short feedback loop with fewer complexities to debug the code. 
- Once I had the machine running correctly on my local machine I pushed a working image to Dockerhub. Dockerhub is a mature and popular solution for publically hosting images making it suitable for my purpose.
- I then SSH'd into my EC2, installed docker, logged in and pulled the image from dockerhub. I used the image to run a container with ports mapped to allow http access. I opted to only allow http traffic from my own ip address to keep the container secure - in this instance no-one else required access to it. 

How it works: 
The docker image is a self-contained package with application code and requirements, this runs as a container on a virtual machine which serves a webpage to the public internet. 

2- the url was: http://<Public IPv4 DNS>


3- Problems I encountered:

Checking on Docker Desktop when I run the image I get the error:

"2024-10-21 11:19:38 python: can't open file 'app.py': [Errno 2] No such file or directory"

I suspect view.py is the intended cmd file so I have made a copy of it called app.py

I have added EXPOSE 3030 to the dockerfile as there are currently no ports exposed making the container unreachable.

updated entrypoint to be python3 as that's what I use locally and is a more explicit command

instead of copying just requirements.txt I have copied the whole directory as it is small and contains files that are needed

Logs indicate index.htm template not found - the app.py file has a typo which I have fixed. 

Re-built image and ran it again, this time the container is exposing a webpage intended for consumption.

4- What you would do or explore if you were deploying this to production.

Assuming that this is a page/site that will have public traffic I would look at using kubernetes to orchestrate multiple containers. Kubernetes would allow automatic upscaling and vastly improve the availability as it will spin up a new pods to maintain a required number. I would also want to check what security was required, this would depend on the function and access routes of the app. It might be appropriate to limit traffic to the site depending on the context.      