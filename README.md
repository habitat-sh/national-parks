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

1. Modify the source code.

In `src/main/webapp/index.html`:
  - Line 5 to:
  ```
  <link rel="stylesheet" href="https://unpkg.com/leaflet@1.3.1/dist/leaflet.css" integrity="sha512-Rksm5RenBEKSKFjgI3a41vrjkw4EVPlJ3+OiI65vTjIdo9brlAacEuKOiQ5OFh7cOI1bkDwLqdLw3Zg0cRJAAQ==" crossorigin=""/>
  ```
  - Line 41 to:
  ```
  <script src="https://unpkg.com/leaflet@1.3.1/dist/leaflet.js" integrity="sha512-/Nsx9X4HebavoBvEBuyp3I7od5tA0UzAxs+j83KgC8PU0kgB4XiK4Lfe4y4cgBtaRJQEIFCW+oC506aPT2L1zw==" crossorigin=""></script>
  <script type="text/coffeescript" src="scripts/sprite.coffee"></script>
  <script type="text/coffeescript" src "script.coffee"></script>
  ```
  - Line 51-54, to:
  ```
  L.tileLayer('https://{s}.tile.thunderforest.com/landscape/{z}/{x}/{y}.png?apikey=816f897a456b4595a09bf8e1d42cfa0b', {
      maxZoom: 18,
      attribution: 'Maps © <a href="http://www.thunderforest.com">Thunderforest</a>, Data © <a href="http://www.openstreetmap.org/copyright">OpenStreetMap contributors</a>'
  }).addTo(map);
  ```
  - Line 84, to:
  ```
  [nationalPark.location.coordinates[1], nationalPark.location.coordinates[0]], { icon: L.icon({ iconUrl: 'images/redicon.png', iconAnchor: [12.5,40]}) }).bindPopup(popupInformation);
  ```
