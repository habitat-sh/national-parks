# National-Parks Habitat Demo

Build a map of all the United States national parks using [Habitat](https://habitat.sh/)! Build, deploy, and manage the application to any cloud, virtual machine, or container.

With this demo, you'll discover the magical **space-cats** living inside of [Habitat](https://habitat.sh/), and learn the power of packaging, shipping, and updating applications in one atomic format.

## Build

You can build the application by simply [installing Habitat](https://www.habitat.sh/docs/install-habitat/) on your workstation and using the Habitat Studio.

1. Clone the repo.
2. `cd national-parks`
3. `hab studio enter`
4. `build`

Watch as the application builds! It should take a few minutes.

If you're showing this as a demo to others, this is a good time to talk about the plan.sh and show how it relates to the build process.

## Export to Docker

Ready to see what the app looks like on your local workstation with Docker?

Inside the Studio, run:
1. hab pkg export docker path/to/build.hart

Now you'll have a Docker container on your local workstation.

2. Modify national-parks/docker-compose.yml to match your origin.

```
   national-parks:
    image: myorigin/national-parks
```

3. `docker-compose up`

4. Browse to http://localhost:8081/national-parks to see the app.

## Provision AWS

Let's show the app in AWS using Terraform!

1. [Install Terraform](https://www.terraform.io/downloads.html)

2. Create a `terraform.tfvars` in the `national-parks/terraform/aws` directory. An example is provided for you at `national-parks/terraform/aws/example.tfvars`

3. `cd national-parks/terraform/aws`

4. `terraform init`

5. `terraform plan`

6. `terraform apply -auto-approve`

7. Browse to the URL output by Terraform for you.

## Update the app

Let's update the appliation with some brand new colors to make a new version.

1. Modify `src/main/webapp/index.html` by replacing it with the contents of `index.html.new`. You can revert and show a rollback too, by using `index.html.old`.

2. Rebuild the app in the Habitat Studio.

3. Re-export the container, or upload the new package to builder.