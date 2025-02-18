# Containeraized Application Deployment

I created a hello.py that uses Flask to run a simple script that will display "Hello World!" when accessed.

To note, there are other ways to deploy a script that will display the same output but some also include deploying webservers that increase the size of the image, take longer to deploy and so on.
I wanted to avoid that and create a simple way.

After creating the Python script, I created a simple Dockerfile to deploy a container that will run the said script.

The command I used to create the docker container is:

**docker build -t project-python-test:v1.0 . && docker tag project-python-test:v1.0 dario34/project-python-test:v1.0 && docker push dario34/project-python-test:v1.0**

![Docker build, tag & push](https://github.com/DarioIlic/containeraized-application-deployment/blob/35dd8aa3aaaef35af91e5c09d2b422dc1f0382f1/docker%20build%20tag%20%26%20push.png)

To break it down:

**docker build -t project-python-test:v1.0 .** -> "This command created a container called project-python-test and tagged it as v1.0 (you have to be in the folder where the Dockerfile is)"

**docker tag project-python-test:v1.0 dario34/project-python-test:v1.0** -> "This command tags the current image with the DockerHub username"

**docker push dario34/project-python-test:v1.0** -> "This command pushes the tagged image to the DockerHub"

After that, I ran the command:

**docker run -p 8000:8000 project-python-test:v1.0** -> "This was used to test if the script is working and, as configured in the Dockerfile, that it works on port 8000"

![Docker run](https://github.com/DarioIlic/containeraized-application-deployment/blob/35dd8aa3aaaef35af91e5c09d2b422dc1f0382f1/docker%20run.png)

Result in browser:

![Docker URL](https://github.com/DarioIlic/containeraized-application-deployment/blob/35dd8aa3aaaef35af91e5c09d2b422dc1f0382f1/docker%20deploy%20URL.png)

Now, to the fun K8 part. For this, I created simple deployment and service YAML files.

Please note that this is for testing, for production, you would need to follow some of the security and best practices. For example:

  **1. Deploy your app in a different namespace**
  
  **2. Set the number of replicas that will be deployed, for easier balancing**
  
  **3. Set liveness and readiness probes**
  
  **4. Auto-scaling**
  
  **5. Limit resources for pods**
  
  **6. Use RBAC**
  
  **7. Use the latest k8 version**


These are some, there are more but these are ones I consider worth investing time in, especially in production environments.

The commands I used are aliases that I set for easier managing, I will write them down under the image:

![K8 deployment](https://github.com/DarioIlic/containeraized-application-deployment/blob/35dd8aa3aaaef35af91e5c09d2b422dc1f0382f1/kubectl%20deploy.png)

**kaf -> kubectl apply -f**

**kgd -> kubectl get deployments**

**kgs -> kubectl get services**

**kgp -> kubectl get pods**

**k -> kubectl**

There are other numerous aliases you can use as well but it is best to set them up to suit your needs.

Now, to list the commands I used:

  **1. kaf deployment.yaml** -> Used to deploy the deployment file

  **2. kaf service.yaml** -> Used to deploy the service file

  **3. kgd** -> Used to check if the deployment is actually deployed and running

  **4. kgs** -> Same as kgd but for service

  **5. kgp** -> Same as others but to check for pods, you need to make sure that pod with your application is actually running and not stuck in CrashLoopBackOff or such.

  **6. k port-forward service/project-python-test 8080:8080** -> This is the command I used to allow access to the K8 service running locally on port 8080

End result is:

![K8 deployment URL](https://github.com/DarioIlic/containeraized-application-deployment/blob/35dd8aa3aaaef35af91e5c09d2b422dc1f0382f1/k8%20deploy%20URL.png)
